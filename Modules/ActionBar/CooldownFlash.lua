﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local

local AB = S:GetModule("ActionBar")
local lib = LibStub("LibCooldown")
local flash, C
local filter = {
	["pet"] = "all",
	["item"] = {
		[6948] = true, -- hearthstone
	},
	["spell"] = {
		[125439] = true,
	},
}
function AB:SetCoolDownFlashUpdate()
	flash:SetScript("OnUpdate", function(self, e)
		flash.e = flash.e + e
		if flash.e > .75 then
			flash:Hide()
		elseif flash.e < .25 then
			flash:SetAlpha(flash.e*4)
		elseif flash.e > .5 then
			flash:SetAlpha(1-(flash.e%.5)*4)
		end
	end)
end
function AB:UpdateSetCoolDownFlashUpdate()
	if self.db.CooldownFlash then
		self:SetCoolDownFlashUpdate()
		lib:RegisterCallback("stop", function(id, class)
			if filter[class]=="all" or filter[class][id] then return end
			flash.icon:SetTexture(class=="item" and GetItemIcon(id) or GetSpellTexture(id))
			flash.e = 0
			flash:Show()
		end)
	else
		AB:UnregisterEvent("PLAYER_ENTERING_WORLD")
		wipe(lib.stopcalls)
		flash:SetScript("OnUpdate", nil)
		flash:Hide()
	end
end
function AB:UpdateCoolDownFlashSize()
	flash:SetSize(self.db.CooldownFlashSize,self.db.CooldownFlashSize)
end
function AB:initCooldownFlash()
	if (IsAddOnLoaded("ncCooldownFlash")) then
		return 
	end
	flash = CreateFrame("Frame", nil, UIParent)
	flash.icon = flash:CreateTexture(nil, "OVERLAY")
	flash.icon:SetAllPoints(flash)
	flash.icon:SetTexCoord(.08, .92, .08, .92)
	flash:CreateShadow()
	flash:SetPoint("TOP", "UIParent", "TOP", 0, -95)
	flash:Hide()
	self:SetCoolDownFlashUpdate()
	self:UpdateCoolDownFlashSize()
	S:CreateMover(flash, "CooldownFlashMover", L["冷却闪光锚点"], true, nil, "ALL,ACTIONBARS")
end