-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["Skin"] = {}
local Module = DB["Modules"]["Skin"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["EnableDBMSkin"] = true,		-- 启用DBM皮肤
		["EnableOmenSkin"] = true,       --Omen皮肤
		["EnablePallyPowerSkin"] = true, --PallyPower皮肤
		["EnableBigWigsSkin"] = true,    --BigWigs
		["EnableQuartzSkin"] = true,    --Quartz
		["EnableRecountSkin"] = true,    --Recount
		["EnableSkadaSkin"] = true,      --Skada
	}
	if not SkinDB then SkinDB = {} end
	for key, value in pairs(Default) do
		if SkinDB[key] == nil then SkinDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(SkinDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["Skin"] =  {
			type = "group", order = 8,
			name = "界面皮肤",
			args = {
				EnableDBMSkin = {
					type = "toggle",
					name = "启用DBM皮肤",
					order = 1,
					get = function() return SkinDB.EnableDBMSkin end,
					set = function(_, value) SkinDB.EnableDBMSkin = value end,
				},
				EnableOmenSkin = {
					type = "toggle",
					name = "启用Omen皮肤",
					order = 2,
					get = function() return SkinDB.EnableOmenSkin end,
					set = function(_, value) SkinDB.EnableOmenSkin = value end,
				},
				EnablePallyPowerSkin = {
					type = "toggle",
					name = "启用PallyPower皮肤",
					order = 3,
					get = function() return SkinDB.EnablePallyPowerSkin end,
					set = function(_, value) SkinDB.EnablePallyPowerSkin = value end,
				},
				EnableBigWigsSkin = {
					type = "toggle",
					name = "启用BigWigs皮肤",
					order = 4,
					get = function() return SkinDB.EnableBigWigsSkin end,
					set = function(_, value) SkinDB.EnableBigWigsSkin = value end,
				},
				EnableQuartzSkin = {
					type = "toggle",
					name = "启用Quartz皮肤",
					order = 5,
					get = function() return SkinDB.EnableQuartzSkin end,
					set = function(_, value) SkinDB.EnableQuartzSkin = value end,
				},
				EnableRecountSkin = {
					type = "toggle",
					name = "启用Recount皮肤",
					order = 6,
					get = function() return SkinDB.EnableRecountSkin end,
					set = function(_, value) SkinDB.EnableRecountSkin = value end,
				},
				EnableSkadaSkin = {
					type = "toggle",
					name = "启用Skada皮肤",
					order = 7,
					get = function() return SkinDB.EnableSkadaSkin end,
					set = function(_, value) SkinDB.EnableSkadaSkin = value end,
				},
			},
		}
	end
end

