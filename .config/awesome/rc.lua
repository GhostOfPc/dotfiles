--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║ ...Founder of Linux Arab Gate (L A G)... ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
--local naughty = require('naughty')
local ruled = require('ruled')
local menubar = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup')

require('awful.autofocus')
require('awful.hotkeys_popup.keys')
local icons = require('icons')


-- Get the configuration directory
local config_dir = gears.filesystem.get_configuration_dir()

-- Import theme
beautiful.init(config_dir .. '/themes/theme.lua')

-- Import apps
local apps = require('apps')

-- Import spotify widget
local spotify = require('widget.spotify-widget.spotify')

-- Import weather widget
local weather = require('widget.weather-widget.weather')

-- Exit screen
require('components.lock-screen')

-- Import vicious
local vicious = require('vicious')

-- Default modkey.
modkey = 'Mod4'
altkey = 'Mod1'
raltkey= 'Mod5'

-- ================================================================================================
-- Layouts
tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
	awful.layout.suit.fair.horizontal,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,
    })
end)

screen.connect_signal('request::desktop_decoration', function(s)
    -- ==== Each tag has its layout and gaps and eventually in rules its clients ==============
    awful.tag.add('',{
	    		icon			= '/home/hisham/.config/awesome/icons/code.png',
			wibox.container.margin(icon, 50, 50, 0, 0),
			layout			= awful.layout.suit.spiral.dwindle,
			gap_single_client	= true,
			gap			= 5,
			screen			= s,
			selected		= true
			}
		)
    awful.tag.add('',{
	    		icon			= '/home/hisham/.config/awesome/icons/browser.png',
			layout			= awful.layout.suit.max,
			gap_single_client	= true,
			gap			= 3,
			screen			= s
			}
		)
    awful.tag.add('',{
	    		icon			= '/home/hisham/.config/awesome/icons/edit.png',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 3,
			screen			= s
			}
		)
    awful.tag.add('',{
	    		icon			= '/home/hisham/.config/awesome/icons/folder.png',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 23,
			screen			= s
			}
		)
    awful.tag.add('',{
	    		icon			= '/home/hisham/.config/awesome/icons/music.png',
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 43,
			screen			= s
			}
		)
    awful.tag.add('',{
	    		icon			= '/home/hisham/.config/awesome/icons/vids.png',
			layout			= awful.layout.suit.max,
			gap_single_client	= true,
			gap			= 2,
			screen			= s
			}
		)

    -- ==== Layout indication icon (On the left of the status bar) ==============
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = awful.button({ }, 1, function () awful.layout.inc( 1) end),
    }

    -- =============== Create a taglist widget ==================================
    s.mytaglist = awful.widget.taglist {
        screen  = s,
	style = {
	        shape		= gears.shape.rectangle,
		bg_focus	= '#7575ff',
		bg_ugent	= '#66ffff',
		bg_empty	= '#515151',
	},
	layout = {
		-- spacing	= 8,
		layout	= wibox.layout.fixed.horizontal,
	},
        filter  = awful.widget.taglist.filter.all,
        buttons = awful.button({ }, 1, function(t) t:view_only() end)
    }

-- ===========================================================================================
-- Status widgets
-- ===========================================================================================
-- Weather
  local weatherwidget = wibox.widget.textbox()
  vicious.register(weatherwidget, vicious.widgets.weather,
    function (widget, args)
      return ' ' .. args['{weather}'] .. ' ' .. args['{tempc}'] .. '°C '
      end, 1800, 'SAZS')
      --'1800': check every 30 minutes.
      --'SAZS': the Bariloche ICAO code.
-- ===========================================================================================

-- ===========================================================================================
volumewidget = wibox.widget.textbox()

	--[[ allows control volume level by:
	- scrolling when the cursor is over the widdget
	- toggling the sound on and off by clicking the widget
	 ]]
	volumewidget:connect_signal('button::press', function (_,_,_,button)
	if (button == 4) then  awful.spawn.with_shell ('$HOME/.local/bin/volume.sh up') 
	elseif (button == 5) then awful.spawn.with_shell ('$HOME/.local/bin/volume.sh down') 
	elseif (button == 1 ) then awful.spawn.with_shell ('$HOME/.local/bin/volume.sh mute') 
	end
			end)
vicious.register(volumewidget, vicious.widgets.volume, '$2 $1%', 1, 'Master')
-- ===========================================================================================

-- ===========================================================================================
-- Date and time
local timewidget = wibox.widget.textbox()
vicious.register(timewidget, vicious.widgets.date, '🕒 %H:%M ', 60)
local datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, '📅 %d-%b-%y (%a) ', 3600)

