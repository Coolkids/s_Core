﻿local S, L, DB, _, C = unpack(select(2, ...))
local _
--[[ local MINCOLOR = 0.5;
local COLORINC = 0.2;
local INCMOD = 0.5;
local MinIL = 284;
local MaxIL = 509;

local slotName = {
	"HeadSlot","NeckSlot","ShoulderSlot","BackSlot","ChestSlot","WristSlot",
	"HandsSlot","WaistSlot","LegsSlot","FeetSlot","Finger0Slot","Finger1Slot",
	"Trinket0Slot","Trinket1Slot","MainHandSlot","SecondaryHandSlot"
}

local function GetAiL(unit)
	i = 0;
	total = 0;
	itn = 0;
	
	if (unit ~= nil) then
		for i in ipairs(slotName) do
			slot = GetInventoryItemID(unit, GetInventorySlotInfo(slotName[i]));
			
			if (slot ~= nil) then
				sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(slot);
				
				if (iLevel ~= nil) then
					if (iLevel > 0) then
						itn = itn + 1;
						total = total + iLevel;
					end
				end
			end
		end
	end
	
	if (total < 1 or itn < 1) then
		return 0;
	end
	
	return floor(total / itn);
end

local function GetAiLColor(ail)
	local r, gb;
	
	if (ail < MinIL) then
		r = (ail / MinIL);
		gb = r;
	else
		r = MINCOLOR + ((ail / MaxIL) * INCMOD);
		gb = 1.0 - ((ail / MaxIL) * INCMOD);
	end
	
	if (r < MINCOLOR) then
		r = MINCOLOR;
		gb = r;
	end
	
	return r, gb;
end
GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
		local ail, r, gb;
		local name, unit = GameTooltip:GetUnit();
		if (unit and CanInspect(unit)) then
			local isInspectOpen = (InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown());
			if ((unit) and (CanInspect(unit)) and (not isInspectOpen)) then
				NotifyInspect(unit);
				ail = GetAiL(unit);
				r, gb = GetAiLColor(ail);
				ClearInspectPlayer(unit);
				GameTooltip:AddLine(STAT_AVERAGE_ITEM_LEVEL..":"..format(S.ToHex(r, gb, gb)..ail.."|r"));
				GameTooltip:Show();
			end
		end
	end) ]]
	-- decimal places of the equipped average item level. to assign '2' will show it like '123.45'
local DECIMAL_PLACES = 1

-- additional strings. if you don't like it just assign 'nil'. but do not delete these variables themselves.
local UPDATED = CANNOT_COOPERATE_LABEL -- '*'
local WAITING = CONTINUED -- '...'
local PENDING = CONTINUED .. CONTINUED -- '......'

-- output prefix. has to have unique strings to update the tooltip correctly
local PREFIX = STAT_FORMAT:format(STAT_AVERAGE_ITEM_LEVEL) .. '|Heqppditmlvl|h |h' .. HIGHLIGHT_FONT_COLOR_CODE


local f = CreateFrame('Frame')
f:SetScript('OnEvent', function(self, event, ...)
	return self[event](self, event, ...)
end)
f:Hide()

local playerGUID, inCombat, updateTimer
local currentUnit, currentGUID
local isDelayed, isForced, isNotified, isReady

local function GetTipUnit ()
	local _, unit = GameTooltip:GetUnit()
	if ( not unit ) then
		local mouseFocus = GetMouseFocus()
		unit = mouseFocus and (mouseFocus.unit or mouseFocus:GetAttribute('unit'))
	end

	return unit and UnitIsPlayer(unit) and unit
end

local SetTipText
do
	local function search (line, numLines)
		if ( line > numLines ) then return end

		local fontString = _G['GameTooltipTextLeft' .. line]
		local stringText = fontString and fontString:GetText()
		if ( stringText and stringText:match(PREFIX) ) then
			return fontString
		end

		return search(line + 1, numLines)
	end

	function SetTipText (text)
		if ( not text ) then return end

		local fontString = search(1, GameTooltip:NumLines())
		if ( fontString ) then
			fontString:SetText(PREFIX .. text)
		else
			GameTooltip:AddLine(PREFIX .. text)
		end

		return GameTooltip:Show()
	end
end

local CanSafeInspect -- 6 times per 10 secs
do
	local limit, period = 6, 11
	local count, startTime = 0, 0

	hooksecurefunc('NotifyInspect', function ()
		local currentTime = GetTime()
		if ( currentTime - startTime > period ) then
			count, startTime = 1, currentTime
			return
		end

		count = count + 1
	end)

	function CanSafeInspect (unit)
		if ( not CanInspect(unit) or InspectFrame and InspectFrame:IsShown() or Examiner and Examiner:IsShown() ) then return end

		local pending = count > limit and period - (GetTime() - startTime)
		return true, pending and pending > 0 and pending
	end
end

