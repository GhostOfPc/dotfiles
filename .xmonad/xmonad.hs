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
import XMonad.Hooks.EwmhDesktops

-- Utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral

-- Defaults
myTerminal      = "kitty"

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
          spawnOnce "$HOME/.local/bin/pmanag.sh &"
          spawnOnce "lxsession &"

-- Keybinding
myKeys :: [([Char], X())]
myKeys = 
      -- Xmonad restart and recompile
      [   ("M-C-r",      spawn "xmonad --recompile")              -- Recompiles xmonad
        , ("M-S-r",      spawn "xmonad --restart")                -- Restarts xmonad
        , ("M-S-q",      io exitSuccess)                          -- Exit xmonad
        , ("M-<Escape>", spawn "$HOME/.local/bin/power.sh")  -- Exit menu

        -- Programs
        , ("M-<Return>", spawn "kitty")
	, ("M-b",        spawn "brave")
	, ("M-n",        spawn "nitrogen")
	, ("M-o",        spawn "spotify")
	, ("M-S-o",      spawn "kill -9 $(pgrep spotify)")
	, ("M-m",        spawn "kodi")
	, ("M-S-m",      spawn "kill -9 $(pgrep kodi)")
	, ("M-v",        spawn "vlc")
	, ("M-S-v",      spawn "kill -9 $(pgrep vlc)")
	, ("M-i",        spawn "inkscape")
	, ("M-g",        spawn "geany")
	, ("M-f",        spawn "pcmanfm")
	, ("M-S-k",      spawn "keepassxc")
	, ("M-S-s",      spawn "filezilla")
	, ("M-u",        spawn "uget-gtk")
	, ("M-S-u",      spawn "kill -9 $(pgrep uget-gtk)")
	, ("M-C-b",      spawn "qbittorrent")
	, ("M-S-b",      spawn "kill -9 $(pgrep qbittorrent)")

	-- Multimedia keys
	, ("<XF86AudioRaiseVolume>",  spawn "$HOME/.local/bin/volume.sh up")
	, ("<XF86AudioLowerVolume>",  spawn "$HOME/.local/bin/volume.sh down")
	, ("<XF86AudioMute>",         spawn "$HOME/.local/bin/volume.sh mute")
	, ("<XF86AudioNext>",         spawn "playerctl next")
	, ("<XF86AudioPrev>",         spawn "playerctl previous")
	, ("<XF86AudioPlay>",         spawn "playerctl play-pause")
	, ("<XF86MonBrightnessUp>",   spawn "$HOME/.local/bin/brightness.sh up")
	, ("<XF86MonBrightnessDown>", spawn "$HOME/.local/bin/brightness.sh down")
      ]

-- Layouts
myLayouts = spacingRaw True (Border 3 3 3 3 ) True (Border 3 3 3 3 ) True (Tall 1 (3/100) (1/2) ||| noBorders (Full) ||| spiral (6/7))

-- Main
main = do
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
    xmonad $ docks def
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
			  , layoutHook         = avoidStruts $ myLayouts
                          , handleEventHook    = fullscreenEventHook

			  } `additionalKeysP` myKeys
