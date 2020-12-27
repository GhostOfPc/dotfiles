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
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi


local top_bar = {}
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.top_bar = awful.wibar(
    {
        position = 'top',
        screen = s ,
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 1.007,
    }
    )

    -- Add widgets to the wibox
    s.top_bar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            separator, separator, lag_wdt, separator,
            s.mytaglist, separator,
        },
	{ -- Middle widgets
		layout = wibox.layout.fixed.horizontal,
		mytasklist, separator,
	},
        { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
	    net_widget, separator,
        pkg_widget, separator,
	    disk_widget, separator,
	    mem_widget, separator,
	    cpu_widget, separator,
        kernel_wdt, separator,
	    datewidget, separator,
	    volumewidget, separator,
	    kbd_widget, separator,separator,
        },
    }

end)
return top_bar
