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
require('widgets')

local bottom_bar = {}

screen.connect_signal('request::desktop_decoration', function(s)
-- Create the status bar
    s.bottom_bar = awful.wibar(
    {
        bg = beautiful.bg_normal,
        position = 'bottom', 
        screen = s,
        width = awful.screen.focused().workarea.width * 1.0,
        height  = awful.screen.focused().workarea.height * 0.02
    })

    s.bottom_bar.widget = {
        layout = wibox.layout.align.horizontal,
	
	-- ================= Left widget ===========================
	{
        layout = wibox.layout.fixed.horizontal,
        separator, lag_wdt,
        },
	-- ================= Middle widget ===========================
    {
        layout = wibox.layout.fixed.horizontal,
    },

	-- ================= Right widget ===========================
	{
        layout = wibox.layout.fixed.horizontal,
        separator, music_wdt,
	    s.mylayoutbox,
        },
    }
-- ===========================================================================================

end)


return bottom_bar
