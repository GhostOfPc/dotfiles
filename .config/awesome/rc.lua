pcall(require, 'luarocks.loader')

-- ========================= Standard awesome library =========================
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
require('awful.autofocus')
require('menubar')
require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local bling = require('bling')

-- ========================= Import theme =====================================
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/Darktheme.lua")

-- ========================= Import components ================================
require('keys')
require('tags')
require('bottom_bar')
require('Menu')
require('notifications')
require('rules')

-- Set wallpaper
--awful.screen.connect_for_each_screen(function(s)
--    local function set_wallpaper(s)
--        local wallpaper = '/home/hisham/Pictures/Nude/0002.jpg'
--        if type(wallpaper) == 'function' then
--            wallpaper = wallpaper(s)
--        end
--        gears.wallpaper.maximized(wallpaper, s, true)
--    end
--    set_wallpaper(s)
--end
--    )

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
