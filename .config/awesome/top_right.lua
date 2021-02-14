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

-- Calls
require('widgets.decoration')
require('widgets.Date_widget')
require('widgets.Kernel_widget')
require('widgets.Packages_widget')
require('widgets.Disk_widget')
require('widgets.Memory_widget')
require('widgets.Cpu_widget')
local volume_widget = require("widgets.volume-widget.volume")
local volume_widget_widget = volume_widget({display_notification = true})
--require('widgets.Volume_widget')
--require('widgets.Net_widget')


local top_right = {}

awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.top_right = awful.wibar(
    {
        position = 'top',
        screen = s ,
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 0.443,
    }
    )

    -- Add widgets to the wibox
    s.top_right:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
	{ -- Middle widgets
		layout = wibox.layout.fixed.horizontal,
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
	    --volumewidget, separator,
        {
            volume_widget_widget,
            shape = wdt_shape,
            bg = wdt_bg,
            widget = wibox.container.background
        },
        separator,
	    kbd_widget, separator,
        --round_systry, separator,
        },
    }

end)
return top_right
