--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝
  ╚════════════════════════════════════════╝
--]]

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- ========================= Standard awesome library =========================
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
require('awful.autofocus')
require('menubar')
require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')

-- ========================= Import theme =====================================
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/Darktheme.lua")

-- ========================= Import components ================================
require ('keys')
require('tags')
--require('top_bar')
require('bottom_bar')
require('Menu')
require('notifications')
require('rules')

-- ========================= Layouts ==========================================
awful.layout.layouts = {
	awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,
}

-- Garbage collection (allows for lower memory consumption)
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
