local awful = require('awful')
local gears = require('gears')
local apps = require('apps')
local hotkeys_popup = require('awful.hotkeys_popup')
local icon_dir = '/usr/share/icons/Papirus/48x48/apps/'
local config_dir = gears.filesystem.get_configuration_dir()

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, icon_dir .. 'system-config-keyboard.svg' },
   { "restart", awesome.restart, icon_dir .. 'system-reboot.svg' },
   { "quit", function() awesome.quit() end, icon_dir .. 'system-log-out.svg'},
}

applications = {
   { "Browser", apps.browser, icon_dir .. 'qutebrowser.svg' },
   { "File Manager", function() awful.spawn.with_shell('pcmanfm') end, icon_dir .. 'system-file-manager.svg' },
   { "Editor", function() awful.spawn.with_shell('geany') end, icon_dir .. 'geany.svg' },
   { "Spotify", apps.mplayer, icon_dir .. 'spotify.svg' },
   { "Inkscape", function() awful.spawn.with_shell('inkscape') end, icon_dir .. 'inkscape.svg' },
   { "MPV", function() awful.spawn.with_shell('mpv') end, icon_dir .. 'mpv.svg' },
   { "Nitrogen", function() awful.spawn.with_shell('nitrogen') end, icon_dir .. 'nitrogen.svg' },
}

mymainmenu = awful.menu(
{
    items = {
        { "Applications", applications, icon_dir .. 'app-launcher.svg' },
        { "open terminal", apps.terminal, icon_dir .. 'terminal.svg' },
        { "awesome", myawesomemenu, config_dir .. 'icons/dove.svg' },
        { "Logout", function() awful.spawn.with_shell('killall $WM') end, icon_dir .. 'system-log-out.svg' },
        { "Reboot", function() awful.spawn.with_shell('systemctl reboot') end, icon_dir .. 'system-reboot.svg' },
        { "Shutdown", function() awful.spawn.with_shell('systemctl shutdown -h') end, icon_dir .. 'system-shutdown.svg' },
    }
}
)
