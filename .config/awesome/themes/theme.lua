--[[
    ╔════════════════════════════════════════╗
   ╔╝                                        ╚╗
   ║ Riced and crafted by  Hisham Abdul Hai  ║
   ║ ...Founder of Linux Arab Gate (L A G)... ║
   ╚╗                                        ╔╝ 
    ╚════════════════════════════════════════╝
--]]

local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local gears = require('gears')
local config_dir = gears.filesystem.get_configuration_dir()

themes_path = config_dir .. '/awesome/themes/'

local theme = {}

-- Default variables
-- Font
theme.font          =   'JetBrainsMono Nerd Font 9'

-- Background colors
theme.bg_normal     =   '#272822e6'
theme.fg_urgent     =   '#fa2573'
theme.fg_focus      =   '#af87ff'
theme.fg_occupied   =   '#0f7fcf'
theme.bg_systray    =   theme.bg_normal
theme.bg_empty      =   '#545454e6'

-- Border colors
theme.border_width      =   dpi(1)
theme.border_normal     =   '#272822'
theme.border_focus      =   '#0f7fcf'

-- Foreground color
theme.fg_normal     =   '#d7eaf3'

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
theme.hotkeys_bg		=	theme.bg_normal
theme.hotkeys_font		=	theme.font
theme.hotkeys_fg		=	theme.fg_normal
theme.hotkeys_border_width	=	dpi(1)
theme.hotkeys_border_color	=	theme.border_focus
theme.hotkeys_opacity		=	0.85
theme.hotkeys_modifiers_fg	=	theme.border_focus 
theme.hotkeys_description_font	=	theme.font
theme.hotkeys_shape             = gears.shape.rectangle

-- tasklist
theme.tasklist_fg_focus                         =       '#b0e05e'
theme.tasklist_bg_normal                        =       theme.bg_empty
theme.tasklist_disable_icon                     =       true
theme.tasklist_plain_task_name                  =       true
theme.tasklist_font                             =       theme.font
theme.tasklist_align                            =       left

theme.layout_fairh = themes_path..'layouts/fairhw.png'
theme.layout_fairv = themes_path..'layouts/fairvw.png'
theme.layout_floating  = themes_path..'layouts/floatingw.png'
theme.layout_max = themes_path..'layouts/maxw.png'
theme.layout_fullscreen = themes_path..'layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path..'layouts/tilebottomw.png'
theme.layout_tile = themes_path..'layouts/tilew.png'
theme.layout_spiral  = themes_path..'layouts/spiralw.png'
theme.layout_dwindle = themes_path..'layouts/dwindlew.png'

--theme.layout_fairh = themes_path..'layouts/fairh.png'
--theme.layout_fairv = themes_path..'layouts/fairv.png'
--theme.layout_floating  = themes_path..'layouts/floating.png'
--theme.layout_max = themes_path..'layouts/max.png'
--theme.layout_fullscreen = themes_path..'layouts/fullscreen.png'
--theme.layout_tilebottom = themes_path..'layouts/tilebottom.png'
--theme.layout_tile = themes_path..'layouts/tile.png'
--theme.layout_spiral  = themes_path..'layouts/spiral.png'
--theme.layout_dwindle = themes_path..'layouts/dwindle.png'

-- menu
theme.menu_font = theme.font
theme.menu_width = dpi(175)
theme.menu_border_color = theme.border_focus
theme.menu_border_width = dpi(1)
theme.menu_fg_focus = '#d7eaf3'
theme.menu_bg_focus = '#515151'

return theme
