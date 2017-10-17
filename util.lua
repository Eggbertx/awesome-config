local naughty = require("naughty")
local util = {}

local function messageBox(msg_type,msg_title,message)
	local messageType = {}
	if msg_type == "info" then
		messageType = naughty.config.presets.info
	elseif msg_type == "warning" then
		messageType = naughty.config.presets.warn
	elseif msg_type == "error" then
		messageType = naughty.config.presets.critical
	end
	naughty.notify({ preset = naughty.config.presets.info,
		title = msg_title,
		text = tostring(message),
	})
end
util.messageBox = messageBox

local function info(msg)
	messageBox("info","Info",msg)
end
util.info = info

local function warn(msg)
	messageBox("warning","Warning",msg)
end
util.warn = warn

local function error(msg)
	messageBox("error","Error",msg)
end
util.error = error

local function forEach(arr,func)
	for i,val in pairs(arr) do
		func(val)
	end
end
util.forEach = forEach

local function getRandomElement(arr)
	math.randomseed(os.time())
	return arr[math.random(0,#arr)]
end
util.getRandomElement = getRandomElement

local function dirFiles(dir, absolute)
	local fullPath = ""
	if dir:sub(-1) ~= "/" then
		fullPath = dir .. "/"
	else
		fullPath = dir
	end
	local i,files, popen = 0, {}, io.popen
	for filename in popen('ls "' .. fullPath .. '"'):lines() do
		if absolute then
			files[i] = fullPath .. filename
		else
			files[i] = filename
		end
		i = i + 1
	end
	return files
end
util.dirFiles = dirFiles

return util