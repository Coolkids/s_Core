﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local MM = S:GetModule("MAP")
local MBCF
local buttons = {}
local List = {
	["BagSync_MinimapButton"] = true,
}
function MM:PositionButtonCollector(self, screenQuadrant)
	local line = math.ceil(Minimap:GetWidth() / 20)
	-- MBCF.bg:SetTexture(0, 0, 0, 1)
	MBCF:SetAlpha(0)
	MBCF:ClearAllPoints()
	screenQuadrant = screenQuadrant or S:GetScreenQuadrant(self)
	for i =1, #buttons do
		buttons[i]:ClearAllPoints()
		if i == 1 then
			buttons[i]:SetPoint("TOP", MBCF, "TOP", 0, 0)
		elseif i%line == 1 then
			if strfind(screenQuadrant, "RIGHT") then
				buttons[i]:SetPoint("TOPRIGHT", buttons[i-line], "TOPLEFT", -1, 0)
			else
				buttons[i]:SetPoint("TOPLEFT", buttons[i-line], "TOPRIGHT", 1, 0)
			end
		else
			buttons[i]:SetPoint("TOP", buttons[i-1], "BOTTOM", 0, -1)
		end
		buttons[i].ClearAllPoints = S.dummy
		buttons[i].SetPoint = S.dummy
	end
	if strfind(screenQuadrant, "RIGHT") then
		MBCF:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -5, 2)
	else
		MBCF:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 5, 2)
	end
end

function MM:initCollector()
	local BlackList = { 
		["MiniMapTracking"] = true,
		["MiniMapVoiceChatFrame"] = true,
		["MiniMapWorldMapButton"] = true,
		["MiniMapLFGFrame"] = true,
		["MinimapZoomIn"] = true,
		["MinimapZoomOut"] = true,
		["MiniMapMailFrame"] = true,
		["BattlefieldMinimap"] = true,
		["MinimapBackdrop"] = true,
		["GameTimeFrame"] = true,
		["TimeManagerClockButton"] = true,
		["FeedbackUIButton"] = true,
		["HelpOpenTicketButton"] = true,
		["MiniMapBattlefieldFrame"] = true,
	}

	MBCF = CreateFrame("Frame", "MinimapButtonCollectFrame", UIParent)
	if select(3, Minimap:GetPoint()):upper():find("TOP") then
		MBCF:SetPoint("BOTTOMLEFT", Minimap, "TOPLEFT", 0, 5)
	else
		MBCF:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -5)
	end
	MBCF:SetSize(20, 150)
	MBCF:SetFrameStrata("BACKGROUND")
	MBCF:SetFrameLevel(4)
	-- MBCF.bg = MBCF:CreateTexture(nil, "BACKGROUND")
	-- MBCF.bg:SetAllPoints(MBCF)
	-- MBCF.bg:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 0, 0, 0, .6)


	local MinimapButtonCollect = CreateFrame("Frame")
	MinimapButtonCollect:RegisterEvent("PLAYER_ENTERING_WORLD")
	MinimapButtonCollect:SetScript("OnEvent", function(self)
		for i, child in ipairs({Minimap:GetChildren()}) do
			if child:GetName() and not BlackList[child:GetName()] then
				if child:GetObjectType() == "Button" and child:GetNumRegions() >= 3 then
					child:SetParent("MinimapButtonCollectFrame")
					for j = 1, child:GetNumRegions() do
						local region = select(j, child:GetRegions())
						if region:GetObjectType() == "Texture" then
							local texture = region:GetTexture()
							if texture == "Interface\\Minimap\\MiniMap-TrackingBorder" or texture == "Interface\\Minimap\\UI-Minimap-Background" or texture == "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" then
								region:Kill()
							end
						end
					end
					tinsert(buttons, child)
				end
			end
		end
		for k,v in pairs(List) do
			if _G[k] then 
				tinsert(buttons, _G[k])
				_G[k]:SetParent("MinimapButtonCollectFrame")
			end
		end
		if #buttons == 0 then 
			MBCF:Hide() 
		else
			for _, child in ipairs(buttons) do
				child:HookScript("OnEnter", function()
					UIFrameFadeIn(MBCF, .5, MBCF:GetAlpha(), 1)
				end)
				child:HookScript("OnLeave", function()
					UIFrameFadeOut(MBCF, .5, MBCF:GetAlpha(), 0)
				end)
			end
		end
		MM:PositionButtonCollector(Minimap)
	end)

	MBCF:SetScript("OnEnter", function(self)
		UIFrameFadeIn(self, .5, self:GetAlpha(), 1)
	end)

	Minimap:HookScript("OnEnter", function()
		UIFrameFadeIn(MBCF, .5, MBCF:GetAlpha(), 1)
	end)

	MBCF:SetScript("OnLeave", function(self)
		UIFrameFadeOut(self, .5, self:GetAlpha(), 0)
	end)

	Minimap:HookScript("OnLeave", function()
		UIFrameFadeOut(MBCF, .5, MBCF:GetAlpha(), 0)
	end)
end
