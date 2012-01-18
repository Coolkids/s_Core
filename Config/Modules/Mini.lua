-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["Mini"] = {}
local Module = DB["Modules"]["Mini"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["AutoSell"] = true,
		["AutoRepair"] = true,
		["ChatFilter"] = true,
		["FastError"] = true,
		["Interrupt"] = true,
		["Icicle"] = false,
		["MiniMapPanels"] = true,
		["UIscale"] = false,
		["AutoUIscale"] = false,
		["LockUIscale"] = false,
		["Autoinvite"] = false,
		["INVITE_WORD"] = "SunUI",
		["uiScale"] = 0.69999998807907,
		["ClassCDOpen"] = false,
		["ClassCDDirection"] = 1,
		["ClassCDWidth"] = 140,
		["ClassCDHeight"] = 20,
		["ClassFontSize"] = 15,
		
	}
	if not MiniDB then MiniDB = {} end
	for key, value in pairs(Default) do
		if MiniDB[key] == nil then MiniDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(MiniDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["Mini"] =  {
			type = "group", order = 10,
			name = "小东西设置",
			args = {
				AutoSell = {
					type = "toggle",
					name = "启用出售垃圾",
					order = 1,
					get = function() return MiniDB.AutoSell end,
					set = function(_, value) MiniDB.AutoSell = value end,
				},
				AutoRepair = {
					type = "toggle",
					name = "启用自动修理",
					order = 2,
					get = function() return MiniDB.AutoRepair end,
					set = function(_, value) MiniDB.AutoRepair = value end,
				},
				ChatFilter = {
					type = "toggle",
					name = "启用聊天信息过滤",
					order = 3,
					get = function() return MiniDB.ChatFilter end,
					set = function(_, value) MiniDB.ChatFilter = value end,
				},
				FastError = {
					type = "toggle",
					name = "启用系统红字屏蔽",
					order = 4,
					get = function() return MiniDB.FastError end,
					set = function(_, value) MiniDB.FastError = value end,
				},
				Interrupt = {
					type = "toggle",
					name = "启用打断通报",
					order = 5,
					get = function() return MiniDB.Interrupt end,
					set = function(_, value) MiniDB.Interrupt = value end,
				},
				Icicle = {
					type = "toggle",
					name = "PVP冷却计时", desc = "开启这玩意会导致内存暴涨 请根据自己的需要选择",
					order = 6,
					get = function() return MiniDB.Icicle end,
					set = function(_, value) MiniDB.Icicle = value end,
				},
				MiniMapPanels = {
					type = "toggle",
					name = "启用团队工具", desc = "需要团长或者助理权限",
					order = 8,
					get = function() return MiniDB.MiniMapPanels end,
					set = function(_, value) MiniDB.MiniMapPanels = value end,
				},
				Autoinvite = {
					type = "toggle",
					name = "启用自动邀请",
					order = 9,
					get = function() return MiniDB.Autoinvite end,
					set = function(_, value) MiniDB.Autoinvite = value end,
				},
				INVITE_WORD = {
					type = "input",
					name = "自动邀请关键字：",
					desc = "请输入自动邀请关键字",
					order = 10,
					get = function() return tostring(MiniDB.INVITE_WORD) end,
					set = function(_, value) MiniDB.INVITE_WORD = tonumber(value) end,
				},
				NewLine = {
					type = "description", order = 11,
					name = "\n",					
				},
				UIscale = {
					type = "toggle",
					name = "启用插件UI缩放设定",
					order = 12,
					get = function() return MiniDB.UIscale end,
					set = function(_, value) MiniDB.UIscale = value end,
				},
				AutoUIscale = {
					type = "toggle",
					name = "自动设定UI缩放", desc = "需要开启插件UI缩放设定",
					order = 13,
					get = function() return MiniDB.AutoUIscale end,
					set = function(_, value) MiniDB.AutoUIscale = value end,
				},
				LockUIscale = {
					type = "toggle",
					name = "锁定UI缩放", desc = "需要开启插件UI缩放设定",
					order = 14,
					get = function() return MiniDB.LockUIscale end,
					set = function(_, value) MiniDB.LockUIscale = value end,
				},
				uiScale = {
					type = "range", order = 15,
					name = "UI缩放大小：", desc = "输入UI缩放大小",
					min = 0.40, max = 1.20, step = 0.01,
					get = function() return MiniDB.uiScale end,
					set = function(_, value) MiniDB.uiScale = value end,
				},
				NewLine = {
					type = "description", order = 16,
					name = "\n",					
				},
				ClassCDOpen = {
					type = "toggle",
					name = "启动内置CD", desc = "开启这玩意会导致内存暴涨 请根据自己的需要选择",
					order = 17,
					get = function() return MiniDB.ClassCDOpen end,
					set = function(_, value) MiniDB.ClassCDOpen = value end,
				},
				ClassFontSize = {
					type = "range", order = 18,
					name = "内置CD字体大小：", desc = "输入内置CD字体大小",
					min = 4, max = 28, step = 1,
					get = function() return MiniDB.ClassFontSize end,
					set = function(_, value) MiniDB.ClassFontSize = value end,
				},
				ClassCDWidth = {
					type = "input",
					name = "框体宽度：",
					desc = "请输入框体宽度",
					order = 19,
					get = function() return tostring(MiniDB.ClassCDWidth) end,
					set = function(_, value) MiniDB.ClassCDWidth = tonumber(value) end,
				},
				ClassCDHeight = {
					type = "input",
					name = "框体高度：",
					desc = "请输入框体高度",
					order = 20,
					get = function() return tostring(MiniDB.ClassCDHeight) end,
					set = function(_, value) MiniDB.ClassCDHeight = tonumber(value) end,
				},
				ClassCDDirection = {
					type = "select",
					name = "计时条增长方向：",
					desc = "请选择计时条增长方向",
					order = 21,
					values = {[1] = "向下", [2] = "向上"},
					get = function() return MiniDB.ClassCDDirection end,
					set = function(_, value) MiniDB.ClassCDDirection = value end,
				},
			},
		}
	end
end

