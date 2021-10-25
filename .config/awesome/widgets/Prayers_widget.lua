local json          =   require('json')
local awful         =   require('awful')
local beautiful     =   require('beautiful')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/prayers/'
local naughty       =   require('naughty')
local watch         =   require('awful.widget.watch')
local wibox         =   require('wibox')
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi

local GET_TIMES_CMD = "curl -s '%s'"
screen_height = awful.screen.focused().geometry.height
screen_width = awful.screen.focused().geometry.width

local Prayers_widget = {}

Pryr_wdt = wibox.widget {
    {
        {
            id      =   'mini_widget',
            widget  =   wibox.widget.textbox
        },
        valign = 'center',
        widget = wibox.container.place,
    },
    {
        {
            {
                id = 'mini_icon',
                image = icons_dir .. 'mosque.svg',
                forced_width = screen_width * 0.01,
                forced_height = screen_width * 0.01,
                resize = true,
                widget = wibox.widget.imagebox
            },
            top = screen_width * 0.0005,
            bottom = screen_width * 0.0005,
            widget = wibox.container.margin
        },
        halign = 'center',
        valign = 'center',
        widget = wibox.container.place
    },
    spacing = screen_width * 0.003,
    layout = wibox.layout.fixed.horizontal
}

--Arguments
local GeoLoc    =   'By_Cor' -- Choose either By_Cor for cooridnation based or By_City for city name based
local today     =   os.time() -- Date should be in the UNIX timestamp format
-- The more accurate coordinates the more accurate prayer times
local lat       =   '-41.124877'
local long      =   '-71.365303'
local city      =   'Bariloche'
local country   =   'Argentina'
local method    =   '2' -- method 2 for Americas
local adjustment=   '1' -- To adjust the hijri date
local timeout   =   60 -- 1 min is good enough to change the backgrouond of the current prayer
local TZ_adj    =   os.time()-os.time(os.date('!*t'))
local bgcolor   =   beautiful.fg_occupied .. 'a9'
local icons_ext =   '.png'

if GeoLoc == 'By_City' then
    Api = ('http://api.aladhan.com/v1/timingsByCity?city=' .. city .. '&country=' .. country .. '&method=' .. method .. '&adjustment=' .. adjustment)
else
    Api = ('http://api.aladhan.com/v1/timings/' .. today .. '?latitude=' .. lat .. '&longitude=' .. long .. '&method=' .. method .. '&adjustment=' .. adjustment)
end

Prayer_id = {'Fajr_widget', 'Shuruq_widget', 'Duhur_widget', 'Asr_widget', 'Maghrib_widget', 'Isha_widget'}
Prayer_bg_id = {'Fajr_widget_bg', 'Shuruq_widget_bg', 'Duhur_widget_bg', 'Asr_widget_bg', 'Maghrib_widget_bg', 'Isha_widget_bg'}
Prayer_names = {'الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'}

