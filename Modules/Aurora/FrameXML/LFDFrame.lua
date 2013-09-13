local S, L, DB, _, C = unpack(select(2, ...))

local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig

tinsert(DB.AuroraModules["SunUI"], function()
	LFDQueueFrameRandomScrollFrameScrollBackgroundTopLeft:Hide()
	LFDQueueFrameRandomScrollFrameScrollBackgroundBottomRight:Hide()

	-- this fixes right border of second reward being cut off
	LFDQueueFrameRandomScrollFrame:SetWidth(LFDQueueFrameRandomScrollFrame:GetWidth()+1)

	hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", function()
		for i = 1, LFD_MAX_REWARDS do
			local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i]

			if button and not button.styled then
				local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
				local cta = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."ShortageBorder"]
				local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
				local na = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."NameFrame"]

				S.CreateBG(icon)
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:SetDrawLayer("OVERLAY")
				count:SetDrawLayer("OVERLAY")
				na:SetTexture(0, 0, 0, .25)
				na:SetSize(118, 39)
				cta:SetAlpha(0)

				button.bg2 = CreateFrame("Frame", nil, button)
				button.bg2:Point("TOPLEFT", na, "TOPLEFT", 10, 0)
				button.bg2:SetPoint("BOTTOMRIGHT", na, "BOTTOMRIGHT")
				S.CreateBD(button.bg2, 0)

				button.styled = true
			end
		end
	end)

	hooksecurefunc("LFGDungeonListButton_SetDungeon", function(button, dungeonID)
		if not button.expandOrCollapseButton.plus then
			S.ReskinCheck(button.enableButton)
			S.ReskinExpandOrCollapse(button.expandOrCollapseButton)
		end
		if LFGCollapseList[dungeonID] then
			button.expandOrCollapseButton.plus:Show()
		else
			button.expandOrCollapseButton.plus:Hide()
		end

		button.enableButton:GetCheckedTexture():SetDesaturated(true)
	end)

	local bonusValor = LFDQueueFrameRandomScrollFrameChildFrameBonusValor
	bonusValor.Border:Hide()
	bonusValor.Icon:SetTexCoord(.08, .92, .08, .92)
	bonusValor.Icon:SetPoint("CENTER", bonusValor.Border, -3, 0)
	bonusValor.Icon:SetSize(24, 24)
	bonusValor.BonusText:Point("LEFT", bonusValor.Border, "RIGHT", -5, -1)
	S.CreateBG(bonusValor.Icon)

	S.CreateBD(LFDRoleCheckPopup)
	S.CreateSD(LFDRoleCheckPopup)
	S.Reskin(LFDRoleCheckPopupAcceptButton)
	S.Reskin(LFDRoleCheckPopupDeclineButton)
	S.Reskin(LFDQueueFrameRandomScrollFrameChildFrame.bonusRepFrame.ChooseButton)
end)