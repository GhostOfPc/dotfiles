--    ██             ██         ████████ 
--   ░██            ████       ██░░░░░░██
--   ░██           ██░░██     ██      ░░ 
--   ░██          ██  ░░██   ░██         
--   ░██         ██████████  ░██    █████
--   ░██        ░██░░░░░░██  ░░██  ░░░░██
--   ░████████  ░██     ░██   ░░████████ 
--   ░░░░░░░░   ░░      ░░     ░░░░░░░░  
--        ██                                                             ██       ██
--       ████                                                           ░██      ░██
--      ██░░██   ███     ██  █████   ██████  ██████  ██████████   █████ ░██   █  ░██
--     ██  ░░██ ░░██  █ ░██ ██░░░██ ██░░░░  ██░░░░██░░██░░██░░██ ██░░░██░██  ███ ░██
--    ██████████ ░██ ███░██░███████░░█████ ░██   ░██ ░██ ░██ ░██░███████░██ ██░██░██
--   ░██░░░░░░██ ░████░████░██░░░░  ░░░░░██░██   ░██ ░██ ░██ ░██░██░░░░ ░████ ░░████
--   ░██     ░██ ███░ ░░░██░░██████ ██████ ░░██████  ███ ░██ ░██░░██████░██░   ░░░██
--   ░░      ░░ ░░░    ░░░  ░░░░░░ ░░░░░░   ░░░░░░  ░░░  ░░  ░░  ░░░░░░ ░░       ░░ 
--    ████     ████                                    
--   ░██░██   ██░██             ██████  ██████         
--   ░██░░██ ██ ░██    ██████  ░██░░░██░██░░░██  ██████
--   ░██ ░░███  ░██   ░░░░░░██ ░██  ░██░██  ░██ ██░░░░ 
--   ░██  ░░█   ░██    ███████ ░██████ ░██████ ░░█████ 
--   ░██   ░    ░██   ██░░░░██ ░██░░░  ░██░░░   ░░░░░██
--   ░██        ░██  ░░████████░██     ░██      ██████ 
--   ░░         ░░    ░░░░░░░░ ░░      ░░      ░░░░░░  
--    ╔════════════════════════════════════════╗
--   ╔╝                                        ╚╗
--   ║ Riced and crafted by  Hisham Abdul Hai  ║
--   ║ ...Founder of Linux Arab Gate (L A G)... ║
--   ╚╗                                        ╔╝ 
--    ╚════════════════════════════════════════╝

local awful = require('awful')
local filesystem = require('gears.filesystem')

local apps = {
	browser = "brave",
	editor	= os.getenv("EDITOR") or "nvim",
	fmanager = "pcmanfm",
	geditor	= "geany",
	launcher = "rofi -normal-window -modi drun -show drun",
	lock	= "i3lock",
	mc	= "kodi",
	mplayer	= "spotify",
	screenshot	=	'maim -B -u $HOME/.screenshoots/"Screenshot-"$(date +%Y-%m-%d-%H-%M).png',
	terminal = "kitty",
	vplayer	= "vlc",
	vector	= "inkscape",
	wallpaper = 'nitrogen'
}
local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd), false)
end

do
  local startup_apps=
  {
    "nitrogen --restore",
    "picom --experimental-backend",
    "xfce4-power-manager",
    "dunst",
    "lxsession"
  }

  for _,apps in pairs(startup_apps) do
    run_once(apps)
  end
end

return apps
