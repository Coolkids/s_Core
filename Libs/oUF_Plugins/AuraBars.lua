local _, ns = ...
local oUF = ns.oUF or oUF

local function Round(number, decimalPlaces)
	if decimalPlaces and decimalPlaces > 0 then
		local mult = 10^decimalPlaces
		return math.floor(number * mult + .5) / mult
	end
	return math.floor(num + .5)
end

local function FormatTime(timeInSec)
	local h = math.floor(timeInSec / 3600)
	local m = math.floor((timeInSec - (3600 * h)) / 60)
	local s = math.floor(timeInSec - ((3600 * h) + (60 * m)))
	if h > 0 then
		return h .. ":" .. m .. "h"
	elseif m > 0 then
		return m .. "m"
	else
		return s .. "s"
	end
end

local function UpdateTooltip(self)
	GameTooltip:SetUnitAura(self.__unit, self:GetParent().aura.name, self:GetParent().aura.rank, self:GetParent().aura.filter)
end

local function OnEnter(self)
	if(not self:IsVisible()) then return end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	self:UpdateTooltip()
end

local function OnLeave(self)
	GameTooltip:Hide()
end

local function SetAnchors(self)
	local bars = self.bars

	for index = 1, #bars do
		local frame = bars[index]
		local anchor = frame.anchor
		frame:SetWidth((self.auraBarWidth or self:GetWidth()) - (frame:GetHeight() + (self.gap or 0)))
		frame:ClearAllPoints()
		if self.down == true then
			if self == anchor then -- Root frame so indent for icon
				frame:SetPoint('TOPLEFT', anchor, 'TOPLEFT', (frame:GetHeight() + (self.gap or 0) ), -1)
			else
				frame:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, (-self.spacing or 0))
			end
		else
			if self == anchor then -- Root frame so indent for icon
				frame:SetPoint('BOTTOMLEFT', anchor, 'BOTTOMLEFT', (frame:GetHeight() + (self.gap or 0)), 1)
			else
				frame:SetPoint('BOTTOMLEFT', anchor, 'TOPLEFT', 0, (self.spacing or 0))
			end
		end
	end
end

