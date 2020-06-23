--    ╔════════════════════════════════════════╗
--   ╔╝                                        ╚╗
--   ║ Riced and crafted by  Hisham Abdul Hai  ║
--   ║ ...Founder of Linux Arab Gate (L A G)... ║
--   ╚╗                                        ╔╝ 
--    ╚════════════════════════════════════════╝

local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local rnotification = require('ruled.notification')
local dpi = xresources.apply_dpi

local themes_path = '/home/hisham/.config/awesome/themes/'
--local themes_path = gears.filesystem.get_configuration_dir() ..'/themes/'

local theme = {}

-- Default variables
-- Font
theme.font          =   'FiraMono Nerd Font 10'

-- Background colors
theme.bg_normal     =   '#181818'
theme.bg_urgent     =   '#ff000040'
theme.bg_focus      =   theme.bg_normal
theme.bg_minimize   =   theme.bg_normal
theme.bg_systray    =   theme.bg_normal

-- Border colors
theme.border_width      =   dpi(1)
theme.border_normal     =   '#282a36'
theme.border_focus      =   '#7575ff'

-- Foreground color
theme.fg_normal     =   '#eeeeee'
theme.fg_focus      =   theme.fg_normal
theme.fg_urgent     =   theme.fg_normal
theme.fg_minimize   =   theme.fg_normal

-- fullscreen
theme.fullscreen_hide_border = true

-- menubar
theme.menubar_fg_normal     =   theme.fg_normal
theme.menubar_bg_normal     =   theme.bg_normal
theme.menubar_border_width  =   theme.border_width
theme.menubar_border_color  =   theme.border_focus

-- Notifications
theme.notification_font         =   theme.font
theme.notification_bg           =   theme.bg_normal
theme.notification_fg           =   theme.fg_normal
theme.notification_border_width =   theme.border_width
theme.notification_border_color =   theme.border_focus
theme.notification_opacity      =   0.8

-- tooltip
theme.tooltip_border_color  =   theme.border_focus
theme.tooltip_bg            =   theme.bg_normal
theme.tooltip_fg            =   theme.fg_normal
theme.tooltip_font          =   theme.font
theme.tooltip_border_width  =   theme.border_width
theme.tooltip_opacity       =   0.85

-- wibar
theme.wibar_bg              =   theme.bg_normal
theme.wibar_fg              =   theme.fg_normal
theme.wibar_height          =   dpi(22)
theme.wibar_border_width    =   dpi(0)
theme.wibar_border_color    =   theme.bg_normal
theme.wibar_opacity         =   0.85

-- menu
theme.menu_font         =   theme.font
theme.menu_width        =   dpi(150)
theme.menu_border_color =   theme.border_focus
theme.menu_border_width =   dpi(1)
theme.menu_fg_focus     =   theme.fg_focus
theme.menu_bg_focus     =   theme.bg_focus
theme.menu_fg_normal    =   theme.fg_normal
theme.menu_bg_normal    =   theme.bg_normal

-- hotkeys
theme.hotkeys_bg            =   theme.bg_normal
theme.hotkeys_font          =   theme.font
theme.hotkeys_fg            =   theme.fg_normal
theme.hotkeys_border_width  =   dpi(1)
theme.hotkeys_border_color  =   theme.border_focus
theme.hotkeys_opacity	=	0.8

-- tasklist
theme.tasklist_fg_normal                        =       theme.fg_normal
theme.tasklist_bg_normal                        =       theme.bg_normal
theme.tasklist_fg_focus                         =       theme.border_focus
theme.tasklist_disable_icon                     =       true
theme.tasklist_disable_task_name                =       true
theme.tasklist_plain_task_name                  =       true
theme.tasklist_font                             =       theme.font
theme.tasklist_align                            =       left
theme.tasklist_spacing                          =       dpi(5)

-- calendar\
-- theme.calendar\_style = nil
-- theme.calendar\_font = nil
-- theme.calendar\_spacing = nil
-- theme.calendar\_week\_numbers = nil
-- theme.calendar\_start\_sunday = nil
-- theme.calendar\_long\_weekdays = nil

theme.layout_fairh = themes_path..'layouts/fairhw.png'
theme.layout_fairv = themes_path..'layouts/fairvw.png'
theme.layout_floating  = themes_path..'layouts/floatingw.png'
theme.layout_max = themes_path..'layouts/maxw.png'
theme.layout_fullscreen = themes_path..'layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path..'layouts/tilebottomw.png'
theme.layout_tile = themes_path..'layouts/tilew.png'
theme.layout_spiral  = themes_path..'layouts/spiralw.png'
theme.layout_dwindle = themes_path..'layouts/dwindlew.png'
return theme
