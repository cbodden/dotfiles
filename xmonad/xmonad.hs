import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

--Simple variable declarations.
myBorderWidth        = 1
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
tall = Tall 1 (3/100) (1/2)
myLayoutHook = avoidStruts  $ layoutHook defaultConfig

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
