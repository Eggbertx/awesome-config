local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local util = require("util")
-- local batterybar = awful.widget.progressbar()

local battery_text = wibox.widget {
	markup = "",
	align = "center",
	widget = wibox.widget.textbox
}

local battery_progress = wibox.widget {
	max_value = 1,
	value = 1,
	forced_width = 60,
	color = "#535d6c",
	background_color = "#535d6c",
	border_color = "#000000",
	border_width = 2,
	widget = wibox.widget.progressbar
}

local batterybar = wibox.widget {
	battery_progress, battery_text,
	layout = wibox.layout.stack
}

-- batterybar:set_border_color("#000000")
-- batterybar:set_background_color("#222222")
-- batterybar:set_color("#535d6c")
-- batterybar:set_width(50)
-- batterybar.shape = gears.shape.rounded_bar


battery_timer = timer({ timeout = 3 })
battery_timer:connect_signal("timeout",
	function()
		f = io.popen('acpi -b', r)
		state, percent = string.match(f:read(), 'Battery %d: (%w+), (%d+)%%')
		f:close()
		battery_text.markup = "<span color=\"#000000\">" .. percent .. "%</span>"
		percent = tonumber(percent)/100
		if state == 'Discharging' then
			battery_progress.color = '#CCCC00'
			if percent < 0.2 then
				battery_progress.color = "#ff0000"
				util.messageBox("error", "Low Battery!", "Plugin or shut down to avoid data loss/corruption")
			end
		elseif state == 'Charging' then
			battery_progress.color = '#66CC00'
		else
			-- batterybar:set_color("#535d6c")
		end
		battery_progress.value = percent
	end
)

battery_timer:start()
battery_timer:emit_signal("timeout")

return batterybar