--    ╔════════════════════════════════════════╗
--   ╔╝                                        ╚╗
--   ║ Riced and crafted by  Hisham Abdul Hai  ║
--   ║ ...Founder of Linux Arab Gate (L A G)... ║
--   ╚╗                                        ╔╝ 
--    ╚════════════════════════════════════════╝

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

-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,
    })
end)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

screen.connect_signal('request::desktop_decoration', function(s)
    -- Each screen has its own tag table.
    awful.tag.add('  ',{
			layout			= awful.layout.suit.spiral.dwindle,
			gap_single_client	= true,
			gap			= 5,
			screen			= s,
			selected		= true
			}
		)
    awful.tag.add('  ',{
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 3,
			screen			= s
			}
		)
    awful.tag.add('  ',{
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 3,
			screen			= s
			}
		)
    awful.tag.add('  ',{
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 3,
			screen			= s
			}
		)
    awful.tag.add('  ',{
			layout			= awful.layout.suit.tile,
			gap_single_client	= true,
			gap			= 3,
			screen			= s
			}
		)
    awful.tag.add('  ',{
			layout			= awful.layout.suit.max,
			gap_single_client	= true,
			gap			= 2,
			screen			= s
			}
		)

    -- Create an imagebox widget which will contain an icon indicating which layout we are using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end),
        }
    }

--  Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", apps.terminal .. " -e man awesome" },
   { "edit config", apps.editor .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", apps.terminal }
                                  }
                        })
mylauncher = awful.widget.launcher({ image = '🐧',
                                     menu = mymainmenu })
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it

-- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = 'tasklist', action = 'toggle_minimization' }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx( 1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx(-1) end),
        }
    }

-- Wibar widget

-- Weather
  local weatherwidget = wibox.widget.textbox()
  weather_t = awful.tooltip({ objects = { weatherwidget },})
  vicious.register(weatherwidget, vicious.widgets.weather,
    function (widget, args)
      weather_t:set_text('City: ' .. args['{city}'] ..'\nWind: ' .. args['{windkmh}'] .. 'km/h ' .. args['{wind}'] .. '\nSky: ' .. args['{sky}'] .. '\nHumidity: ' .. args['{humid}'] .. '%')
      return args['{sky}'] .. ' ' .. args['{tempc}'] .. '°C '
      end, 1800, 'SAZS')
      --'1800': check every 10 minutes.
      --'SAZS': the Bariloche ICAO code.

-- Volume
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume,
                 function (widget, args)
                     local label = {["🔊"] = "O", ["♩"] = "🔇"}
                     return ("🔊 %d%%"):format(
                         args[1], label[args[2]])
                 end, 2, "Master")

-- Date and time
local timewidget = wibox.widget.textbox()
vicious.register(timewidget, vicious.widgets.date, '🕒<span color = "#19F6FF">%H:%M </span>', 60)
local datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, '📅 <span color = "#1EB715">%d-%b-%y (%a) </span>', 3600)

-- CPU graph
   local cpuwidget = awful.widget.graph()
   cpuwidget:set_width(100)
   cpuwidget:set_background_color('#181818')
   cpuwidget:set_color({ type = 'linear', from = { 0, 0 }, to = { 0,0 }, stops = { {1.0, '#A2FF5D'}, {1.0, '#A2FF5D'}, 
                   {1, '#AECF96' }}})
   vicious.register(cpuwidget, vicious.widgets.cpu, ' $2 ', 1)

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
	t=t..'|'..'🔽 <span color="#00FF00">'..args['{'..e..' down_kb}']..'kbps</span> 🔼<span color="#FF0000"> ' ..args['{'..e..' up_kb}']..'kbps</span>'
    else          
	t=t..'|'..'🔽 <span color="#00FF00">'..args['{'..e..' down_kb}']..'kbps</span> 🔼<span color="#FF0000"> ' ..args['{'..e..' up_kb}']..'kbps</span>'

    end
end
end               
if string.len(t)>0 then -- remove leading '|'
return string.sub(t,2,-1)
end               
return 'No network'
end                                                                                                                                                           
, 1 )

-- Memory
local memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, ' 📊 <span color = "#00F0FF">$2 MiB </span>', 10)

-- Cpu temperature
local thermalwidget  = wibox.widget.textbox()
 vicious.register(thermalwidget, vicious.widgets.thermal, ' 🤒 $1 °C ', 1, 'thermal_zone4' )

-- Disk usage
local fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs, '💾 <span color = "#FF00FF">${/ avail_gb}G</span>', 60)

-- Uptime
local uptimewidget = wibox.widget.textbox()
vicious.register(uptimewidget,vicious.widgets.uptime,'⏳<span color ="#FFFF00">$1d:$2h:$3m </span>', 60)

-- Separator
separator = wibox.widget.textbox(' ')

