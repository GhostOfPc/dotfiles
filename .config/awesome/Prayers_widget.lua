local json          =   require('json')
local watch         =   require('awful.widget.watch')
local awful         =   require('awful')
local wibox         =   require('wibox')
local beautiful     =   require('beautiful')
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi
local gears         =   require('gears')
local naughty       =   require('naughty')
local config_dir    =   gears.filesystem.get_configuration_dir()

local GET_TIMES_CMD = [[bash -c "curl -s '%s'"]]

local Prayers_widget = {}

Prayer_icon = wibox.widget { -- For decoration only
        {
            forced_height   =   200,
            forced_width    =   200,
            resize          =   true,
            opacity         =   0.9,
            widget          =   wibox.widget.imagebox
        },
        align   =   'center',
        widget  =   wibox.container.place
}

Prayers_widget = wibox.widget {
        font    =   'Noto Kufi Arabic 8', -- the Kufi font looks incredible for Salawat
        widget  =   wibox.widget.textbox
}

--Arguments
local GeoLoc    =   'By_Cor' -- Choose either By_Cor for cooridnation based or By_City for city name based
local today     =   os.time() -- Date should by in the UNIX format
-- The more accurate coordinates the more accurate prayer times
local lat       =   '-41.124877'
local long      =   '-71.365303'
local city      =   'Bariloche'
local country   =   'Argentina'
local method    =   '2' -- method 2 for Americas
local adjustment=   '1' -- To adjust the hijri date
local timeout   =   60 -- 1 min is good enough to change the backgrouond of the current prayer
local TZ_adj    =   -10800 -- For Argentina the timezone is GMT-3 (3*3600=10800)
local bgcolor   =   '#7e8d50'

if GeoLoc == 'By_City' then
    Api = ('http://api.aladhan.com/v1/timingsByCity?city=' .. city .. '&country=' .. country .. '&method=' .. method .. '&adjustment=' .. adjustment)
else
    Api = ('http://api.aladhan.com/v1/timings/' .. today .. '?latitude=' .. lat .. '&longitude=' .. long .. '&method=' .. method .. '&adjustment=' .. adjustment)
end

local function update_widget(widget,stdout)


    Current_time    =   os.date('%H:%M')
    Result          =   json.decode(stdout)
    Fajr            =   Result.data.timings.Fajr
    Shuruq          =   Result.data.timings.Sunrise
    Duhur           =   Result.data.timings.Dhuhr
    Asr             =   Result.data.timings.Asr
    Maghrib         =   Result.data.timings.Maghrib
    Isha            =   Result.data.timings.Isha

    function HourPart(hourMinute)
        H_s = hourMinute:gsub(':%d%d','')
        H_p = tonumber(H_s)
        return H_p
    end

    function MinPart(hourMinute)
        M_s = hourMinute:gsub('%d%d:','')
        M_p = tonumber(M_s)
        return M_p
    end

    function Diff(next)
        str = os.date('%a, %d %b %Y ') .. HourPart(next) .. ':' .. MinPart(next)
        p="%a+, (%d+) (%a+) (%d+) (%d+):(%d+)"
        day,month,year,hour,min,sec=str:match(p)
        MON={Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}
        month=MON[month]
        offset=os.time()+TZ_adj
        Seconds = os.time({day=day,month=month,year=year,hour=hour,min=min})-offset
        Total = os.date('%H:%M',Seconds)
        return Total
    end

    Prayer_names = {'الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'}

    function Notification (name)
        naughty.notify(
        {
            timeout     =   30,
            font        =   'Noto Kufi Arabic 8',
            icon        =   config_dir .. '/icons/prayers/mosque_flat.svg',
            icon_size   =   dpi(48),
            text        =   'حان الآن موعد صلاة <span fgcolor="' .. bgcolor .. '"><b>' .. name .. '</b></span> حسب التوقيت المحلي لمدينة باريلوتشي'
        }
        )
        awful.spawn.with_shell('mpv $HOME/.local/share/Azan.webm')
    end

    Fajr_text       = '۞ '   .. Prayer_names[1] .. '\t\t\t' .. Fajr    .. ' ۞ '
    Shuruq_text     = '\n۞ ' .. Prayer_names[2] .. '\t\t\t' .. Shuruq  .. ' ۞ '
    Duhur_text      = '\n۞ ' .. Prayer_names[3] .. '\t\t\t' .. Duhur   .. ' ۞ '
    Asr_text        = '\n۞ ' .. Prayer_names[4] .. '\t\t\t' .. Asr     .. ' ۞ '
    Maghrib_text    = '\n۞ ' .. Prayer_names[5] .. '\t\t\t' .. Maghrib .. ' ۞ '
    Isha_text       = '\n۞ ' .. Prayer_names[6] .. '\t\t\t' .. Isha    .. ' ۞ '

    if Current_time >= Fajr and Current_time < Shuruq then
        if Current_time == Fajr then
            Notification(Prayer_names[1])
        end
        Remain = Diff(Duhur)
        Fajr_text = '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">۞ ' .. Prayer_names[1] .. '\t\t\t' .. Fajr .. ' ۞ </span>'
    elseif Current_time >= Shuruq and Current_time < Duhur then
        Remain = Diff(Duhur)
        Shuruq_text = '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n۞ ' .. Prayer_names[2] .. '\t\t\t' .. Shuruq .. ' ۞ </span>'
    elseif Current_time >= Duhur and Current_time < Asr then
        if Current_time == Duhur then
            Notification(Prayer_names[3])
        end
        Remain = Diff(Asr)
        Duhur_text = '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n۞ ' .. Prayer_names[3] .. '\t\t\t' .. Duhur .. ' ۞ </span>'
    elseif Current_time >= Asr and Current_time < Maghrib then
        if Current_time == Asr then
            Notification(Prayer_names[4])
        end
        Remain = Diff(Maghrib)
        Asr_text = '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n۞ ' .. Prayer_names[4] .. '\t\t\t' .. Asr .. ' ۞ </span>'
    elseif Current_time >= Maghrib and Current_time < Isha then
        if Current_time == Maghrib then
            Notification(Prayer_names[5])
        end
        Remain = Diff(Isha)
        Maghrib_text = '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n۞ ' .. Prayer_names[5] .. '\t\t\t' .. Maghrib .. ' ۞ </span>'
    else
        if Current_time == Isha then
            Notification(Prayer_names[6])
        end
        Remain = Diff(Fajr)
        Isha_text = '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n۞ ' .. Prayer_names[6] .. '\t\t\t' .. Isha .. ' ۞ </span>'
    end

    ArabicDay = Result.data.date.hijri.weekday.ar
    ArabicDayNum = Result.data.date.hijri.day
    HijriMonth = Result.data.date.hijri.month.ar
    HijriYear = Result.data.date.hijri.year
    HijriDate = ArabicDayNum .. ' ' .. HijriMonth .. ' ' .. HijriYear .. ' هجرية\n'
    Heading = 'مواقيت الصلاة ليوم ' .. ArabicDay .. '\n' .. HijriDate

    widget:set_markup(
    Heading ..
    'الوقت المتبقي:\t\t<span bgcolor="' .. bgcolor .. '" bgalpha="68%">' .. Remain .. '</span>' .. '\n' ..
    Fajr_text ..
    Shuruq_text ..
    Duhur_text ..
    Asr_text ..
    Maghrib_text ..
    Isha_text
    )
