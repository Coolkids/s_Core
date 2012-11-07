﻿local S, C, L, DB = unpack(select(2, ...))
local _
local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("RollFrame")

----------------------------------------------------------------------------------------
--	Based on teksLoot(by Tekkub)
----------------------------------------------------------------------------------------
local pos = "TOP"
local frames = {}
local cancelled_rolls = {}
local LootRollAnchor = CreateFrame("Frame", "LootRollAnchor", UIParent)
LootRollAnchor:Size(362, 26)
local _G = _G
local function ClickRoll(frame)
	RollOnLoot(frame.parent.rollID, frame.rolltype)
end

local function HideTip() GameTooltip:Hide() end
local function HideTip2() GameTooltip:Hide() ResetCursor() end

local rolltypes = {[1] = "need", [2] = "greed", [3] = "disenchant", [0] = "pass"}

local function SetTip(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:SetText(frame.tiptext)
	if frame:IsEnabled() == 0 then GameTooltip:AddLine("|cffff3333"..L_LOOT_CANNOT) end
	for name, roll in pairs(frame.parent.rolls) do if rolltypes[roll] == rolltypes[frame.rolltype] then GameTooltip:AddLine(name, 1, 1, 1) end end
	GameTooltip:Show()
end

local function SetItemTip(frame)
	if not frame.link then return end
	GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
	GameTooltip:SetHyperlink(frame.link)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	if IsModifiedClick("DRESSUP") then ShowInspectCursor() else ResetCursor() end
end

local function ItemOnUpdate(self)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	CursorOnUpdate(self)
end

local function LootClick(frame)
	if IsControlKeyDown() then DressUpItemLink(frame.link)
	elseif IsShiftKeyDown() then ChatEdit_InsertLink(frame.link) end
end

local function OnEvent(frame, event, rollID)
	cancelled_rolls[rollID] = true
	if frame.rollID ~= rollID then return end

	frame.rollID = nil
	frame.time = nil
	frame:Hide()
end

local function StatusUpdate(frame)
	if not frame.parent.rollID then return end
	local t = GetLootRollTimeLeft(frame.parent.rollID)
	local perc = t / frame.parent.time
	frame:SetValue(t)
	if t > 1000000000 then
		frame:GetParent():Hide()
	end
	frame.spark:SetPoint("CENTER", frame, "LEFT", perc * frame:GetWidth(), 0)
end

local function CreateRollButton(parent, ntex, ptex, htex, rolltype, tiptext, ...)
	local f = CreateFrame("Button", nil, parent)
	f:SetPoint(...)
	f:SetSize(28, 28)
	f:SetNormalTexture(ntex)
	if ptex then f:SetPushedTexture(ptex) end
	f:SetHighlightTexture(htex)
	f.rolltype = rolltype
	f.parent = parent
	f.tiptext = tiptext
	f:SetScript("OnEnter", SetTip)
	f:SetScript("OnLeave", HideTip)
	f:SetScript("OnClick", ClickRoll)
	f:SetMotionScriptsWhileDisabled(true)
	local txt = f:CreateFontString(nil, nil)
	txt:SetFont(DB.Font, 11*S.Scale(1), "THINOUTLINE")
	txt:SetPoint("CENTER", 0, rolltype == 2 and 1 or rolltype == 0 and -1.2 or 0)
	txt:SetShadowOffset(1,  -1)
	return f, txt
end

local function CreateRollFrame()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:Size(240, 8)
	frame:SetScript("OnEvent", OnEvent)
	frame:RegisterEvent("CANCEL_LOOT_ROLL")
	frame:Hide()

	local button = CreateFrame("Button", nil, frame)
	button:SetPoint("LEFT", -26, 9)
	button:Size(22)
	button:CreateShadow()
	button:SetScript("OnEnter", SetItemTip)
	button:SetScript("OnLeave", HideTip2)
	button:SetScript("OnUpdate", ItemOnUpdate)
	button:SetScript("OnClick", LootClick)
	frame.button = button

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetAllPoints()
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.icon.border = button.border
	
	local status = CreateFrame("StatusBar", nil, frame)
	status:CreateShadow()
	status:Size(240, 8)
	status:Point("BOTTOMLEFT", frame, "BOTTOMLEFT")
	status:SetScript("OnUpdate", StatusUpdate)
	status:SetFrameLevel(status:GetFrameLevel() - 1)
	status:SetStatusBarTexture(DB.Statusbar)
	status:SetStatusBarColor(0.8, 0.8, 0.8, 0.9)
	
	status.parent = frame
	frame.status = status
	frame.status.bg = status:GetStatusBarTexture()
	
	local spark = frame:CreateTexture(nil, "OVERLAY")
	spark:Width(14)
	spark:Height(20)
	spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	spark:SetBlendMode("ADD")
	status.spark = spark
	
	S.CreateBack(status)
	
			
	--local need, needtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Dice-Up", "Interface\\Buttons\\UI-GroupLoot-Dice-Highlight", "Interface\\Buttons\\UI-GroupLoot-Dice-Down", 1, NEED, "LEFT", frame.button, "RIGHT", 5, -1)
	--local greed, greedtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Coin-Up", "Interface\\Buttons\\UI-GroupLoot-Coin-Highlight", "Interface\\Buttons\\UI-GroupLoot-Coin-Down", 2, GREED, "LEFT", need, "RIGHT", 0, -1)
	--local de, detext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-DE-Up", "Interface\\Buttons\\UI-GroupLoot-DE-Highlight", "Interface\\Buttons\\UI-GroupLoot-DE-Down", 3, ROLL_DISENCHANT, "LEFT", greed, "RIGHT", 0, -1)
	--local pass, passtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Pass-Up", nil, "Interface\\Buttons\\UI-GroupLoot-Pass-Down", 0, PASS, "LEFT", de or greed, "RIGHT", 0, 2.2)
	local need, needtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Dice-Up", "Interface\\Buttons\\UI-GroupLoot-Dice-Highlight", "Interface\\Buttons\\UI-GroupLoot-Dice-Down", 1, NEED, "LEFT", frame.button, "RIGHT", S.Scale(5), S.Scale(-1))
	local greed, greedtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Coin-Up", "Interface\\Buttons\\UI-GroupLoot-Coin-Highlight", "Interface\\Buttons\\UI-GroupLoot-Coin-Down", 2, GREED, "LEFT", need, "RIGHT", 0, 0)
	local de, detext
	de, detext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-DE-Up", "Interface\\Buttons\\UI-GroupLoot-DE-Highlight", "Interface\\Buttons\\UI-GroupLoot-DE-Down", 3, ROLL_DISENCHANT, "LEFT", greed, "RIGHT", 0, 0)
	local pass, passtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Pass-Up", nil, "Interface\\Buttons\\UI-GroupLoot-Pass-Down", 0, PASS, "BOTTOMLEFT", frame, "BOTTOMRIGHT", S.Scale(2.2), 0)
	frame.needbutt, frame.greedbutt, frame.disenchantbutt = need, greed, de
	frame.need, frame.greed, frame.pass, frame.disenchant = needtext, greedtext, passtext, detext

	local bind = frame:CreateFontString()
	bind:SetPoint("LEFT", de or greed, "RIGHT", S.Scale(3), S.Scale(1))
	bind:SetFont(DB.Font, 11*S.Scale(1), "THINOUTLINE")
	bind:SetShadowOffset(1,  -1)
	frame.fsbind = bind

	local loot = frame:CreateFontString(nil, "ARTWORK")
	loot:SetFont(DB.Font, 12*S.Scale(1), "OUTLINE")
	loot:SetShadowOffset(1, -1)
	loot:Point("LEFT", bind, "RIGHT", 0, 0)
	loot:Point("RIGHT", frame, "RIGHT", -5, 0)
	loot:Size(200, 10)
	loot:SetJustifyH("LEFT")
	frame.fsloot = loot

	frame.rolls = {}

	return frame
end

local function GetFrame()
	for i, f in ipairs(frames) do
		if not f.rollID then return f end
	end

	local f = CreateRollFrame()
	if pos == "TOP" then
		f:Point("TOPLEFT", next(frames) and frames[#frames] or LootRollAnchor, "BOTTOMLEFT", next(frames) and frames[#frames] and 0 or 27, -23)
	else
		f:Point("BOTTOMLEFT", next(frames) and frames[#frames] or LootRollAnchor, "TOPLEFT", next(frames) and frames[#frames] and 0 or 27, 23)
	end
	table.insert(frames, f)
	return f
end

local function START_LOOT_ROLL(rollID, time)
	if cancelled_rolls[rollID] then return end

	local f = GetFrame()
	f.rollID = rollID
	f.time = time
	for i in pairs(f.rolls) do f.rolls[i] = nil end
	f.need:SetText(0)
	f.greed:SetText(0)
	f.pass:SetText(0)
	f.disenchant:SetText(0)

	local texture, name, count, quality, bop, canNeed, canGreed, canDisenchant = GetLootRollItemInfo(rollID)
	f.button.icon:SetTexture(texture)
	f.button.link = GetLootRollItemLink(rollID)

	if canNeed then f.needbutt:Enable() else f.needbutt:Disable() end
	if canGreed then f.greedbutt:Enable() else f.greedbutt:Disable() end
	if canDisenchant then f.disenchantbutt:Enable() else f.disenchantbutt:Disable() end
	SetDesaturation(f.needbutt:GetNormalTexture(), not canNeed)
	SetDesaturation(f.greedbutt:GetNormalTexture(), not canGreed)
	SetDesaturation(f.disenchantbutt:GetNormalTexture(), not canDisenchant)
	if canNeed then f.needbutt:SetAlpha(1) else f.needbutt:SetAlpha(0.2) end
	if canGreed then f.greedbutt:SetAlpha(1) else f.greedbutt:SetAlpha(0.2) end
	if canDisenchant then f.disenchantbutt:SetAlpha(1) else f.disenchantbutt:SetAlpha(0.2) end

	f.fsbind:SetText(bop and "BoP" or "BoE")
	f.fsbind:SetVertexColor(bop and 1 or 0.3, bop and 0.3 or 1, bop and 0.1 or 0.3)

	local color = ITEM_QUALITY_COLORS[quality]
	f.fsloot:SetText(name)
	f.status:SetStatusBarColor(color.r, color.g, color.b, 0.7)
	f.button.icon.border:SetBackdropBorderColor(color.r, color.g, color.b, 0.7)
	S.CreateTop(f.status.bg, color.r, color.g, color.b)
	f.status:SetMinMaxValues(0, time)
	f.status:SetValue(time)

	f:Point("CENTER", WorldFrame, "CENTER")
	f:Show()
end

local function LOOT_HISTORY_ROLL_CHANGED(itemIdx, playerIdx)
	local rollID, itemLink, numPlayers, isDone, winnerIdx, isMasterLoot = C_LootHistory.GetItem(itemIdx)
	local name, class, rollType, roll, isWinner = C_LootHistory.GetPlayerInfo(itemIdx, playerIdx)

	if name and rollType then
		for _, f in ipairs(frames) do
			if f.rollID == rollID then
				f.rolls[name] = rollType
				f[rolltypes[rollType]]:SetText(tonumber(f[rolltypes[rollType]]:GetText()) + 1)
				return
			end
		end
	end
end

LootRollAnchor:RegisterEvent("ADDON_LOADED")
LootRollAnchor:SetScript("OnEvent", function(frame, event, addon)
	if addon == "SunUI" then 
		LootRollAnchor:Size(240, 20)
		LootRollAnchor:UnregisterEvent("ADDON_LOADED")
		LootRollAnchor:RegisterEvent("LOOT_HISTORY_ROLL_CHANGED")
		LootRollAnchor:RegisterEvent("START_LOOT_ROLL")
		UIParent:UnregisterEvent("START_LOOT_ROLL")
		UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")

		LootRollAnchor:SetScript("OnEvent", function(frame, event, ...) if event == "LOOT_HISTORY_ROLL_CHANGED" then return LOOT_HISTORY_ROLL_CHANGED(...) else return START_LOOT_ROLL(...) end end)
		MoveHandle.RollFrame = S.MakeMoveHandle(LootRollAnchor, "Roll", "RollFrame")
		SlashCmdList["LFrames"] = function(msg) 
			local f = GetFrame()
			local texture = select(10, GetItemInfo(32837))
			f.button:SetNormalTexture(texture)
			f.button:GetNormalTexture():SetTexCoord(.1, .9, .1, .9)
			f.fsloot:SetVertexColor(ITEM_QUALITY_COLORS[5].r, ITEM_QUALITY_COLORS[5].g, ITEM_QUALITY_COLORS[5].b)
			f.fsloot:SetText(GetItemInfo(32837))
			f.status:SetMinMaxValues(0, 100)
			f.status:SetValue(70)
			f.status:SetStatusBarColor(ITEM_QUALITY_COLORS[5].r, ITEM_QUALITY_COLORS[5].g, ITEM_QUALITY_COLORS[5].b)
			f:Show()
		end
		SLASH_LFrames1 = "/rolltest"
	end
end)