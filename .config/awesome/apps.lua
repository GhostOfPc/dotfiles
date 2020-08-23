--    ╔════════════════════════════════════════╗
--   ╔╝                                        ╚╗
--   ║ Riced and crafted by  Hisham Abdul Hai  ║
--   ║ ...Founder of Linux Arab Gate (L A G)... ║
--   ╚╗                                        ╔╝ 
--    ╚════════════════════════════════════════╝

local awful = require('awful')
local filesystem = require('gears.filesystem')

local apps = {
    browser = 'firefox',
	editor	= os.getenv('EDITOR') or 'nvim',
	fmanager = 'pcmanfm',
	geditor	= 'geany',
	launcher = 'dmenu_run -i',
	lock	= 'i3lock',
	mc	= 'plexmediaplayer',
	mplayer	= 'spotify',
	screenshot	=	'maim -B -u $HOME/.screenshots/"Screenshot-"$(date +%Y-%m-%d-%H-%M).png',
	terminal = 'kitty',
	vplayer	= 'mpv',
	vector	= 'inkscape',
	ssh	= 'filezilla',
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
      'nitrogen --restore',
      'picom',
      --'$HOME/.local/bin/pmanag.sh',
      'dunst',
      'lxsession'
  }

  for _,apps in pairs(startup_apps) do
      run_once(apps)
  end
end

return apps
