﻿local S, C, L, DB = unpack(select(2, ...))
local Module = LibStub("AceAddon-3.0"):GetAddon("Core"):NewModule("ClassCD")
if DB.ClassCDOpen ~= true then return end

----------------------------------------------------------------------------------------
--	职业被动技能,饰品,附魔内置CD
--  Modify by Ljxx.net at 2011.10.15
----------------------------------------------------------------------------------------
local show = {
	raid = true,
	party = true,
	arena = true,
	none = true,
}

local class_spells = {
	[47755] = 12, --狂喜
	[96171] = 45, --大墓地的意志
	[81094] = 12, --XD 新生
	[87023] = 60, --FS 炙灼
	[96263] = 60, --崇圣护盾
	--饰品 数据来源于ExtraCD
	[89091] = 45, --火山毁灭
	[101289]= 50, --石化卤蛋
	[101291]= 50, --密银秒表
	[101287]= 50, --科林的冰冻铬银杯垫

-- Cataclysm 4.3
	-- Kiril, Fury of Beasts
	[109864] = 60, -- H
	[108011] = 60, -- N
	[109861] = 60, -- LFR
	-- Creche of the Final Dragon
	[109744] = 100, -- H
	[107988] = 100, -- N
	[109742] = 100, -- LFR
	-- Cunning of the Cruel
	[109800] = 30, -- H
	[108005] = 30, -- N
	[109798] = 30, -- LFR
	-- Indomitable Pride
	[109786] = 60, -- H
	[108007] = 60, -- N
	[109785] = 60, -- LFR
	-- Insignia of the Corrupted Mind
	[109789] = 100, -- H
	[107892] = 100, -- N
	[109787] = 100, -- LFR
	-- Seal of the Seven Signs
	[109804] = 100, -- H
	[107982] = 100, -- N
	[109802] = 100, -- LFR
	-- Soulshifter Vortex
	[109776] = 100, -- H
	[107986] = 100, -- N
	[109774] = 100, -- LFR
	-- Starcatcher Compass
	[109711] = 100, -- H
	[107982] = 100, -- N
	[109709] = 100, -- LFR
	-- Windward Heart
	[109825] = 25, -- H
	[108000] = 25, -- N
	[109822] = 25, -- LFR
	
	-- Bone-Link Fetish
	[109754] = 25, -- H
	[107997] = 25, -- N
	[109752] = 25, -- LFR
	-- Cunning of the Cruel
	[109800] = 25, -- H
	[108005] = 25, -- N
	[109798] = 25, -- LFR
	-- Vial of Shadows
	[109724] = 25, -- H
	[107994] = 25, -- N
	[109721] = 25, -- LFR
	-- S11 PVP
	[105135] = 50,
	[105137] = 50,
	[105139] = 50,
		
	[102439] = 50,
	[102435] = 50,
	[102432] = 50,
		
	-- 378 others
	[102659] = 50,
	[102662] = 50,
	[102664] = 50,
		
	[109993] = 50,
	[102660] = 50,
	[102667] = 50,	

	--4.2
	[97139] = 105, --矩阵回稳器H
	[97140] = 105,
	[97141] = 105,
	[96978] = 105, --矩阵回稳器
	[96977] = 105,
	[96979] = 105,
	[97129] = 60, --蛛丝纺锤H
	[96945] = 60, --蛛丝纺锤
	[97125] = 60, --饥不择食H
	[96911] = 60, --饥不择食
	[100322]= 45, --杜耶尔的重棍
	[91192] = 50, --激越曼陀罗坠石
	[91047] = 75, --时光的残枝
	[92233] = 30, --基岩护符
	
	[92320] = 90, --瑟纳利昂之镜H
	[92355] = 30, --共生之虫H
	[92349] = 75, --普瑞斯托的诡计护符H
	[92345] = 100, --狂怒之心H
	[92332] = 75, --生命之殒H
	[92351] = 50, --气旋精华H
	[92342] = 75, --压顶之力H
	[92318] = 100, --狂怒鸣响之铃H
		
	[92108] = 50, -- 无闻之兆
	[91024] = 90, -- 瑟纳利昂之镜
	[92235] = 30, -- 共生之虫
	[92124] = 75, -- 普瑞斯托的诡计护符
	[91816] = 100, -- 狂怒之心
	[91184] = 75, -- 生命之殒
	[92126] = 50, -- 气旋精华
	[91821] = 75, -- 压顶之力
	[91007] = 100, -- 狂怒鸣响之铃
	
	[97136] = 45, --炽焰能量之眼H (治疗)
	[96966] = 45, --炽焰能量之眼
	
	-- FM_CTM
	[74241] = 45, -- 能量洪流
	[74221] = 45, -- 飓风
	[74224] = 20, -- 心灵之歌
	[75173] = 50, -- 黑光
	[75170] = 65, -- 亮纹
	[75176] = 55, -- 剑刃刺绣
	-- FM WLK
	[55637] = 45, -- 亮纹
	[55775] = 45, -- 剑刃刺绣
	[55767] = 45,	-- 黑光
	[59626] = 35, -- 黑魔法	
	
	
}

