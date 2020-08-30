--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Standard awesome library
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local bottom_bar = {}

left = wibox.widget {
    {
        markup = '<span foreground = "#0f7fcf"> Now playing  >>></span>',
        widget = wibox.widget.textbox,
    },
    widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
}right = wibox.widget {
    {
        markup = '<span foreground = "#0f7fcf">&lt;&lt;&lt;</span>',
        widget = wibox.widget.textbox
    },
    widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
}

screen.connect_signal('request::desktop_decoration', function(s)

    bottom_bar = awful.wibar(
    {
        bg = beautiful.bg_normal,
        position = 'bottom', 
        screen = s,
        width = awful.screen.focused().workarea.width * 1.0,
        height  = awful.screen.focused().workarea.height * 0.02
    })

    bottom_bar.widget = {
        layout = wibox.layout.align.horizontal,
	
	-- ================= Left widget ===========================
	{
        layout = wibox.layout.fixed.horizontal,
        separator, left, music_wdt,  right, separator, 
        },
	-- ================= Middle widget ===========================
    {
        layout = wibox.layout.fixed.horizontal,
    },

	-- ================= Right widget ===========================
	{
        layout = wibox.layout.fixed.horizontal,
        layoutbox, separator,
        pkg_widget, separator,
        uptime_wdt, separator, 
        kernel_wdt, separator, 
        },
    }
-- ===========================================================================================

end)


return bottom_bar
