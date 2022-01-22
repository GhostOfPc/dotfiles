local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local gears = require('gears')
local config_dir = gears.filesystem.get_configuration_dir()

Themes_path = config_dir .. '/awesome/themes/'

local theme = {}

-- Font
theme.font          =   'FantasqueSansMono Nerd Font 11'

-- Background colors
theme.bg_normal             =   '#e7e7e7' .. 'b3' -- Two digits for the transparency
theme.fg_urgent             =   '#e45649'
theme.fg_occupied           =   '#ba68c8'
theme.bg_systray            =   theme.bg_normal
theme.bg_empty              =   '#7a7a7a' .. '45' -- Two digits for the transparency
theme.taglist_fg_occupied   =   theme.fg_normal
theme.taglist_bg_occupied   =   '#0184bc'
theme.taglist_bg_empty      =   theme.bg_empty
theme.taglist_bg_focus      =   theme.fg_occupied

-- Border colors
theme.border_width      =   dpi(1)
theme.border_normal     =   theme.bg_normal
theme.border_focus      =   theme.fg_occupied

-- Foreground color
theme.fg_normal     =   '#2a2a2a'

-- tooltip
theme.tooltip_border_color  =   theme.border_focus
theme.tooltip_bg            =   theme.bg_normal
theme.tooltip_fg            =   theme.fg_normal
theme.tooltip_font          =   theme.font
theme.tooltip_border_width  =   dpi(0)
theme.tooltip_opacity       =   0.85
theme.tooltip_align         =   'top'

-- wibar
theme.wibar_fg              =   theme.fg_normal
theme.wibar_border_width    =   dpi(0)
theme.wibar_border_color    =   theme.border_focus

-- hotkeys
theme.hotkeys_bg		        =	'#e7e7e7' .. 'c5'
theme.hotkeys_font		        =	theme.font
theme.hotkeys_fg		        =	theme.fg_normal
theme.hotkeys_border_width	    =	dpi(1)
theme.hotkeys_border_color	    =	theme.border_focus
theme.hotkeys_opacity		    =	0.85
theme.hotkeys_modifiers_fg	    =	theme.border_focus
theme.hotkeys_description_font	=	theme.font
theme.hotkeys_shape             =   function(cr, width, height) gears.shape.rounded_rect(cr, width, height, dpi(8)) end

-- tasklist
theme.tasklist_fg_focus         =   theme.fg_normal
theme.tasklist_bg_normal        =   theme.bg_empty .. '00'
theme.tasklist_disable_icon     =   true
theme.tasklist_plain_task_name  =   true
theme.tasklist_font             =   theme.font
theme.tasklist_align            =   'center'
theme.icon_theme                =   '/usr/share/icons/Papirus-Light/48x48'

theme.layout_fairh      = Themes_path..'layouts/fairhw.png'
theme.layout_fairv      = Themes_path..'layouts/fairvw.png'
theme.layout_floating   = Themes_path..'layouts/floatingw.png'
theme.layout_max        = Themes_path..'layouts/maxw.png'
theme.layout_fullscreen = Themes_path..'layouts/fullscreenw.png'
theme.layout_tilebottom = Themes_path..'layouts/tilebottomw.png'
theme.layout_tile       = Themes_path..'layouts/tilew.png'
theme.layout_spiral     = Themes_path..'layouts/spiralw.png'
theme.layout_dwindle    = Themes_path..'layouts/dwindlew.png'

-- menu
theme.menu_font         = 'Inter 10'
theme.menu_height       = dpi(20)
theme.menu_width        = dpi(160)
theme.menu_border_color = '#0000'
theme.menu_border_width = dpi(2)
theme.menu_submenu      = "ᐅ "

-- current temp
theme.temp_cold         =   '#0184bc'
theme.temp_norm         =   '#4c474a'
theme.temp_hot          =   '#e06c75'
theme.temp_min          =   '#3247bb'
theme.temp_max          =   '#8f27c9'

theme.titlebar_bg       =   theme.border_focus
theme.titlebar_fg       =   theme.fg_normal
theme.titlebar_close_button_normal = "/home/hisham/.config/awesome/icons/buttons/close.svg"
theme.titlebar_close_button_focus  = "/home/hisham/.config/awesome/icons/buttons/close.svg"
theme.titlebar_sticky_button_normal_inactive = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"
theme.titlebar_sticky_button_focus_inactive  = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"
theme.titlebar_sticky_button_normal_active = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"
theme.titlebar_sticky_button_focus_active  = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"

theme.titlebar_floating_button_normal_inactive = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"
theme.titlebar_floating_button_focus_inactive  = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"
theme.titlebar_floating_button_normal_active = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"
theme.titlebar_floating_button_focus_active  = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"

theme.titlebar_maximized_button_normal_inactive = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"
theme.titlebar_maximized_button_focus_inactive  = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"
theme.titlebar_maximized_button_normal_active = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"
theme.titlebar_maximized_button_focus_active  = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"

return theme
