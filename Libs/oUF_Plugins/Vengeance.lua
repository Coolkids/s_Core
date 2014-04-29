local _, ns = ...
local oUF = ns.oUF or oUF

local vengeance = GetSpellInfo(93098)
-- local vengeance = GetSpellInfo(76691)
local siValue = function(val)
	if(val >= 1e6) then
		return format("%.2fm", val * 0.000001)
	elseif(val >= 1e4) then
		return format("%.1fk", val * 0.001)
	else
		return val
	end
end
local function valueChanged(self, event, unit)
	local S, L = unpack(SunUI)
	if unit ~= "player" then return end
	local bar = self.Vengeance

	if S.Role ~= "Tank" then
		bar:Hide()
		return
	end

	local name = UnitAura("player", vengeance, nil, "PLAYER|HELPFUL")
	if name then
		local value = select(15, UnitAura("player", vengeance, nil, "PLAYER|HELPFUL")) or -1
		if value > 0 then
			if value > bar.max then bar.max = value end
			-- if value > bar.max then value = bar.max end
			if value == bar.value then return end

			bar:SetMinMaxValues(0, bar.max)
			bar:SetValue(siValue(value))
			bar.value = value
			bar:Show()

			if bar.Text then
				bar.Text:SetText(value)
			end
		end
	elseif bar.showInfight and InCombatLockdown() then
		bar:Show()
		bar:SetMinMaxValues(0, 1)
		bar:SetValue(0)
		bar.value = 0
	else
		bar:Hide()
		bar.value = 0
	end
end

local function maxChanged(self, event, unit)
	local S, L = unpack(SunUI)

	unit = event == "PLAYER_ENTERING_WORLD" and "player" or unit
	if unit ~= "player" then return end
	local bar = self.Vengeance

	if S.Role ~= "Tank" then
		bar:Hide()
		return
	end

	local health = UnitHealthMax(unit)
	if not health then return end
	bar.max = health
end

local function Enable(self, unit)
	local bar = self.Vengeance

	if bar and unit == "player" then
		bar.max = 0
		bar.value = 0
		self:RegisterEvent("UNIT_AURA", valueChanged)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", maxChanged)
		self:RegisterEvent("UNIT_MAXHEALTH", maxChanged)
		self:RegisterEvent("UNIT_LEVEL", maxChanged)

		bar:Hide()
		bar:SetScript("OnEnter", function(self)
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 5)
			if self.value > 0 then
				GameTooltip:SetUnitBuff("player", vengeance)
			end
			GameTooltip:Show()
		end)
		bar:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
		return true
	end
end

local function Disable(self)
	local bar = self.Vengeance

	if bar then
		self:UnregisterEvent("UNIT_AURA", valueChanged)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", maxChanged)
		self:UnregisterEvent("UNIT_MAXHEALTH", maxChanged)
		self:UnregisterEvent("UNIT_LEVEL", maxChanged)
	end
end

oUF:AddElement("Vengeance", nil, Enable, Disable)
