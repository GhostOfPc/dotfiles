local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Weather_widget = {}

WTHR_CMD = [[ bash -c 'weather.sh' ]]
timeout = 1800

wthr_widget = wibox.widget {
    {
        {
            id = 'weather_widget',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

function Update_wthr_widget(widget,stdout)
    widget:get_children_by_id('weather_widget')[1]:set_text(stdout)
end

watch(WTHR_CMD,timeout,Update_wthr_widget,wthr_widget)
return Weather_widget
