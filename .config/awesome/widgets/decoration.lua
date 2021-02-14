--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Initialization
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local config_dir = gears.filesystem.get_configuration_dir()

local decoration = {}
local screen_width = awful.screen.focused().workarea.width

-- Global widgets settings
wdt_bg      =   beautiful.bg_empty
wdt_shape   =   function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, screen_width * 0.0025) end
wdt_rmgn    =   screen_width * 0.002
wdt_lmgn    =   screen_width * 0.002

-- the systray has its own internal background because of X11 limitations
round_systry = wibox.widget {
    {
        wibox.widget.systray(),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg         = wdt_bg,
    shape      = wdt_shape,
    widget     = wibox.container.background,
}

kbd_widget = wibox.widget {
    {
        {
            widget = awful.widget.keyboardlayout()
        },
        margins = screen_width * 0.001,
        widget = wibox.container.margin
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

logo = wibox.widget {
        {
            image = config_dir ..'/icons/dove.svg',
            resize = true,
            opacity = 1.0,
            widget = wibox.widget.imagebox
        },
        margins = screen_width * 0.001,
        widget = wibox.container.margin
}
logo:connect_signal('button::press',function(_,_,_,button)
    if (button == 1) then mymainmenu:toggle()
    end
end)

separator = {

                forced_width    = screen_width * 0.0013,
                opacity         = 0,
                widget          = wibox.widget.separator
            }

return decration
