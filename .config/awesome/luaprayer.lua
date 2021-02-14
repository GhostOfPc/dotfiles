local json    =   require('json')
local watch   =   require('awful.widget.watch')
local awful   =   require('awful')
local wibox   =   require('wibox')
local beautiful =   require('beautiful')
local gears =   require('gears')
local config_dir = gears.filesystem.get_configuration_dir()


local luaprayer = {}

icon = wibox.widget {
        {
            image = config_dir ..'/icons/praying.svg',
            forced_height    =   100,
            forced_width    =   100,
            resize = true,
            opacity = 0.9,
            widget = wibox.widget.imagebox
        },
        align   =   'center',
        widget  =   wibox.container.place
}

local prayer_wdt = wibox.widget {
        font    =   'Noto Kufi Arabic 8',
        widget  =   wibox.widget.textbox
}

local GET_TIMES_CMD = [[bash -c "curl -s '%s'"]]

local city = 'Bariloche'
local country = 'Argentina'
local method = '3'
local timeout = 3600

local api = ("http://api.aladhan.com/v1/timingsByCity?city=" .. city .. "&country=" .. country .. "&method=" .. method)

watch(
--salawat = string.format(GET_TIMES_CMD,api)
"bash -c 'cat $HOME/.local/share/prayers_formatted'",timeout,
function(_,stdout)
    prayer_wdt:set_text(stdout)
end
)

awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.luaprayer = awful.wibox(
    {
        screen  =   s ,
        height  =   awful.screen.focused().workarea.height * 0.335,
        width   =   awful.screen.focused().workarea.width * 0.13,
        shape   =   wdt_shape,
        bg      =   beautiful.bottom_bar_bg,
    }
    )

    -- Add widgets to the wibox
    s.luaprayer:setup {
            {
                {
                    id  =   'icon',
                    layout = wibox.layout.flex.vertical,
                    icon
                },
                {
                    {
                        {
                            id  =   'times',
                            layout = wibox.layout.flex.horizontal,
                            prayer_wdt
                        },
                        widget  =   wibox.container.margin(_,_,6,_,_,_,_)
                    },
                    bg  =   wdt_bg,
                    shape   =   wdt_shape,
                    widget  =   wibox.container.background,
                },
                layout  =   wibox.layout.fixed.vertical,
                spacing =   15,
            },
            widget  =   wibox.container.margin(_,10,10,5,5,_,_)
    }

end)

return luaprayer

