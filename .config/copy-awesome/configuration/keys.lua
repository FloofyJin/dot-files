local awful = require('awful')
local gears = require('gears')

root.buttons(gears.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = gears.table.join(
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
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
	--awful.key({ modkey, "Control" }, "space", function()
		--if awful.layout.suit
		--{description = "toggle floating", group = "client"}),		
    
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
)



-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)
