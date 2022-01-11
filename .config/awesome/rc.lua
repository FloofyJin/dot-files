pcall(require, "luarocks.loader")
require('configuration.global_variables')
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
beautiful.init(require('theme'))

--------------------------------------------------
require("signals.error")
--------------------------------------------------
require("layout")
--------------------------------------------------
require("configuration.keys")
--------------------------------------------------
require("configuration.rules")
--------------------------------------------------
require("signals.client")
--------------------------------------------------

--local view = require("layout")
--view.initialize()

--[[
screen.connect_signal(
    'request::wallpaper',
    function(s)
        -- If wallpaper is a function, call it with the screen
        if beautiful.wallpaper then
            if type(beautiful.wallpaper) == 'string' then
                -- Check if beautiful.wallpaper is color/image
                if beautiful.wallpaper:sub(1, #'#') == '#' then
                    -- If beautiful.wallpaper is color
                    gears.wallpaper.set(beautiful.wallpaper)
                elseif beautiful.wallpaper:sub(1, #'/') == '/' then
                    -- If beautiful.wallpaper is path/image
                    gears.wallpaper.maximized(beautiful.wallpaper, s)
                end
            else
                beautiful.wallpaper(s)
            end
        end
    end
)--]]
