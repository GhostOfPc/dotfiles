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
local rubato = require('rubato')

-- ========================= Import theme =====================================
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/material_dark.lua")

-- ========================= Import components ================================
require('keys')
require('tags')
require('bottom_bar')
require('Menu')
require('notifications')
require('rules')

-- Enable windows switcher module provided by bling
bling.widget.window_switcher.enable {
    type = "thumbnail", -- set to anything other than "thumbnail" to disable client previews

    -- keybindings (the examples provided are also the default if kept unset)
    hide_window_switcher_key = "Escape", -- The key on which to close the popup
    minimize_key = "n",                  -- The key on which to minimize the selected client
    unminimize_key = "N",                -- The key on which to unminimize all clients
    kill_client_key = "q",               -- The key on which to close the selected client
    cycle_key = "Tab",                   -- The key on which to cycle through all clients
    previous_key = "Left",               -- The key on which to select the previous client
    next_key = "Right",                  -- The key on which to select the next client
    vim_previous_key = "h",              -- Alternative key on which to select the previous client
    vim_next_key = "l",                  -- Alternative key on which to select the next client
}
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

timed = rubato.timed {
	intro = 0.5,
	duration = 1,
	easing = rubato.quadratic --quadratic slope, not easing
}

-- Garbage collection (allows for lower memory consumption)
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
