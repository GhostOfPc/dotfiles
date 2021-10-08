local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

require('widgets.decoration')


local top_left = {}

awful.screen.connect_for_each_screen(function(s)
    s.top_left = awful.wibar(
    {
        position = 'left',
        screen  =   s,
        height = awful.screen.focused().geometry.height * 0.018,
        width = awful.screen.focused().geometry.width * 0.172,
        bg  = '#0000',
        shape = Wdt_shape,
    }
    )

    s.top_left:setup {
        {
            {
                spacing = 1,
                layout = wibox.layout.fixed.horizontal,
                logo, separator,
                s.mytaglist
            },
            top = awful.screen.focused().geometry.width * 0.0000,
            bottom = awful.screen.focused().geometry.width * 0.0000,
            left = awful.screen.focused().geometry.width * 0.00,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = bar_wdt_shape,
        bg = beautiful.bg_normal
    }

end)
return top_left
