local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')


local Memory_widget = {}

MEM_CMD = [[ bash -c "free -h | awk '/^Mem/ {print $3}' | sed 's/i//'" ]]
timeout = 10

mem_widget = wibox.widget {
    {
        {
            id = 'mem_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    bg = Wdt_bg,
    shape = Wdt_shape,
    widget = wibox.container.background
}
mem_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e htop')
    end
        end)

function Update_mem_widget(widget,stdout)
    widget:get_children_by_id('mem_wdt')[1]:set_text('🧠 ' .. stdout)
end

watch(MEM_CMD,timeout,Update_mem_widget,mem_widget)

return Memory_widget
