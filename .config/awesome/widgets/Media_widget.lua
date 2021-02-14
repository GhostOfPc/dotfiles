local watch = require('awful.widget.watch')
local wibox = require('wibox')
local awful = require('awful')

local Media_widget = {}


MEDIA_CMD = [[bash -c '
if pidof -s "mpv" >/dev/null;then
    title=$(playerctl metadata --format "{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:title}}")
    echo -e $title

elif pidof -s "spotifyd" >/dev/null; then
    song_info=$(playerctl metadata --format "{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:artist}} - {{xesam:title}}")
    echo -e $song_info

elif pidof -s "mpd" >/dev/null; then 
	play_info=$(mpc current)
    play_sts=$(mpc | awk "/\[/ {print $1}")
    play_pos=$(mpc | awk "/\[/ {print $3}" | awk -F "/" "{print $1 '[' $2 ']'}")
	case "$play_sts" in
		"[paused]") cur_icon="⏸️" ;;
		"[playing]") cur_icon="▶️" ;;
	esac
	echo -e $cur_icon $play_pos $play_info
else exit 
fi
']]

Media_wdt = wibox.widget {
        {
            id = 'current_song',
            widget = wibox.widget.textbox
        },
        layout = wibox.container.scroll.horizontal,
        max_size = awful.screen.focused().workarea.width * 0.25,
        step_function = wibox.container.scroll.step_functions.linear_increase,
        fps = 75,
        speed = 60,
        extra_space = 5
}
Media_wdt:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e vis')
        elseif (button == 3) then awful.spawn.with_shell('alacritty --hold -e spt')
    end
        end)

function Update_media_widget(widget,stdout)
    widget:get_children_by_id('current_song')[1]:set_text(stdout)
end

watch(MEDIA_CMD,2,Update_media_widget,Media_wdt)

return Media_widget
