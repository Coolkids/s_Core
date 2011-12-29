-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["ActionBar"] = {}
local Module = DB["Modules"]["ActionBar"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["HideHotKey"] = false,
		["HideMacroName"] = false,
		["Bar1Layout"] = 1,
		["Bar2Layout"] = 1,
		["Bar3Layout"] = 1,
		["ButtonSize"] = 34,
		["ButtonSpacing"] = 1,
		["FontSize"] = 15,
		["MFontSize"] = 13,
		["MainBarSacle"] = 1,
		["ExtraBarSacle"] = 1.5,
		["PetBarSacle"] = 0.7,
		["StanceBarSacle"] = 1,
		["TotemBarSacle"] = 1,
		["Style"] = 1,
		["bar1"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 24 },
		["bar2"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 60 },
		["bar3"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 96 }, 
		["bar4"] = { a1 = "RIGHT", a2 = "RIGHT", af = "UIParent", x = -10, y = 0 }, 
		["bar5"] = { a1 = "RIGHT", a2 = "RIGHT", af = "UIParent", x = -38, y = 0 }, 
		["stancebar"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 170 }, 
		["petbar"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 123, y = 189 }, 
		["extrabar"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -210, y = 135 },
		["totembar"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 166 }, 
		["vehicleexit"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 170, y = 130 }, 
	}
	if not ActionBarDB then ActionBarDB = {} end
	for key, value in pairs(Default) do
		if ActionBarDB[key] == nil then ActionBarDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(ActionBarDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["ActionBar"] =  {
			type = "group", order = 1,
			name = "动作条",
			args = {
				Bar1Layout = {
					type = "select", order = 1,
					name = "bar1布局：", desc = "请选择主动作条布局",
					values = {[1] = "12x1布局", [2] = "6x2布局"},
					get = function() return ActionBarDB.Bar1Layout end,
					set = function(_, value) ActionBarDB.Bar1Layout = value end,
				},
				Bar2Layout = {
					type = "select", order = 2,
					name = "bar2布局：", desc = "请选择主动作条布局",
					values = {[1] = "12x1布局", [2] = "6x2布局"},
					get = function() return ActionBarDB.Bar2Layout end,
					set = function(_, value) ActionBarDB.Bar2Layout = value end,
				},
				Bar3Layout = {
					type = "select", order = 3,
					name = "bar3布局：", desc = "请选择主动作条布局",
					values = {[1] = "12x1布局", [2] = "6x2布局"},
					get = function() return ActionBarDB.Bar3Layout end,
					set = function(_, value) ActionBarDB.Bar3Layout = value end,
				},
				Style = {
					type = "select", order = 4,
					name = "动作条皮肤风格：", desc = "请选择动作条皮肤风格",
					values = {[1] = "阴影风格", [2] = "框框风格"},
					get = function() return ActionBarDB.Style end,
					set = function(_, value) ActionBarDB.Style = value end,
				},
				NewLine = {
					type = "description", order = 5,
					name = "\n",					
				},
				HideHotKey = {
					type = "toggle", order = 6,
					name = "隐藏快捷键显示",			
					get = function() return ActionBarDB.HideHotKey end,
					set = function(_, value) ActionBarDB.HideHotKey = value end,
				},
				HideMacroName = {
					type = "toggle", order = 7,
					name = "隐藏宏名称显示",		
					get = function() return ActionBarDB.HideMacroName end,
					set = function(_, value) ActionBarDB.HideMacroName = value end,
				},
				ButtonSize = {
					type = "range", order = 8,
					name = "动作条按钮大小：", desc = "输入主动作条按钮大小",
					min = 16, max = 64, step = 1,
					get = function() return ActionBarDB.ButtonSize end,
					set = function(_, value) ActionBarDB.ButtonSize = value end,
				},
				ButtonSpacing = {
					type = "range", order = 9,
					name = "动作条间距大小：", desc = "输入主动作条间距大小",
					min = 0, max = 6, step = 1,
					get = function() return ActionBarDB.ButtonSpacing end,
					set = function(_, value) ActionBarDB.ButtonSpacing = value end,
				},
				FontSize = {
					type = "range", order = 10,
					name = "动作条字体大小：", desc = "输入主动作条动作条字体大小",
					min = 1, max = 36, step = 1,
					get = function() return ActionBarDB.FontSize end,
					set = function(_, value) ActionBarDB.FontSize = value end,
				},
				MFontSize = {
					type = "range", order = 11,
					name = "宏名字字体大小：", desc = "输入宏名字字体大小",
					min = 1, max = 36, step = 1,
					get = function() return ActionBarDB.MFontSize end,
					set = function(_, value) ActionBarDB.MFontSize = value end,
				},
				MainBarSacle = {
					type = "range", order = 12,
					name = "主动作条缩放大小：", desc = "输入主动作条缩放大小",
					min = 0, max = 3, step = 0.1,
					get = function() return ActionBarDB.MainBarSacle end,
					set = function(_, value) ActionBarDB.MainBarSacle = value end,
				},
				ExtraBarSacle = {
					type = "range", order = 13,
					name = "特殊按钮缩放大小：", desc = "输入特殊按钮缩放大小",
					min = 0, max = 3, step = 0.1,
					get = function() return ActionBarDB.ExtraBarSacle end,
					set = function(_, value) ActionBarDB.ExtraBarSacle = value end,
				},
				PetBarSacle = {
					type = "range", order = 14,
					name = "宠物条缩放大小：", desc = "输入宠物条缩放大小",
					min = 0, max = 3, step = 0.1,
					get = function() return ActionBarDB.PetBarSacle end,
					set = function(_, value) ActionBarDB.PetBarSacle = value end,
				},
				StanceBarSacle = {
					type = "range", order = 15,
					name = "姿态栏缩放大小：", desc = "输入姿态栏缩放大小",
					min = 0, max = 3, step = 0.1,
					get = function() return ActionBarDB.StanceBarSacle end,
					set = function(_, value) ActionBarDB.StanceBarSacle = value end,
				},
				TotemBarSacle = {
					type = "range", order = 16,
					name = "图腾栏缩放大小：", desc = "输入图腾栏缩放大小",
					min = 0, max = 3, step = 0.1,
					get = function() return ActionBarDB.TotemBarSacle end,
					set = function(_, value) ActionBarDB.TotemBarSacle = value end,
				},
			},
		}
	end
end


