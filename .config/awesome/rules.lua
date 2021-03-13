local awful = require('awful')
local beautiful = require('beautiful')

local rules = {}
awful.screen.connect_for_each_screen(function(s)
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
                'Virtualbox Machine', 'Virtualbox Manager', 'Xfce4-about', 'Xfce4-power-manager-settings',
            },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            'Event Tester',  -- xev.
            'Customize Look and Feel',
            'ArcoLinux Spices Application',
            'Search movie',
            'About Mozilla Firefox'
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
        --x = awful.screen.focused().workarea.width * 0.25,
        --y = awful.screen.focused().workarea.height * 0.25,
    }
},

{
    rule_any = {
        class = {'slickpicker', 'Gnome-sudoku','Variety'},
    },
    properties = {
        floating = true
    }
},

    -- Specific applications run on specific tags
{
    rule = {
        class = 'kitty'
    },
    properties = {
        tag = screen[s].tags[1],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'firefox','Brave-browser', 'Chromium', 'qutebrowser', 'LibreWolf'
        }
    },
    properties = {
        tag = screen[s].tags[2],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Geany','Inkscape','Gimp'
        }
    },
    properties = {
        tag = screen[s].tags[3],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Pcmanfm','qBittorrent','Uget-gtk'
        }
    },
    properties = {
        tag = screen[s].tags[4],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'VirtualBox Machine'
        }
    },
    properties = {
        tag = screen[s].tags[5],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'VirtualBox Manager'
        }
    },
    properties = {
        tag = screen[s].tags[4],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'mpv'
        }
    },
    properties = {
        tag = screen[s].tags[6],
        switchtotag = true,
        floating = true,
        border_width = 0
    }
},

{
    rule_any = {
        class = {
            'vlc'
        }
    },
    properties = {
        tag = screen[s].tags[6],
        switchtotag = true,
        border_width = 0
    }
},

}
end)

-- ========================= Signals ===========================================
-- Enable mouse bindings to move and resize clients
client.connect_signal('manage', function (c)
    c:keys(clientkeys)
    c:buttons(clientbuttons)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
end)

-- Enable borders for focused windows
client.connect_signal('focus', function(c)
    local clients = awful.client.visible(s)
            if not awful.rules.match(c, {class = 'mpv'}) then
                c.border_width = beautiful.border_width
                c.border_color = beautiful.border_focus
            end
end)
client.connect_signal('unfocus', function(c)
    c.border_width = 0
    c.border_color = beautiful.border_normal
end)

return rules
