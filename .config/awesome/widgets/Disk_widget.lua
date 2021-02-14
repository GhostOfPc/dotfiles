local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Disk_widget = {}

DSK_CMD = [[ bash -c 'disk.sh']]
timeout = 300

disk_widget = wibox.widget {
    {
        {
            id = 'disk_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
disk_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell ('alacritty --hold -e dust -r /home')
    end
        end)

function Update_disk_widget(widget,stdout)
    widget:get_children_by_id('disk_wdt')[1]:set_text(stdout)
end

watch(DSK_CMD,timeout,Update_disk_widget,disk_widget)

return Disk_widget
