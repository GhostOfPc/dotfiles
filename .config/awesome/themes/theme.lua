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

local theme = {}

-- Default variables
-- Font
theme.font          =   'FiraMono Nerd Font 10'

-- Background colors
theme.bg_normal     =   '#181818'
theme.bg_urgent     =   '#818181'
theme.bg_focus      =   theme.bg_normal
theme.bg_minimize   =   theme.bg_normal
theme.bg_systray    =   theme.bg_normal

-- Border colors
theme.border_width      =   dpi(1)
theme.border_normal     =   '#282a36'
theme.border_focus      =   '#ff92df'

-- Foreground color
theme.fg_normal     =   '#EEEEEE'
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

-- taglist
theme.taglist_fg_focus                  =       theme.border_focus
theme.taglist_fg_urgent                 =       '#FF0000'
theme.taglist_bg_focus                  =       '#545454'
theme.taglist_font                      =       'AwesomeFont 11'
theme.taglist_fg_empty                  =       '#EEEEEE40'

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

-- icon
theme.icon_theme	=	'/usr/share/icons/Papirus/48x48'

-- layoutlist\
-- theme.layoutlist\_fg\_normal = nil
-- theme.layoutlist\_bg\_normal = nil
-- theme.layoutlist\_fg\_selected = nil
-- theme.layoutlist\_bg\_selected = nil
-- theme.layoutlist\_disable\_icon = nil
-- theme.layoutlist\_disable\_name = nil
-- theme.layoutlist\_font = nil
-- theme.layoutlist\_align = nil
-- theme.layoutlist\_font\_selected = nil
-- theme.layoutlist\_spacing = nil
-- theme.layoutlist\_shape = nil
-- theme.layoutlist\_shape\_border\_width = nil
-- theme.layoutlist\_shape\_border\_color = nil
-- theme.layoutlist\_shape\_selected = nil
-- theme.layoutlist\_shape\_border\_width\_selected = nil
-- theme.layoutlist\_shape\_border\_color\_selected = nil

return theme
