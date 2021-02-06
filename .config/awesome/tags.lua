--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')


local tags = {}
awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag.add('',{
            name            = 'Term',
            id              = '1',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 8,
			screen			= s,
			selected		= true
			}
		)
    awful.tag.add('',{
            name            = 'web',
            id              = '2',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 8,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Edit',
            id              = '3',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 8,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Files',
            id              = '4',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 8,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Music',
            id              = '5',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 20,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Vids',
            id              = '6',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 8,
			screen			= s
			}
		)
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
                        resize = true,
                        widget = wibox.widget.imagebox,
                    },
                    widget  = wibox.container.margin(_,_,_,_,_,_)
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
    -- Create an imagebox widget which contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end)))
    -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
        screen  = s,
        style = {
            shape		= wdt_shape,
            bg_focus	= beautiful.bg_empty,
            fg_focus    = beautiful.fg_focus,
            fg_occupied = beautiful.fg_occupied,
            fg_empty    = beautiful.taglist_fg_empty
        },
            layout	= {
                layout = wibox.layout.fixed.horizontal,
                spacing = 5,
            },
            filter  = awful.widget.taglist.filter.all,
            buttons = awful.button({ }, 1, function(t) t:view_only() end)
    }

end)
return tags
