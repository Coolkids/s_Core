local S, L, DB, _, C = unpack(select(2, ...))

local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig

tinsert(DB.AuroraModules["SunUI"], function()
	RaidFinderFrameBottomInset:DisableDrawLayer("BORDER")
	RaidFinderFrameBottomInsetBg:Hide()
	RaidFinderFrameBtnCornerRight:Hide()
	RaidFinderFrameButtonBottomBorder:Hide()
	RaidFinderQueueFrameScrollFrameScrollBackground:Hide()
	RaidFinderQueueFrameScrollFrameScrollBackgroundTopLeft:Hide()
	RaidFinderQueueFrameScrollFrameScrollBackgroundBottomRight:Hide()

	-- this fixes right border of second reward being cut off
	RaidFinderQueueFrameScrollFrame:SetWidth(RaidFinderQueueFrameScrollFrame:GetWidth()+1)

	hooksecurefunc("RaidFinderQueueFrameRewards_UpdateFrame", function()
			for i = 1, LFD_MAX_REWARDS do
					local button = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i]

					if button and not button.styled then
							local icon = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."IconTexture"]
							local cta = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."ShortageBorder"]
							local count = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."Count"]
							local na = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."NameFrame"]

							S.CreateBG(icon)
							icon:SetTexCoord(.08, .92, .08, .92)
							icon:SetDrawLayer("OVERLAY")
							count:SetDrawLayer("OVERLAY")
							na:SetTexture(0, 0, 0, .25)
							na:SetSize(118, 39)
							cta:SetAlpha(0)

							button.bg2 = CreateFrame("Frame", nil, button)
							button.bg2:SetPoint("TOPLEFT", na, "TOPLEFT", 10, 0)
							button.bg2:SetPoint("BOTTOMRIGHT", na, "BOTTOMRIGHT")
							S.CreateBD(button.bg2, 0)

							button.styled = true
					end
			end
	end)

	S.ReskinScroll(RaidFinderQueueFrameScrollFrameScrollBar)
end)