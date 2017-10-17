local awful = require("awful")
local util - require("util")
local batterybar = awful.widget.progressbar()


batterybar:set_border_color("#000000")
batterybar:set_background_color("#222222")
batterybar:set_color("#535d6c")
batterybar:set_width(50)

battery_timer = timer({ timeout = 15 })
battery_timer:connect_signal("timeout",
	function()
		f = io.popen('acpi -b', r)
		state, percent = string.match(f:read(), 'Battery %d: (%w+), (%d+)%%')
		f:close()
		percent = tonumber(percent)/100
		if state == 'Discharging' then
			batterybar:set_color('#CCCC00')
			if percent < 0.2 then
				batterybar:set_color("#ff0000")
				util.messageBox("error", "Low Battery!", "Plugin or shut down to avoid data loss/corruption")
			end
		elseif state == 'Charging' then
			batterybar:set_color('#66CC00')
		else
			batterybar:set_color("#535d6c")
		end
		batterybar:set_value(percent)
	end
)

battery_timer:start()
battery_timer:emit_signal("timeout")

return batterybar