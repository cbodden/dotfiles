import XMonad
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders

--Simple variable declarations.
myBorderWidth       = 1
myFocusFollowsMouse = False
myModMask           = mod4Mask
myTerminal          = "urxvt"

myManageHook = composeAll
  [ isFullscreen       --> doFullFloat
  , isDialog           --> doCenterFloat
  , className =? "mpv" --> doFloat
  ]

tall = Tall 1 (3/100) (1/2)
myLayoutHook = smartBorders tall ||| smartBorders (Mirror tall) ||| smartBorders Full

main = xmonad $ def
        { borderWidth        = myBorderWidth
        , modMask            = myModMask
        , terminal           = myTerminal
        , normalBorderColor  = "#D0D0D0"
        , focusedBorderColor = "#FFAA00"
        , manageHook         = myManageHook
        , focusFollowsMouse  = myFocusFollowsMouse
        , layoutHook         = myLayoutHook
        , handleEventHook    = fullscreenEventHook
        }
