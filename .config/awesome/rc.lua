--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local menubar = require('menubar')
require("awful.hotkeys_popup.keys")

-- Import theme
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. '/themes/theme.lua')

-- Import components
require('apps')
require('widgets')
require('rules')
require('keys')
require('layouts')
require('tags')
require('top_bar')
require('notifications')
--require('bottom_bar')

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    c:activate { context = 'mouse_enter', raise = false }
end)

-- Garbage collection (allows for lower memory consumption)
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