local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
local band = bit.band
local sformat = string.format
local floor = math.floor
local timer = 0
local bars = {}
function Module:OnInitialize()
C=MoveHandleDB

local ClassCDAnchor = CreateFrame("Frame", "ClassCDAnchor", UIParent)

ClassCDAnchor:SetSize(140, 20)

ClassCDAnchor:SetPoint(unpack(C["ClassCD"]))
end
local FormatTime = function(time)
	if time >= 60 then
		return sformat("%.2d:%.2d", floor(time / 60), time % 60)
	else
		return sformat("%.2d", time)
	end
end

local CreateFS = function(frame, fsize, fstyle)
	local fstring = frame:CreateFontString(nil, "OVERLAY")
	fstring:SetFont(DB.Font, 15, "OUTLINE")
	return fstring
end

local UpdatePositions = function()
	for i = 1, #bars do
		bars[i]:ClearAllPoints()
		if i == 1 then
			bars[i]:SetPoint("TOPLEFT", ClassCDAnchor, "TOPLEFT", 26, 0)
		else
			if DB.ClassCDDirection == "up" then
				bars[i]:SetPoint("BOTTOMLEFT", bars[i-1], "TOPLEFT", 0, 5)
			else
				bars[i]:SetPoint("TOPLEFT", bars[i-1], "BOTTOMLEFT", 0, -5)
			end
		end
		bars[i].id = i
	end
end

local StopTimer = function(bar)
	bar:SetScript("OnUpdate", nil)
	bar:Hide()
	tremove(bars, bar.id)
	UpdatePositions()
end

local BarUpdate = function(self, elapsed)
	local curTime = GetTime()
	if self.endTime < curTime then
		StopTimer(self)
		return
	end
	self:SetValue(100 - (curTime - self.startTime) / (self.endTime - self.startTime) * 100)
	self.right:SetText(FormatTime(self.endTime - curTime))
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddDoubleLine(self.spell, self.right:GetText())
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
		if GetRealNumRaidMembers() > 0 then
			SendChatMessage(sformat("冷卻計時".." %s: %s", self.left:GetText(), self.right:GetText()), "RAID")
		elseif GetRealNumPartyMembers() > 0 and not UnitInRaid("player") then
			SendChatMessage(sformat("冷卻計時".." %s: %s", self.left:GetText(), self.right:GetText()), "PARTY")
		else
			SendChatMessage(sformat("冷卻計時".." %s: %s", self.left:GetText(), self.right:GetText()), "SAY")
		end
	elseif button == "RightButton" then
		StopTimer(self)
	end
end