local function update_widget(widget,stdout)
    Current_time    =   os.date('%H:%M')
    Result          =   json.decode(stdout)
    Fajr            =   Result.data.timings.Fajr
    Shuruq          =   Result.data.timings.Sunrise
    Duhur           =   Result.data.timings.Dhuhr
    Asr             =   Result.data.timings.Asr
    Maghrib         =   Result.data.timings.Maghrib
    Isha            =   Result.data.timings.Isha

    function Prayer_utc(P_h_m)
        str                         =   os.date('%a %d %b %Y ') .. P_h_m .. ':' .. os.date('%S')
        p                           =   "%a+ (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)"
        Day,Month,Year,Hour,Min,Sec =   str:match(p)
        MON                         =   {Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}
        Month                       =   MON[Month]
        Seconds                     =   os.time({day=Day,month=Month,year=Year,hour=Hour,min=Min,sec=Sec}) - os.time() - TZ_adj
        return Seconds
    end

    function Diff(next_p)
        In_sec  =   Prayer_utc(next_p)
        Total   =   os.date('%H:%M',In_sec)
        return Total
    end


    function Notification (name)
        naughty.notify(
        {
            timeout     =   30,
            font        =   'Geeza Pro 11',
            icon        =   icons_dir .. 'mosque.svg',
            icon_size   =   dpi(48),
            text        =   'حان الآن موعد صلاة <span fgcolor="' .. bgcolor .. '"><b>' .. name .. '</b></span> حسب التوقيت المحلي لمدينة باريلوتشي',
            position    =   'top_middle',
        }
        )
        if name == Prayer_names[1] then
            awful.spawn.with_shell('mpv --volume=70 $HOME/.local/share/Azan_fajr.webm')
        else
            awful.spawn.with_shell('mpv --volume=70 $HOME/.local/share/Azan.webm')
        end
    end

    Fajr_text       = ' ۞ ' .. Prayer_names[1] .. '\t\t\t' .. Fajr    .. ' ۞ '
    Shuruq_text     = ' ۞ ' .. Prayer_names[2] .. '\t\t'   .. Shuruq  .. ' ۞ '
    Duhur_text      = ' ۞ ' .. Prayer_names[3] .. '\t\t\t' .. Duhur   .. ' ۞ '
    Asr_text        = ' ۞ ' .. Prayer_names[4] .. '\t\t\t' .. Asr     .. ' ۞ '
    Maghrib_text    = ' ۞ ' .. Prayer_names[5] .. '\t\t\t' .. Maghrib .. ' ۞ '
    Isha_text       = ' ۞ ' .. Prayer_names[6] .. '\t\t\t' .. Isha    .. ' ۞ '

    widget:get_children_by_id(Prayer_bg_id[1])[1]:set_bg(beautiful.bg_empty)
    widget:get_children_by_id(Prayer_bg_id[2])[1]:set_bg(beautiful.bg_empty)
    widget:get_children_by_id(Prayer_bg_id[3])[1]:set_bg(beautiful.bg_empty)
    widget:get_children_by_id(Prayer_bg_id[4])[1]:set_bg(beautiful.bg_empty)
    widget:get_children_by_id(Prayer_bg_id[5])[1]:set_bg(beautiful.bg_empty)
    widget:get_children_by_id(Prayer_bg_id[6])[1]:set_bg(beautiful.bg_empty)

    if Current_time >= Fajr and Current_time < Shuruq then
        if Current_time == Fajr then
            Notification(Prayer_names[1])
        end
        widget:get_children_by_id(Prayer_bg_id[1])[1]:set_bg(bgcolor)
        Remain          =   Diff(Duhur)
        Image           =   icons_dir .. 'praying_fajr' .. icons_ext
        Remain          =   Diff(Duhur)
        Next_prayer     =   Duhur
        Next_prayer_str =   Prayer_names[3]
    elseif Current_time >= Shuruq and Current_time < Duhur then
        if Current_time == Shuruq then
            awful.spawn.with_shell('mpv $HOME/.local/share/Nature.mp3')
        end
        widget:get_children_by_id(Prayer_bg_id[2])[1]:set_bg(bgcolor)
        Remain          =   Diff(Duhur)
        Image           =   icons_dir .. 'praying' .. icons_ext
        Remain          =   Diff(Duhur)
        Next_prayer     =   Duhur
        Next_prayer_str =   Prayer_names[3]
    elseif Current_time >= Duhur and Current_time < Asr then
        if Current_time == Duhur then
            Notification(Prayer_names[3])
        end
        widget:get_children_by_id(Prayer_bg_id[3])[1]:set_bg(bgcolor)
        Remain          =   Diff(Asr)
        Image           =   icons_dir .. 'praying_duhur' .. icons_ext
        Remain          =   Diff(Asr)
        Next_prayer     =   Asr
        Next_prayer_str =   Prayer_names[4]
    elseif Current_time >= Asr and Current_time < Maghrib then
        if Current_time == Asr then
            Notification(Prayer_names[4])
        end
        widget:get_children_by_id(Prayer_bg_id[4])[1]:set_bg(bgcolor)
        Remain          =   Diff(Maghrib)
        Image           =   icons_dir .. 'praying_asr' .. icons_ext
        Remain          =   Diff(Maghrib)
        Next_prayer     =   Maghrib
        Next_prayer_str =   Prayer_names[5]
    elseif Current_time >= Maghrib and Current_time < Isha then
        if Current_time == Maghrib then
            Notification(Prayer_names[5])
        end
        widget:get_children_by_id(Prayer_bg_id[5])[1]:set_bg(bgcolor)
        Remain          =   Diff(Isha)
        Image           =   icons_dir .. 'praying_maghrib' .. icons_ext
        Remain          =   Diff(Isha)
        Next_prayer     =   Isha
        Next_prayer_str =   Prayer_names[6]
    else
        if Current_time == Isha then
            Notification(Prayer_names[6])
        end
        widget:get_children_by_id(Prayer_bg_id[6])[1]:set_bg(bgcolor)
        Remain          =   Diff(Fajr)
        Image           =   icons_dir .. 'praying_isha' .. icons_ext
        Remain          =   Diff(Fajr)
        Next_prayer     =   Fajr
        Next_prayer_str =   Prayer_names[1]
    end

    ArabicDay       =   Result.data.date.hijri.weekday.ar
    ArabicDayNum    =   Result.data.date.hijri.day
    HijriMonth      =   Result.data.date.hijri.month.ar
    HijriYear       =   Result.data.date.hijri.year
    HijriDate       =   ArabicDayNum .. ' ' .. HijriMonth .. ' ' .. HijriYear .. ' هجرية\n'
    Heading         =   'مواقيت الصلاة ليوم ' .. ArabicDay .. '\n' .. HijriDate

    widget:get_children_by_id('Heading_widget')[1]:set_markup(Heading ..
    'الوقت المتبقي:\t\t<span fgcolor="' .. beautiful.fg_occupied .. '">'.. Remain .. '</span> ۞ ')
    widget:get_children_by_id(Prayer_id[1])[1]:set_markup(Fajr_text)
    widget:get_children_by_id(Prayer_id[2])[1]:set_markup(Shuruq_text)
    widget:get_children_by_id(Prayer_id[3])[1]:set_markup(Duhur_text)
    widget:get_children_by_id(Prayer_id[4])[1]:set_markup(Asr_text)
    widget:get_children_by_id(Prayer_id[5])[1]:set_markup(Maghrib_text)
    widget:get_children_by_id(Prayer_id[6])[1]:set_markup(Isha_text)
    widget:get_children_by_id('icon')[1]:set_image(Image)
    Pryr_wdt:get_children_by_id('mini_widget')[1]:set_markup('الصلاة القادمة: <span fgcolor="' .. beautiful.color2 .. '">' .. Next_prayer_str
    .. ' ' .. Next_prayer  .. '</span> ' .. ' (الوقت المتبقي <span fgcolor="' .. beautiful.color2 .. '">' .. Remain .. '</span>)')
