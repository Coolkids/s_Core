--[[ Element: Heal Prediction And Absorb Bar
			By Ray
]]--
local _, ns = ...
local oUF = ns.oUF or oUF

local function UpdateFillBar(frame, previousTexture, bar, amount)
	if ( amount == 0 ) then
		bar:Hide()
		if ( bar.overlay ) then
			bar.overlay:Hide()
		end
		return previousTexture
	end

	bar:SetPoint("TOPLEFT", previousTexture, "TOPRIGHT", 0, 0)
	bar:SetPoint("BOTTOMLEFT", previousTexture, "BOTTOMRIGHT", 0, 0)

	local totalWidth, totalHeight = frame.Health:GetSize()
	local totalMax = UnitHealthMax(frame.unit)

	local barSize = (amount / totalMax) * totalWidth
	bar:SetWidth(barSize)
	bar:Show()
	if ( bar.overlay ) then
		bar.overlay:SetTexCoord(0, barSize / bar.overlay.tileSize, 0, totalHeight / bar.overlay.tileSize)
		bar.overlay:Show()
	end
	return bar
end

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local hp = self.HealPredictionAndAbsorb
	if(hp.PreUpdate) then hp:PreUpdate(unit) end

	local myIncomingHeal = UnitGetIncomingHeals(unit, 'player') or 0
	local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
	local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)

	if(health + allIncomingHeal > maxHealth * hp.maxOverflow) then
		allIncomingHeal = maxHealth * hp.maxOverflow - health
	end

	if(allIncomingHeal < myIncomingHeal) then
		myIncomingHeal = allIncomingHeal
		allIncomingHeal = 0
	else
		allIncomingHeal = allIncomingHeal - myIncomingHeal
	end

	local overAbsorb = false
	--We don't overfill the absorb bar
	if ( health + myIncomingHeal + allIncomingHeal + totalAbsorb >= maxHealth ) then
		if ( totalAbsorb > 0 ) then
			overAbsorb = true
		end
		totalAbsorb = max(0,maxHealth - (health + myIncomingHeal + allIncomingHeal))
	end
	if hp.overAbsorbGlow then
		if ( overAbsorb ) then
			hp.overAbsorbGlow:Show()
		else
			hp.overAbsorbGlow:Hide()
		end
	end

	local previousTexture = self.Health:GetStatusBarTexture()

	previousTexture = UpdateFillBar(self, previousTexture, hp.myBar, myIncomingHeal)
	previousTexture = UpdateFillBar(self, previousTexture, hp.otherBar, allIncomingHeal)
	if (hp.absorbBar) then
		previousTexture = UpdateFillBar(self, previousTexture, hp.absorbBar, totalAbsorb)
	end

	if(hp.PostUpdate) then
		return hp:PostUpdate(unit)
	end
end

local function Path(self, ...)
	return (self.HealPredictionAndAbsorb.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local hp = self.HealPredictionAndAbsorb
	if(hp) then
		hp.__owner = self
		hp.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)
		self:RegisterEvent('UNIT_HEALTH', Path)
		self:RegisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:RegisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)

		if(not hp.maxOverflow) then
			hp.maxOverflow = 1.05
		end

		if(hp.myBar and hp.myBar:IsObjectType'Texture' and not hp.myBar:GetTexture()) then
			hp.myBar:SetTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end
		if(hp.otherBar and hp.otherBar:IsObjectType'Texture' and not hp.otherBar:GetTexture()) then
			hp.otherBar:SetTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end
		if(hp.absorbBar and hp.absorbBar:IsObjectType'Texture' and not hp.absorbBar:GetTexture()) then
			hp.absorbBar:SetTexture([[Interface\TargetingFrame\UI-Texture]])
		end
		if(hp.overAbsorbGlow and hp.overAbsorbGlow:IsObjectType'Texture' and not hp.overAbsorbGlow:GetTexture()) then
			hp.overAbsorbGlow:SetTexture([[Interface\RaidFrame\Shield-Overshield]])
		end
		hp.absorbBar.overlay = hp.absorbBarOverlay

		return true
	end
end

local function Disable(self)
	local hp = self.HealPredictionAndAbsorb
	if(hp) then
		self:UnregisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEALTH', Path)
		self:UnregisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:UnregisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
	end
end

oUF:AddElement('HealPredictionAndAbsorb', Path, Enable, Disable)
