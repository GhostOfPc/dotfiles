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
local naughty = require('naughty')
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
--require('bottom_bar')

-- ================================ Error handling ================================================
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- ================================ Error handling ================================================

-- ================================================================================================
-- Enable sloppy focus, so that focus follows mouse.

client.connect_signal('mouse::enter', function(c)
    c:activate { context = 'mouse_enter', raise = false }
end)

-- ================================================================================================
-- Garbage collection (allows for lower memory consumption)
-- ================================================================================================
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
