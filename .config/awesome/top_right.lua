local awful = require('awful')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

require('widgets.decoration')
require('widgets.Date_widget')
require('widgets.Packages_widget')
require('widgets.Disk_widget')
require('widgets.Memory_widget')
require('widgets.Cpu_widget')
require('widgets.Load_avg_widget')
require('widgets.Uptime_widget')
local volume_widget = require("widgets.volume-widget.volume")
local volume_widget_widget = volume_widget({display_notification = true})


local top_right = {}
local screen_width = awful.screen.focused().workarea.width

awful.screen.connect_for_each_screen(function(s)
    s.top_right = awful.wibar(
    {
        position = 'top',
        height = dpi(20),
        width = screen_width * 0.494,
    }
    )

    s.top_right:setup {
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                layout = wibox.layout.fixed.horizontal,
                net_widget, separator,
                pkg_widget, separator,
                disk_widget, separator,
                mem_widget, separator,
                cpu_widget, separator,
                Load_wdt, separator,
                uptime_wdt, separator,
                datewidget, separator,
                --volumewidget, separator,
                {
                    volume_widget_widget,
                    shape = Wdt_shape,
                    bg = Wdt_bg,
                    widget = wibox.container.background
                },
                separator,
                kbd_widget, separator,
                }
            },
            margins = screen_width * 0.0005,
            widget = wibox.container.margin
        }

end)
return top_right
