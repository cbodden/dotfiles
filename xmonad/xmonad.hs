import XMonad
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

--Simple variable declarations.
myBorderWidth       = 1
myFocusFollowsMouse = True
myModMask           = mod4Mask
myTerminal          = "st"
myWorkspaces        = ["term","browse","3","4","5","6","7","8","9"]

-- Color of current window title in xmobar.
xmobarTitleColor = "#22CCDD"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#00ff00"

myManageHook = composeAll
  [ isFullscreen       --> doFullFloat
  , isDialog           --> doCenterFloat
  , className =? "mpv" --> doFloat
  ]

tall = Tall 1 (3/100) (1/2)
myLayoutHook = smartBorders tall ||| smartBorders (Mirror tall) ||| smartBorders Full

main = do
  xmproc <- spawnPipe "xmobar"

  xmonad $ defaultConfig
        { borderWidth        = myBorderWidth
        , modMask            = myModMask
        , terminal           = myTerminal
        , workspaces         = myWorkspaces
        --, normalBorderColor  = "#D0D0D0"
        , normalBorderColor  = "#000000"
        --, focusedBorderColor = "#FFAA00"
        , focusedBorderColor = "#000000"
        , manageHook         = manageDocks <+> manageHook defaultConfig
        , focusFollowsMouse  = myFocusFollowsMouse
        , layoutHook         = avoidStruts  $ layoutHook defaultConfig
        , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
                 { ppOutput = hPutStrLn xmproc
                 , ppHiddenNoWindows = xmobarColor "grey" ""
                 , ppTitle = xmobarColor xmobarTitleColor "" . shorten 40
                 , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                 , ppSep = "   "
                 }
        }
