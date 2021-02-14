local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Packages_widget = {}

PKG_CMD = [[ bash -c 'pacman.sh']]
timeout = 3600

pkg_widget = wibox.widget {
    {
        {
            id = 'pkg_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
pkg_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e checkupdates')
    end
        end)

function Update_pkg_widget(widget,stdout)
    widget:get_children_by_id('pkg_wdt')[1]:set_text(stdout)
end

watch(PKG_CMD,timeout,Update_pkg_widget,pkg_widget)

return Packages_widget
