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

local layouts = {}

tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts(
    {
        awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,
    }
    )
end)


return layouts
