﻿local S, C, L, DB, _ = unpack(select(2, ...))
 if IsAddOnLoaded("Omen3") then
	return
end
local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("Threat")

--[[local aggroColors = {
	[1] = {12/255, 151/255,  15/255},
	[2] = {166/255, 171/255,  26/255},
	[3] = {163/255,  24/255,  24/255},
}]]

local ThreatBar = CreateFrame("StatusBar", "ThreatBar", UIParent)

ThreatBar:SetStatusBarTexture(DB.Statusbar)
ThreatBar:GetStatusBarTexture():SetHorizTile(false)
ThreatBar:SetMinMaxValues(0, 100)
ThreatBar:CreateShadow()

local gradient = ThreatBar:CreateTexture(nil, "BACKGROUND")
gradient:SetPoint("TOPLEFT")
gradient:SetPoint("BOTTOMRIGHT")
gradient:SetTexture(DB.Statusbar)
gradient:SetGradientAlpha("VERTICAL", .3, .3, .3, .6, .1, .1, .1, .6)

ThreatBar.text = ThreatBar:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
ThreatBar.text:Point("CENTER", ThreatBar, "CENTER")
local function Smooth(self, value)
	if value == self:GetValue() then
        self.smoothing = nil
    else
        self.smoothing = value
    end
end
local function UpdateHealthSmooth(self)
	if self.smoothing == nil then return end
	local val = self.smoothing
	local limit = 30/GetFramerate()
    local cur = self:GetValue()
    local new = cur + min((val-cur)/3, max(val-cur, limit))

    if new ~= new then
        new = val
    end

    self:SetValue_(new)
    if cur == val or abs(new - val) < 2 then
        self:SetValue_(val)
        self.smoothing = nil
    end
end
local function OnEvent(self, event, ...)
	
	local party = GetNumGroupMembers()
	local raid = GetNumGroupMembers()
	local pet = select(1, HasPetUI())
	if event == "PLAYER_ENTERING_WORLD" then
		self:Hide()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:Hide()
	elseif event == "PLAYER_REGEN_DISABLED" then
		if party > 0 or raid > 0 or pet == 1 then
			self:Show()
		else
			self:Hide()
		end
	else
		if (InCombatLockdown()) and (party > 0 or raid > 0 or pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	end
end

local function OnUpdate(self, event, unit)
	if UnitAffectingCombat(self.unit) then
		local _, _, threatpct, rawthreatpct, _ = UnitDetailedThreatSituation(self.unit, self.tar)
		local threatval = threatpct or 0
		
		self:SetValue(threatval)
		self.text:SetText("仇恨:"..format("%3.1f", threatval).."%")
		
		local r, g, b = S.ColorGradient(threatval/100, 0,.8,0,.8,.8,0,.8,0,0)
		self:SetStatusBarColor(r, g, b)

		if threatval > 0 then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end	
		UpdateHealthSmooth(self)
	end
end
function Module:OnInitialize()
	C=C["ThreatDB"]
	if C["VERTICAL"] then
		ThreatBar:Size(12, C["ThreatBarWidth"])
		ThreatBar:SetOrientation("VERTICAL")
		ThreatBar.text:Point("TOP", ThreatBar, "BOTTOM", 0, -3)
	else
		ThreatBar:Size(C["ThreatBarWidth"], 12)
	end
	MoveHandle.Threat = S.MakeMoveHandle(ThreatBar, "Threat", "Threat")
	
end
function Module:OnEnable()
	ThreatBar.SetValue_ = ThreatBar.SetValue
	ThreatBar.SetValue = Smooth
	ThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	ThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
	ThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
	ThreatBar:SetScript("OnEvent", OnEvent)
	ThreatBar:SetScript("OnUpdate", OnUpdate)
	ThreatBar.unit = "player"
	ThreatBar.tar = ThreatBar.unit.."target"
end