-- Imports
-- Essentials
import XMonad
import System.IO
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Actions
import XMonad.Actions.SpawnOn
import XMonad.Actions.Submap

-- Prompts
import XMonad.Prompt
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.XMonad
import XMonad.Prompt.Ssh
import XMonad.Prompt.Man
import Control.Arrow (first)

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers ( isFullscreen, isDialog, doCenterFloat, doFullFloat )
import XMonad.Hooks.DynamicProperty

-- Utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce

-- Layouts modifiers
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LayoutHints
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral

-- Defaults
myTerminal      = "kitty"

-- Variables
myModKey :: KeyMask
myModKey        = mod4Mask
altMask :: KeyMask
altMask         = mod1Mask
raltMask :: KeyMask
raltMask        = mod5Mask

myFont :: [Char]
myFont          = "xft:FiraMono Nerd Font:regular:pixelsize=10"

myBorderWidth :: Dimension
myBorderWidth   = 2

myNormColor :: [Char]
myNormColor     = "#181818"

myFocusColor :: [Char]
myFocusColor    = "#7575ff"

-- Workspaces
myWorkspaces :: [String]
myWorkspaces    = ["dev", "web", "edit", "files", "music", "vids"]

-- Autostart
mystartupHook :: X ()
mystartupHook   = do
          spanwOnce "xsetroot -cursor_name bloom &"
          spawnOnce "nitrogen --restore &"
          spawnOnce "picom --experimental-backends &"
          spawnOnce "dunst &"
          spawnOnce "$HOME/.local/bin/pmanag.sh &"
          spawnOnce "lxsession &"
          -- spawnOnce "polybar xmonad &"

-- Keybinding
myKeys :: [([Char], X())]
myKeys = 
      -- Xmonad restart and recompile
        [ ("M-C-r",      spawn "xmonad --recompile")
        , ("M-S-r",      spawn "xmonad --restart")
        , ("M-S-q",      io exitSuccess)

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
        , ("M-C-s",      spawn "filezilla")
        , ("M-u",        spawn "uget-gtk")
        , ("M-S-u",      spawn "kill -9 $(pgrep uget-gtk)")
        , ("M-C-b",      spawn "qbittorrent")
        , ("M-S-b",      spawn "kill -9 $(pgrep qbittorrent)")
        , ("M-M1-h",     spawn "xterm -hold htop")
        , ("M-M1-n",     spawn "xterm -hold neofetch")
        , ("M-M1-c",     spawn "kitty -e cmatrix")
        , ("M-c b",      spawn "blueman-manager")
        , ("M-c i",      spawn "nm-connection-editor")

        -- Screenshoot
        , ("M-S-s", spawn "maim -B -u $HOME/.screenshoots/'Screenshoot-'$(date +%Y-%m-%d-%H-%M).png")
        
        -- Layouts
        , ("M1-f", sendMessage $ Toggle FULL)
        
        -- dmenu commands
        , ("M5-1",        spawn "$HOME/.local/bin/dmenu_url.sh")
        , ("M5-2",        spawn "$HOME/.local/bin/dmenu_webSearch.sh")
        , ("M5-3",        spawn "$HOME/.local/bin/dmenu_kill.sh")
        , ("M5-4",        spawn "$HOME/.local/bin/nordvpn.sh")
        , ("M5-5",        spawn "$HOME/.local/bin/dmenu_emoji.sh")
        , ("M5-6",        spawn "$HOME/.local/bin/configs.sh")
        , ("M1-<Escape>", spawn "$HOME/.local/bin/power.sh")

        -- Multimedia keys
        , ("<XF86AudioRaiseVolume>",  spawn "$HOME/.local/bin/volume.sh up")
        , ("<XF86AudioLowerVolume>",  spawn "$HOME/.local/bin/volume.sh down")
        , ("<XF86AudioMute>",         spawn "$HOME/.local/bin/volume.sh mute")
        , ("<XF86AudioNext>",         spawn "playerctl next")
        , ("<XF86AudioPrev>",         spawn "playerctl previous")
        , ("<XF86AudioPlay>",         spawn "playerctl play-pause")
        , ("<XF86MonBrightnessUp>",   spawn "$HOME/.local/bin/brightness.sh up")
        , ("<XF86MonBrightnessDown>", spawn "$HOME/.local/bin/brightness.sh down")
        , ("M1-x",  spawn "$HOME/.local/bin/volume.sh up")        -- Another way to change volume since my multimedia keys are aweful
        , ("M1-z",  spawn "$HOME/.local/bin/volume.sh down")      -- Another way to change volume since my multimedia keys are aweful
        , ("M1-c",  spawn "$HOME/.local/bin/volume.sh mute")      -- Another way to change volume since my multimedia keys are aweful
        , ("M1-s",  spawn "$HOME/.local/bin/brightness.sh up")    -- Another way to change volume since my multimedia keys are aweful
        , ("M1-a",  spawn "$HOME/.local/bin/brightness.sh down")  -- Another way to change volume since my multimedia keys are aweful
        ]

-- Layouts
myLayouts = avoidStruts $ spacingRaw False ( Border 2 2 2 2 ) True ( Border 2 2 2 2 ) True $
            Tall 1 (3/100) (1/2) 
            ||| spiral (6/7)
            ||| Mirror (Tall 1 (3/100) (1/2))
            ||| Full

-- Manage Hooks
myManageHook = composeAll
    [ className =? "Brave-browser" --> doShift "web"
    , className =? "kitty" --> doShift "dev"
    , className =? "vlc" --> doShift "vids"
    , className =? "Kodi" --> doShift "vids" <+> doFloat
    , className =? "Nitrogen" --> doCenterFloat 
    , className =? "Lxappearance" --> doCenterFloat 
    , className =? "qt5ct" --> doCenterFloat
    , className =? "Pavucontrol" --> doCenterFloat
    , className =? "Blueman-manager" --> doCenterFloat
    , className =? "Nm-connection-editor" --> doCenterFloat
    , isFullscreen --> doFullFloat
    ]

-- Dynamic hook (Spotify)
myDynHook = composeAll
    [ className =? "Spotify" --> doShift "music"
    ]
-- Main
main = do
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
    xmonad $ ewmh $ docks def
                          { terminal           = myTerminal
                          , modMask            = myModKey
                          , borderWidth        = myBorderWidth
                          , normalBorderColor  = myNormColor
                          , focusedBorderColor = myFocusColor
                          , startupHook        = mystartupHook
                          , workspaces         = myWorkspaces
                          , logHook            = dynamicLogWithPP xmobarPP
                                   { ppOutput = hPutStrLn xmproc
                                   , ppCurrent = xmobarColor "#7575ff" "" . wrap "[" "]" -- Current workspace in xmobar
                                   , ppVisible = xmobarColor "#d7eaf3" ""                -- Visible but not current workspace
                                   , ppHidden = xmobarColor "#ff92d0" "" . wrap "|" "|"   -- Hidden workspaces in xmobar
                                   , ppHiddenNoWindows = xmobarColor "#8e8e8e" ""        -- Hidden workspaces (no windows)
                                   , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                                   , ppSep =  "<fc=#666666> | </fc>"                     -- Separators in xmobar
                                   , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                                   , ppOrder  = \(ws:l:t:ex) -> [ws,l]
                                   }
                          , layoutHook         = myLayouts
                          , manageHook         = myManageHook
                          , handleEventHook    = dynamicPropertyChange "WM_NAME" myDynHook <+> fullscreenEventHook

                          } `additionalKeysP` myKeys
