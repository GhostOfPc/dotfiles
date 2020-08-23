--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Standard awesome library
local awful = require('awful')
local ruled = require('ruled')

require('awful.autofocus')

local rules = {}

  -- ================= Rules to apply to new clients ================
ruled.client.connect_signal('request::rules', function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = 'global',
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.centered,
        }
    }

  -- ================= Floating clients ================
    ruled.client.append_rule {
        id       = 'floating',
        rule_any = {
            instance = { 'copyq', 'pinentry' },
            class    = {
                'Arandr', 'Blueman-manager', 'Nitrogen', 'lxrandr', 'lxappearnace', 'qt5ct', 'Hardinfo',
                'Kvantum Manager', 'Xarchiver', 'Nm-connection-editor', 'Pavucontrol', 'GParted', 'Timeshift-gtk',
                'Virtualbox Machine', 'Virtualbox Manager'
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                'Event Tester',  -- xev.
                'Customize Look and Feel'
            },
            role    = {
                'pop-up',         -- e.g. Google Chrome (detached) Developer Tools.
                'GtkFileChooserDialog'
            }
        },
        properties = {
            floating = true, 
            width   = awful.screen.focused().workarea.width * 0.6,
            height  = awful.screen.focused().workarea.height * 0.6
        }
    }

  -- ================= Each program opens in its corresponding tag ================
    ruled.client.append_rule {
        rule       = { class = 'kitty'     },
        properties = { tag = screen[1].tags[1] , switchtotag = true}
    }
    ruled.client.append_rule {
        rule       = { class = 'Brave-browser'     },
        properties = { tag = screen[1].tags[2], switchtotag = true}
    }
    ruled.client.append_rule {
        rule       = { class = 'firefox'     },
        properties = { tag = screen[1].tags[2], switchtotag = true}
    }

    ruled.client.append_rule {
        rule       = { class = 'Uget-gtk'},
        properties = { tag = screen[1].tags[4] , switchtotag = true}
    }
    ruled.client.append_rule {
        rule       = { class = 'qBittorrent'},
        properties = { tag = screen[1].tags[4] , switchtotag = true}
    }
    ruled.client.append_rule {
        rule       = { class = 'Pcmanfm'},
        properties = { tag = screen[1].tags[4] , switchtotag = true}
    }
    ruled.client.append_rule {
        rule       = { class = 'Geany'},
        properties = { tag = screen[1].tags[3] , switchtotag = true}
    }
    ruled.client.append_rule {
        rule       = { class = 'vlc'},
        properties = { tag = screen[1].tags[6] , switchtotag = true, border_width = 0}
    }
    ruled.client.append_rule {
        rule       = { class = 'mpv'},
        properties = { tag = screen[1].tags[6] , switchtotag = true , border_width = 0}
    }
    ruled.client.append_rule {
        rule       = { class = 'plexmediaplayer'},
        properties = { tag = screen[1].tags[6] , switchtotag = true , border_width = 0, fullscreen = true},

    }

   -- ==== Spotify and Kodi have to be treated differently since they do not set the class before running ====
client.connect_signal(
	'property::class',
	function(c)
		if c.class == 'Spotify' then
			-- Check if Spotify is already open
			local spotify = function (c)
				return ruled.client.match(c, { class = 'Spotify' })
			end
			local spotify_count = 0
			for c in awful.client.iterate(spotify) do
				spotify_count = spotify_count + 1
			end
			-- If Spotify is already open, do not open a new instance
			if spotify_count > 1 then
				c:kill()
				-- Switch to previous instance
				for c in awful.client.iterate(spotify) do
					c:jump_to(false)
				end
			else
				-- Move the Spotify instance to '5' tag on this screen
				local t = awful.screen.focused().tags[5]
				c:move_to_tag(t)
				t:view_only()
			end

		elseif c.class == 'Kodi' then
			local kdi_count = 0
			for c in awful.client.iterate(kodi) do
				kdi_count = kdi_count + 1
			end
			-- If Kodi is already open, do not open a new instance
			if kdi_count > 1 then
				c:kill()
				-- Switch to previous instance
				for c in awful.client.iterate(kdi) do
					c:jump_to(false)
				end
			else
				-- Move the instance to specified tag tag on this screen
				local t = awful.screen.focused().tags[6]
				c:move_to_tag(t)
				t:view_only()
				-- Enable fullscreeen again
				c.fullscreen = true
			end
		end
	end
)
end)

return rules