-- Add the previously created widgets to the status bar
    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
	
	-- Left widget
	{
            layout = wibox.layout.fixed.horizontal,
	    s.mylayoutbox,
	    separator,
            s.mytaglist,
        },
	
	-- Middle widgets
	separator,

	-- Right widget
	{
            layout = wibox.layout.fixed.horizontal,
	    cpuwidget,
	    weatherwidget,
	    netwidget,
	    thermalwidget,
	    fswidget,
	    memwidget,
	    datewidget,
	    uptimewidget,
	    timewidget,
	    volumewidget,
            mykeyboardlayout,
            wibox.widget.systray(),
        },
    }

end)

-- Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev),
})

-- Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, 's',      hotkeys_popup.show_help,
              {description='show help', group='awesome'}),

    awful.key({ modkey, 'Shift' }, 'r', awesome.restart,
              {description = 'reload awesome', group = 'awesome'}),
	      
    awful.key({ modkey, 'Shift'   }, 'q', awesome.quit,
              {description = 'quit awesome', group = 'awesome'}),
-- LockScreen
	awful.key ({ raltkey }, 'Escape',
		function()
			exit_screen_show()
		end,
		{description = 'LockScreen', group = 'awesome'}
	),

-- Program launching keybinding
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

-- Program killing keybinding
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


-- Take a screenshot
	awful.key({modkey, 'Shift'},'s',function() awful.spawn.with_shell(apps.screenshot) end,
	{description = 'Take a screenshot', group = 'hotKeys'}),

-- Hotkeys (using multimedia keys)
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

-- Hotkeys (using modifier key)
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

-- dmenu script
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
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, 'Left',   awful.tag.viewprev,
              {description = 'view previous', group = 'tag'}),

    awful.key({ modkey,           }, 'Right',  awful.tag.viewnext,
              {description = 'view next', group = 'tag'}),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = 'go back', group = 'tag'}),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
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

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
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

-- Gap resizing
awful.keyboard.append_global_keybindings({
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

-- Resize client keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, 'minus',     function () awful.tag.incmwfact( 0.05)          end,
              {description = 'increase master width factor', group = 'layout'}),

    awful.key({ modkey,           }, 'period',     function () awful.tag.incmwfact(-0.05)          end,
              {description = 'decrease master width factor', group = 'layout'}),
})

awful.keyboard.append_global_keybindings({
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

client.connect_signal('request::default_keybindings', function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey, 'Shift' }, 'f',
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = 'toggle fullscreen', group = 'client'}),

	awful.key({ modkey,'Shift' }, 'c',      function (c) c:kill()                         end,
                {description = 'close', group = 'client'}),

        awful.key({ modkey, 'Control' }, 'space',  awful.client.floating.toggle                     ,
                {description = 'toggle floating', group = 'client'}),

        awful.key({ modkey, 'Control' }, 'Return', function (c) c:swap(awful.client.getmaster()) end,
                {description = 'move to master', group = 'client'}),
    })
end)

-- {{{ Rules
-- Rules to apply to new clients.
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

    -- Floating clients.
    ruled.client.append_rule {
        id       = 'floating',
        rule_any = {
            instance = { 'copyq', 'pinentry' },
            class    = {
                'Arandr', 'Blueman-manager', 'Nitrogen', 'Lxappearnace', 'qt5ct',
                'Kvantum Manager', 'Xarchiver', 'Nm-connection-editor', 'Pavucontrol', 'Rofi'
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                'Event Tester',  -- xev.
            },
            role    = {
                'pop-up',         -- e.g. Google Chrome (detached) Developer Tools.
		'GtkFileChooserDialog'
            }
        },
        properties = { floating = true }
    }

    -- Each specific program will open in its correspoindig tag
    ruled.client.append_rule {
        rule       = { class = 'kitty'     },
        properties = { screen = 1, tag = '  ' }
    }
    ruled.client.append_rule {
        rule       = { class = 'Brave-browser'     },
        properties = { screen = 1, tag = '  ' }
    }
    ruled.client.append_rule {
        rule       = { class = 'Uget-gtk'},
        properties = { screen = 1, tag = '  ' }
    }
    ruled.client.append_rule {
        rule       = { class = 'qBittorrent'},
        properties = { screen = 1, tag = '  ' }
    }
    ruled.client.append_rule {
        rule       = { class = 'Pcmanfm'},
        properties = { screen = 1, tag = '  ' }
    }
    ruled.client.append_rule {
        rule       = { class = 'Geany'},
        properties = { screen = 1, tag = '  ' }
    }
    ruled.client.append_rule {
        rule       = { class = 'vlc'},
        properties = { screen = 1, tag = '  ' }
    }
-- Normally we would do this with a rule, but other apps like spotify and Kodi do not set its class or name
-- until after it starts up, so we need to catch that signal.

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
				local t = awful.tag.find_by_name(awful.screen.focused(), '  ')
				c:move_to_tag(t)
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
				local t = awful.tag.find_by_name(awful.screen.focused(), '  ')
				c:move_to_tag(t)
				t:view_only()
				-- Enable fullscreeen again
				c.fullscreen = true
			end
		end

	end
)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    c:activate { context = 'mouse_enter', raise = false }
end)


