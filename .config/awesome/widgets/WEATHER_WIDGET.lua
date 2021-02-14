local json          =   require('json')
local watch         =   require('awful.widget.watch')
local awful         =   require('awful')
local wibox         =   require('wibox')
local beautiful     =   require('beautiful')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/weather/Dual_tone/'


local WEATHER_WIDGET = {}

local GET_WTHR_CMD  =   [[bash -c 'curl -s "%s"']]
local city_id       =   '7647007'
local api_key       =   '8cc75d17134e5ae1a723b5a39e7b6850'
local untis         =   'metric'
local lang          =   'es'
local timeout       =   600
local icons_ext     =   '.svg'
local API           =   'api.openweathermap.org/data/2.5/weather?appid=' .. api_key
                        .. '&id='       ..  city_id
                        .. '&units='    ..  untis
                        .. '&lang='     ..  lang
local screen_width = awful.screen.focused().workarea.width
local screen_height = awful.screen.focused().workarea.height

local icon_map = {
    ['01d'] = '01d',
    ['01n'] = '01n',
    ['02d'] = '02d',
    ['02n'] = '02n',
    ['03d'] = '03d',
    ['03n'] = '03n',
    ['04d'] = '04d',
    ['04n'] = '04n',
    ['09d'] = '09d',
    ['09n'] = '09n',
    ['10d'] = '10d',
    ['11d'] = '11d',
    ['11n'] = '11n',
    ['13d'] = '13d',
    ['13n'] = '13n',
    ['50d'] = '50d',
    ['50n'] = '50n',
}

WEATHER_WIDGET_DESC = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    {
        {
            {
                id = 'icon',
                resize = true,
                widget = wibox.widget.imagebox
            },
            margins = screen_width * 0.002,
            widget = wibox.container.margin
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        id = 'desc',
        widget = wibox.widget.textbox
    },
    {
        id = 'deg',
        widget = wibox.widget.textbox
    },
}

WEATHER_WIDGET_BIG = wibox.widget {
    {
        {
            {
                {
                    id = 'icon',
                    forced_width = screen_width * 0.08,
                    forced_height = screen_width * 0.08,
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                margins = screen_width * 0.0039,
                widget = wibox.container.margin
            },
            shape = wdt_shape,
            bg = wdt_bg,
            widget = wibox.container.background
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        {
            id = 'desc',
            font = 'SF Pro Display Regular 18',
            widget = wibox.widget.textbox
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        {
            id = 'Temperatures',
            font = 'SF Pro Display Bold 12',
            widget = wibox.widget.textbox
        },
        align = 'center',
        widget = wibox.container.place
    },
    spacing = screen_height * 0.001,
    layout = wibox.layout.fixed.vertical
}

local function update_widget(widget,stdout)
    Result  =   json.decode(stdout)
    Desc    =   Result.weather[1].description
    Icon    =   Result.weather[1].icon
    Deg_now     =   Result.main.temp
    Deg_min     =   Result.main.temp_min
    Deg_max     =   Result.main.temp_max
    Deg     =   math.floor(Deg_now)
    Min     =   math.floor(Deg_min)
    Max     =   math.floor(Deg_max)
    widget:get_children_by_id('desc')[1]:set_markup(Desc)
    if Deg <= 10 then
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="#9ac8eb"> ' .. Deg .. ' °C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="#6c99ba"> Min: ' .. Min .. ' °C\t</span>' .. '<span fgcolor="#9ac8eb"> ' .. Deg .. ' °C' .. '</span>' .. '<span font="8" fgcolor="#ac4142"> \tMax: ' .. Max .. ' °C</span>')
    elseif Deg > 10 and Deg <= 24 then
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="#e5b566"> ' .. Deg .. ' °C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="#6c99ba"> Min: ' .. Min .. ' °C\t</span>' .. '<span fgcolor="#e5b566"> ' .. Deg .. ' °C' .. '</span>' .. '<span font="8" fgcolor="#ac4142"> \tMax: ' .. Max .. ' °C</span>')
    else
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="#dc828f"> ' .. Deg .. ' °C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="#6c99ba"> Min: ' .. Min .. ' °C\t</span>' .. '<span fgcolor="#dc828f"> ' .. Deg .. ' °C' .. '</span>' .. '<span font="8" fgcolor="#ac4142"> \tMax: ' .. Max .. ' °C</span>')
end
    widget:get_children_by_id('icon')[1]:set_image(icons_dir .. icon_map[Icon] .. icons_ext)
    WEATHER_WIDGET_BIG:get_children_by_id('icon')[1]:set_image(icons_dir .. icon_map[Icon] .. icons_ext)

end

awful.screen.connect_for_each_screen(function(s)
    s.WEATHER_WIDGET = awful.wibar(
    {
        screen = 'primary',
        position = 'left',
        width = screen_width * 0.13,
        height = screen_width * 0.13,
        shape = wdt_shape,
        bg = beautiful.bottom_bar_bg
    }
    )

    s.WEATHER_WIDGET:setup{
        WEATHER_WIDGET_BIG,
        margins = screen_height * 0.007,
        widget = wibox.container.margin
    }
end)

watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_DESC)
watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_BIG)

return WEATHER_WIDGET
