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
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Import theme
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/theme.lua")

-- Import components
local apps = require('apps')
require ('keys')
--require('rules')
require('widgets')
require('tags')
require('top_bar')
require('bottom_bar')

-- Layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,

}


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { id = 'global',
    rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {

                'Arandr', 'Blueman-manager', 'Nitrogen', 'lxrandr', 'lxappearnace', 'qt5ct', 'Hardinfo',
                'Kvantum Manager', 'Xarchiver', 'Nm-connection-editor', 'Pavucontrol', 'GParted', 'Timeshift-gtk',
                'Virtualbox Machine', 'Virtualbox Manager'
},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
	  "Customize Look and Feel"
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
	  "GtkFileChooserDialog",
        }
      }, 
      properties = {
	      floating = true,
	      width = awful.screen.focused().workarea.width * 0.6,
	      height = awful.screen.focused().workarea.height * 0.6,
	      placement = awful.placement.centered
      }
      },

     { rule = { class = "kitty" },
       properties = {tag = screen[1].tags[1], switchtotag = true} },

     { rule = { class = "firefox" },
       properties = {tag = screen[1].tags[2], switchtotag = true} },

     { rule = { class = "Brave-browser" },
       properties = {tag = screen[1].tags[2], switchtotag = true} },

     { rule = { class = "Geany" },
       properties = {tag = screen[1].tags[3], switchtotag = true} },

     { rule = { class = "Pcmanfm" },
       properties = {tag = screen[1].tags[4], switchtotag = true} },
       
     { rule = { class = "qBittorrent" },
       properties = {tag = screen[1].tags[4], switchtotag = true} },

     { rule = { class = "Uget-gtk" },
       properties = {tag = screen[1].tags[4], switchtotag = true} },

     { rule = { class = "vlc" },
       properties = {tag = screen[1].tags[6], switchtotag = true, border_width = 0} },

     { rule = { class = "mpv" },
       properties = {tag = screen[1].tags[6], switchtotag = true, border_width = 0} },

}
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Garbage collection (allows for lower memory consumption)
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