local function CreateAuraBar(oUF, anchor)
	local auraBarParent = oUF.AuraBars
	
	local frame = CreateFrame("Frame", nil, auraBarParent)
	frame:SetHeight(auraBarParent.auraBarHeight or 20)
	frame:SetWidth((auraBarParent.auraBarWidth or auraBarParent:GetWidth()) - (frame:GetHeight() + (auraBarParent.gap or 0)))
	frame.anchor = anchor
	
	-- the main bar
	local statusBar = CreateFrame("StatusBar", nil, frame)
	statusBar:SetStatusBarTexture(auraBarParent.auraBarTexture or [[Interface\TargetingFrame\UI-StatusBar]])
	statusBar:SetAlpha(auraBarParent.fgalpha or 1)
	statusBar:SetAllPoints(frame)
	
	frame.statusBar = statusBar
	
	if auraBarParent.down == true then
		if auraBarParent == anchor then -- Root frame so indent for icon
			frame:SetPoint('TOPLEFT', anchor, 'TOPLEFT', (frame:GetHeight() + (auraBarParent.gap or 0) ), -1)
		else
			frame:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, (-auraBarParent.spacing or 0))
		end
	else
		if auraBarParent == anchor then -- Root frame so indent for icon
			frame:SetPoint('BOTTOMLEFT', anchor, 'BOTTOMLEFT', (frame:GetHeight() + (auraBarParent.gap or 0)), 1)
		else
			frame:SetPoint('BOTTOMLEFT', anchor, 'TOPLEFT', 0, (auraBarParent.spacing or 0))
		end
	end
	
	local spark = statusBar:CreateTexture(nil, "OVERLAY", nil);
	spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]]);
	spark:SetWidth(12);
	spark:SetBlendMode("ADD");
	spark:SetPoint('CENTER', statusBar:GetStatusBarTexture(), 'RIGHT')		
	statusBar.spark = spark
	
	statusBar.iconHolder = CreateFrame('Button', nil, statusBar)
	statusBar.iconHolder:SetHeight(frame:GetHeight())
	statusBar.iconHolder:SetWidth(frame:GetHeight())
	statusBar.iconHolder:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMLEFT', -auraBarParent.gap, 0)
	statusBar.iconHolder.__unit = oUF.unit
	statusBar.iconHolder:SetScript('OnEnter', OnEnter)
	statusBar.iconHolder:SetScript('OnLeave', OnLeave)
	statusBar.iconHolder.UpdateTooltip = UpdateTooltip
	
	statusBar.icon = statusBar.iconHolder:CreateTexture(nil, 'BACKGROUND')
	statusBar.icon:SetTexCoord(.07, .93, .07, .93)
	statusBar.icon:SetAllPoints()

	statusBar.spelltime = statusBar:CreateFontString(nil, 'ARTWORK')
	if auraBarParent.spellTimeObject then
		statusBar.spelltime:SetFontObject(auraBarParent.spellTimeObject)
	else
		statusBar.spelltime:SetFont(auraBarParent.spellTimeFont or [[Fonts\FRIZQT__.TTF]], auraBarParent.spellTimeSize or 10)
	end
	statusBar.spelltime:SetTextColor(1 ,1, 1)
	statusBar.spelltime:SetJustifyH'RIGHT'
	statusBar.spelltime:SetJustifyV'CENTER'
	statusBar.spelltime:SetPoint'RIGHT'

	statusBar.spellname = statusBar:CreateFontString(nil, 'ARTWORK')
	if auraBarParent.spellNameObject then
		statusBar.spellname:SetFontObject(auraBarParent.spellNameObject)
	else
		statusBar.spellname:SetFont(auraBarParent.spellNameFont or [[Fonts\FRIZQT__.TTF]], auraBarParent.spellNameSize or 10)
	end
	statusBar.spellname:SetTextColor(1, 1, 1)
	statusBar.spellname:SetJustifyH'LEFT'
	statusBar.spellname:SetJustifyV'CENTER'
	statusBar.spellname:SetPoint'LEFT'
	statusBar.spellname:SetPoint('RIGHT', statusBar.spelltime, 'LEFT')

	if auraBarParent.PostCreateBar then
		auraBarParent.PostCreateBar(frame)
	end
	
	return frame
end

local function UpdateBars(auraBars)
	local bars = auraBars.bars
	local timenow = GetTime()

	for index = 1, #bars do
		local frame = bars[index]
		local bar = frame.statusBar
		if not frame:IsVisible() then
			break
		end
		if bar.aura.noTime then
			bar.spelltime:SetText()
			bar.spark:Hide()
		else
			local timeleft = bar.aura.expirationTime - timenow
			bar:SetValue(timeleft)
			bar.spelltime:SetText(FormatTime(timeleft))
			if auraBars.spark == true then
				bar.spark:Show()
			end
		end
	end
end

local function DefaultFilter(self, unit, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate)
	if unitCaster == 'player' and not shouldConsolidate then
		return true
	end
end

local sort = function(a, b)
	local compa, compb = a.noTime and math.huge or a.expirationTime, b.noTime and math.huge or b.expirationTime
	return compa > compb
end