local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach( datewidget, 'tr' )
-- ===========================================================================================

-- ===========================================================================================
-- CPU graph
   local cpuwidget = awful.widget.graph()
   cpuwidget:set_width(160)
   cpuwidget:set_background_color('#343434')
   cpuwidget:set_color({ type = 'linear', from = { 0, 0 }, to = { 0,0 }, stops = { {1.0, '#A2FF5D'}, {1.0, '#A2FF5D'}, 
                   {1, '#AECF96' }}})
   vicious.register(cpuwidget, vicious.widgets.cpu, ' $1 ', 1)
-- ===========================================================================================

-- ===========================================================================================
-- Netwrok
eths = { 'eno2', 'wlo1' }
netwidget = wibox.widget.textbox()
vicious.register( netwidget, vicious.widgets.net,
function(widget,args)
t=''  
for i = 1, #eths do
e = eths[i]       
if args["{"..e.." carrier}"] == 1 then
    if e == 'wlo1' then
	t=t..'|'..'🔽 '..args['{'..e..' down_kb}']..'kbps 🔼 ' ..args['{'..e..' up_kb}']..'kbps'
    else          
	t=t..'|'..'🔽 '..args['{'..e..' down_kb}']..'kbps 🔼 ' ..args['{'..e..' up_kb}']..'kbps'

    end
end
end               
if string.len(t)>0 then -- remove leading '|'
return string.sub(t,2,-1)
end               
return 'No network'
end                                                                                                                                                           
, 1 )
-- ===========================================================================================

-- ===========================================================================================
-- Memory
local memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, ' 📊 $2 MiB ', 10)
-- ===========================================================================================

-- ===========================================================================================
-- Cpu temperature
local thermalwidget  = wibox.widget.textbox()
 vicious.register(thermalwidget, vicious.widgets.thermal, ' 🤒 $1 °C ', 1, 'thermal_zone4' )
-- ===========================================================================================

-- ===========================================================================================
-- Disk usage
local fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs, '💾 ${/ avail_gb}G', 60)
-- ===========================================================================================

-- ===========================================================================================
-- Uptime
local uptimewidget = wibox.widget.textbox()
vicious.register(uptimewidget,vicious.widgets.uptime,'⏳$1d:$2h:$3m ', 60)
-- ===========================================================================================

-- ===========================================================================================
-- Keyboard map indicator and switcher

mykeyboardlayout = awful.widget.keyboardlayout()
-- ===========================================================================================

-- ===========================================================================================
-- Simple separator between the wibar segments

separator = wibox.widget.textbox(' ')
-- ===========================================================================================

-- ===========================================================================================
-- Create the status bar
    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
	
	-- ================= Left widget ===========================
	{
            layout = wibox.layout.fixed.horizontal,
	    s.mylayoutbox,
	    separator,
            s.mytaglist,
        },
	-- ================= Middle widget ===========================
	separator,

	-- ================= Right widget ===========================
	{
            layout = wibox.layout.fixed.horizontal,
	    spotify({
	    		font = 'FiraMono Nerd Font 10',
			play_icon = '/home/hisham/.local/share/play.png',
			pause_icon = '/home/hisham/.local/share/pause.png',
			show_tooltip = true
			}),
            separator,
	    weatherwidget,
	    netwidget,
	    thermalwidget,
	    fswidget,
	    memwidget,
	    cpuwidget,
	    separator,
	    datewidget,
	    uptimewidget,
	    timewidget,
	    volumewidget,
            mykeyboardlayout,
            wibox.widget.systray(),
        },
    }
-- ===========================================================================================

end)

-- ===========================================================================================
-- Mouse bindings

awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev),
})
-- ===========================================================================================

