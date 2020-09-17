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
local hotkeys_popup = require('awful.hotkeys_popup')

-- Import apps
local apps = require('apps')

-- Default modkey.
modkey      =   'Mod4'
altkey      =   'Mod1'
raltkey     =   'Mod5'

local keys = {}

awful.keyboard.append_global_keybindings({
    -- ================= General awesome keybindings ===========================
    awful.key({ modkey,           }, 's',      hotkeys_popup.show_help,
              {description='show help', group='awesome'}),

    awful.key({ modkey, 'Shift' }, 'r', awesome.restart,
              {description = 'reload awesome', group = 'awesome'}),
	      
    awful.key({ modkey, 'Shift'   }, 'q', awesome.quit,
              {description = 'quit awesome', group = 'awesome'}),

    awful.key({ raltkey }, 'Escape', 
    	    function()
		--exit_screen_show()
        awful.spawn.with_shell('$HOME/.local/bin/dmenu_shutdown.sh')
    	    end,
    {description = 'Power options', group = 'awesome'}),

    -- ================= Programs launching keybindings ===========================
    awful.key({ modkey,           }, 'Return', function () awful.spawn(apps.terminal) end,
              {description = 'open a terminal', group = 'launcher'}),

    awful.key({ modkey,           }, 'F1', function () awful.spawn(apps.ssh) end,
              {description = 'open filezilla', group = 'launcher'}),

    awful.key({ modkey,           }, 'g', function () awful.spawn(apps.geditor) end,
              {description = 'open geany', group = 'launcher'}),

    awful.key({modkey,     'Shift'}, 's',function () awful.spawn('st') end,
              {description = 'open st terminal', group = 'launcher'}),

    awful.key({modkey,     'Shift'}, 'a',function () awful.spawn('alacritty') end,
              {description = 'open alacritty terminal', group = 'launcher'}),

    awful.key({ modkey,           }, 'i', function () awful.spawn(apps.vector) end,
              {description = 'open inkscape', group = 'launcher'}),

    awful.key({ modkey,           }, 'v', function () awful.spawn(apps.vplayer) end,
              {description = 'open vlc', group = 'launcher'}),

    awful.key({ modkey,           }, 'm', function () awful.spawn(apps.mc) end,
              {description = 'open mediaCenter', group = 'launcher'}),

    awful.key({ modkey,           }, 'o', function () awful.spawn.with_shell('$TERMINAL --hold .local/bin/spt_o.sh') end,
              {description = 'open spotify', group = 'launcher'}),

    awful.key({ modkey,           }, 'b', function () awful.spawn(apps.browser) end,
              {description = 'Navigate the web', group = 'launcher'}),

    awful.key({                   }, 'XF86LaunchB',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey            }, 'p',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey            }, 'f',     function () awful.spawn.with_shell('$TERMINAL --hold lf') end,
              {description = 'open the file manager', group = 'launcher'}),

    awful.key({ modkey            }, 'n',     function () awful.spawn(apps.wallpaper) end,
              {description = 'Change the wallpaper', group = 'launcher'}),

    awful.key({modkey,	    altkey}, 'h', function() awful.spawn.with_shell('$TERMINAL --hold htop') end,
    	      {description = 'htop', group = 'launcher'}),

    awful.key({modkey,	    altkey},		"n", function() awful.spawn.with_shell('$TERMINAL --hold neofetch') end,
    	      {description = 'neofetch', group = 'launcher'}),

    awful.key({modkey,	    altkey}, 'c', function() awful.spawn.with_shell('$TERMINAL --hold cmatrix') end,
    	      {description = 'cmatrix', group = 'launcher'}),

    awful.key({modkey,	    'Shift'}, 'p', function() awful.spawn.with_shell('$TERMINAL --hold pulsemixer') end,
    	      {description = 'run pulsemixer', group = 'launcher'}),

    -- ================= Programs killing keybindings ===========================
    awful.key({ modkey, 'Shift' }, 'v', function () awful.spawn.with_shell('kill -9 $(pgrep vlc)') end,
              {description = 'kill vlc', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'm', function () awful.spawn.with_shell('kill -9 $(pgrep kodi)') end,
              {description = 'kill kodi', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'u', function () awful.spawn.with_shell('kill -9 $(pgrep uget-gtk)') end,
              {description = 'kill uget', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 't', function () awful.spawn.with_shell('kill -9 $(pgrep qbittorrent)') end,
              {description = 'kill qbittorrent', group = 'client'}),

    awful.key({ modkey, 'Shift' }, 'o', function () awful.spawn.with_shell('$HOME/.local/bin/spt_k.sh') end,
              {description = 'kill spotify', group = 'client'}),

    -- ================= Screenshoot keybinging ===========================
	awful.key({modkey, 'Shift'},'f',function() awful.spawn.with_shell(apps.screenshot) end,
	{description = 'Take a screenshot', group = 'hotKeys'}),

    -- ================= Hotkeys (using multimedia keys) ===========================
    awful.key({ }, 'XF86AudioRaiseVolume', function () awful.spawn.with_shell('amixer -D pulse sset Master 5%+') end,
              {description = 'Volume increase', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioLowerVolume', function () awful.spawn.with_shell('amixer -D pulse sset Master 5%-') end,
              {description = 'Volume decrease', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioMute', function () awful.spawn.with_shell('amixer -D pulse sset Master 1+ toggle') end,
              {description = 'Volume mute', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioNext', function () awful.spawn('playerctl next') end,
              {description = 'Jump to the next song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioPrev', function () awful.spawn('playerctl previous') end,
              {description = 'Jump to the previous song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioPlay', function () awful.spawn('playerctl play-pause') end,
              {description = 'Play/Pause current song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioNext', function () awful.spawn('mpc next') end,
              {description = 'Jump to the next song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioPrev', function () awful.spawn('mpc prev') end,
              {description = 'Jump to the previous song', group = 'hotKeys'}),

    awful.key({ }, 'XF86AudioPlay', function () awful.spawn('mpc toggle') end,
              {description = 'Play/Pause current song', group = 'hotKeys'}),

    awful.key({ }, 'XF86MonBrightnessUp', function () awful.spawn.with_shell('xbacklight -inc 2') end,
              {description = 'Brightness increase', group = 'hotKeys'}),

    awful.key({ }, 'XF86MonBrightnessDown', function () awful.spawn.with_shell('xbacklight -dec 2') end,
              {description = 'Brightness decrease', group = 'hotKeys'}),

    -- ================= Hotkeys (using modifier key) ===========================
    awful.key({ altkey}, 'x', function () awful.spawn.with_shell('amixer -D pulse sset Master 5%+') end,
              {description = 'Volume increase', group = 'hotKeys'}),

    awful.key({ altkey}, 'z', function () awful.spawn.with_shell('amixer -D pulse sset Master 5%-') end,
              {description = 'Volume decrease', group = 'hotKeys'}),

    awful.key({ altkey}, 'c', function () awful.spawn.with_shell('amixer -D pulse sset Master 1+ toggle') end,
              {description = 'Volume mute', group = 'hotKeys'}),

    awful.key({ altkey}, 'd', function () awful.spawn('playerctl next') end,
              {description = 'Jump to the next song', group = 'hotKeys'}),

    awful.key({ altkey}, 'a', function () awful.spawn('playerctl previous') end,
              {description = 'Jump to the previous song', group = 'hotKeys'}),

    awful.key({ altkey}, 's', function () awful.spawn('playerctl play-pause') end,
              {description = 'Play/Pause current song', group = 'hotKeys'}),

    awful.key({ altkey}, 'w', function () awful.spawn.with_shell('xbacklight -inc 2') end,
              {description = 'Brightness increase', group = 'hotKeys'}),

    awful.key({ altkey}, 'q', function () awful.spawn.with_shell('xbacklight -dec 2') end,
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

    awful.key({ raltkey }, 's', function () awful.spawn.with_shell('$HOME/.local/bin/dmenu_services.sh') end,
              {description = 'dmenu script to Start/Stop systemd services', group = 'dmenu'}),

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
    awful.key({ modkey,           }, 'minus',     function () awful.tag.incmwfact( 0.01)          end,
              {description = 'increase master width factor', group = 'layout'}),

    awful.key({ modkey,           }, 'period',     function () awful.tag.incmwfact(-0.01)          end,
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


return keys
