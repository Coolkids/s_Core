local S, C, L, DB = unpack(select(2, ...))
local CT = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("ClassTools", "AceEvent-3.0", "AceTimer-3.0")
local SunUIConfig = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SunUIConfig")
local start, duration

local datebase = {
	["PRIEST"] = {
		[1] = {},
		[2] = {},
		[3] = {
			["spellid"] = 32379,
			["per"] = 0.2,
			["level"] = 50,
		},
	},
	["HUNTER"] = {
		[0] = {
			["spellid"] = 53351,
			["per"] = 0.2,
			["level"] = 50,
		}
	},
	["MAGE"] = {},
	["WARLOCK"] = {},
	["PALADIN"] = {},
	["ROGUE"] = {},
	["DRUID"] = {},
	["SHAMAN"] = {},
	["WARRIOR"] = {},
	["DEATHKNIGHT"] = {},
	["MONK"] = {},
}
--Parent
local Frame = CreateFrame("Frame", nil, UIParent)
Frame:CreateShadow()
Frame:Hide()
--Children
	--CooldownFrame
Frame.Cooldown = CreateFrame("Cooldown", nil, Frame)
Frame.Cooldown:SetAllPoints()
Frame.Cooldown:SetReverse(true)
	-- IconTexture
Frame.Icon = Frame:CreateTexture(nil, "ARTWORK") 
Frame.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
Frame.Icon:SetAllPoints(Frame)
local function SetFrameTexture()
	local spec = GetSpecialization()
	local texture
	if #datebase[DB.MyClass] == 0 then 
		CT:UnregisterAllEvents()
		return
	end
	if datebase[DB.MyClass][0] then
		texture = GetSpellTexture(v.spellid)
		Frame.spellid = v. spellid
		Frame.per = v.per
		Frame.level = v.level
		CT:RegisterEvent("UNIT_HEALTH")
		CT:RegisterEvent("PLAYER_TARGET_CHANGED")
		CT:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		Frame.Icon:SetTexture(texture) 
		return
	end
	if datebase[DB.MyClass][spec].spellid then 
		texture = GetSpellTexture(datebase[DB.MyClass][spec].spellid)
		Frame.spellid = datebase[DB.MyClass][spec]. spellid
		Frame.per = datebase[DB.MyClass][spec].per
		Frame.level = datebase[DB.MyClass][spec].level
		CT:RegisterEvent("UNIT_HEALTH")
		CT:RegisterEvent("PLAYER_TARGET_CHANGED")
		CT:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		Frame.Icon:SetTexture(texture) 
		return
	else
		CT:UnregisterEvent("UNIT_HEALTH")
		CT:UnregisterEvent("PLAYER_TARGET_CHANGED")
		CT:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
		Frame:Hide()
	end
end
function CT:UpdateSet()
	if C["Enable"] then
		Frame:SetSize(C["Size"], C["Size"])
		Frame:SetScale(C["Scale"])
		SetFrameTexture()
		CT:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", SetFrameTexture)
	else
		Frame:Hide()
		CT:UnregisterAllEvents()
	end
end
function CT:UNIT_HEALTH(event, unit)
	if unit ~= "target" then return end
	if ( UnitCanAttack("player", "target") and not UnitIsDead("target") and ( UnitHealth("target")/UnitHealthMax("target") < Frame.per and UnitLevel("player") > Frame.level ) and not UnitIsDead("player") ) then		
		if not Frame:IsShown() then
			Frame:Show()
		end
	else
		Frame:Hide()
	end
end
function CT:SPELL_UPDATE_COOLDOWN()
	local start, duration = GetSpellCooldown(Frame.spellid)
	Frame.Cooldown:SetReverse(false)
	CooldownFrame_SetTimer(Frame.Cooldown, start, duration, 1)
end
function CT:PLAYER_TARGET_CHANGED()
	self:UNIT_HEALTH(event, "target")
end
function CT:OnInitialize()
	C = SunUIConfig.db.profile.ClassToolsDB
	self:UpdateSet()
	MoveHandle.ClassTools = S.MakeMove(Frame, "ClassTools", "ClassTools", C["Scale"])
end