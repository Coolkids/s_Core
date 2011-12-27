﻿-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["Threat"] = {}
local Module = DB["Modules"]["Threat"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["ThreatBarWidth"] = 240,	-- 仇恨条宽度
		["NameTextL"] = 3,			-- 姓名长度(单位:字)
		["ThreatLimited"] = 3,		-- 显示仇恨人数(不包括Tank)
	}
	if not ThreatDB then ThreatDB = {} end
	for key, value in pairs(Default) do
		if ThreatDB[key] == nil then ThreatDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(ThreatDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["Threat"] =  {
			type = "group", order = 5,
			name = "仇恨监视",
			args = {
				ThreatBarWidth = {
					type = "input",
					name = "仇恨条宽度：",
					desc = "请输入仇恨条宽度",
					order = 1,
					get = function() return tostring(ThreatDB.ThreatBarWidth) end,
					set = function(_, value) ThreatDB.ThreatBarWidth = tonumber(value) end,
				},
				NameTextL = {
					type = "input",
					name = "仇恨条姓名长度：",
					desc = "请输入仇恨条姓名长度",
					order = 2,
					get = function() return tostring(ThreatDB.NameTextL) end,
					set = function(_, value) ThreatDB.NameTextL = tonumber(value) end,
				},
				ThreatLimited = {
					type = "input",
					name = "显示仇恨人数(不包括Tank)：",
					desc = "请输入显示仇恨人数(不包括Tank)",
					order = 3,
					get = function() return tostring(ThreatDB.ThreatLimited) end,
					set = function(_, value) ThreatDB.ThreatLimited = tonumber(value) end,
				},
			},
		}
	end
end

