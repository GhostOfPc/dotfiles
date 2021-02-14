local wibox = require('wibox')

local Date_widget = {}

datewidget = wibox.widget {
    {
        {
            format = "📅 %d-%m-%y(%a)|%H:%M",
            widget = wibox.widget.textclock
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

return Date_widget