-- ===========================================================================================
-- Key bindings
awful.keyboard.append_global_keybindings({

    -- ================= General awesome keybindings ===========================
    awful.key({ modkey,           }, 's',      hotkeys_popup.show_help,
              {description='show help', group='awesome'}),

    awful.key({ modkey, 'Shift' }, 'r', awesome.restart,
              {description = 'reload awesome', group = 'awesome'}),
	      
    awful.key({ modkey, 'Shift'   }, 'q', awesome.quit,
              {description = 'quit awesome', group = 'awesome'}),
	
    -- ================= Programs launching keybindings ===========================
    awful.key({ modkey,           }, 'Return', function () awful.spawn(apps.terminal) end,
              {description = 'open a terminal', group = 'launcher'}),

    awful.key({ modkey,           }, 'F1', function () awful.spawn(apps.ssh) end,
              {description = 'open filezilla', group = 'launcher'}),

    awful.key({ modkey,           }, 'g', function () awful.spawn(apps.geditor) end,
              {description = 'open geany', group = 'launcher'}),

    awful.key({ modkey,           }, 'i', function () awful.spawn(apps.vector) end,
              {description = 'open inkscape', group = 'launcher'}),

    awful.key({ modkey,           }, 'v', function () awful.spawn(apps.vplayer) end,
              {description = 'open vlc', group = 'launcher'}),

    awful.key({ modkey,           }, 'm', function () awful.spawn(apps.mc) end,
              {description = 'open kodi', group = 'launcher'}),

    awful.key({ modkey,           }, 'o', function () awful.spawn(apps.mplayer) end,
              {description = 'open spotify', group = 'launcher'}),

    awful.key({ modkey,           }, 'b', function () awful.spawn(apps.browser) end,
              {description = 'Navigate the web', group = 'launcher'}),

    awful.key({ },            'XF86LaunchB',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey },            'p',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey },            'f',     function () awful.spawn(apps.fmanager) end,
              {description = 'open the file manager', group = 'launcher'}),

    awful.key({ modkey },            'n',     function () awful.spawn(apps.wallpaper) end,
              {description = 'Change the wallpaper', group = 'launcher'}),

    awful.key({modkey,	altkey},		'h', function() awful.spawn.with_shell('xterm -hold htop') end,
    	      {description = 'htop', group = 'launcher'}),

    awful.key({modkey,	altkey},		"n", function() awful.spawn.with_shell('xterm -hold neofetch') end,
    	      {description = 'neofetch', group = 'launcher'}),
    awful.key({modkey,	altkey},		'c', function() awful.spawn.with_shell('kitty -e cmatrix') end,
    	      {description = 'cmatrix', group = 'launcher'}),

    -- ================= Programs killing keybindings ===========================
    awful.key({ modkey, 'Shift' }, 'v', function () awful.spawn.with_shell('kill -9 $(pgrep vlc)') end,
              {description = 'kill vlc', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'm', function () awful.spawn.with_shell('kill -9 $(pgrep kodi)') end,
              {description = 'kill kodi', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'u', function () awful.spawn.with_shell('kill -9 $(pgrep uget-gtk)') end,
              {description = 'kill uget', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'b', function () awful.spawn.with_shell('kill -9 $(pgrep qbittorrent)') end,
              {description = 'kill qbittorrent', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'o', function () awful.spawn.with_shell('kill -9 $(pgrep spotify)') end,
              {description = 'kill spotify', group = 'client'}),

    -- ================= Screenshoot keybinging ===========================
	awful.key({modkey, 'Shift'},'s',function() awful.spawn.with_shell(apps.screenshot) end,
	{description = 'Take a screenshot', group = 'hotKeys'}),

    -- ================= Hotkeys (using multimedia keys) ===========================
    awful.key({ }, 'XF86AudioRaiseVolume', function () awful.spawn.with_shell('$HOME/.local/bin/volume.sh up') end,
              {description = 'Volume increase', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioLowerVolume', function () awful.spawn.with_shell('$HOME/.local/bin/volume.sh down') end,
              {description = 'Volume decrease', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioMute', function () awful.spawn.with_shell('$HOME/.local/bin/volume.sh mute') end,
              {description = 'Volume mute', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioNext', function () awful.spawn('playerctl next') end,
              {description = 'Jump to the next song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioPrev', function () awful.spawn('playerctl previous') end,
              {description = 'Jump to the previous song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioPlay', function () awful.spawn('playerctl play-pause') end,
              {description = 'Play/Pause current song', group = 'hotKeys'}),

    awful.key({ }, 'XF86MonBrightnessUp', function () awful.spawn.with_shell('$HOME/.local/bin/brightness.sh up') end,
              {description = 'Brightness increase', group = 'hotKeys'}),

    awful.key({ }, 'XF86MonBrightnessDown', function () awful.spawn.with_shell('$HOME/.local/bin/brightness.sh down') end,
              {description = 'Brightness decrease', group = 'hotKeys'}),

    -- ================= Hotkeys (using modifier key) ===========================
    awful.key({ altkey}, 'x', function () awful.spawn.with_shell('$HOME/.local/bin/volume.sh up') end,
              {description = 'Volume increase', group = 'hotKeys'}),

    awful.key({ altkey}, 'z', function () awful.spawn.with_shell('$HOME/.local/bin/volume.sh down') end,
              {description = 'Volume decrease', group = 'hotKeys'}),

    awful.key({ altkey}, 'c', function () awful.spawn.with_shell('$HOME/.local/bin/volume.sh mute') end,
              {description = 'Volume mute', group = 'hotKeys'}),

    awful.key({ altkey}, 'd', function () awful.spawn('playerctl next') end,
              {description = 'Jump to the next song', group = 'hotKeys'}),

    awful.key({ altkey}, 'a', function () awful.spawn('playerctl previous') end,
              {description = 'Jump to the previous song', group = 'hotKeys'}),

    awful.key({ altkey}, 's', function () awful.spawn('playerctl play-pause') end,
              {description = 'Play/Pause current song', group = 'hotKeys'}),

    awful.key({ altkey}, 'w', function () awful.spawn.with_shell('$HOME/.local/bin/brightness.sh up') end,
              {description = 'Brightness increase', group = 'hotKeys'}),

    awful.key({ altkey}, 'q', function () awful.spawn.with_shell('$HOME/.local/bin/brightness.sh down') end,
              {description = 'Brightness decrease', group = 'hotKeys'}),

    -- ================= dmenu scripts ===========================
    awful.key({ raltkey }, '1', function () awful.spawn.with_shell('$HOME/.local/bin/dmenu_url.sh') end,
              {description = 'dmenu script to surf the web', group = 'dmenu'}),

    awful.key({ raltkey }, '2', function () awful.spawn.with_shell('$HOME/.local/bin/dmenu_webSearch.sh') end,
              {description = 'dmenu script to search the web', group = 'dmenu'}),

    awful.key({ raltkey }, '3', function () awful.spawn.with_shell('$HOME/.local/bin/dmenu_kill.sh') end,
              {description = 'dmenu script to kill a process', group = 'dmenu'}),

    awful.key({ raltkey }, '4', function () awful.spawn.with_shell('$HOME/.local/bin/nordvpn.sh') end,
              {description = 'dmenu script to switch the vpn', group = 'dmenu'}),

    awful.key({ raltkey }, '5', function () awful.spawn.with_shell('$HOME/.local/bin/dmenu_emoji.sh') end,
              {description = 'dmenu script to select an emoji', group = 'dmenu'}),

    awful.key({ raltkey }, '6', function () awful.spawn.with_shell('$HOME/.local/bin/configs.sh') end,
              {description = 'dmenu script to edit confgiration files', group = 'dmenu'}),

})

awful.keyboard.append_global_keybindings({
    -- ================= Switching between tags ===========================
    awful.key({ modkey,           }, 'Left',   awful.tag.viewprev,
              {description = 'view previous', group = 'tag'}),

    awful.key({ modkey,           }, 'Right',  awful.tag.viewnext,
              {description = 'view next', group = 'tag'}),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = 'go back', group = 'tag'}),
})

awful.keyboard.append_global_keybindings({
    -- ================= Switching between clients ===========================
    awful.key({ modkey,           }, 'j', function () awful.client.focus.byidx( 1) end,
        {description = 'focus next by index', group = 'client'}),

    awful.key({ modkey,           }, 'k', function () awful.client.focus.byidx(-1) end,
        {description = 'focus previous by index', group = 'client'}),

    awful.key({ modkey,           }, 'Tab', function ()
	    awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'go back', group = 'client'}),
})

awful.keyboard.append_global_keybindings({
    -- ================= Layout control keybindings ===========================
    awful.key({ modkey, 'Shift'   }, 'j', function () awful.client.swap.byidx(  1)    end,
              {description = 'swap with next client by index', group = 'client'}),

    awful.key({ modkey, 'Shift'   }, 'k', function () awful.client.swap.byidx( -1)    end,
              {description = 'swap with previous client by index', group = 'client'}),

   awful.key({ modkey, 'Shift'   }, 'h',     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = 'increase the number of master clients', group = 'layout'}),

    awful.key({ modkey, 'Shift'   }, 'l',     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = 'decrease the number of master clients', group = 'layout'}),

    awful.key({ modkey, 'Control' }, 'h',     function () awful.tag.incncol( 1, nil, true)    end,
              {description = 'increase the number of columns', group = 'layout'}),

    awful.key({ modkey, 'Control' }, 'l',     function () awful.tag.incncol(-1, nil, true)    end,
              {description = 'decrease the number of columns', group = 'layout'}),

    awful.key({ modkey,           }, 'space', function () awful.layout.inc( 1)                end,
              {description = 'select next', group = 'layout'}),

    awful.key({ modkey, 'Shift'   }, 'space', function () awful.layout.inc(-1)                end,
              {description = 'select previous', group = 'layout'}),
})

awful.keyboard.append_global_keybindings({
    -- ================= Gap resizing keybindings ===========================
	awful.key({ altkey }, '.', 
	function ()
		awful.tag.incgap(2,null)
	end,
	{description = 'Increase gap size', group = 'gap control'}),

	awful.key({ altkey }, ',', 
	function ()
		awful.tag.incgap(-2,null)
	end,
	{description = 'Decrease gap size', group = 'gap control'}),

})

awful.keyboard.append_global_keybindings({
    -- ================= Resize client keybindings ===========================
    awful.key({ modkey,           }, 'minus',     function () awful.tag.incmwfact( 0.05)          end,
              {description = 'increase master width factor', group = 'layout'}),

    awful.key({ modkey,           }, 'period',     function () awful.tag.incmwfact(-0.05)          end,
              {description = 'decrease master width factor', group = 'layout'}),
})

awful.keyboard.append_global_keybindings({
    -- ================= Switch between tags and move clients to tags ===========================
    awful.key {
        modifiers   = { modkey },
        keygroup    = 'numrow',
        description = 'only view tag',
        group       = 'tag',
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, 'Control' },
        keygroup    = 'numrow',
        description = 'toggle tag',
        group       = 'tag',
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, 'Shift' },
        keygroup    = 'numrow',
        description = 'move focused client to tag',
        group       = 'tag',
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, 'Control', 'Shift' },
        keygroup    = 'numrow',
        description = 'toggle focused client on tag',
        group       = 'tag',
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = 'numpad',
        description = 'select layout directly',
        group       = 'layout',
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

-- ================= Tags are clickable ===========================
client.connect_signal('request::default_mousebindings', function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = 'mouse_click' }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = 'mouse_click', action = 'mouse_move'  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = 'mouse_click', action = 'mouse_resize'}
        end),
    })
