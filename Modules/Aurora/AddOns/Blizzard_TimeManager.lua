local S, L, DB, _, C = unpack(select(2, ...))
local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
local F = S
local C = DB
DB.AuroraModules["Blizzard_TimeManager"] = function()
	TimeManagerGlobe:Hide()
	StopwatchFrameBackgroundLeft:Hide()
	select(2, StopwatchFrame:GetRegions()):Hide()
	StopwatchTabFrameLeft:Hide()
	StopwatchTabFrameMiddle:Hide()
	StopwatchTabFrameRight:Hide()

	TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
	TimeManagerStopwatchCheck:SetCheckedTexture(C.media.checked)
	F.CreateBG(TimeManagerStopwatchCheck)

	TimeManagerAlarmHourDropDown:SetWidth(80)
	TimeManagerAlarmMinuteDropDown:SetWidth(80)
	TimeManagerAlarmAMPMDropDown:SetWidth(90)

	F.ReskinPortraitFrame(TimeManagerFrame, true)
	select(9, TimeManagerFrame:GetChildren()):Hide()

	F.CreateBD(StopwatchFrame)
	F.ReskinDropDown(TimeManagerAlarmHourDropDown)
	F.ReskinDropDown(TimeManagerAlarmMinuteDropDown)
	F.ReskinDropDown(TimeManagerAlarmAMPMDropDown)
	F.ReskinInput(TimeManagerAlarmMessageEditBox)
	F.ReskinCheck(TimeManagerAlarmEnabledButton)
	F.ReskinCheck(TimeManagerMilitaryTimeCheck)
	F.ReskinCheck(TimeManagerLocalTimeCheck)
	F.ReskinClose(StopwatchCloseButton, "TOPRIGHT", StopwatchFrame, "TOPRIGHT", -2, -2)
end