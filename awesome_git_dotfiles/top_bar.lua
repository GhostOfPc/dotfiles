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

local top_bar = {}

screen.connect_signal('request::desktop_decoration', function(s)
    -- ==== Tasklist (Opened clients) ==========================================
    mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.focused,
    style    = {
        shape        = wdt_shape,
    },
    layout   = {
        spacing = 5,
        max_widget_size = awful.screen.focused().workarea.width * 0.12,
        layout  = wibox.layout.flex.horizontal
    },
    widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 2,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
}

-- Create the status bar
    top_bar = awful.wibar(
    {
        bg = beautiful.bg_normal,
        position = 'top',
        screen = s,
        width = awful.screen.focused().workarea.width * 1.0,
        height  = awful.screen.focused().workarea.height * 0.02
    })

    top_bar.widget = {
        layout = wibox.layout.align.horizontal,
	
	-- ================= Left widget ===========================
	{
        layout = wibox.layout.fixed.horizontal,
        separator, lag_wdt,separator,
        s.mytaglist, separator, 
        },
	-- ================= Middle widget ===========================
    {
        layout = wibox.layout.fixed.horizontal,
        mytasklist, separator,
    },

	-- ================= Right widget ===========================
	{
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
-- ===========================================================================================
end)


return top_bar