end

Prayers_widget = wibox.widget {
    {
        {
            id              =   'icon',
            forced_height   =   screen_width * 0.045,
            forced_width    =   screen_width * 0.045,
            resize          =   true,
            opacity         =   0.9,
            widget          =   wibox.widget.imagebox
        },
        halign   =   'center',
        valign   =   'center',
        widget  =   wibox.container.place
    },
    
    -- Heading
    {
        {
            {
                id      =   'Heading_widget',
                font    =   'Noto Kufi Arabic 9',
                widget  =   wibox.widget.textbox
            },
            right = screen_width * 0.0015,
            left = screen_width * 0.0015,
            widget = wibox.container.margin
        },
        bg = beautiful.bg_empty,
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    
    { -- Fajr
        {
            id      =   Prayer_id[1],
            font    =   'Noto Kufi Arabic 9',
            widget  =   wibox.widget.textbox
        },
        id      =   Prayer_bg_id[1],
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    
    { -- Shuruq
        {
            id      =   Prayer_id[2],
            font    =   'Noto Kufi Arabic 9',
            widget  =   wibox.widget.textbox
        },
        id      =   Prayer_bg_id[2],
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    
    { -- Dhuhr
        {
            id      =   Prayer_id[3],
            font    =   'Noto Kufi Arabic 9',
            widget  =   wibox.widget.textbox
        },
        id = Prayer_bg_id[3],
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    
    { -- Asr
        {
            id      =   Prayer_id[4],
            font    =   'Noto Kufi Arabic 9',
            widget  =   wibox.widget.textbox
        },
        id      =   Prayer_bg_id[4],
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    
    { -- Maghrib
        {
            id      =   Prayer_id[5],
            font    =   'Noto Kufi Arabic 9',
            widget  =   wibox.widget.textbox
        },
        id      =   Prayer_bg_id[5],
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    
    { -- Isha
        {
            id      =   Prayer_id[6],
            font    =   'Noto Kufi Arabic 9',
            widget  =   wibox.widget.textbox
        },
        id      =   Prayer_bg_id[6],
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    spacing = screen_height * 0.002,
    layout = wibox.layout.fixed.vertical,
}

CAT_CMD = [[bash -c 'cat $HOME/.local/share/prayers.json']]
watch(CAT_CMD, timeout, update_widget, Prayers_widget)

awful.screen.connect_for_each_screen(function(s)
    s.Prayers_widget = awful.wibar(
    {
        screen  =   s,
        height  =   screen_height * 0.257,
        width   =   screen_width * 0.078,
        bg      =   '#0000',
        shape   =   bar_wdt_shape
    }
    )

    s.Prayers_widget:setup {
        {
            {
                layout  =   wibox.layout.fixed.horizontal,
                Prayers_widget
            },
            halign = 'center',
            widget = wibox.container.place
        },
        widget = wibox.container.background,
        shape = big_wdt_shape,
        bg = beautiful.bg_normal
    }

end)

return Prayers_widget
