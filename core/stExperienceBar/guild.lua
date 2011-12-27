﻿-- Config ----------------
--------------------------
--Bar Height and Width
local barHeight, barWidth = 12, stExperienceBar_Frame:GetWidth()

--Where you want the fame to be anchored
--------AnchorPoint, AnchorTo, RelativePoint, xOffset, yOffset
local Anchor = { "TOP", stExperienceBar_Frame, "BOTTOM", 0, -4}

--Textures
local barTex = [[Interface\Addons\S_core\media\Flat.tga]]
local flatTex = [[Interface\Addons\S_core\media\Flat.tga]]

-----------------------------------------------------------
-- Don't edit past here unless you know what your doing! --
-----------------------------------------------------------
--Prefix for naming frames
local aName = "stExperienceBar_Guild_"

--Create Background and Border
local Frame = CreateFrame("Frame", aName.."Frame", UIParent)
Frame:SetHeight(barHeight)
Frame:SetWidth(barWidth)
Frame:SetPoint(unpack(Anchor))

local xpBorder = CreateFrame("frame", aName.."xpBorder", Frame)
xpBorder:SetHeight(barHeight)
xpBorder:SetWidth(barWidth)
xpBorder:SetPoint("TOP", Frame, "TOP", 0, 0)
xpBorder:SetBackdrop({
	bgFile = barTex, 
	edgeFile = barTex, 
	tile = false, tileSize = 0, edgeSize = 1, 
	insets = { left = -1, right = -1, top = -1, bottom = -1}
})
xpBorder:SetBackdropColor(0, 0, 0)
xpBorder:SetBackdropBorderColor(.2, .2, .2, 1)

xpOverlay = xpBorder:CreateTexture(nil, "BORDER", Frame)
xpOverlay:ClearAllPoints()
xpOverlay:SetPoint("TOPLEFT", xpBorder, "TOPLEFT", 2, -2)
xpOverlay:SetPoint("BOTTOMRIGHT", xpBorder, "BOTTOMRIGHT", -2, 2)
xpOverlay:SetTexture(barTex)
xpOverlay:SetVertexColor(.1,.1,.1)

--Create xp status bar
local xpBar = CreateFrame("StatusBar",  aName.."xpBar", xpBorder, "TextStatusBar")
--xpBar:SetWidth(barWidth-4)
--xpBar:SetHeight(barHeight-4)
xpBar:SetPoint("TOPRIGHT", xpBorder,"TOPRIGHT", -2, -2)
xpBar:SetPoint("BOTTOMLEFT", xpBorder,"BOTTOMLEFT", 2, 2)
xpBar:SetStatusBarTexture(barTex)
xpBar:SetStatusBarColor(.5, 0, .75)

local dailyxpBar = CreateFrame("StatusBar",  aName.."dailyxpBar", xpBorder, "TextStatusBar")
--dailyxpBar:SetWidth(barWidth-4)
--dailyxpBar:SetHeight(barHeight-4)
dailyxpBar:SetPoint("TOPRIGHT", xpBorder,"TOPRIGHT", -2, -2)
dailyxpBar:SetPoint("BOTTOMLEFT", xpBorder,"BOTTOMLEFT", 2, 2)
dailyxpBar:SetStatusBarTexture(barTex)
dailyxpBar:SetStatusBarColor(50/255, 0, 70/255)

--Create reputation status bar
local repBorder = CreateFrame("frame", aName.."repBorder", Frame)
repBorder:SetHeight(5)
repBorder:SetWidth(Frame:GetWidth())
repBorder:SetPoint("BOTTOM", Frame, "BOTTOM", 0, 0)
repBorder:SetBackdrop({
	bgFile = barTex, 
	edgeFile = barTex, 
	tile = false, tileSize = 0, edgeSize = 1, 
	insets = { left = -1, right = -1, top = -1, bottom = -1}
})
repBorder:SetBackdropColor(0, 0, 0)
repBorder:SetBackdropBorderColor(.2, .2, .2, 1)

local repOverlay = repBorder:CreateTexture(nil, "BORDER", Frame)
repOverlay:ClearAllPoints()
repOverlay:SetPoint("TOPLEFT", repBorder, "TOPLEFT", 2, -2)
repOverlay:SetPoint("BOTTOMRIGHT", repBorder, "BOTTOMRIGHT", -2, 2)
repOverlay:SetTexture(barTex)
repOverlay:SetVertexColor(.1,.1,.1)

local repBar = CreateFrame("StatusBar", aName.."repBar", repBorder, "TextStatusBar")
--repBar:SetWidth(barWidth-4)
--repBar:SetHeight(st.IsMaxLevel() and barHeight-4 or 2)
repBar:SetPoint("TOPRIGHT", repBorder, "TOPRIGHT", -2, -2)
repBar:SetPoint("BOTTOMLEFT", repBorder, "BOTTOMLEFT", 2, 2)
repBar:SetStatusBarTexture(barTex)

--Create frame used for mouseover, clicks, and text
local mouseFrame = CreateFrame("Frame", aName.."mouseFrame", Frame)
mouseFrame:SetAllPoints(Frame)
mouseFrame:EnableMouse(true)