local CreateBar = function()
	local bar = CreateFrame("Statusbar", nil, UIParent)
	bar:SetFrameStrata("LOW")
	bar:SetSize(140, 20)
	bar:SetStatusBarTexture(DB.Statusbar)
	bar:SetMinMaxValues(0, 100)
    
	bar.backdrop = CreateFrame("Frame", nil, bar)
	bar.backdrop:SetPoint("TOPLEFT", -2, 2)
	bar.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	bar.backdrop:SetFrameStrata("BACKGROUND")
	bar.backdrop:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\AddOns\\s_Core\\Media\\glowTex", edgeSize = 3,
	insets = {top = 3, left = 3, bottom = 3, right = 3},
    })
	bar.backdrop:SetBackdropColor(0, 0, 0, 0.2)
    bar.backdrop:SetBackdropBorderColor(0, 0, 0)
	
	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(DB.Statusbar)
	
	bar.left = CreateFS(bar)
	bar.left:SetPoint("LEFT", 2, 0)
	bar.left:SetJustifyH("LEFT")
	bar.left:SetSize(140, 20)

	bar.right = CreateFS(bar)
	bar.right:SetPoint("RIGHT", 1, 0)
	bar.right:SetJustifyH("RIGHT")

	bar.icon = CreateFrame("Button", nil, bar)
	bar.icon:SetWidth(20)
	bar.icon:SetHeight(20)
	bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -6, 0)
	S.MakeShadow(bar.icon, 3)
	bar.icon.backdrop = CreateFrame("Frame", nil, bar.icon)
	bar.icon.backdrop:SetPoint("TOPLEFT", -2, 2)
	bar.icon.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	bar.icon.backdrop:SetFrameStrata("BACKGROUND")
    S.MakeShadow(bar, 3)
	return bar
end

local StartTimer = function(name, spellId)
	local bar = CreateBar()
	local spell, rank, icon = GetSpellInfo(spellId)
	bar.endTime = GetTime() + class_spells[spellId]
	bar.startTime = GetTime()
	bar.left:SetText(spell)
	bar.right:SetText(FormatTime(class_spells[spellId]))
	bar.icon:SetNormalTexture(icon)
	bar.icon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bar.spell = spell
	bar:Show()
	local color = RAID_CLASS_COLORS[select(2, UnitClass(name))]
	if color then
		bar:SetStatusBarColor(color.r, color.g, color.b)
		bar.bg:SetVertexColor(color.r, color.g, color.b, 0.25)
	else
		bar:SetStatusBarColor(0.3, 0.7, 0.3)
		bar.bg:SetVertexColor(0.3, 0.7, 0.3, 0.25)
	end
	bar:SetScript("OnUpdate", BarUpdate)
	bar:EnableMouse(true)
	bar:SetScript("OnEnter", OnEnter)
	bar:SetScript("OnLeave", OnLeave)
	bar:SetScript("OnMouseDown", OnMouseDown)
	tinsert(bars, bar)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, _, sourceName, sourceFlags = ...
		
		if band(sourceFlags, filter) == 0 then return end
		local spellId = select(12, ...)
		if class_spells[spellId] and show[select(2, IsInInstance())] then
			if eventType == "SPELL_RESURRECT" and not spellId == 61999 then
				if spellId == 95750 then spellId = 6203 end
				StartTimer(sourceName, spellId)
			elseif eventType == "SPELL_AURA_APPLIED" then
				if spellId == 20707 then
					local _, class = UnitClass(sourceName)
					if class == "WARLOCK" then
						StartTimer(sourceName, spellId)
					end
				end
				if sourceName == DB.PlayerName then
					StartTimer(sourceName, spellId)
				end				
			elseif eventType == "SPELL_CAST_SUCCESS" then
				StartTimer(sourceName, spellId)
			elseif eventType == "SPELL_ENERGIZE" then
				if sourceName == DB.PlayerName and spellId == 47755 then
					StartTimer(sourceName, spellId)
				end
				if sourceName == DB.PlayerName and spellId == 81094 then
					StartTimer(sourceName, spellId)
				end
			elseif eventType == "SPELL_HEAL" then
				if sourceName == DB.PlayerName and (spellId == 87023 or spellId == 97136 or spellId == 96966) then
					StartTimer(sourceName, spellId)
				end
			end

		end
	elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) == "arena" then
		for k, v in pairs(bars) do
			StopTimer(v)
		end
	end
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList.ClassCD = function(msg)
	StartTimer(UnitName("player"), 47755)
	StartTimer(UnitName("player"), 96171)
end
SLASH_ClassCD1 = "/classcd"