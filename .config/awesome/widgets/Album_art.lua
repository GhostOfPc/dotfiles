local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local watch = require('awful.widget.watch')
local wibox = require('wibox')

--ART_CMD = [[ bash -c 'playerctl metadata --format "{{lc(mpris:artUrl)}}" | convert -flatten -thumbnail 256x256 /tmp/thumb.png' ]]

local Album_art = {}

cover = wibox.widget {
        id = 'cover',
        --image = '/tmp/thumb.png',
        widget = wibox.widget.imagebox
}

gears.timer {
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = function()
        awful.spawn.easy_async(
        {"sh", "-c", "playerctl metadata --format '{{lc(mpris:artUrl)}}' | convert -flatten -thumbnail 256x256 /tmp/thumb.png"},
        function()
        cover.image = '/tmp/thumb.png'
    end
        )
    end
}
--watch(ART_CMD,60,update_cover,cover)

awful.screen.connect_for_each_screen(function(s)
    s.Album_art = awful.wibar(
    {
        screen = 's',
        position = 'left',
        height  =   300,
        width   =   300,
        shape   =   wdt_shape,
        bg      =   beautiful.bottom_bar_bg,
    }
    )
    s.Album_art:setup {
        layout = wibox.layout.fixed.vertical,
        cover
    }
end)
return Album_art
