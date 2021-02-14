local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Kernel_widget = {}

KNL_CMD = [[ bash -c 'uname -r']]
timeout = 3600

kernel_wdt = wibox.widget {
    {
        {
            id = 'knl_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,wdt_lmgn,wdt_rmgn,_,_,_,_),
    },
    bg = wdt_bg,
    shape = wdt_shape,
    widget = wibox.container.background
}


function Update_knl_widget(widget,stdout)
    widget:get_children_by_id('knl_wdt')[1]:set_text( '🐧 ' .. stdout)
end

watch(KNL_CMD,timeout,Update_knl_widget,kernel_wdt)
return Kernel_widget
