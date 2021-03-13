local awful = require('awful')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

require('widgets.decoration')


local top_left = {}

awful.screen.connect_for_each_screen(function(s)
    s.top_left = awful.wibar(
    {
        position = 'left',
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 0.17,
    }
    )

    s.top_left:setup {
        {
            spacing = 1,
            layout = wibox.layout.fixed.horizontal,
            separator, logo, separator,
            s.mytaglist
        },
        margins = awful.screen.focused().workarea.width * 0.0005,
        widget = wibox.container.margin
    }

end)
return top_left
