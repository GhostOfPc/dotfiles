local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Media_widget = {}
MUSIC_CMD = [[bash -c '
pidof -s "spotifyd" >/dev/null && song_info=$(playerctl metadata --format "{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:artist}} - {{xesam:title}}") ; printf "$song_info" || exit
']]

Media_widget = wibox.widget {
    --[[layout = wibox.container.scroll.horizontal,
    max_size = awful.screen.focused().workarea.width * 0.25,
    step_function = wibox.container.scroll.step_functions.linear_increase,
    fps = 60,
    speed = 60,
    extra_space = 5,
    {
        {
            watch('bash -c "$HOME/.local/bin/music.sh"'),
            widget = wibox.container.margin(_,10,10,_,_,_,_),
        },
        bg = nil,
        shape = wdt_shape,
        widget = wibox.container.background
    }--]]
    widget = wibox.widget.textbox
}
Media_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e vis')
        elseif (button == 3) then awful.spawn.with_shell('alacritty --hold -e spt')
    end
        end)

local function update_media_widget(widget,stdout)
    widget:set_markup(stdout)
end
watch(MUSIC_CMD,_,update_media_widget,Media_widget)

return Media_widget
