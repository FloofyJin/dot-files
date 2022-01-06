--awful 		= require('awful')
--beautiful 	= require('beautiful')
--gears 		= require('gears')
--HOME 		= os.getenv 'HOME'
--wibox 		= require('wibox')
--naughty 	= require('naughty')
--icons		= require('theme.icons')
--hotkeys_popup	= require("awful.hotkeys_popup")
--menubar 	= require("menubar")
gears = require("gears")
awful = require("awful")
wibox = require("wibox")
beautiful = require("beautiful")
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup")

HOME 		= os.getenv 'HOME'

modkey = "Mod4"

terminal = "alacritty"
editor_cmd = terminal .. ' -e ' .. (os.getenv('EDITOR') or 'vim')
