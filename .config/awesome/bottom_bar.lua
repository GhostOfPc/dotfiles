--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

local awful = require("awful")
local wibox = require("wibox")
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
require 'widgets'

local bottom_bar = {}
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.bottom_bar = awful.wibar(
    {
        position = "bottom",
        screen = s ,
        height = dpi(21),
        width = awful.screen.focused().workarea.width * 0.96,
        shape = wdt_shape
    }
    )
left = wibox.widget {
    {
        markup = '<span foreground = "#6c99ba">Now playing  >>></span>',
        widget = wibox.widget.textbox,
    },
    widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
}right = wibox.widget {
    {
        markup = '<span foreground = "#6c99ba">&lt;&lt;&lt;</span>',
        widget = wibox.widget.textbox
    },
    widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
}

    -- Add widgets to the wibox
    s.bottom_bar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            separator, left, music_wdt, right, separator,
        },
	{ -- Middle widgets
		layout = wibox.layout.fixed.horizontal,
	},
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	layoutbox, separator,
	pkg_widget, separator,
    gpu_temp_widget, separator,
    temp_widget, separator,
	uptime_wdt, separator,
	kernel_wdt, separator,
    wibox.widget.systray(), separator,
        },
    }

end)
return bottom_bar
