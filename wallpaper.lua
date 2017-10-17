local gears = require("gears")
local util = require("util")
local wallpaper = {}
local wallpaperDir = os.getenv("HOME") .. "/Pictures/Wallpapers"

wp_timeout = 4
wp_timer = timer { timeout = wp_timeout}

wallpaperFile =  "/home/josh/Pictures/pillars_of_creation-wallpaper-1366x768.jpg"
local function setWallpaper()
	wallpapers = util.dirFiles(wallpaperDir,true)
	randWallpaper = util.getRandomElement(wallpapers)
	gears.wallpaper.maximized(randWallpaper, 1, true)
end
wallpaper.setWallpaper = setWallpaper

local function initRandWallpaper()
	wp_timer:connect_signal("timeout",setWallpaper)
	wp_timer:emit_signal("timeout")
end
wallpaper.initRandWallpaper = initRandWallpaper

return wallpaper