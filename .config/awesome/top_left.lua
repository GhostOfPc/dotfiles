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


local top_left = {}

awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.top_left = awful.wibar(
    {
        position = 'left',
        screen = s ,
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 0.17,
    }
    )

    -- Add widgets to the wibox
    s.top_left:setup {
        spacing = 1,
        layout = wibox.layout.fixed.horizontal,
        separator, logo, separator,
        s.mytaglist
    }

end)
return top_left