local function Update(self, event, unit)
	if self.unit ~= unit then return end
	local auraBars = self.AuraBars
	local helpOrHarm
	local isFriend = UnitIsFriend('player', unit)
	
	if auraBars.friendlyAuraType and auraBars.enemyAuraType then
		if isFriend then
			helpOrHarm = auraBars.friendlyAuraType
		else
			helpOrHarm = auraBars.enemyAuraType
		end
	else
		helpOrHarm = isFriend and 'HELPFUL' or 'HARMFUL'
	end

	-- Create a table of auras to display
	local auras = {}
	local lastAuraIndex = 0
	for index = 1, 40 do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellID = UnitAura(unit, index, helpOrHarm)
		if not name then break end
		
		if (auraBars.filter or DefaultFilter)(self, unit, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellID) then
			lastAuraIndex = lastAuraIndex + 1
			auras[lastAuraIndex] = {}
			auras[lastAuraIndex].name = name
			auras[lastAuraIndex].rank = rank
			auras[lastAuraIndex].icon = icon
			auras[lastAuraIndex].count = count
			auras[lastAuraIndex].debuffType = debuffType
			auras[lastAuraIndex].duration = duration
			auras[lastAuraIndex].expirationTime = expirationTime
			auras[lastAuraIndex].unitCaster = unitCaster
			auras[lastAuraIndex].isStealable = isStealable
			auras[lastAuraIndex].noTime = (duration == 0 and expirationTime == 0)
			auras[lastAuraIndex].filter = helpOrHarm
			auras[lastAuraIndex].shouldConsolidate = shouldConsolidate
		end
	end

	if auraBars.sort then
		table.sort(auras, type(auraBars.sort) == 'function' and auraBars.sort or sort)
	end

	-- Show and configure bars for buffs/debuffs.
	local bars = auraBars.bars
	if lastAuraIndex == 0 then
		self.AuraBars:SetHeight(1)
	end
	
	for index = 1 , lastAuraIndex do
		if auraBars:GetWidth() == 0 then break; end
		local aura = auras[index]
		local frame = bars[index]
		
		if not frame then
			frame = CreateAuraBar(self, index == 1 and auraBars or bars[index - 1])
			bars[index] = frame
		end
		
		if index == lastAuraIndex then
			if self.AuraBars.down then
				self.AuraBars:SetHeight(self.AuraBars:GetTop() - frame:GetBottom())
			else
				self.AuraBars:SetHeight(frame:GetTop() - self.AuraBars:GetBottom())
			end
		end
		
		local bar = frame.statusBar
		frame.index = index
		
		-- Backup the details of the aura onto the bar, so the OnUpdate function can use it
		bar.aura = aura

		-- Configure
		if bar.aura.noTime then
			bar:SetMinMaxValues(0, 1)
			bar:SetValue(1)
		else
			if auraBars.scaleTime then
				local maxvalue = math.min(auraBars.scaleTime, bar.aura.duration)
				bar:SetMinMaxValues(0, maxvalue)
				bar:SetWidth(
					( maxvalue / auraBars.scaleTime ) *
					(	( auraBars.auraBarWidth or auraBars:GetWidth() ) -
						( bar:GetHeight() + (auraBars.gap or 0) ) ) ) 				-- icon size + gap
			else
				bar:SetMinMaxValues(0, bar.aura.duration)
			end
			bar:SetValue(bar.aura.expirationTime - GetTime())
		end

		bar.icon:SetTexture(bar.aura.icon)

		bar.spellname:SetText(bar.aura.count > 1 and string.format("%s [%d]", bar.aura.name, bar.aura.count) or bar.aura.name)
		bar.spelltime:SetText(not bar.noTime and FormatTime(bar.aura.expirationTime-GetTime()))

		-- Colour bars
		local r, g, b = .2, .6, 1 -- Colour for buffs
		if auraBars.buffColor then
			r, g, b = unpack(auraBars.buffColor)
		end		
		
		if helpOrHarm == 'HARMFUL' then
			local debuffType = bar.aura.debuffType and bar.aura.debuffType or 'none'
			
			r, g, b = DebuffTypeColor[debuffType].r, DebuffTypeColor[debuffType].g, DebuffTypeColor[debuffType].b
			if auraBars.debuffColor then
				r, g, b = unpack(auraBars.debuffColor)
			else
				if debuffType == 'none' and auraBars.defaultDebuffColor then
					r, g, b = unpack(auraBars.defaultDebuffColor)
				end
			end			
		end
		bar:SetStatusBarColor(r, g, b)
		frame:Show()
	end

	-- Hide unused bars.
	for index = lastAuraIndex + 1, #bars do
		bars[index]:Hide()
	end
	
	if auraBars.PostUpdate then
		auraBars:PostUpdate(event, unit)
	end
end

local function Enable(self)
	if self.AuraBars then
		self:RegisterEvent('UNIT_AURA', Update)
		self.AuraBars:SetHeight(1)
		self.AuraBars.bars = self.AuraBars.bars or {}
		self.AuraBars.SetAnchors = SetAnchors
		self.AuraBars:SetScript('OnUpdate', UpdateBars)
		return true
	end
end

local function Disable(self)
	local auraFrame = self.AuraBars
	if auraFrame then
		self:UnregisterEvent('UNIT_AURA', Update)
		auraFrame:SetScript('OnUpdate', nil)
	end
end

oUF:AddElement('AuraBars', Update, Enable, Disable)
