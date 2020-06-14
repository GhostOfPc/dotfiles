-- Imports
-- Essentials
import XMonad
import System.IO
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageDocks

-- Utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce


-- Defaults
myTerminal      = "kitty"
mybrowser       = "brave"
myEditor        = "nvim"
myVector        = "inkscape"
myMplayer       = "spotify"
myVplayer       = "vlc"
myMC            = "kodi"
myGEditor       = "geany"
myWallpaper     = "nitrogen"
myPasswd        = "keepassxc"
mySsh           = "filezilla"
myPhEdit        = "gimp"

-- Variables
myModKey :: KeyMask
myModKey        = mod4Mask

myAltKey :: KeyMask
myAltKey        = mod1Mask

myFont :: [Char]
myFont          = "xft:FiraMono Nerd Font:regular:pixelsize=10"

myBorderWidth :: Dimension
myBorderWidth   = 2

myNormColor :: [Char]
myNormColor     = "#181818"

myFocusColor :: [Char]
myFocusColor    = "#ff92df"

-- Workspaces
myWorkspaces :: [String]
myWorkspaces    = ["dev", "web", "edit", "files", "music", "vids"]

-- Autostart
mystartupHook :: X ()
mystartupHook   = do
          spawnOnce "nitrogen --restore &"
          spawnOnce "picom --experimental-backends &"
          spawnOnce "dunst &"
          spawnOnce "xfce4-power-manager &"
          spawnOnce "lxsession &"

-- Keybinding
myKeys :: [([Char], X())]
myKeys = 
      -- Xmonad restart and recompile
      [   ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-q", io exitSuccess)   

        , ("M-<Return>", spawn "myTerminal")
      ]
-- Main
main = do
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
    xmonad $ docks defaultConfig
                          { terminal           = myTerminal
			  , modMask            = myModKey
                          , borderWidth        = myBorderWidth
			  , normalBorderColor  = myNormColor
			  , focusedBorderColor = myFocusColor
			  , startupHook        = mystartupHook
			  , workspaces         = myWorkspaces
		          , logHook            = dynamicLogWithPP xmobarPP
                                  { ppOutput = hPutStrLn xmproc
				  , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                                  , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                                  , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                                  , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                                  , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                                  , ppSep =  "<fc=#666666> | </fc>"                     -- Separators in xmobar
                                  , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                                  , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
			          }
			  , layoutHook         = avoidStruts $ layoutHook defaultConfig
			  } `additionalKeysP` myKeys
