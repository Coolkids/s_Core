local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")

local function LoadSkin()
	ScriptErrorsFrame:SetParent(UIParent)
	ScriptErrorsFrame:SetSize(386, 274)
	ScriptErrorsFrame:DisableDrawLayer("OVERLAY")
	ScriptErrorsFrameTitleBG:Hide()
	ScriptErrorsFrameDialogBG:Hide()
	A:CreateBD(ScriptErrorsFrame)
	A:CreateSD(ScriptErrorsFrame)

	A:CreateBD(EventTraceFrame)
	A:CreateSD(EventTraceFrame)
	A:ReskinClose(EventTraceFrameCloseButton)
	select(1, EventTraceFrameScroll:GetRegions()):Hide()
	local bu = select(2, EventTraceFrameScroll:GetRegions())
	bu:SetAlpha(0)
	bu:Width(17)

	bu.bg = CreateFrame("Frame", nil, EventTraceFrame)
	bu.bg:Point("TOPLEFT", bu, 0, 0)
	bu.bg:Point("BOTTOMRIGHT", bu, 0, 0)
	A:CreateBD(bu.bg, 0)

	local tex = EventTraceFrame:CreateTexture(nil, "BACKGROUND")
	tex:Point("TOPLEFT", bu.bg)
	tex:Point("BOTTOMRIGHT", bu.bg)
	tex:SetTexture(A["media"].backdrop)
	tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

	FrameStackTooltip:SetParent(UIParent)
	FrameStackTooltip:SetFrameStrata("TOOLTIP")
	FrameStackTooltip:SetBackdrop(nil)

	local bg = CreateFrame("Frame", nil, FrameStackTooltip)
	bg:SetPoint("TOPLEFT")
	bg:SetPoint("BOTTOMRIGHT")
	bg:SetFrameLevel(FrameStackTooltip:GetFrameLevel()-1)
	A:CreateBD(bg, .6)

	EventTraceTooltip:SetParent(UIParent)
	EventTraceTooltip:SetFrameStrata("TOOLTIP")
	EventTraceTooltip:SetBackdrop(nil)

	local bg = CreateFrame("Frame", nil, EventTraceTooltip)
	bg:SetPoint("TOPLEFT")
	bg:SetPoint("BOTTOMRIGHT")
	bg:SetFrameLevel(EventTraceTooltip:GetFrameLevel()-1)
	A:CreateBD(bg, .6)

	A:ReskinClose(ScriptErrorsFrameClose)
	A:ReskinScroll(ScriptErrorsFrameScrollFrameScrollBar)
	A:Reskin(select(4, ScriptErrorsFrame:GetChildren()))
	A:Reskin(select(5, ScriptErrorsFrame:GetChildren()))
	A:Reskin(select(6, ScriptErrorsFrame:GetChildren()))

	local texs = {
		"TopLeft",
		"TopRight",
		"Top",
		"BottomLeft",
		"BottomRight",
		"Bottom",
		"Left",
		"Right",
		"TitleBG",
		"DialogBG",
	}

	for i=1, #texs do
		_G["ScriptErrorsFrame"..texs[i]]:SetTexture(nil)
		_G["EventTraceFrame"..texs[i]]:SetTexture(nil)
	end

	for i=1, ScriptErrorsFrame:GetNumChildren() do
		local child = select(i, ScriptErrorsFrame:GetChildren())
		if child:GetObjectType() == "Button" and not child:GetName() then
			A:Reskin(child)
		end
	end
end

A:RegisterSkin("Blizzard_DebugTools", LoadSkin)