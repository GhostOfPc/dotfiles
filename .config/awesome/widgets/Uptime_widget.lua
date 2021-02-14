local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Uptime_widget = {}

UP_CMD = [[ bash -c "awk '{print $1}' /proc/uptime" ]]
timeout = 60

uptime_wdt = wibox.widget {
    {
        {
            id = 'up_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

function Update_up_widget(widget,stdout)
    Up_sec = math.floor(stdout)
    up_d = math.floor(Up_sec   / (3600 * 24))
    up_h = math.floor((Up_sec  % (3600 * 24)) / 3600)
    up_m = math.floor(((Up_sec % (3600 * 24)) % 3600) / 60)
    widget:get_children_by_id('up_wdt')[1]:set_text('⏳' .. up_d .. 'd:' .. up_h .. 'h:' .. up_m .. 'm')
end

watch(UP_CMD,timeout,Update_up_widget,uptime_wdt)

return Uptime_widget
