local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Cpu_widget = {}

timeout = 10
CPU_CMD = [[ bash -c 'cpu.sh']]

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

function Update_cpu_widget(widget,stdout)
    widget:get_children_by_id('cpu_wdt')[1]:set_text(stdout)
end

watch(CPU_CMD,timeout,Update_cpu_widget,cpu_widget)

return Cpu_widget
