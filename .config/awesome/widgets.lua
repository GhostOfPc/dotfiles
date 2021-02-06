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
local watch = require('awful.widget.watch')
local config_dir = gears.filesystem.get_configuration_dir()


local widgets = {}
wdt_bg      =   beautiful.bg_empty

wdt_shape   =   function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 6) end

wdt_rmgn    =   '6'
wdt_lmgn    =   '6'

logo = wibox.widget {
        {
            image = config_dir ..'/icons/dove.svg',
            resize = true,
            opacity = 1.0,
            widget = wibox.widget.imagebox
        },
        widget = wibox.container.margin(_,2,2,2,2,_,_),
}

-- layout widget
layoutbox = wibox.widget {
    {
        awful.widget.layoutbox(screen[1]),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
-- separator

separator = {

                forced_width    = 3,
                opacity         = 0,
                widget          = wibox.widget.separator
            }

--[[ Cpu temperature
temp_widget = wibox.widget {
    {
        watch('bash -c "temp.sh"',10),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

-- Gpu temperature
gpu_temp_widget = wibox.widget {
    {
        watch('bash -c "temp_gpu.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
--]]

-- Weather
wthr_widget = wibox.widget {
    {
        watch('bash -c "weather.sh"', 1800),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
wthr_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell ('alacritty --hold -e curl wttr.in/bariloche')
    end
end)
-- Network traffic
net_widget = wibox.widget {
    {
        watch('bash -c "net.sh"',1),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
net_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e bmon -p eno2')
    end
end)

-- Free disk available
disk_widget = wibox.widget {
    {
        watch('bash -c "disk.sh"', 300),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
disk_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell ('alacritty --hold -e dust -r /home')
    end
        end)

-- Memory usage
mem_widget = wibox.widget {
    {
        {
            id = 'mem_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
mem_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e htop')
    end
        end)

function update_mem_widget(widget,stdout)
    widget:get_children_by_id('mem_wdt')[1]:set_text(stdout)
end
MEM_CMD = [[ bash -c 'memory.sh' ]]
watch(MEM_CMD,10,update_mem_widget,mem_widget)
---- Cpu usage
cpu_widget = wibox.widget {
    {
        {
            id = 'cpu_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
cpu_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e htop')
    end
        end)
function update_cpu_widget(widget,stdout)
    widget:get_children_by_id('cpu_wdt')[1]:set_text(stdout)
end
CPU_CMD = [[ bash -c 'cpu.sh']]
watch(CPU_CMD,10,update_cpu_widget,cpu_widget)

-- Keyboard layout indicator
kbd_widget = wibox.widget {
    {
        watch('bash -c "kb-layout.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_)
    },
    bg = wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}

----Volume
volumewidget = wibox.widget {
    {
        {
            id = 'vol_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}

function Update_vol_widget(widget,stdout)
    --widget:set_text(stdout)
    widget:get_children_by_id('vol_wdt')[1]:set_text(stdout)
end

VOL_CMD = [[ bash -c 'volume_mon.sh' ]]
Vol_wdt_timer = watch(VOL_CMD,_,Update_vol_widget,volumewidget)

    --[[
	scrolling when the cursor is over the widdget
	toggling the sound on and off by clicking the widget
    --]]
	volumewidget:connect_signal('button::press', function (_,_,_,button)
	if (button == 4) then  awful.spawn.with_shell ('volume.sh up') 
	elseif (button == 5) then awful.spawn.with_shell ('volume.sh down') 
	elseif (button == 1 ) then awful.spawn.with_shell ('alacritty --hold -e pulsemixer') 
	end
			end)

---- Date and time
datewidget = wibox.widget {
    {
        {
            format = "📅 %d-%m-%y(%a)|%H:%M",
            widget = wibox.widget.textclock
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}

Media_wdt = wibox.widget {
    {
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
    },
    shape = wdt_shape,
    widget = wibox.container.background
}

Media_wdt:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e vis')
        elseif (button == 3) then awful.spawn.with_shell('alacritty --hold -e spt')
    end
        end)

local function update_music_widget(widget,stdout)
    widget:get_children_by_id('current_song')[1]:set_text(stdout)
end

MUSIC_CMD = [[bash -c '
if pidof -s "mpv" >/dev/null;then
    title=$(playerctl metadata --format "{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:title}}")
    printf "$title"

elif pidof -s "spotifyd" >/dev/null; then
    song_info=$(playerctl metadata --format "{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:artist}} - {{xesam:title}}")
    printf "$song_info"

elif pidof -s "mpd" >/dev/null; then 
	play_info=$(mpc current)
    play_sts=$(mpc | awk "/\[/ {print $1}"); play_pos=$(mpc | awk "/\[/ {print $3}" | awk -F "/" "{print $1 '[' $2 ']'}")
	case "$play_sts" in
		"[paused]") cur_icon="⏸️" ;;
		"[playing]") cur_icon="▶️" ;;
	esac
	printf "$cur_icon $play_pos $play_info"
else exit 
fi
']]

watch(MUSIC_CMD,_,update_music_widget,Media_wdt)

pkg_widget = wibox.widget {
    {
        watch('bash -c "pacman.sh"', 3600),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
pkg_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e checkupdates')
    end
        end)

kernel_wdt = wibox.widget {
    {
        watch('bash -c "knl_v.sh"',3600),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

uptime_wdt = wibox.widget {
    {
        watch('bash -c "uptime.sh"',60),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

---- the systray has its own internal background because of X11 limitations
round_systry = wibox.widget {
    {
        wibox.widget.systray(),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg         = wdt_bg,
    shape      = wdt_shape,
    shape_clip = true,
    widget     = wibox.container.background,
}

---- Prayer times
--prayer_widget = wibox.widget {
--    {
--        --watch('bash -c "prayer.sh"',60),
--        watch('bash -c "tail -n 1 $HOME/.local/share/prayer_widget"',60),
--        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
--    },
--    bg = wdt_bg,
--    shape = wdt_shape,
--    widget = wibox.container.background
--}
--return widgets
