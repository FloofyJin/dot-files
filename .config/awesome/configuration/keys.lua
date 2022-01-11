local awful = require('awful')
local gears = require('gears')

awful.mouse.append_global_mousebindings({
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
})

awful.keyboard.append_global_keybindings({
	--basic
	awful.key({ modkey,           }, "h",      hotkeys_popup.show_help,
    	{description="show help", group="awesome"}),
	awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
    	{description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Control" }, "r", awesome.restart,
    	{description = "reload awesome", group = "awesome"}),	
	awful.key({ modkey }, "d", function()
        --os.execute(string.format("rofi -show %s -theme %s", 'run', 'dmenu'))
        os.execute(string.format("rofi -show %s -show-icons", 'run'))
        end,
        {description = "show rofi", group = "launcher"}),
	--Screenshot
	awful.key({}, "Print", function ()
		awful.util.spawn("scrot -e 'mv $f ~/Screenshots/ 2>/dev/null'", false) end),
	awful.key({ "Control" }, "Print", function()
		awful.spawn("flameshot gui") end),
	--volume
	awful.key({ }, "XF86AudioLowerVolume", function() 
		os.execute(string.format("pamixer -d 5"))
		end,
		{description = "volume decrease", group = "hotkeys"}),
	awful.key({ }, "XF86AudioRaiseVolume", function() 
		os.execute(string.format("pamixer -i 5"))
		end,
		{description = "volume increase", group = "hotkeys"}),
	awful.key({ }, "XF86AudioMute", function() 
		os.execute(string.format("pamixer -t"))
		end,
		{description = "Audio mute", group = "hotkeys"}),
	--screen brightness
	awful.key({ "Control" }, "Up", function() 
		os.execute(string.format("ddcutil setvcp 10 + 5"))
		end),
	awful.key({ "Control" }, "Down", function() 
		os.execute(string.format("ddcutil setvcp 10 - 5"))
		end)
})

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    
	awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill() end,
        {description = "close", group = "client"}),
	--move window focus via key
	awful.key({modkey}, "Left", function()
  		awful.client.focus.bydirection("left")
		end, {description = "Focus left", group = "client"}),
	awful.key({modkey}, "Right", function()
  		awful.client.focus.bydirection("right")
		end, {description = "Focus right", group = "client"}),
	awful.key({modkey}, "Down", function()
  		awful.client.focus.bydirection("down")
		end, {description = "Focus down", group = "client"}),
	awful.key({modkey}, "Up", function()
  		awful.client.focus.bydirection("up")
		end, {description = "Focus up", group = "client"})
	})
end)

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
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
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
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
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

root.keys(globalkeys)
