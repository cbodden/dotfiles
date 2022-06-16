import System.IO
import XMonad
import XMonad hiding ( (|||) )
import XMonad.Actions.GridSelect        -- displays items in a 2D grid & select from it with cursor/hjkl or the mouse
import XMonad.Hooks.DynamicLog          -- output status info to external status programs
import XMonad.Hooks.EwmhDesktops        -- make xmonad use EWMH hints
import XMonad.Hooks.ICCCMFocus          -- will not misbehavewhentaking and losing focus
import XMonad.Hooks.InsertPosition      -- Configure where new windows should be added and which window should be focused
import XMonad.Hooks.ManageDocks         -- provide tools ot manage dock type programs
import XMonad.Hooks.ManageHelpers       -- helper functions to be used in manageHook
import XMonad.Hooks.UrgencyHook         -- configure action to occur when window needs attention
import XMonad.Layout.Circle             -- circle layout
import XMonad.Layout.Grid               -- grid layout
import XMonad.Layout.PerWorkspace (onWorkspace)          -- configure layouts per workspace
import XMonad.Layout.ResizableTile      -- resizable tile layout
import XMonad.Layout.SimpleFloat        -- float layout
import XMonad.Layout.Spacing            -- add space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane            -- twopane only layout
import XMonad.Util.EZConfig             -- helper func for parsing keybindings
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)       -- provides commands to run external programs


-- xmonad variable declarations.
xmonadBorderWidth        = 0            -- border width
xmonadFocusFollowsMouse  = False        -- focus follows mouse
xmonadFocusedBorderColor = "#000000"    -- focused border color
xmonadModMask            = mod4Mask     -- set mod key to winkey
xmonadNormalBorderColor  = "#000000"    -- normal border color
xmonadTerminal           = "st"         -- default terminal
xmonadWorkspaces         = ["1:st","2:qb"] ++ map show [3..9]  -- workspaces available


-- xmobar variable declarations.
xmobarTitleColor         = "#22CCDD"    -- color of window title
xmobarTitleLength        = 40           -- length of title name
xmobarCurrentWSColor     = "#00ff00"    -- active workspace color
xmobarVisibleWSColor     = "#c185a7"    -- inactive sorkspace color
xmobarUrgentWSColor      = "#cc0000"    -- urgent workspace color
xmobarCurrentWSLeft      = "["          -- active workspace id wrap
xmobarCurrentWSRight     = "]"
xmobarVisibleWSLeft      = "("          -- inactive workspace id wrap
xmobarVisibleWSRight     = ")"
xmobarUrgentWSLeft       = "{"          -- urgent workspace id wrap
xmobarUrgentWSRight      = "}"


-- managehook settings
-- -- to find the property name > "xprop | grep WM_CLASS" then select window
xmonadManageHook    = composeAll
    [ className     =? "st-256color"    --> doShift "1:st"
    , className     =? "qutebrowser"    --> doShift "2:qb"
    , className     =? "Signal"         --> doShift "2:qb"
    , className     =? "firefox"        --> doShift "3"
    , className     =? "Navigator"      --> doShift "3"
    , className     =? "Virt-manager"   --> doShift "4"
    , className     =? "mpv"            --> doFloat
    , className     =? "sxiv"           --> doFloat
    , isFullscreen                      --> doFullFloat
    , isDialog                          --> doCenterFloat
    ]

xmonadManageHookDetail = insertPosition Below Newer <+> xmonadManageHook <+> manageDocks


-- Layouthook settings
xmonadLayoutHook = onWorkspace "1:st" (defTerm) $ onWorkspace "2:qb" defLayout $ standardLayouts
    where
        standardLayouts = avoidStruts ( Full ||| tPane ||| tiled ||| mtiled ||| Grid ||| floaT ||| simpleTabbed ||| Circle )
            where
                floaT                = simpleFloat
                tiled1               = Tall nmaster delta ratio
                mtiled               = Mirror tiled1
                -- tPane                = spacing 10 $ TwoPane (3/100) (75/100)
                tPane                = spacingRaw False (Border 0 30 0 30) True (Border 30 0 30 0) True $ TwoPane (3/100) (75/100)
                -- tiled                = spacing 10 $ ResizableTall nmaster delta ratio []
                tiled                = spacingRaw False (Border 0 30 0 30) True (Border 30 0 30 0) True $ ResizableTall nmaster delta ratio []
                nmaster              = 1                         -- The default number of windows in the master pane
                delta                = 3/100                     -- Percent of screen to increment when resizing panes
                ratio                = 1/4                       -- Default amount of screen occupied by master pane
        defTerm = Full
        defLayout = avoidStruts $ tPane
            where
                tPane                = spacingRaw False (Border 0 30 0 30) True (Border 30 0 30 0) True $ TwoPane (3/100) (75/100)
                -- tPane                = spacing 10 $ TwoPane (3/100) (75/100)


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
        , manageHook         = xmonadManageHookDetail
        , modMask            = xmonadModMask
        , normalBorderColor  = xmonadNormalBorderColor
        , terminal           = xmonadTerminal
        , workspaces         = xmonadWorkspaces
        , logHook            = takeTopFocus <+> dynamicLogWithPP xmobarPP
            { ppOutput          = hPutStrLn xmproc
            , ppHiddenNoWindows = xmobarColor "grey"               ""
            , ppTitle           = xmobarColor xmobarTitleColor     "" . shorten xmobarTitleLength
            , ppCurrent         = xmobarColor xmobarCurrentWSColor "" . wrap xmobarCurrentWSLeft xmobarCurrentWSRight
            , ppVisible         = xmobarColor xmobarVisibleWSColor "" . wrap xmobarVisibleWSLeft xmobarVisibleWSRight
            , ppUrgent          = xmobarColor xmobarUrgentWSColor  "" . wrap xmobarUrgentWSLeft xmobarUrgentWSRight
            , ppSep             = "   "
            }
        }

        `additionalKeysP`
            [ ("<XF86AudioLowerVolume>",  spawn "amixer sset Master playback 3%-")
            , ("<XF86AudioMute>",         spawn "amixer sset Master toggle")
            , ("<XF86AudioRaiseVolume>",  spawn "amixer sset Master playback 3%+ unmute")
            , ("<XF86MonBrightnessDown>", spawn "/usr/bin/xbacklight -dec 2")
            , ("<XF86MonBrightnessUp>",   spawn "/usr/bin/xbacklight -inc 2")
            , ("M-S-x",                   spawn "xscreensaver-command -lock")
            , ("M-g",                     goToSelected defaultGSConfig)   -- Display window selection grid
            , ("M-b",                     sendMessage ToggleStruts)
            , ("M-q",                     spawn "xmonad --recompile && xmonad --restart")
            --, ("M-p",                     spawn "dmenu_run -i -l 4 -p 'sup ? : '")
            , ("M-p",                     spawn "rofi -config ~/git/mine/dotfiles/rofi.rasi -show combi")
            ]
