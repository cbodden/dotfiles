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
myFocusFollowsMouse = False
myModMask           = mod4Mask
myTerminal          = "st"
--myTerminal          = "urxvtc || urxvt"

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
        , normalBorderColor  = "#D0D0D0"
        , focusedBorderColor = "#FFAA00"
        , manageHook         = manageDocks <+> manageHook defaultConfig
        , focusFollowsMouse  = myFocusFollowsMouse
        , layoutHook         = avoidStruts  $ layoutHook defaultConfig
        , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
                 { ppOutput = hPutStrLn xmproc
                 , ppTitle = xmobarColor "green" "" . shorten 50
                 , ppHiddenNoWindows = xmobarColor "grey" ""
                 }
        }
