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
require('awful.autofocus')
local beautiful = require('beautiful')
local menubar = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')

-- ========================= Import theme =====================================
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. 'themes/theme.lua')

-- ========================= Import components ================================
require ('keys')
require('widgets')
require('tags')
require('top_bar')
require('bottom_bar')
require('notifications')

-- ========================= Layouts ==========================================
awful.layout.layouts = {
	awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,
}


awful.rules.rules = {
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = buttonkeys,
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
            'Customize Look and Feel',
            'ArcoLinux Spices Application'
        },
        role = {
            'pop-up',       -- e.g. Google Chrome's (detached) Developer Tools.
            'GtkFileChooserDialog',
        }
    }, 
    properties = {
        floating = true,
        width = awful.screen.focused().workarea.width * 0.5,
        height = awful.screen.focused().workarea.height * 0.5,
        x = awful.screen.focused().workarea.width * 0.25,
        y = awful.screen.focused().workarea.height * 0.25,
    }
},

    -- Specific applications run on specific tags
{
    rule = {
        class = 'kitty'
    },
    properties = {
        tag = screen[1].tags[1], switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'firefox','Brave-browser'
        }
    },
    properties = {
        tag = screen[1].tags[2], switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Geany','Inkscape','Gimp'
        }
    },
    properties = {
        tag = screen[1].tags[3], switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Pcmanfm','qBittorrent','Uget-gtk'
        }
    },
    properties = {
        tag = screen[1].tags[4], switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'mpv'
        }
    },
    properties = {
        tag = screen[1].tags[6], switchtotag = true, border_width = 0, floating = true
    }
},

{
    rule_any = {
        class = {
            'vlc'
        }
    },
    properties = {
        tag = screen[1].tags[6], switchtotag = true, border_width = 0
    }
},

}

-- ========================= Signals ===========================================
-- Enable mouse bindings to move and resize clients
client.connect_signal("manage", function (c)
    c:keys(clientkeys)
    c:buttons(clientbuttons)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
end)

-- Enable borders
client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)

-- Garbage collection (allows for lower memory consumption)
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
