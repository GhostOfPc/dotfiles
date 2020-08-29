--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Standard awesome library
local beautiful = require('beautiful')
local naughty = require('naughty')
local awful = require('awful')
local dpi = beautiful.xresources.apply_dpi
local ruled = require('ruled')
local gears = require('gears')
local wibox = require('wibox')
local menubar = require('menubar')

local notifications = {}

naughty.config.defaults.shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 8) end
naughty.config.defaults.width = awful.screen.focused().workarea.width * 0.2
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.font = beautiful.font
naughty.config.defaults.border_width = dpi(0)

naughty.config.icon_dirs = {'/usr/share/icons/Papirus'}
naughty.config.icon_format = {'svg', 'png', 'jpg', 'gif'}

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule       = {urgency = 'normal'},
        properties = {
            bg = beautiful.bg_normal,
            fg = beautiful.fg_normal,
            timeout = 10,
            widget_template = {
                {
                    shape = gears.shape.rounded_rect,
                    widget = naughty.container.background
                },
            }
        }
    }

    -- Add a red background for urgent notifications.
     ruled.notification.append_rule {
        rule       = {urgency = 'critical'},
        properties = {
            bg = beautiful.fg_urgent,
            fg = beautiful.fg_normal,
            timeout = -1,
            widget_template = {
                {
                    shape = gears.shape.rounded_rect,
                    widget = naughty.container.background
                },
            }
        }
    }
end)


-- XDG icon lookup
naughty.connect_signal(
	'request::icon',
	function(n, context, hints)
		if context ~= 'app_icon' then return end

		local path = menubar.utils.lookup_icon(hints.app_icon) or
		menubar.utils.lookup_icon(hints.app_icon:lower())

		if path then
			n.icon = path
		end
	end
)
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

return notifications
