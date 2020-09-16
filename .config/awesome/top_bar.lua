--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

local awful = require('awful')
local wibox = require('wibox')


local top_bar = {}
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    top_bar = awful.wibar({ position = 'top', screen = s })

    -- Add widgets to the wibox
    top_bar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            separator, lag_wdt, separator,
            s.mytaglist, separator,
        },
	{ -- Middle widgets
		layout = wibox.layout.fixed.horizontal,
		mytasklist, separator,
	},
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	    wthr_widget, separator,
	    net_widget, separator,
	    disk_widget, separator,
	    mem_widget, separator,
	    cpu_widget, separator,
	    datewidget, separator,
	    volumewidget, separator,
	    kbd_widget, separator,
        },
    }

end)
return top_bar
