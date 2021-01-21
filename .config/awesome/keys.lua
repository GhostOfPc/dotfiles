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
require('awful.autofocus')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local apps = require('apps')
local xrandr=require('xrandr')

modkey = 'Mod4'
altkey = 'Mod1'
raltkey = 'Mod5'

local keys = {}



-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
   if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
      if direction == "up" then
         c:relative_move(0, 0, 0, -floating_resize_amount)
      elseif direction == "down" then
         c:relative_move(0, 0, 0, floating_resize_amount)
      elseif direction == "left" then
         c:relative_move(0, 0, -floating_resize_amount, 0)
      elseif direction == "right" then
         c:relative_move(0, 0, floating_resize_amount, 0)
      end
   else
      if direction == "up" then
         awful.client.incwfact(-tiling_resize_factor)
      elseif direction == "down" then
         awful.client.incwfact(tiling_resize_factor)
      elseif direction == "left" then
         awful.tag.incmwfact(-tiling_resize_factor)
      elseif direction == "right" then
         awful.tag.incmwfact(tiling_resize_factor)
      end
   end
end

globalkeys = gears.table.join(
    -- ================= General awesome keybindings ===========================
    awful.key({ modkey,           }, 's',      hotkeys_popup.show_help,
              {description='show help', group='awesome'}),

    awful.key({ modkey, 'Shift' }, 'r', awesome.restart,
              {description = 'reload awesome', group = 'awesome'}),

    awful.key({ modkey, 'Shift'   }, 'q', awesome.quit,
              {description = 'quit awesome', group = 'awesome'}),

    awful.key({ raltkey }, 'Escape', function()
        awful.spawn.with_shell('$HOME/.local/bin/dmenu_shutdown.sh') end,
        {description = 'Power options', group = 'awesome'}),

    -- ================= Switching between tags ===========================
    awful.key({ modkey,           }, 'Left',   awful.tag.viewprev,
              {description = 'view previous', group = 'tag'}),

    awful.key({ modkey,           }, 'Right',  awful.tag.viewnext,
              {description = 'view next', group = 'tag'}),

    -- ================= Switching between clients ===========================
    awful.key({ modkey,           }, 'j', function ()
            awful.client.focus.byidx( 1) end,
        {description = 'focus next by index', group = 'client'}),
    awful.key({ modkey,           }, 'k', function ()
            awful.client.focus.byidx(-1) end,
        {description = 'focus previous by index', group = 'client'}),

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

    -- ================= Resize client keybindings ===========================
    awful.key({ modkey,           }, 'minus',     function () awful.tag.incmwfact( 0.01)          end,
              {description = 'increase master width factor', group = 'layout'}),

    awful.key({ modkey,           }, 'period',     function () awful.tag.incmwfact(-0.01)          end,
              {description = 'decrease master width factor', group = 'layout'}),

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

    awful.key({                   }, 'XF86LaunchA',     function () awful.spawn.with_shell('$TERMINAL --hold $HOME/.local/bin/fhd_2_4k.sh') end,
              {description = 'Change Screen resolution', group = 'launcher'}),

    awful.key({ modkey            }, 'p',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey            }, 'r',     function () awful.spawn(apps.rofi) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey            }, 'f',     function () awful.spawn(apps.fmanager) end,
              {description = 'open the file manager', group = 'launcher'}),

    awful.key({ modkey            }, 'n',     function () awful.spawn(apps.wallpaper) end,
              {description = 'Change the wallpaper', group = 'launcher'}),

    awful.key({modkey,	    altkey}, 'h', function() awful.spawn.with_shell('$TERMINAL --hold htop') end,
    	      {description = 'htop', group = 'launcher'}),

    awful.key({modkey,	    altkey},		'n', function() awful.spawn.with_shell('$TERMINAL --hold neofetch') end,
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

    awful.key({ altkey}, 'p', function () awful.spawn.with_shell('$HOME/.local/bin/shuffle.sh') end,
              {description = 'Play a random file (audio/video) with mpv', group = 'hotKeys'}),

    awful.key({ altkey, 'Control'}, 'p', function () awful.spawn.with_shell('$HOME/.local/bin/shuffleList.sh') end,
              {description = 'Create a random playlist of random videos ', group = 'hotKeys'}),

    awful.key({ modkey, }, 'w', function () awful.spawn.with_shell('nitrogen --random --set-zoom-fill') end,
              {description = 'Set a random wallpaper', group = 'hotKeys'}),

    awful.key({ altkey, 'Control'}, 'm', function () awful.spawn.with_shell('mpv $(xclip -o -selection clipboard)') end,
              {description = 'Play the copied link with mpv w/o caching', group = 'hotKeys'}),

    awful.key({ altkey, }, 'm', function () awful.spawn.with_shell('mpv --cache=yes $(xclip -o -selection clipboard)') end,
              {description = 'Play the copied link with mpv w caching', group = 'hotKeys'}),

    awful.key({ raltkey, }, '7', function () awful.spawn.with_shell('$HOME/.local/bin/movies.sh') end,
              {description = 'Play a random movie', group = 'hotKeys'}),
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

    awful.key({ raltkey }, 'w', function () awful.spawn.with_shell('$HOME/.local/bin/mpvWatch.sh') end,
              {description = 'dmenu script to edit confgiration files', group = 'dmenu'}),

    awful.key({ raltkey }, 's', function () awful.spawn.with_shell('$HOME/.local/bin/dmenu_services.sh') end,
              {description = 'dmenu script to Start/Stop systemd services', group = 'dmenu'}),

    awful.key({ raltkey }, 'r', function () xrandr.xrandr() end,
              {description = 'dmenu script to Start/Stop systemd services', group = 'dmenu'}),

    awful.key({ modkey }, 't', function () awful.spawn.with_shell('$HOME/.local/bin/theme.sh') end,
              {description = 'Toggle dark or light theme', group = 'dmenu'}),

    -- ================= Increase brightness with xrandr ===========================
    awful.key({ raltkey }, 'XF86MonBrightnessUp', function () awful.spawn.with_shell('xrandr --output HDMI-A-0 --brightness 1.25') end,
              {description = 'dmenu script to surf the web', group = 'dmenu'}),

    awful.key({ raltkey }, 'XF86MonBrightnessDown', function () awful.spawn.with_shell('xrandr --output HDMI-A-0 --brightness 1') end,
              {description = 'dmenu script to surf the web', group = 'dmenu'}),


    awful.key({ modkey,           }, 'l',     function () awful.tag.incmwfact( 0.05)          end,
              {description = 'increase master width factor', group = 'layout'}),
    awful.key({ modkey,           }, 'h',     function () awful.tag.incmwfact(-0.05)          end,
              {description = 'decrease master width factor', group = 'layout'}),
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


   -- =========================================
   -- CLIENT RESIZING
   -- =========================================

    awful.key({modkey, 'Control'}, 'Down',    function(c) resize_client(client.focus, 'down') end),

    awful.key({modkey, 'Control'}, 'Up',      function(c) resize_client(client.focus, 'up') end),

    awful.key({modkey, 'Control'}, 'Left',    function(c) resize_client(client.focus, 'left') end),

    awful.key({modkey, 'Control'}, 'Right',   function(c) resize_client(client.focus, 'right') end),

    awful.key({modkey, 'Control'}, 'j',       function(c) resize_client(client.focus, 'down') end),

    awful.key({ modkey, 'Control' }, 'k',     function(c) resize_client(client.focus, 'up') end),

    awful.key({modkey, 'Control'}, 'h',       function(c) resize_client(client.focus, 'left') end),

    awful.key({modkey, 'Control'}, 'l',       function(c) resize_client(client.focus, 'right') end)
    )

clientkeys = gears.table.join(
    awful.key({ modkey, 'Shift'   }, 'c',      function (c) c:kill()                         end,
              {description = 'close', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'space',  awful.client.floating.toggle                     ,
              {description = 'toggle floating', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'Return', function (c) c:swap(awful.client.getmaster()) end,
              {description = 'move to master', group = 'client'})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, '#' .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = 'view tag #'..i, group = 'tag'}),
        -- Toggle tag display.
        awful.key({ modkey, 'Control' }, '#' .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = 'toggle tag #' .. i, group = 'tag'}),
        -- Move client to tag.
        awful.key({ modkey, 'Shift' }, '#' .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = 'move focused client to tag #'..i, group = 'tag'}),
        -- Toggle tag on focused client.
        awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = 'toggle focused client on tag #' .. i, group = 'tag'})
    )
end

-- ================= Tags are clickable ===========================
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal('request::activate', 'mouse_click', {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal('request::activate', 'mouse_click', {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal('request::activate', 'mouse_click', {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- ==================== Set keys ====================================
root.keys(globalkeys)

return keys
