local dpi = require("beautiful.xresources").apply_dpi
local gears = require('gears')
local awful = require("awful")
local gfs = gears.filesystem

local theme_dir = os.getenv("HOME") .. "/.config/awesome/theme"

awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
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
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

function mybar(s)
    -- Wallpaper
    set_wallpaper(s)

	local spr = wibox.widget.textbox('  ')

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
   
    local taglist_buttons = gears.table.join(
                                awful.button({}, 1, function(t) t:view_only() end),
                                awful.button({modkey}, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end), awful.button({}, 3, awful.tag.viewtoggle),
                                awful.button({modkey}, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end), awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end), awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))
    local unfocus = gears.surface.load_uncached(theme_dir .. "/icons/unfocus_icon.png")
    local unfocus_icon = gears.color.recolor_image(unfocus, "#C2CFDB")
    local empty = gears.surface.load_uncached(theme_dir .. "/icons/unfocus_icon.png")
    local empty_icon = gears.color.recolor_image(empty, "#4C6070")
    local focus = gears.surface.load_uncached(theme_dir .. "/icons/focus_icon.png")
    local focus_icon = gears.color.recolor_image(focus, "#C2CFDB")
    local update_tags = function(self, c3)
        local tagicon = self:get_children_by_id('icon_role')[1]
        if c3.selected then
            tagicon.image = focus_icon
        elseif #c3:clients() == 0 then
            tagicon.image = empty_icon
        else
            tagicon.image = unfocus_icon
        end
    end   


    s.mytaglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
            widget_template = {
            {
                {id = 'icon_role',widget = wibox.widget.imagebox},
                id = 'margin_role',
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(2),
                right = dpi(2),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)       
            end,

            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = taglist_buttons
    }
	beautiful.systray_icon_spacing = dpi(6)
	--beautiful.bg_systray = #0000
	local systray = wibox.widget.systray()

--------------------------------------------------------------
    s.mywibox = awful.wibar({ 
	    position = "top", 
	    screen = s, 
	    height = dpi(30), 
	    bg = "#00000050", --theme.bg_normal, 
	    fg = "#BBBBBB",
    })
    s.mywibox.visible = true
    local left_item = {
	{
	    layout = wibox.layout.fixed.horizontal,
		s.mylayoutbox,
	    spr,
		s.mytaglist,
		spr,
	    s.mypromptbox,
    },
	bg = "#0000",	
    shape = gears.shape.rounded_rect,
	widget = wibox.container.background,
	--widget = wibox.container.margin({left=5})   
	}
    local center_item = {
	{
		layout = wibox.layout.fixed.horizontal,
		require("layout.widgets.calendar").create(s),
	},
	bg = "#0000",
	shape = gears.shape.rounded_rect,
	widget = wibox.container.background
    }
	local right_item = {
	{
		layout = wibox.layout.fixed.horizontal,
		--require("layout.widgets.calendar").create(s),
		--require("layout.widgets.bluetooth"),
		--systray
	},
	bg = "#0000",
	shape = gears.shape.rounded_rect,
	widget = wibox.container.background
	}

    s.mywibox:setup {
    layout = wibox.container.margin,
	top = 5,
	bottom = 5,
	left = 5,
	right = 5,
	{
	    widget = wibox.container.background,
   		bg = "0000",
	    {
	        layout = wibox.layout.align.horizontal,
	        expand = "none",
	        left_item,
	        center_item,
	        right_item
    	    }
        }
    }
end