local UnitItemLevel
do
	local formatString = '%.' .. DECIMAL_PLACES .. 'f'

	local function scan (unit, slot, total, count, twoHanded, incomplete)
		if ( slot > INVSLOT_LAST_EQUIPPED ) then
			return formatString:format(total / (twoHanded and count - 2 or count-1)), incomplete
		end

		if ( slot == INVSLOT_BODY or slot == INVSLOT_TABARD ) then
			return scan(unit, slot + 1, total, count, twoHanded, incomplete)
		end

		local hasItem = GetInventoryItemTexture(unit, slot) and true
		local _, level, equipLoc

		local link = hasItem and GetInventoryItemLink(unit, slot)
		if ( link ) then
			repeat
				_, _, _, level, _, _, _, _, equipLoc = GetItemInfo(link)
			until level and equipLoc

			total = total + level
		end

		-- two-handed weapon and Titan's Grip
		if ( slot == INVSLOT_MAINHAND ) then
			twoHanded = equipLoc == 'INVTYPE_2HWEAPON' and 1 or not hasItem and 0
		elseif ( slot == INVSLOT_OFFHAND ) then
			twoHanded = twoHanded == 1 and not hasItem or twoHanded == 0 and equipLoc == 'INVTYPE_2HWEAPON'
		end

		local failed = hasItem and not link
		return scan(unit, slot + 1, total, failed and count or count + 1, twoHanded, incomplete or failed)
	end

	function UnitItemLevel (unit)
		if ( unit == 'player' or UnitIsUnit(unit, 'player') ) then
			local _, level = GetAverageItemLevel()
			return formatString:format(level)
		end

		return scan(unit, INVSLOT_FIRST_EQUIPPED, 0, 0)
	end
end

local UpdateItemLevel
do
	local cache = {}
	local cachedLevel

	local function update (unit, guid)
		local level, incomplete = UnitItemLevel(unit)

		if ( incomplete ) then
			updateTimer = TOOLTIP_UPDATE_TIME
			f:Show()
			level = cachedLevel or level
			return SetTipText(WAITING and level .. WAITING or level)
		end

		if ( isReady ) then
			cache[guid] = level
			return SetTipText(UPDATED and level .. UPDATED or level)
		end

		level = cachedLevel or level
		return SetTipText(WAITING and level .. WAITING or level)
	end

	function UpdateItemLevel ()
		cachedLevel = cache[currentGUID]

		if ( inCombat ) then
			return SetTipText(cachedLevel)
		end

		if ( isReady ) then
			return update(currentUnit, currentGUID)
		end

		if ( not isForced and cachedLevel ) then
			return SetTipText(cachedLevel)
		end

		if ( currentGUID == playerGUID ) then
			local level = UnitItemLevel('player')
			cache[playerGUID] = level
			return SetTipText(level)
		end

		local canInspect, pending = CanSafeInspect(currentUnit)
		if ( not canInspect ) then
			return SetTipText(cachedLevel)
		end

		if ( pending ) then
			updateTimer = pending
			f:Show()
--			return SetTipText(cachedLevel and (WAITING and cachedLevel .. WAITING or cachedLevel) or PENDING)
			return SetTipText(cachedLevel and cachedLevel .. PENDING or PENDING)
		end

		if ( not isDelayed ) then
			isDelayed = true
			updateTimer = TOOLTIP_UPDATE_TIME
			f:Show()
			return SetTipText(cachedLevel and (WAITING and cachedLevel .. WAITING or cachedLevel) or PENDING)
		end

		if ( not isNotified ) then
			isNotified = true
			NotifyInspect(currentUnit)
		end

		return update(currentUnit, currentGUID)
	end
end

local function OnTooltipSetUnit ()
	currentUnit, currentGUID, isDelayed, isForced, isNotified, isReady = GetTipUnit(), nil, nil, nil, nil, nil
	if ( not currentUnit ) then return end

	currentGUID, isForced = UnitGUID(currentUnit), UnitIsUnit(currentUnit, 'target')

	return UpdateItemLevel()
end
GameTooltip:HookScript('OnTooltipSetUnit', OnTooltipSetUnit)

f:SetScript('OnUpdate', function (self, elapsed)
	updateTimer = updateTimer - elapsed
	if ( updateTimer > 0 ) then return end
	self:Hide()

	if ( not currentGUID ) then return end

	local tipUnit = GetTipUnit()
	if ( not tipUnit or UnitGUID(tipUnit) ~= currentGUID ) then return end

	return UpdateItemLevel()
end)

function f:INSPECT_READY (_, guid)
	if ( not currentGUID or guid ~= currentGUID ) then return end

	local tipUnit = GetTipUnit()
	if ( not tipUnit or UnitGUID(tipUnit) ~= currentGUID ) then return end

	isReady = true
	-- we never know if the others are waiting for the further info about the same guid
	-- ClearInspectPlayer()
	-- we never know how many times 'INSPECT_READY' be fired
	-- f:UnregisterEvent('INSPECT_READY')

	return UpdateItemLevel()
end
f:RegisterEvent('INSPECT_READY')

function f:UNIT_INVENTORY_CHANGED (_, unit)
	if ( not currentGUID or UnitGUID(unit) ~= currentGUID ) then return end

	local tipUnit = GetTipUnit()
	if ( not tipUnit or UnitGUID(tipUnit) ~= currentGUID ) then return end

	isForced, isNotified, isReady = true, nil, nil

	return UpdateItemLevel()
end
f:RegisterEvent('UNIT_INVENTORY_CHANGED')

function f:PLAYER_TARGET_CHANGED ()
	return self:UNIT_INVENTORY_CHANGED (nil, 'target')
end
f:RegisterEvent('PLAYER_TARGET_CHANGED')

function f:PLAYER_REGEN_DISABLED ()
	inCombat = true
end
f:RegisterEvent('PLAYER_REGEN_DISABLED')

function f:PLAYER_REGEN_ENABLED ()
	inCombat = nil
end
f:RegisterEvent('PLAYER_REGEN_ENABLED')

function f:PLAYER_LOGIN ()
	self:UnregisterEvent('PLAYER_LOGIN')
	self.PLAYER_LOGIN = nil

	playerGUID = UnitGUID('player')
end

if ( IsLoggedIn() ) then
	f:PLAYER_LOGIN()
	inCombat = InCombatLockdown()
	return OnTooltipSetUnit()
end

return f:RegisterEvent('PLAYER_LOGIN')
