local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Uptime_widget = {}
local screen_width = awful.screen.focused().workarea.width

UP_CMD = [[ bash -c "awk '{print $1}' /proc/uptime" ]]
timeout = 60

uptime_wdt = wibox.widget {
    {
        {
            id = 'up_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    bg = Wdt_bg,
    forced_width = screen_width * 0.062,
    shape = Wdt_shape,
    widget = wibox.container.background
}

function Update_up_widget(widget,stdout)
    Up_sec = math.floor(stdout)
    up_d = math.floor(Up_sec   / (3600 * 24))
    up_h = math.floor((Up_sec  % (3600 * 24)) / 3600)
    up_m = math.floor(((Up_sec % (3600 * 24)) % 3600) / 60)
    widget:get_children_by_id('up_wdt')[1]:set_text('⏳' .. string.format('%2d',up_d) ..
    'd:' .. string.format('%2d',up_h) .. 'h:' .. string.format('%2d',up_m) .. 'm')
end

watch(UP_CMD,timeout,Update_up_widget,uptime_wdt)

return Uptime_widget
