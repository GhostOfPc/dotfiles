local gears = require('gears')
local wibox = require('wibox')
local awful = require('awful')
local ruled = require('ruled')
local naughty = require('naughty')
local menubar = require('menubar')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
--local clickable_container = require('widget.clickable-container')

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(48)
naughty.config.defaults.timeout = 10
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.shape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 8)
end

-- Apply theme variables
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_dirs = {
	'/usr/share/icons/Papirus/48x48',
}
naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }


-- Presets / rules

ruled.notification.connect_signal(
'request::rules', function()
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
end
	)

-- Error handling
naughty.connect_signal(
	'request::display_error',
	function(message, startup)
		naughty.notification {
			urgency = 'critical',
			title   = 'Oops, an error happened'..(startup and ' during startup!' or '!'),
			message = message,
			app_name = 'System Notification',
			icon = beautiful.awesome_icon
		}
	end
)

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

-- Connect to naughty on display signal
naughty.connect_signal(
	'request::display',
	function(n)

		-- Actions Blueprint
		local actions_template = wibox.widget {
			notification = n,
			base_layout = wibox.widget {
				spacing        = dpi(0),
				layout         = wibox.layout.flex.horizontal
			},
			widget_template = {
				{
					{
							{
								id     = 'text_role',
								widget = wibox.widget.textbox
							},
							widget  =   wibox.container.place
                        },
                        widget  =   wibox.container.background
                    },
                    margins = dpi(10),
                    widget  = wibox.container.margin
                }
            }

		-- Notifbox Blueprint
		naughty.layout.box {
			notification = n,
			type = 'notification',
			screen = awful.screen.preferred(),
			shape = gears.shape.rounded_rect,
			widget_template = {
				{
					{
						{
							{
								{
									{
										{
											{
													{
														valign = 'center',
														widget = wibox.widget.textbox

													},
												widget  = wibox.container.background,
											},
											{
												{
													{
														resize_strategy = 'center',
														widget = naughty.widget.icon,
													},
													margins = dpi(10),
													widget  = wibox.container.margin,
												},
												{
													{
														layout = wibox.layout.align.vertical,
														expand = 'none',
														nil,
														{
															{
																align = 'left',
																widget = naughty.widget.title
															},
															{
																align = 'left',
																widget = naughty.widget.message,
															},
															layout = wibox.layout.fixed.vertical
														},
														nil
													},
													margins = dpi(5),
													widget  = wibox.container.margin,
												},
												layout = wibox.layout.fixed.horizontal,
											},
											layout  = wibox.layout.fixed.vertical,
										},
										margins = dpi(1),
										widget  = wibox.container.margin,
									},
									widget  = wibox.container.background,
								},
								layout  = wibox.layout.fixed.vertical,
							},
							id     = 'background_role',
							widget = naughty.container.background,
						},
						strategy = 'min',
						width    = dpi(400),
						widget   = wibox.container.constraint,
					},
					strategy = 'max',
					width    = dpi(500),
					widget   = wibox.container.constraint
				},
				shape = gears.shape.rounded_rect,
				widget = wibox.container.background	
			}
		}

	end
)