--Set all frame levels (easier to see if organized this way)
Frame:SetFrameLevel(0)
xpBorder:SetFrameLevel(0)
repBorder:SetFrameLevel(0)
dailyxpBar:SetFrameLevel(1)
xpBar:SetFrameLevel(2)
repBar:SetFrameLevel(2)
mouseFrame:SetFrameLevel(3)

local function updateStatus()
	if not IsAddOnLoaded("Blizzard_GuildUI") then LoadAddOn("Blizzard_GuildUI") end
	if not IsInGuild() then
		if Frame:IsShown() then Frame:Hide() end
	else
		local XP, remXP, dailyXP, dailymaxXP = UnitGetGuildXP("player")
		xpBar:SetMinMaxValues(min(0, XP), XP+remXP)
		xpBar:SetValue(XP)
		
		dailyxpBar:SetMinMaxValues(min(0, XP), XP+remXP)
		dailyxpBar:SetValue(XP+dailymaxXP-dailyXP)		
		
		for i=1,GetNumFactions() do
			local name, _, rank, minRep, maxRep, value = GetFactionInfo(i)
			local guildname = GetGuildInfo("player")
			if name == guildname then				
				repBar:SetMinMaxValues(minRep, maxRep)
				repBar:SetValue(value)
				repBar:SetStatusBarColor(unpack(st.FactionInfo[rank][1]))
				
				if rank ~= 8 then
					xpBorder:SetHeight(barHeight-(repBorder:GetHeight()-1))
				else
					if GetGuildLevel() == MAX_GUILD_LEVEL then
						if Frame:IsShown() then Frame:Hide() end
					else
						if not Frame:IsShown() then Frame:Show() end
						xpBorder:SetHeight(barHeight)
					end
				end				
			end
		end
		
		--Setup Exp Tooltip
		mouseFrame:SetScript("OnEnter", function()
			if mouseoverText == true then
				Text:SetAlpha(1)
			end
			GameTooltip:SetOwner(mouseFrame, "ANCHOR_BOTTOMLEFT", -3, barHeight)
			GameTooltip:ClearLines()
			if not st.GuildIsMaxLevel() then
				GameTooltip:AddLine(GetGuildInfo("player").."工會經驗:")
				GameTooltip:AddLine(string.format('等級: %s',UnitGetGuildLevel("player")))
				GameTooltip:AddLine(string.format('經驗: %s/%s (%d%%)', st.ShortValue(XP), st.ShortValue(remXP+XP), (XP/(remXP+XP))*100))
				GameTooltip:AddLine(string.format('剩餘: %s', st.ShortValue(remXP)))
				GameTooltip:AddLine(string.format('每日經驗: %s/%s', st.ShortValue(dailyXP), st.ShortValue(dailymaxXP)))
				GameTooltip:AddLine(" ")
			end
			for i=1,GetNumFactions() do
				if select(1, GetGuildInfo("player")) == select(1, GetFactionInfo(i)) then
					local name, _, rank, minRep, maxRep, value = GetFactionInfo(i)
					GameTooltip:AddLine(string.format('在 %s 的聲望:', name))
					GameTooltip:AddLine(string.format('狀態: |c'..st.Colorize(rank)..'%s|r', st.FactionInfo[rank][2]))
					GameTooltip:AddLine(string.format('聲望值: %s/%s (%d%%)', st.CommaValue(value-minRep), st.CommaValue(maxRep-minRep), (value-minRep)/(maxRep-minRep)*100))
					GameTooltip:AddLine(string.format('剩餘: %s', st.CommaValue(maxRep-value)))
				end
			end
			
			GameTooltip:Show()
		end)
		mouseFrame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if mouseoverText == true then
				Text:SetAlpha(0)
			end
		end)
	end
end

function GuildXPBar_SetProgress(currentValue, maxValue, capValue)
	local MAX_BAR = GuildXPBar:GetWidth() - 4;
	local progress = min(MAX_BAR * currentValue / maxValue, MAX_BAR);
	
	GuildXPBarProgress:SetWidth(progress + 1);
	if ( capValue + currentValue > maxValue ) then
		capValue = maxValue - currentValue;
	end
	local capWidth = MAX_BAR * capValue / maxValue;
	if ( capWidth > 0 ) then
		GuildXPBarCap:SetWidth(capWidth);
		GuildXPBarCap:Show();
		GuildXPBarCapMarker:Show();
	else
		GuildXPBarCap:Hide();
		GuildXPBarCapMarker:Hide();
	end
	currentValue = TextStatusBar_CapDisplayOfNumericValue(currentValue);
	maxValue = TextStatusBar_CapDisplayOfNumericValue(maxValue);
	--GuildXPBarText:SetText(currentValue.."/"..maxValue);
end


-- Event Stuff -----------
--------------------------
local frame = CreateFrame("Frame",nil,UIParent)
--Event handling
frame:RegisterEvent("GUILD_XP_UPDATE")
frame:RegisterEvent("GUILD_PERK_UPDATE")
frame:RegisterEvent("CHAT_MSG_COMBAT_GUILD_XP_GAIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", updateStatus)