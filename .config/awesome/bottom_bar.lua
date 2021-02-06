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
require('top_bar')
require('Prayers_widget')

local bottom_bar = {}
awful.screen.connect_for_each_screen(function(s)

    s.bottom_bar = awful.wibar(
    {
        position = 'bottom',
        screen = s ,
        height = dpi(20),
        width = awful.screen.focused().workarea.width * 0.96,
        --shape = wdt_shape,
        bg      =   beautiful.bottom_bar_bg
    }
    )
-- ========================= Widgets and bars placement =======================
    s.top_bar.y = 3
    --s.prayer.x = awful.screen.focused().workarea.width * 0.888
    --s.prayer.y = awful.screen.focused().workarea.height * 0.75
    s.Prayers_widget.x = awful.screen.focused().workarea.width * 0.867
    s.Prayers_widget.y = awful.screen.focused().workarea.height * 0.647
    s.bottom_bar.y = 1050

    s.bottom_bar:setup {
        layout = wibox.layout.align.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    {
                        id = 'left',
                        text = 'Now Playing >>> ',
                        widget = wibox.widget.textbox
                    },
                    Media_wdt,
                    {
                        id = 'right',
                        text = ' <<<',
                        widget = wibox.widget.textbox
                    }
                },
                widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_)
            },
            bg = wdt_bg,
            shape = wdt_shape,
            widget = wibox.container.background
        },
        {
            layout = wibox.layout.fixed.horizontal,
        },
        {
        layout = wibox.layout.fixed.horizontal,
        --prayer_widget, separator,
        {
            {
                Pryr_wdt,
                widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_)
            },
            bg = wdt_bg,
            shape = wdt_shape,
            widget = wibox.container.background
        },
        separator,
        wthr_widget, separator,
        --gpu_temp_widget, separator,
        --temp_widget, separator,
        uptime_wdt, separator,
        layoutbox, separator,
        --round_systry, separator,
        },
    }

end)

return bottom_bar
