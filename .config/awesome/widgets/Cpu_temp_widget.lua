local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')


local Cpu_temp_widget = {}

timeout = 10
CPU_CMD = [[ bash -c 'temp.sh']]

cpu_temp_widget = wibox.widget {
    {
        {
            id = 'temp',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    bg = Wdt_bg,
    shape = Wdt_shape,
    widget = wibox.container.background
}
cpu_temp_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e htop')
    end
        end)

function Update_cpu_temp_widget(widget,stdout)
    widget:get_children_by_id('temp')[1]:set_text(stdout)
end

watch(CPU_CMD,timout,Update_cpu_temp_widget,cpu_temp_widget)

return Cpu_temp_widget
