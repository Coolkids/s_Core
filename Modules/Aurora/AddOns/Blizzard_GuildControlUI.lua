local S, L, DB, _, C = unpack(select(2, ...))

local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
DB.AuroraModules["Blizzard_GuildControlUI"] = function()
	S.CreateBD(GuildControlUI)
	S.CreateSD(GuildControlUI)

	for i = 1, 9 do
		select(i, GuildControlUI:GetRegions()):Hide()
	end

	for i = 1, 8 do
		select(i, GuildControlUIRankBankFrameInset:GetRegions()):Hide()
	end

	GuildControlUIRankSettingsFrameChatBg:SetAlpha(0)
	GuildControlUIRankSettingsFrameRosterBg:SetAlpha(0)
	GuildControlUIRankSettingsFrameInfoBg:SetAlpha(0)
	GuildControlUIRankSettingsFrameBankBg:SetAlpha(0)
	GuildControlUITopBg:Hide()
	GuildControlUIHbar:Hide()
	GuildControlUIRankBankFrameInsetScrollFrameTop:SetAlpha(0)
	GuildControlUIRankBankFrameInsetScrollFrameBottom:SetAlpha(0)

	hooksecurefunc("GuildControlUI_RankOrder_Update", function()
		for i = 1, GuildControlGetNumRanks() do
			local rank = _G["GuildControlUIRankOrderFrameRank"..i]
			if not rank.styled then
				rank.upButton.icon:Hide()
				rank.downButton.icon:Hide()
				rank.deleteButton.icon:Hide()

				S.ReskinArrow(rank.upButton, "up")
				S.ReskinArrow(rank.downButton, "down")
				S.ReskinClose(rank.deleteButton)

				S.ReskinInput(rank.nameBox, 20)

				rank.styled = true
			end
		end
	end)

	hooksecurefunc("GuildControlUI_BankTabPermissions_Update", function()
		for i = 1, GetNumGuildBankTabs() + 1 do
			local tab = "GuildControlBankTab"..i
			local bu = _G[tab]
			if bu and not bu.styled then
				local ownedTab = bu.owned

				_G[tab.."Bg"]:Hide()

				ownedTab.tabIcon:SetTexCoord(.08, .92, .08, .92)
				S.CreateBG(ownedTab.tabIcon)

				S.CreateBD(bu, .25)
				S.Reskin(bu.buy.button)
				S.ReskinInput(ownedTab.editBox)

				for _, ch in pairs({ownedTab.viewCB, ownedTab.depositCB, ownedTab.infoCB}) do
					-- can't get a backdrop frame to appear behind the checked texture for some reason
					ch:SetNormalTexture("")
					ch:SetPushedTexture("")
					ch:SetHighlightTexture(DB.media.backdrop)

					local hl = ch:GetHighlightTexture()
					hl:Point("TOPLEFT", 5, -5)
					hl:Point("BOTTOMRIGHT", -5, 5)
					hl:SetVertexColor(r, g, b, .2)

					local check = ch:GetCheckedTexture()
					check:SetDesaturated(true)
					check:SetVertexColor(r, g, b)

					local tex = S.CreateGradient(ch)
					tex:Point("TOPLEFT", 5, -5)
					tex:Point("BOTTOMRIGHT", -5, 5)

					local left = ch:CreateTexture(nil, "BACKGROUND")
					left:SetWidth(1)
					left:SetTexture(0, 0, 0)
					left:Point("TOPLEFT", tex, -1, 1)
					left:Point("BOTTOMLEFT", tex, -1, -1)

					local right = ch:CreateTexture(nil, "BACKGROUND")
					right:SetWidth(1)
					right:SetTexture(0, 0, 0)
					right:Point("TOPRIGHT", tex, 1, 1)
					right:Point("BOTTOMRIGHT", tex, 1, -1)

					local top = ch:CreateTexture(nil, "BACKGROUND")
					top:SetHeight(1)
					top:SetTexture(0, 0, 0)
					top:Point("TOPLEFT", tex, -1, 1)
					top:Point("TOPRIGHT", tex, 1, 1)

					local bottom = ch:CreateTexture(nil, "BACKGROUND")
					bottom:SetHeight(1)
					bottom:SetTexture(0, 0, 0)
					bottom:Point("BOTTOMLEFT", tex, -1, -1)
					bottom:Point("BOTTOMRIGHT", tex, 1, -1)
				end

				bu.styled = true
			end
		end
	end)

	for i = 1, 20 do
		if i ~= 14 then
			S.ReskinCheck(_G["GuildControlUIRankSettingsFrameCheckbox"..i])
		end
	end

	S.Reskin(GuildControlUIRankOrderFrameNewButton)
	S.ReskinClose(GuildControlUICloseButton)
	S.ReskinScroll(GuildControlUIRankBankFrameInsetScrollFrameScrollBar)
	S.ReskinDropDown(GuildControlUINavigationDropDown)
	S.ReskinDropDown(GuildControlUIRankSettingsFrameRankDropDown)
	S.ReskinDropDown(GuildControlUIRankBankFrameRankDropDown)
	S.ReskinInput(GuildControlUIRankSettingsFrameGoldBox, 20)
end