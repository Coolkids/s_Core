﻿-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["Tooltip"] = {}
local Module = DB["Modules"]["Tooltip"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["Cursor"] = true,
		["HideInCombat"] = false,
		["FontSize"] = 10,
		["HideTitles"] = true,
	}
	if not TooltipDB then TooltipDB = {} end
	for key, value in pairs(Default) do
		if TooltipDB[key] == nil then TooltipDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(TooltipDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["Tooltip"] =  {
			type = "group", order = 3,
			name = "鼠标提示",
			args = {
				Cursor = {
					type = "toggle",
					name = "提示框体跟随鼠标",
					order = 1,
					get = function() return TooltipDB.Cursor end,
					set = function(_, value) TooltipDB.Cursor = value end,
				},
				HideInCombat = {
					type = "toggle",
					name = "进入战斗自动隐藏",
					order = 2,
					get = function() return TooltipDB.HideInCombat end,
					set = function(_, value) TooltipDB.HideInCombat = value end,
				},
				FontSize = {
					type = "range", order = 3,
					name = "字体大小：", desc = "输入字体大小",
					min = 10, max = 22, step = 1,
					get = function() return TooltipDB.FontSize end,
					set = function(_, value) TooltipDB.FontSize = value end,
				},
				HideTitles = {
					type = "toggle",
					name = "隐藏头衔",
					order = 4,
					get = function() return TooltipDB.HideTitles end,
					set = function(_, value) TooltipDB.HideTitles = value end,	
				},
			},
		}
	end
end
