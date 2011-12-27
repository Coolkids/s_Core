﻿-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["MoveHandle"] = {}
local Module = DB["Modules"]["MoveHandle"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["Buff"] = {"TOPRIGHT", "UIParent", "TOPRIGHT", -5, -5},
		["Debuff"] = {"TOPRIGHT", "UIParent", "TOPRIGHT", -5, -140},
		["Minimap"] = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -20, 27},
		["PlayerCastbar"] = {"CENTER","UIParent","CENTER",0,-335},
		["TargetCastbar"] = {"CENTER","UIParent","CENTER",226,-257},
		["FocusCastbar"] = {"RIGHT","UIParent","RIGHT",-99,-165},
		["PetCastbar"] = {"LEFT","UIParent","LEFT",414,-219},
		["ShadowPet"] = {"CENTER","UIParent","CENTER", -423, -223},
		["ClassCD"] = {"CENTER","UIParent","CENTER", 415, -380},
		["Threat"] = {"CENTER","UIParent","CENTER", -225, -133},
	}
	if not MoveHandleDB then MoveHandleDB = {} end
	for key, value in pairs(Default) do
		if MoveHandleDB[key] == nil then MoveHandleDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(MoveHandleDB)
end

-- BuildGUI
function Module.BuildGUI() end