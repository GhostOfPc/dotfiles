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
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
--require('top_left')
--require('top_right')
require('prayer')

local bottom_bar = {}
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.bottom_bar = awful.wibox(
    {
        position = "bottom",
        screen = s ,
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 0.96,
        shape = wdt_shape,
        bg      =   beautiful.bottom_bar_bg
    }
    )
-- ========================= Widgets and bars placement =======================
    s.prayer.x = awful.screen.focused().workarea.width * 0.888
    s.prayer.y = awful.screen.focused().workarea.height * 0.75
    --s.top_left.x = 10
    --s.top_left.y = 0
    --s.top_right.x = 930
    --s.top_right.y = 0
    s.bottom_bar.y = 1050

left = wibox.widget {
    {
        text = 'Now playing >>>',
        widget = wibox.widget.textbox,
    },
    widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
}

right = wibox.widget {
    {
        text = '<<<',
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
        prayer_widget, separator, 
        wthr_widget, separator,
        gpu_temp_widget, separator,
        temp_widget, separator,
        uptime_wdt, separator,
        layoutbox, separator,
        --round_systry, separator,
        },
    }

end)
return bottom_bar
