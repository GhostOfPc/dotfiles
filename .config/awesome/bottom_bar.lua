local awful = require("awful")
local wibox = require("wibox")
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
require('top_right')
require('top_left')
--require('top_center')
require('widgets.Prayers_widget')
--require('widgets.Weather_widget')
require('widgets.Media_widget')
require('widgets.Date_widget')
require('widgets.Kernel_widget')
require('widgets.WEATHER_WIDGET')

local bottom_bar = {}

local screen_width = awful.screen.focused().workarea.width
local screen_height = awful.screen.focused().workarea.height

layoutbox = wibox.widget {
    {
        awful.widget.layoutbox(),
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    bg = Wdt_bg,
    shape = Wdt_shape,
    widget = wibox.container.background
}

awful.screen.connect_for_each_screen(function(s)

    s.bottom_bar = awful.wibar(
    {
        position = 'bottom',
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 0.96,
        --shape = Wdt_shape,
    }
    )
-- ========================= Widgets and bars placement =======================
    --s.top_bar.y = screen_height * 0.003
    s.top_right.x       =   screen_width * 0.503
    s.top_right.y       =   screen_height * 0.003
    s.top_left.x        =   screen_width * 0.0025
    s.top_left.y        =   screen_height * 0.003
    s.Prayers_widget.x  =   screen_width * 0.867
    s.Prayers_widget.y  =   screen_height * 0.634
    s.WEATHER_WIDGET.x  =   screen_width * 0.867
    s.WEATHER_WIDGET.y  =   screen_height * 0.39
    s.bottom_bar.y      =   screen_height * 0.998

    s.bottom_bar:setup {
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                separator,
                {
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                            {
                                text = 'Now Playing >>> ',
                                widget = wibox.widget.textbox
                            },
                            Media_wdt,
                            {
                                text = ' <<<',
                                widget = wibox.widget.textbox
                            }
                        },
                        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_)
                    },
                    bg = Wdt_bg,
                    shape = Wdt_shape,
                    widget = wibox.container.background
                }
            },
            {
                layout = wibox.layout.fixed.horizontal,
                wibox.widget {
                    forced_width = screen_width * 0.01,
                    opacity = 0,
                    widget = wibox.widget.separator
                },
                mytasklist
            },
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    {
                        Pryr_wdt,
                        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_)
                    },
                    bg = Wdt_bg,
                    shape = Wdt_shape,
                    widget = wibox.container.background
                },
                separator,
                {
                    {
                        WEATHER_WIDGET_DESC,
                        widget = wibox.container.margin(_,2,Wdt_rmgn,_,_,_,_)
                    },
                    bg = Wdt_bg,
                    shape = Wdt_shape,
                    widget = wibox.container.background,
                },
                separator,
                --gpu_temp_widget, separator,
                ----temp_widget, separator,
                kernel_wdt, separator,
                layoutbox, separator,
                --round_systry, separator,
            }
        },
        top = screen_width * 0.0005,
        bottom = screen_width * 0.0005,
        widget = wibox.container.margin
    }

end)

return bottom_bar
