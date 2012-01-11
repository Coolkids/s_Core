local function SetChatFrame()
	FCF_SetLocked(ChatFrame1, nil)
	FCF_SetChatWindowFontSize(self, ChatFrame1, 11) 
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMLEFT", 5, 25)
	ChatFrame1:SetWidth(460)
	ChatFrame1:SetHeight(200)
	ChatFrame1:SetUserPlaced(true)
	for i = 1,10 do FCF_SetWindowAlpha(_G["ChatFrame"..i], 0) end
	FCF_SavePositionAndDimensions(ChatFrame1)
	FCF_SetLocked(ChatFrame1, 1)
end
local function SetUIScale()
	SetCVar("useUiScale", 1)
	SetCVar("uiScale", 0.69999998807907)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 3.4)
end
SlashCmdList["AutoSet"] = function()
	if not UnitAffectingCombat("player") then
		SetUIScale()
	end
end
SLASH_AutoSet1 = "/AutoSet"