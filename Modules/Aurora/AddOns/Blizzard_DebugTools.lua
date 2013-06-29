local S, L, DB, _, C = unpack(select(2, ...))
local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
local F = S
local C = DB
DB.AuroraModules["Blizzard_DebugTools"] = function()
		ScriptErrorsFrame:SetScale(UIParent:GetScale())
		ScriptErrorsFrame:SetSize(386, 274)
		ScriptErrorsFrame:DisableDrawLayer("OVERLAY")
		ScriptErrorsFrameTitleBG:Hide()
		ScriptErrorsFrameDialogBG:Hide()
		F.CreateBD(ScriptErrorsFrame)
		F.CreateSD(ScriptErrorsFrame)

		FrameStackTooltip:SetScale(UIParent:GetScale())
		FrameStackTooltip:SetBackdrop(nil)

		local bg = CreateFrame("Frame", nil, FrameStackTooltip)
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
		bg:SetFrameLevel(FrameStackTooltip:GetFrameLevel()-1)
		F.CreateBD(bg, .6)

		F.ReskinClose(ScriptErrorsFrameClose)
		F.ReskinScroll(ScriptErrorsFrameScrollFrameScrollBar)
		F.Reskin(select(4, ScriptErrorsFrame:GetChildren()))
		F.Reskin(select(5, ScriptErrorsFrame:GetChildren()))
		F.Reskin(select(6, ScriptErrorsFrame:GetChildren()))
end