end

--local function update_image(self,widget)
local function update_image(self)
    if Current_time >= Fajr and Current_time < Shuruq then
        Image = config_dir .. '/icons/prayers/praying_fajr.svg'
    elseif Current_time >= Shuruq and Current_time < Duhur then
        Image = config_dir .. '/icons/prayers/praying.svg'
    elseif Current_time >= Duhur and Current_time < Asr then
        Image = config_dir .. '/icons/prayers/praying_duhur.svg'
    elseif Current_time >= Asr and Current_time < Maghrib then
        Image = config_dir .. '/icons/prayers/praying_asr.svg'
    elseif Current_time >= Maghrib and Current_time < Isha then
        Image = config_dir .. '/icons/prayers/praying_maghrib.svg'
    else
        Image = config_dir .. '/icons/prayers/praying_isha.svg'
    end
    self.widget:set_image(Image)
end

Pryr_wdt = wibox.widget {
    font = 'Noto Kufi Arabic 8',
    widget = wibox.widget.textbox
}

local function update_remain_time(widget)

    if Current_time >= Fajr and Current_time < Shuruq then
        Remain = Diff(Duhur)
        Next_prayer = Duhur
        Next_prayer_str = Prayer_names[3]
    elseif Current_time >= Shuruq and Current_time < Duhur then
        Remain = Diff(Duhur)
        Next_prayer = Duhur
        Next_prayer_str = Prayer_names[3]
    elseif Current_time >= Duhur and Current_time < Asr then
        Remain = Diff(Asr)
        Next_prayer = Asr
        Next_prayer_str = Prayer_names[4]
    elseif Current_time >= Asr and Current_time < Maghrib then
        Remain = Diff(Maghrib)
        Next_prayer = Maghrib
        Next_prayer_str = Prayer_names[5]
    elseif Current_time >= Maghrib and Current_time < Isha then
        Remain = Diff(Isha)
        Next_prayer = Isha
        Next_prayer_str = Prayer_names[6]
    else
        Remain = Diff(Fajr)
        Next_prayer = Fajr
        Next_prayer_str = Prayer_names[1]
    end

    widget:set_text('🕌 الصلاة القادمة: ۩ ' .. Next_prayer_str .. ' ۩  ' .. Next_prayer .. ' (الوقت المتبقي ' .. Remain .. ')')
end

CAT_CMD = [[bash -c 'cat $HOME/.local/share/prayers.json']]
watch(CAT_CMD, timeout, update_widget, Prayers_widget)
watch(CAT_CMD, timeout, update_image, Prayer_icon)
watch(CAT_CMD, timeout, update_remain_time, Pryr_wdt)

--watch(string.format(GET_TIMES_CMD,Api), timeout, update_widget, Prayers_widget)
--watch(string.format(GET_TIMES_CMD,Api), timeout, update_image, Prayer_icon)

awful.screen.connect_for_each_screen(function(s)
    s.Prayers_widget = awful.wibar(
    {
        screen  =   'primary' ,
        height  =   awful.screen.focused().workarea.height * 0.333,
        width   =   awful.screen.focused().workarea.width * 0.12,
        shape   =   wdt_shape,
        bg      =   beautiful.bottom_bar_bg,
    }
    )

    s.Prayers_widget:setup {
            {
                {
                    id  =   'icon',
                    layout = wibox.layout.flex.vertical,
                    Prayer_icon
                },
                {
                    {
                        {
                            id  =   'times',
                            layout = wibox.layout.flex.horizontal,
                            Prayers_widget
                        },
                        widget  =   wibox.container.margin(_,_,6,_,_,_,_)
                    },
                    bg  =   wdt_bg,
                    shape   =   wdt_shape,
                    widget  =   wibox.container.background,
                },
                layout  =   wibox.layout.fixed.vertical,
                spacing =   5,
            },
            widget  =   wibox.container.margin(_,10,10,15,5,_,_)
    }

end)

return Prayers_widget
