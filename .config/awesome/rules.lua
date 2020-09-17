--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local rules = {}
-- {{{ Rules
-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            screen = awful.screen.preferred,
            placement = awful.placement.centered
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA',  -- Firefox addon DownThemAll.
                'copyq',  -- Includes session name in class.
                'pinentry',
            },
            class = {
                'Arandr', 'Blueman-manager', 'Nitrogen', 'lxrandr', 'Lxappearance', 'qt5ct', 'Hardinfo',
                'Kvantum Manager', 'Xarchiver', 'Nm-connection-editor', 'Pavucontrol', 'GParted', 'Timeshift-gtk',
                'Virtualbox Machine', 'Virtualbox Manager'
            },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            'Event Tester',  -- xev.
            'Customize Look and Feel'
        },
        role = {
            'pop-up',       -- e.g. Google Chrome's (detached) Developer Tools.
            'GtkFileChooserDialog',
        }
    }, 
    properties = {
        floating = true,
        placement = awful.placement.centered,
        width = awful.screen.focused().workarea.width * 0.5,
        height = awful.screen.focused().workarea.height * 0.5
    }
},

     { rule = { class = 'kitty' },
       properties = {tag = screen[1].tags[1], switchtotag = true} },

     { rule = { class = 'firefox' },
       properties = {tag = screen[1].tags[2], switchtotag = true} },

     { rule = { class = 'Brave-browser' },
       properties = {tag = screen[1].tags[2], switchtotag = true} },

     { rule = { class = 'Geany' },
       properties = {tag = screen[1].tags[3], switchtotag = true} },

     { rule = { class = 'Pcmanfm' },
       properties = {tag = screen[1].tags[4], switchtotag = true} },
       
     { rule = { class = 'qBittorrent' },
       properties = {tag = screen[1].tags[4], switchtotag = true} },

     { rule = { class = 'Uget-gtk' },
       properties = {tag = screen[1].tags[4], switchtotag = true} },

     { rule = { class = 'vlc' },
       properties = {tag = screen[1].tags[6], switchtotag = true, border_width = 0} },

     { rule = { class = 'mpv' },
       properties = {tag = screen[1].tags[6], switchtotag = true, border_width = 0} },

}
-- }}}

return rules
