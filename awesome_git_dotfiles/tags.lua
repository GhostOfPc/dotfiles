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

local tags = {}
screen.connect_signal('request::desktop_decoration', function(s)
    -- ==== Each tag has its layout and gaps and eventually in rules its clients ==============
    awful.tag.add('',{
            name            = 'Term',
            id              = '1',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 4,
			screen			= s,
			selected		= true
			}
		)
    awful.tag.add('',{
            name            = 'web',
            id              = '2',
			layout			= awful.layout.suit.max,
			gap_single_client	= true,
			gap			= 4,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Edit',
            id              = '3',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 10,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Files',
            id              = '4',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 23,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Music',
            id              = '5',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 43,
			screen			= s
			}
		)
    awful.tag.add('',{
            name            = 'Vids',
            id              = '6',
			layout			= awful.layout.suit.fullscreen,
			gap_single_client	= true,
			gap			= 10,
			screen			= s
			}
		)

    -- ==== Layout indication icon (On the left of the status bar) ==============
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = awful.button({ }, 1, function () awful.layout.inc( 1) end),
    }
    -- =============== Create a taglist widget ==================================
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        style = {
            shape		= wdt_shape,
            bg_focus	= beautiful.bg_empty,
            fg_focus    = beautiful.fg_focus,
            fg_occupied = beautiful.fg_occupied,
            fg_empty    = '#d7eaf340'
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
