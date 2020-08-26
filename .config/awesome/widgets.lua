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
local config_dir = gears.filesystem.get_configuration_dir()


local widgets = {}
wdt_bg      =   beautiful.bg_empty

wdt_shape   =   function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 8) end

wdt_rmgn    =   '6'
wdt_lmgn    =   '6'

lag_wdt = wibox.widget {
    image = config_dir ..'/icons/lag.svg',
    resize = true,
    opacity = 0.6,
    widget = wibox.widget.imagebox
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
            
                forced_width    = 6,
                opacity         = 0,
                widget          = wibox.widget.separator
            }

--[[ Cpu temperature
temp_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/temp.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

Gpu temperature
gpu_temp_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/temp_gpu.sh"'),
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
        awful.widget.watch('bash -c "$HOME/.local/bin/weather.sh"', 1800),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
wthr_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell ('$TERMINAL --hold curl wttr.in/bariloche')
    end
end)
-- Network traffic
net_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/net.sh"', 1,_,_,_,signal,16),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
net_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('$TERMINAL --hold vnstat -d')
    end
end)
-- Free disk available
disk_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/disk.sh"', 60),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
disk_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell ('$TERMINAL --hold dust -r /home')
    end
        end)
diskIO_wdt = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/disk-io.sh -t 1 -R nvme0n1"',_),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

-- Memory usage
mem_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/memory.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
mem_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('$TERMINAL --hold htop')
    end
        end)

-- Cpu usage
cpu_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/cpu.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}
cpu_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('$TERMINAL --hold htop')
    end
        end)

-- Keyboard layout indicator
kbd_widget = wibox.widget {
    awful.widget.watch('bash -c "$HOME/.local/bin/kb-layout.sh"'),
    --bg = wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}

--Volume
volumewidget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/volume_mon.sh"',_,_,_,_,signal,10),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}
    --[[
	scrolling when the cursor is over the widdget
	toggling the sound on and off by clicking the widget
    --]]
	volumewidget:connect_signal('button::press', function (_,_,_,button)
	if (button == 4) then  awful.spawn.with_shell ('$HOME/.local/bin/volume.sh up') 
	elseif (button == 5) then awful.spawn.with_shell ('$HOME/.local/bin/volume.sh down') 
	elseif (button == 1 ) then awful.spawn.with_shell ('$TERMINAL -e pulsemixer') 
	end
			end)

-- Date and time
datewidget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/date.sh"', 60),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}

music_wdt = wibox.widget {
    layout = wibox.container.scroll.horizontal,
    max_size = awful.screen.focused().workarea.width * 0.15,
    step_function = wibox.container.scroll.step_functions.linear_increase,
    fps = 30,
    speed = 30,
    extra_space = 5,
    {
        {
            awful.widget.watch('bash -c "$HOME/.local/bin/music.sh"',_),
            widget = wibox.container.margin(_,10,10,_,_,_,_),
        },
        bg = wdt_bg,
        shape = wdt_shape,
        widget = wibox.container.background
    }
}

pkg_widget = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/pacman.sh"', 3600),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

kernel_wdt = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/knl_v.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}

uptime_wdt = wibox.widget {
    {
        awful.widget.watch('bash -c "$HOME/.local/bin/uptime.sh"'),
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}


return widgets
