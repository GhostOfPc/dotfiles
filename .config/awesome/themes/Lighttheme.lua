local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local gears = require('gears')
local config_dir = gears.filesystem.get_configuration_dir()

Themes_path = config_dir .. '/awesome/themes/'

local theme = {}

-- Font
theme.font          =   'FantasqueSansMono Nerd Font 9'

-- Background colors
theme.bg_normal             =   '#e6ebef' .. 'bf' -- Two digits for the transparency
theme.fg_urgent             =   '#e45649'
theme.fg_occupied           =   '#0184bc'
theme.bg_systray            =   theme.bg_normal
theme.bg_empty              =   '#787878' .. '6a' -- Two digits for the transparency
theme.taglist_fg_occupied   =   theme.fg_normal
theme.taglist_bg_occupied   =   theme.bg_empty
theme.taglist_bg_focus      =   '#0184bc' .. 'a9' -- Two digits for the transparency

-- Border colors
theme.border_width      =   dpi(1)
theme.border_normal     =   theme.bg_normal
theme.border_focus      =   '#0184bc'

-- Foreground color
theme.fg_normal     =   '#32343d'

-- tooltip
theme.tooltip_border_color  =   theme.border_focus
theme.tooltip_bg            =   theme.bg_normal
theme.tooltip_fg            =   theme.fg_normal
theme.tooltip_font          =   theme.font
theme.tooltip_border_width  =   theme.border_width
theme.tooltip_opacity       =   0.85

-- wibar
theme.wibar_fg              =   theme.fg_normal
theme.wibar_border_width    =   dpi(0)
theme.wibar_border_color    =   theme.border_focus

-- hotkeys
theme.hotkeys_bg		        =	theme.bg_normal
theme.hotkeys_font		        =	theme.font
theme.hotkeys_fg		        =	theme.fg_normal
theme.hotkeys_border_width	    =	dpi(1)
theme.hotkeys_border_color	    =	theme.border_focus
theme.hotkeys_opacity		    =	0.85
theme.hotkeys_modifiers_fg	    =	theme.border_focus
theme.hotkeys_description_font	=	theme.font

-- tasklist
theme.tasklist_fg_focus         =   theme.fg_normal
theme.tasklist_bg_normal        =   theme.bg_empty .. '00'
theme.tasklist_disable_icon     =   true
theme.tasklist_plain_task_name  =   true
theme.tasklist_font             =   theme.font
theme.tasklist_align            =   'left'
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
theme.menu_font         = theme.font
theme.menu_width        = dpi(175)
theme.menu_border_color = theme.border_focus
theme.menu_border_width = dpi(1)

-- current temp
theme.temp_cold         =   '#0184bc'
theme.temp_norm         =   '#8e5b2b'
theme.temp_hot          =   '#e06c75'
theme.temp_min          =   '#61afef'
theme.temp_max          =   '#c678dd'

return theme
