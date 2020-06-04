import System.IO
import XMonad
import XMonad hiding ( (|||) )
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

-- xmonad variable declarations.
xmonadBorderWidth        = 0
xmonadFocusFollowsMouse  = False
xmonadFocusedBorderColor = "#000000"
xmonadModMask            = mod4Mask
xmonadNormalBorderColor  = "#000000"
xmonadTerminal           = "st"
xmonadWorkspaces         = ["1","2"] ++ map show [3..9]

-- xmobar variable declarations.
xmobarTitleColor     = "#22CCDD"
xmobarTitleLength    = 40
xmobarCurrentWSColor = "#00ff00"
xmobarVisibleWSColor = "#c185a7"
xmobarUrgentWSColor  = "#cc0000"
xmobarCurrentWSLeft  = "["
xmobarCurrentWSRight = "]"
xmobarVisibleWSLeft  = "("
xmobarVisibleWSRight = ")"
xmobarUrgentWSLeft   = "{"
xmobarUrgentWSRight  = "}"

-- managehook settings
-- -- to find the property name > "xprop | grep WM_CLASS" then select window
xmonadManageHook = composeAll
    [ className =? "qutebrowser"     --> doShift "2"
    , className =? "Vivaldi-stable"  --> doShift "3"
    , className =? "Virt-manager"    --> doShift "4"
    , className =? "mpv"             --> doFloat
    , className =? "sxiv"            --> doFloat
    , isFullscreen                   --> doFullFloat
    , isDialog                       --> doCenterFloat
    ]

-- Layouthook settings
xmonadLayoutHook =
    avoidStrutsOn [U] -- avoid statusbar overlapping
        $ onWorkspace "1" Full
        $ standardLayouts
    where
        standardLayouts = Full ||| tiled ||| mtiled ||| Grid ||| floaT
        floaT   = simpleFloat
        tiled1  = Tall nmaster delta ratio
        mtiled  = Mirror tiled1
        tiled   = spacing 6 $ ResizableTall nmaster delta ratio []
        nmaster = 1       -- The default number of windows in the master pane
        delta   = 3/100   -- Percent of screen to increment when resizing panes
        ratio   = 1/2     -- Default amount of screen occupied by master pane

-- eventhook settings
xmonadEventHook = handleEventHook defaultConfig <+> docksEventHook

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ withUrgencyHook NoUrgencyHook $ ewmh defaultConfig
        { borderWidth        = xmonadBorderWidth
        , focusFollowsMouse  = xmonadFocusFollowsMouse
        , focusedBorderColor = xmonadFocusedBorderColor
        , handleEventHook    = xmonadEventHook
        , layoutHook         = xmonadLayoutHook
        , manageHook         = xmonadManageHook
        , modMask            = xmonadModMask
        , normalBorderColor  = xmonadNormalBorderColor
        , terminal           = xmonadTerminal
        , workspaces         = xmonadWorkspaces
        , logHook            = takeTopFocus <+> dynamicLogWithPP xmobarPP
            { ppOutput          = hPutStrLn xmproc
            , ppHiddenNoWindows = xmobarColor "grey" ""
            , ppTitle           = xmobarColor xmobarTitleColor "" . shorten xmobarTitleLength
            , ppCurrent         = xmobarColor xmobarCurrentWSColor "" . wrap xmobarCurrentWSLeft xmobarCurrentWSRight
            , ppVisible         = xmobarColor xmobarVisibleWSColor "" . wrap xmobarVisibleWSLeft xmobarVisibleWSRight
            , ppUrgent          = xmobarColor xmobarUrgentWSColor "" . wrap xmobarUrgentWSLeft xmobarUrgentWSRight
            , ppSep             = "   "
            }
        }

        `additionalKeysP`
        [("M-q",                     spawn "xmonad --recompile && xmonad --restart")
        ,("<XF86AudioMute>",         spawn "amixer set Master toggle")
        ,("<XF86AudioRaiseVolume>",  spawn "amixer set Master playback 1+ unmute")
        ,("<XF86AudioLowerVolume>",  spawn "amixer set Master playback 1-")
        ,("<XF86MonBrightnessDown>", spawn "/usr/bin/xbacklight -dec 2")
        ,("<XF86MonBrightnessUp>",   spawn "/usr/bin/xbacklight -inc 2")
        ]
