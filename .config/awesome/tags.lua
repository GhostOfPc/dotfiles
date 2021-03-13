local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
require('widgets.decoration')


local tags = {}
awful.screen.connect_for_each_screen(function(s)
    awful.tag.add('',{
            name                = 'Term',
            id                  = '1',
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap                 = 8,
			selected		    = true
			}
		)
    awful.tag.add('',{
            name                = 'web',
            id                  = '2',
			layout              = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 8,
			}
		)
    awful.tag.add('',{
            name                = 'Edit',
            id                  = '3',
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 8,
			}
		)
    awful.tag.add('',{
            name                = 'Files',
            id                  = '4',
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 8,
			}
		)
    awful.tag.add('',{
            name                = 'Music',
            id                  = '5',
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 20,
			}
		)
    awful.tag.add('',{
            name                = 'Vids',
            id                  = '6',
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 8,
			}
		)
    mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.focused,
    style    = {
        shape       =   Wdt_shape,
        bg_focus    =   Wdt_bg,
        align       =  'center'
    },
    layout   = {
        spacing = 5,
        max_widget_size = awful.screen.focused().workarea.width * 0.13,
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
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end)))
    -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
        screen  = s,
        style = {
            shape		= Wdt_shape,
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
