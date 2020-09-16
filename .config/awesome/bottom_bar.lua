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

local bottom_bar = {}
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.bottom_bar = awful.wibar({ position = "bottom", screen = s })
left = wibox.widget {
    {
        markup = '<span foreground = "#6c99ba"> Now playing  >>></span>',
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
	uptime_wdt, separator,
	kernel_wdt, separator,
        },
    }

end)
return bottom_bar
