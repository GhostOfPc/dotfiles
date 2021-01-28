local json    =   require('json')
local watch   =   require('awful.widget.watch')
local awful   =   require('awful')
local wibox   =   require('wibox')
local beautiful =   require('beautiful')
local gears =   require('gears')
local config_dir = gears.filesystem.get_configuration_dir()

local GET_TIMES_CMD = [[bash -c "curl -s '%s'"]]

local Prayers_widget = {}

Prayer_icon = wibox.widget { -- For decoration only
        {
            forced_height    =   100,
            forced_width    =   100,
            resize = true,
            opacity = 0.9,
            widget = wibox.widget.imagebox
        },
        align   =   'center',
        widget  =   wibox.container.place
}

Prayers_widget = wibox.widget {
        font    =   'Noto Kufi Arabic 8', -- the Kufi font looks incredible for Salawat
        widget  =   wibox.widget.textbox
}

--Arguments
local GeoLoc = 'By_Cor' -- Choose either By_Cor for cooridnation based or By_City for city name based
local today = os.time(os.date('!*t')) -- Date should by in this exact format
-- The more accurate coordinates the more accurate prayer times
local lat = '-41.124877'
local long = '-71.365303'
local city = 'Bariloche'
local country = 'Argentina'
local method = '2' -- method 2 for Americas
local adjustment = '1' -- To adjust the hijri date
local timeout = 60 -- 1 min is good enough to change the backgrouond of the current prayer

if GeoLoc == 'By_City' then
    Api = ('http://api.aladhan.com/v1/timingsByCity?city=' .. city .. '&country=' .. country .. '&method=' .. method .. '&adjustment=' .. adjustment)
else
    Api = ('http://api.aladhan.com/v1/timings/' .. today .. '?latitude=' .. lat .. '&longitude=' .. long .. '&method=' .. method .. '&adjustment=' .. adjustment)
end

local function update_widget(widget,stdout)
    Current_time = os.date('%H:%M')
    Result = json.decode(stdout)
    Fajr = Result.data.timings.Fajr
    Shuruq = Result.data.timings.Sunrise
    Duhur = Result.data.timings.Dhuhr
    Asr = Result.data.timings.Asr
    Maghrib = Result.data.timings.Maghrib
    Isha = Result.data.timings.Isha

    Fajr_text = '۞ الفجر\t\t\t' .. Fajr .. ' ۞ '
    Shuruq_text = '\n۞ الشروق\t\t\t' .. Shuruq .. ' ۞ '
    Duhur_text = '\n۞ الظهر\t\t\t' .. Duhur .. ' ۞ '
    Asr_text = '\n۞ العصر\t\t\t' .. Asr .. ' ۞ '
    Maghrib_text = '\n۞ المغرب\t\t\t' .. Maghrib .. ' ۞ '
    Isha_text = '\n۞ العشاء\t\t\t' .. Isha .. ' ۞ '

    if Current_time >= Fajr and Current_time < Shuruq then
        Fajr_text = '<span bgcolor="#7e8d50" bgalpha="68%">۞ الفجر\t\t\t' .. Fajr .. ' ۞ </span>'
    elseif Current_time >= Shuruq and Current_time < Duhur then
        Shuruq_text = '<span bgcolor="#7e8d50" bgalpha="68%">\n۞ الشروق\t\t\t' .. Shuruq .. ' ۞ </span>'
    elseif Current_time >= Duhur and Current_time < Asr then
        Duhur_text = '<span bgcolor="#7e8d50" bgalpha="68%">\n۞ الظهر\t\t\t' .. Duhur .. ' ۞ </span>'
    elseif Current_time >= Asr and Current_time < Maghrib then
        Asr_text = '<span bgcolor="#7e8d50" bgalpha="68%">\n۞ العصر\t\t\t' .. Asr .. ' ۞ </span>'
    elseif Current_time >= Maghrib and Current_time < Isha then
        Maghrib_text = '<span bgcolor="#7e8d50" bgalpha="68%">\n۞ المغرب\t\t\t' .. Maghrib .. ' ۞ </span>'
    else
        Isha_text = '<span bgcolor="#7e8d50" bgalpha="68%">\n۞ العشاء\t\t\t' .. Isha .. ' ۞ </span>'
    end

    ArabicDay = Result.data.date.hijri.weekday.ar
    ArabicDayNum = Result.data.date.hijri.day
    HijriMonth = Result.data.date.hijri.month.ar
    HijriYear = Result.data.date.hijri.year
    HijriDate = ArabicDayNum .. ' ' .. HijriMonth .. ' ' .. HijriYear .. ' هجرية\n'
    Heading = 'مواقيت الصلاة ليوم ' .. ArabicDay .. '\n' .. HijriDate

    widget:set_markup(
    Heading ..
    Fajr_text ..
    Shuruq_text ..
    Duhur_text ..
    Asr_text ..
    Maghrib_text ..
    Isha_text
    )
end

local function update_image(self,widget)
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

watch(string.format(GET_TIMES_CMD,Api), timeout, update_widget, Prayers_widget)
watch(string.format(GET_TIMES_CMD,Api), timeout, update_image, Prayer_icon)

awful.screen.connect_for_each_screen(function(s)
    s.Prayers_widget = awful.wibar(
    {
        screen  =   s ,
        height  =   awful.screen.focused().workarea.height * 0.335,
        width   =   awful.screen.focused().workarea.width * 0.13,
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
