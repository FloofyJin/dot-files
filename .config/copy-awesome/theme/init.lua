
local theme = {}
theme.default_dir		= require("awful.util").get_themes_dir() .. "default"
theme.dir				= os.getenv("HOME") .. "/.config/awesome/theme"
theme.wallpaper			= theme.dir .. "/wallpapers/1.png"
theme.useless_gap		= 5
theme.layout_floating	= theme.default_dir .. "/layouts/floatingw.png"
theme.layout_tile		= theme.default_dir .. "/layouts/tilew.png"
theme.title_font		= "SF Pro Display Medium 10"

return theme
