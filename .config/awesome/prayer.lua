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

local prayer = {}
-- Prayer times
prayers = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/prayers.sh"'),
        widget = wibox.container.margin(_,10,10,_,_,_,_),
    },
    --bg = wdt_bg,
    --shape = wdt_shape,
    widget = wibox.container.background
}
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.prayer = awful.wibox(
    {
        screen  =   s ,
        height  =   awful.screen.focused().workarea.height * 0.16,
        width  =   awful.screen.focused().workarea.width * 0.07,
        --height  =   dpi(120),
        --width   =   dpi(100),
        shape   =   wdt_shape,
        bg      =   beautiful.bottom_bar_bg,
    }
    )

    -- Add widgets to the wibox
    s.prayer:setup {
        layout = wibox.layout.flex.horizontal,
        prayers,
    }

end)
return prayer
