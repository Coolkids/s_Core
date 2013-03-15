﻿local S, L, DB, _, C = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Target Talents(TipTacTalents by Aezay)
----------------------------------------------------------------------------------------
local gtt = GameTooltip
local GetTalentTabInfo = GetTalentTabInfo

-- Constants
local TALENTS_PREFIX = TALENTS..":|cffffffff "
local CACHE_SIZE = 25
local INSPECT_DELAY = 0.2
local INSPECT_FREQ = 2

-- Variables
local ttt = CreateFrame("Frame", "TipTacTalents")
local cache = {}
local current = {}

-- Time of the last inspect reuqest. Init this to zero, just to make sure. This is a global so other addons could use this variable as well
lastInspectRequest = 0

-- Allow these to be accessed through other addons
ttt.cache = cache
ttt.current = current
ttt:Hide()

----------------------------------------------------------------------------------------
--	Gather Talents
----------------------------------------------------------------------------------------
local function GatherTalents(mouseover)
	if mouseover == 1 then
		local currentSpecID = GetInspectSpecialization("mouseover")
		local currentSpecName = currentSpecID and select(2, GetSpecializationInfoByID(currentSpecID)) or UNKNOWN
		local _, currentSpecName, _, icon = GetSpecializationInfoByID(currentSpecID)
        icon = icon and "|T"..icon..":12:12:0:0:64:64:5:59:5:59|t " or ""
		current.tree = currentSpecName and icon..currentSpecName or "n/a"
	else
		local currentSpec = GetSpecialization()
		local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or NONE..TALENTS
		local _, currentSpecName, _, icon = GetSpecializationInfo(currentSpec)
        icon = icon and "|T"..icon..":12:12:0:0:64:64:5:59:5:59|t " or ""
		current.tree = currentSpecName and icon..currentSpecName or "n/a"
	end

	-- Set the tips line output, for inspect, only update if the tip is still showing a unit!
	if mouseover == 0 then
		gtt:AddLine(TALENTS_PREFIX..current.tree)
	elseif gtt:GetUnit() then
		for i = 2, gtt:NumLines() do
			if (_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..TALENTS_PREFIX) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("%s%s", TALENTS_PREFIX, current.tree)
				break
			end
		end
	end
	-- Organise Cache
	local cacheSize = CACHE_SIZE
	for i = #cache, 1, -1 do
		if current.name == cache[i].name then
			tremove(cache, i)
			break
		end
	end
	if #cache > cacheSize then
		tremove(cache, 1)
	end
	-- Cache the new entry
	if cacheSize > 0 then
		cache[#cache + 1] = CopyTable(current)
	end
end

----------------------------------------------------------------------------------------
--	Event Handling
----------------------------------------------------------------------------------------
-- OnEvent
ttt:SetScript("OnEvent", function(self, event, guid)
	self:UnregisterEvent(event)
	if guid == current.guid then
		GatherTalents(1)
	end
end)

-- OnUpdate
ttt:SetScript("OnUpdate", function(self, elapsed)
	self.nextUpdate = (self.nextUpdate - elapsed)
	if self.nextUpdate <= 0 then
		self:Hide()
		-- Make sure the mouseover unit is still our unit
		if UnitGUID("mouseover") == current.guid then
			lastInspectRequest = GetTime()
			self:RegisterEvent("INSPECT_READY")
			-- Az: Fix the blizzard inspect copypasta code (Blizzard_InspectUI\InspectPaperDollFrame.lua @ line 23)
			if InspectFrame then
				InspectFrame.unit = "player"
			end
			NotifyInspect(current.unit)
		end
	end
end)

-- HOOK: OnTooltipSetUnit
gtt:HookScript("OnTooltipSetUnit", function(self, ...)
	-- Abort any delayed inspect in progress
	ttt:Hide()
	-- Get the unit -- Check the UnitFrame unit if this tip is from a concated unit, such as "targettarget".
	local _, unit = self:GetUnit()
	if not unit then
		local mFocus = GetMouseFocus()
		if mFocus and mFocus.unit then
			unit = mFocus.unit
		end
	end
	-- No Unit or not a Player
	if not unit or not UnitIsPlayer(unit) then
		return
	end
	-- Only bother for players over level 9
	local level = UnitLevel(unit)
	if level > 9 or level == -1 then
		-- Wipe Current Record
		wipe(current)
		current.unit = unit
		current.name = UnitName(unit)
		current.guid = UnitGUID(unit)
		-- No need for inspection on the player
		if UnitIsUnit(unit, "player") then
			GatherTalents(0)
			return
		end
		-- Show Cached Talents, If Available
		local isInspectOpen = (InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown())
		local cacheLoaded = false
		for _, entry in ipairs(cache) do
			if current.name == entry.name and not isInspectOpen then
				self:AddLine(TALENTS_PREFIX..entry.tree)
				current.tree = entry.tree
				cacheLoaded = true
				break
			end
		end
		-- Queue an inspect request
		if CanInspect(unit) and not isInspectOpen then
			local lastInspectTime = GetTime() - lastInspectRequest
			ttt.nextUpdate = (lastInspectTime > INSPECT_FREQ) and INSPECT_DELAY or (INSPECT_FREQ - lastInspectTime + INSPECT_DELAY)
			ttt:Show()
			if not cacheLoaded then
				self:AddLine(TALENTS_PREFIX..UNKNOWN)
			end
		elseif isInspectOpen then
			self:AddLine(TALENTS_PREFIX..UNKNOWN)
		end
	end
end)