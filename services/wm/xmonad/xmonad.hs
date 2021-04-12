import XMonad hiding ( (|||) )
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.SpawnOn
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.TwoPane
import XMonad.Util.Scratchpad
import XMonad.Util.SpawnOnce
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86
import System.IO
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map as M

startup :: X ()
startup = do
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnOnce "\8198\61747\8198" "st -t \"Personal\" nvim ~/Documents/Personal/Schedule"
    spawnOnOnce "\8198\61747\8198" "st -t \"School\" nvim ~/Documents/School/Grade-11/Schedule"
    spawnOnOnce "\8198\61747\8198" "st -t \"Calendar\" calcurse"
    spawnOnOnce "\8198\61664\8198" "st -t \"Mail\" neomutt"

myStartupHook = do
    startup
    spawn "feh --bg-fill ~/.xmonad/background"
    spawn "systemctl --user restart taffybar"

main = do 
  xmonad $ ewmh $ defaultConfig
    { terminal = "st"
    , borderWidth = 0
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , modMask  = mod4Mask
    , workspaces = myWorkspaces
    , layoutHook = myLayout
    , logHook = myLogHook
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig
    , manageHook = manageDocks <+> manageSpawn <+> manageScratchPad <+> manageHook defaultConfig
    , keys = myKeys
    , startupHook = myStartupHook
    }

myWorkspaces = [ "\8198\61728\8198", "\8198\61486\8198", "\8198\61747\8198", "\8198\61664\8198", "\8198\61853\8198","\8198\61459\8198", "\8198\62003\8198", "\8198\62056\8198", "\8198\61897\8198", "\8198\61787\8198" ]

-- Variable `handleMonitors` added by Nix script
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
      [ ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
      , ((modMask .|. shiftMask, xK_Escape), spawn "xmonad --recompile && xmonad --restart")
      , ((modMask, xK_t), sendMessage $ JumpToLayout "Tall")
      , ((modMask .|. shiftMask, xK_t), sendMessage $ JumpToLayout "Mirror Tall")
      , ((modMask, xK_p), sendMessage $ JumpToLayout "TwoPane")
      , ((modMask, xK_f), sendMessage $ JumpToLayout "Full")
      , ((modMask, xK_b), sendMessage ToggleStruts)
      , ((modMask, xK_j), windows W.focusDown)
      , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
      , ((modMask, xK_k), windows W.focusUp)
      , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
      , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
      , ((modMask .|. controlMask, xK_t), withFocused $ windows . W.sink)
      , ((modMask, xK_h), sendMessage Shrink)
      , ((modMask, xK_l), sendMessage Expand)
      , ((modMask, xK_equal), sendMessage (IncMasterN 1))
      , ((modMask, xK_minus), sendMessage (IncMasterN (-1)))
      , ((modMask, xK_q), kill)
      , ((modMask, xK_space), spawn "rofi -modi drun -show drun -show-icons")
      , ((modMask, xK_p), spawn "rofi-pass")
      , ((modMask .|. shiftMask, xK_space), spawn "rofi -modi window -show window -show-icons")
      , ((modMask .|. controlMask, xK_space), spawn "rofi -modi ssh -show ssh -show-icons")
      , ((modMask, xK_Return), spawn $ XMonad.terminal conf)
      , ((modMask .|. controlMask, xK_Return), scratchpadSpawnActionCustom $ (XMonad.terminal conf) ++ " -n scratchpad")
      , ((0      , xF86XK_MonBrightnessUp), spawn "light -A 10")
      , ((modMask, xF86XK_MonBrightnessUp), spawn "light -A 5")
      , ((modMask .|. shiftMask, xF86XK_MonBrightnessUp), spawn "light -A 1")
      , ((0      , xF86XK_MonBrightnessDown), spawn "light -U 10")
      , ((modMask, xF86XK_MonBrightnessDown), spawn "light -U 5")
      , ((modMask .|. shiftMask, xF86XK_MonBrightnessDown), spawn "light -U 1")
      ] ++
      [ ((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)] 
      ] ++
      [ ((m .|. modMask, k), f sc)
      | (k, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]
      ]

layoutDefaultConfig = avoidStruts $ noBorders $
    Tall 1 (3/100) (1/2)
    ||| Mirror (Tall 1 (3/100) (1/2))
    ||| TwoPane (3/100) (1/2)
    ||| Full

layoutInfoConfig = avoidStruts $ noBorders $ Full

myLayout = onWorkspace "\8198\61747\8198" layoutInfoConfig $
           onWorkspace "\8198\61664\8198" layoutInfoConfig $
           layoutDefaultConfig

manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.2
    w = 0.2
    t = 0.2
    l = 0.4

myLogHook = updatePointer (0.5, 0.5) (0, 0)
