local awful = require('awful')
local bling = require('modules.bling')
local scratch_width = awful.screen.focused().geometry.width * 0.8
local scratch_height = awful.screen.focused().geometry.height * 0.8

local pulse_scratch = bling.module.scratchpad {
   command = 'kitty --class scpul pulsemixer',
   rule = { instance = 'scpul'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 4, y=scratch_height / 4, height=scratch_height * 6 / 8, width=scratch_width * 6 / 8},
   reapply = true,
   dont_focus_before_close = false,
}
awesome.connect_signal("scratch::pulse",function()pulse_scratch:toggle() end)

local spt_scratch = bling.module.scratchpad {
   command = 'kitty --class scspt spt',
   rule = { instance = 'scspt'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 8, y=scratch_height / 8, height=scratch_height, width=scratch_width},
   reapply = true,
   dont_focus_before_close = false,
}
awesome.connect_signal("scratch::spotify",function()spt_scratch:toggle() end)

local lf_scratch = bling.module.scratchpad {
   command = 'kitty --class sclf lf',
   rule = { instance = 'sclf'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 8, y=scratch_height / 8, height=scratch_height, width=scratch_width},
   reapply = true,
   dont_focus_before_close = false,
}
awesome.connect_signal("scratch::lf",function()lf_scratch:toggle() end)

local mpv_scratch = bling.module.scratchpad {
   command = 'kitty --class scmpv',
   rule = { instance = 'scmpv'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 4, y=scratch_height / 4, height=scratch_height * 6 / 8, width=scratch_width * 6 / 8},
   reapply = false,
   dont_focus_before_close = false,
}
awesome.connect_signal("scratch::mpv",function()mpv_scratch:toggle() end)

local spt_scratch = bling.module.scratchpad {
   command = 'kitty --class scspt spt',
   rule = { instance = 'scspt'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 8, y=scratch_height / 8, height=scratch_height, width=scratch_width},
   reapply = true,
   dont_focus_before_close = false,
}