end)

-- ================= Miscellaneous keybindings (toggle full screen, floating, move to master) =========
client.connect_signal('request::default_keybindings', function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey, 'Shift' }, 'f',
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = 'toggle fullscreen', group = 'client'}),

	awful.key({ modkey,'Shift' }, 'c',
		function (c) c:kill()
		end,
                {description = 'close', group = 'client'}),

        awful.key({ modkey, 'Control' }, 'space',  awful.client.floating.toggle,
                {description = 'toggle floating', group = 'client'}),

        awful.key({ modkey, 'Control' }, 'Return',
		function (c) c:swap(awful.client.getmaster())
		end,
                {description = 'move to master', group = 'client'}),
    })
end)
-- ================================================================================================

-- ================================================================================================
-- Rules

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
	    placement = awful.placement.centered

        }
    }

  -- ================= Floating clients ================
    ruled.client.append_rule {
        id       = 'floating',
        rule_any = {
            instance = { 'copyq', 'pinentry' },
            class    = {
                'Arandr', 'Blueman-manager', 'Nitrogen', 'lxappearnace', 'qt5ct',
                'Kvantum Manager', 'Xarchiver', 'Nm-connection-editor', 'Pavucontrol', 'Rofi'
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                'Event Tester',  -- xev.
		'pulsemixer',
		'Customize Look and Feel'
            },
            role    = {
                'pop-up',         -- e.g. Google Chrome (detached) Developer Tools.
		'GtkFileChooserDialog'
            }
        },
        properties = { floating = true, 
			width = awful.screen.focused().workarea.width * 0.6,
        		height = awful.screen.focused().workarea.height * 0.6
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
        properties = { tag = screen[1].tags[6] , switchtotag = true}
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
			-- Disable fullscreen first
			c.fullscreen = false

			-- Check if Kodi is already open
			local stk = function (c)
				return ruled.client.match(c, { class = 'Kodi' })
			end

			local stk_count = 0
			for c in awful.client.iterate(stk) do
				stk_count = stk_count + 1
			end

			-- If Kodi is already open, do not open a new instance
			if stk_count > 1 then
				c:kill()
				-- Switch to previous instance
				for c in awful.client.iterate(stk) do
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
-- ================================================================================================

-- ================================================================================================
-- Enable sloppy focus, so that focus follows mouse.

client.connect_signal('mouse::enter', function(c)
    c:activate { context = 'mouse_enter', raise = false }
end)
-- ================================================================================================
