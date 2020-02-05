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

-- Simple variable declarations.
myBorderWidth        = 0
myFocusFollowsMouse  = True
myModMask            = mod4Mask
myTerminal           = "st"
myWorkspaces         = ["term","browse","3","4","5","6","7","8","9"]
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#000000"

-- Color of current window title in xmobar.
xmobarTitleColor     = "#22CCDD"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#00ff00"

-- managehook settings
myManageHook = composeAll
  [ className =? "mpv"  --> doFloat
  , className =? "sxiv" --> doFloat
  , isFullscreen        --> doFullFloat
  , isDialog            --> doCenterFloat
  ]

-- Layouthook settings
---- original
--- tall =  ResizableTall 1 (1/100) 1
--- myLayoutHook = avoidStruts  $ layoutHook defaultConfig

myLayoutHook =
    avoidStrutsOn [U] -- avoid statusbar overlapping
        $ onWorkspace "web" floaT
        $ onWorkspace "dev" tiled
        $ standardLayouts
    where
        standardLayouts = Full ||| tiled ||| mtiled ||| Grid ||| floaT
        floaT   = simpleFloat
        tiled1  = Tall nmaster delta ratio
        mtiled  = Mirror tiled1
        tiled   = spacing 5 $ ResizableTall nmaster delta ratio []
        nmaster = 1       -- The default number of windows in the master pane
        ratio   = 1/2     -- Default proportion of screen occupied by master pane
        delta   = 3/100   -- Percent of screen to increment by when resizing panes

-- eventhook settings
myEventHook = handleEventHook defaultConfig <+> docksEventHook

main = do
  xmproc <- spawnPipe "xmobar"

  xmonad $ defaultConfig
        { borderWidth        = myBorderWidth
        , modMask            = myModMask
        , terminal           = myTerminal
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , manageHook         = myManageHook
        , focusFollowsMouse  = myFocusFollowsMouse
        , layoutHook         = myLayoutHook
        , handleEventHook    = myEventHook
        , logHook = dynamicLogWithPP xmobarPP
                 { ppOutput = hPutStrLn xmproc
                 , ppHiddenNoWindows = xmobarColor "grey" ""
                 , ppTitle = xmobarColor xmobarTitleColor "" . shorten 40
                 , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                 , ppSep = "   "
                 }
        }
