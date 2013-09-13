local S, L, DB, _, C = unpack(select(2, ...))

local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig

tinsert(DB.AuroraModules["SunUI"], function()
	LFGDungeonReadyDialogBackground:Hide()
	LFGDungeonReadyDialogBottomArt:Hide()
	LFGDungeonReadyDialogFiligree:Hide()

	LFGDungeonReadyDialogRoleIconTexture:SetTexture(DB.media.roleIcons)
	LFGDungeonReadyDialogRoleIconLeaderIcon:SetTexture(DB.media.roleIcons)
	LFGDungeonReadyDialogRoleIconLeaderIcon:SetTexCoord(0, 0.296875, 0.015625, 0.2875)

	local leaderBg = S.CreateBG(LFGDungeonReadyDialogRoleIconLeaderIcon)
	leaderBg:SetDrawLayer("ARTWORK", 2)
	leaderBg:Point("TOPLEFT", LFGDungeonReadyDialogRoleIconLeaderIcon, 2, 0)
	leaderBg:Point("BOTTOMRIGHT", LFGDungeonReadyDialogRoleIconLeaderIcon, -3, 4)

	hooksecurefunc("LFGDungeonReadyPopup_Update", function()
		leaderBg:SetShown(LFGDungeonReadyDialogRoleIconLeaderIcon:IsShown())
	end)

	do
		local left = LFGDungeonReadyDialogRoleIcon:CreateTexture(nil, "OVERLAY")
		left:SetWidth(1)
		left:SetTexture(DB.media.backdrop)
		left:SetVertexColor(0, 0, 0)
		left:Point("TOPLEFT", 9, -7)
		left:Point("BOTTOMLEFT", 9, 10)

		local right = LFGDungeonReadyDialogRoleIcon:CreateTexture(nil, "OVERLAY")
		right:SetWidth(1)
		right:SetTexture(DB.media.backdrop)
		right:SetVertexColor(0, 0, 0)
		right:Point("TOPRIGHT", -8, -7)
		right:Point("BOTTOMRIGHT", -8, 10)

		local top = LFGDungeonReadyDialogRoleIcon:CreateTexture(nil, "OVERLAY")
		top:SetHeight(1)
		top:SetTexture(DB.media.backdrop)
		top:SetVertexColor(0, 0, 0)
		top:Point("TOPLEFT", 9, -7)
		top:Point("TOPRIGHT", -8, -7)

		local bottom = LFGDungeonReadyDialogRoleIcon:CreateTexture(nil, "OVERLAY")
		bottom:SetHeight(1)
		bottom:SetTexture(DB.media.backdrop)
		bottom:SetVertexColor(0, 0, 0)
		bottom:Point("BOTTOMLEFT", 9, 10)
		bottom:Point("BOTTOMRIGHT", -8, 10)
	end

	hooksecurefunc("LFGDungeonReadyDialogReward_SetMisc", function(button)
		if not button.styled then
			local border = _G[button:GetName().."Border"]

			button.texture:SetTexCoord(.08, .92, .08, .92)

			border:SetTexture(0, 0, 0)
			border:SetDrawLayer("BACKGROUND")
			border:Point("TOPLEFT", button.texture, -1, 1)
			border:Point("BOTTOMRIGHT", button.texture, 1, -1)

			button.styled = true
		end

		button.texture:SetTexture("Interface\\Icons\\inv_misc_coin_02")
	end)

	hooksecurefunc("LFGDungeonReadyDialogReward_SetReward", function(button, dungeonID, rewardIndex, rewardType, rewardArg)
		if not button.styled then
			local border = _G[button:GetName().."Border"]

			button.texture:SetTexCoord(.08, .92, .08, .92)

			border:SetTexture(0, 0, 0)
			border:SetDrawLayer("BACKGROUND")
			border:Point("TOPLEFT", button.texture, -1, 1)
			border:Point("BOTTOMRIGHT", button.texture, 1, -1)

			button.styled = true
		end

		local name, texturePath, quantity
		if rewardType == "reward" then
			name, texturePath, quantity = GetLFGDungeonRewardInfo(dungeonID, rewardIndex);
		elseif rewardType == "shortage" then
			name, texturePath, quantity = GetLFGDungeonShortageRewardInfo(dungeonID, rewardArg, rewardIndex);
		end
		if texturePath then
			button.texture:SetTexture(texturePath)
		end
	end)

	S.CreateBD(LFGDungeonReadyDialog)
	LFGDungeonReadyDialog.SetBackdrop = S.dummy
	S.CreateSD(LFGDungeonReadyDialog)
	S.CreateBD(LFGInvitePopup)
	S.CreateSD(LFGInvitePopup)
	S.CreateBD(LFGDungeonReadyStatus)
	S.CreateSD(LFGDungeonReadyStatus)

	S.Reskin(LFGDungeonReadyDialogEnterDungeonButton)
	S.Reskin(LFGDungeonReadyDialogLeaveQueueButton)
	S.Reskin(LFGInvitePopupAcceptButton)
	S.Reskin(LFGInvitePopupDeclineButton)
	S.ReskinClose(LFGDungeonReadyDialogCloseButton)
	S.ReskinClose(LFGDungeonReadyStatusCloseButton)

	for _, roleButton in pairs({LFDQueueFrameRoleButtonTank, LFDQueueFrameRoleButtonHealer, LFDQueueFrameRoleButtonDPS, LFDQueueFrameRoleButtonLeader, LFRQueueFrameRoleButtonTank, LFRQueueFrameRoleButtonHealer, LFRQueueFrameRoleButtonDPS, RaidFinderQueueFrameRoleButtonTank, RaidFinderQueueFrameRoleButtonHealer, RaidFinderQueueFrameRoleButtonDPS, RaidFinderQueueFrameRoleButtonLeader}) do
		if roleButton.background then
			roleButton.background:SetTexture("")
		end

		roleButton.cover:SetTexture(DB.media.roleIcons)
		roleButton:SetNormalTexture(DB.media.roleIcons)

		roleButton.checkButton:SetFrameLevel(roleButton:GetFrameLevel() + 2)

		for i = 1, 2 do
			local left = roleButton:CreateTexture()
			left:SetDrawLayer("OVERLAY", i)
			left:SetWidth(1)
			left:SetTexture(DB.media.backdrop)
			left:SetVertexColor(0, 0, 0)
			left:Point("TOPLEFT", roleButton, 6, -5)
			left:Point("BOTTOMLEFT", roleButton, 6, 7)
			roleButton["leftLine"..i] = left

			local right = roleButton:CreateTexture()
			right:SetDrawLayer("OVERLAY", i)
			right:SetWidth(1)
			right:SetTexture(DB.media.backdrop)
			right:SetVertexColor(0, 0, 0)
			right:Point("TOPRIGHT", roleButton, -6, -5)
			right:Point("BOTTOMRIGHT", roleButton, -6, 7)
			roleButton["rightLine"..i] = right

			local top = roleButton:CreateTexture()
			top:SetDrawLayer("OVERLAY", i)
			top:SetHeight(1)
			top:SetTexture(DB.media.backdrop)
			top:SetVertexColor(0, 0, 0)
			top:Point("TOPLEFT", roleButton, 6, -5)
			top:Point("TOPRIGHT", roleButton, -6, -5)
			roleButton["topLine"..i] = top

			local bottom = roleButton:CreateTexture()
			bottom:SetDrawLayer("OVERLAY", i)
			bottom:SetHeight(1)
			bottom:SetTexture(DB.media.backdrop)
			bottom:SetVertexColor(0, 0, 0)
			bottom:Point("BOTTOMLEFT", roleButton, 6, 7)
			bottom:Point("BOTTOMRIGHT", roleButton, -6, 7)
			roleButton["bottomLine"..i] = bottom
		end

		roleButton.leftLine2:Hide()
		roleButton.rightLine2:Hide()
		roleButton.topLine2:Hide()
		roleButton.bottomLine2:Hide()

		local shortageBorder = roleButton.shortageBorder
		if shortageBorder then
			local icon = roleButton.incentiveIcon

			shortageBorder:SetTexture("")

			icon.border:SetTexture(0, 0, 0)
			icon.border:SetDrawLayer("BACKGROUND")
			icon.border:Point("TOPLEFT", icon.texture, -1, 1)
			icon.border:Point("BOTTOMRIGHT", icon.texture, 1, -1)

			icon:Point("BOTTOMRIGHT", 3, -3)
			icon:SetSize(14, 14)
			icon.texture:SetSize(14, 14)
			icon.texture:SetTexCoord(.12, .88, .12, .88)
		end

		S.ReskinCheck(roleButton.checkButton)
	end

	for _, roleButton in pairs({LFDRoleCheckPopupRoleButtonTank, LFDRoleCheckPopupRoleButtonHealer, LFDRoleCheckPopupRoleButtonDPS, LFGInvitePopupRoleButtonTank, LFGInvitePopupRoleButtonHealer, LFGInvitePopupRoleButtonDPS}) do
		roleButton.cover:SetTexture(DB.media.roleIcons)
		roleButton:SetNormalTexture(DB.media.roleIcons)

		roleButton.checkButton:SetFrameLevel(roleButton:GetFrameLevel() + 2)

		local left = roleButton:CreateTexture(nil, "OVERLAY")
		left:SetWidth(1)
		left:SetTexture(DB.media.backdrop)
		left:SetVertexColor(0, 0, 0)
		left:Point("TOPLEFT", roleButton, 9, -7)
		left:Point("BOTTOMLEFT", roleButton, 9, 11)

		local right = roleButton:CreateTexture(nil, "OVERLAY")
		right:SetWidth(1)
		right:SetTexture(DB.media.backdrop)
		right:SetVertexColor(0, 0, 0)
		right:SetPoint("TOPRIGHT", roleButton, -9, -7)
		right:SetPoint("BOTTOMRIGHT", roleButton, -9, 11)

		local top = roleButton:CreateTexture(nil, "OVERLAY")
		top:SetHeight(1)
		top:SetTexture(DB.media.backdrop)
		top:SetVertexColor(0, 0, 0)
		top:SetPoint("TOPLEFT", roleButton, 9, -7)
		top:SetPoint("TOPRIGHT", roleButton, -9, -7)

		local bottom = roleButton:CreateTexture(nil, "OVERLAY")
		bottom:SetHeight(1)
		bottom:SetTexture(DB.media.backdrop)
		bottom:SetVertexColor(0, 0, 0)
		bottom:Point("BOTTOMLEFT", roleButton, 9, 11)
		bottom:Point("BOTTOMRIGHT", roleButton, -9, 11)

		S.ReskinCheck(roleButton.checkButton)
	end

	do
		local roleButtons = {LFGDungeonReadyStatusGroupedTank, LFGDungeonReadyStatusGroupedHealer, LFGDungeonReadyStatusGroupedDamager, LFGDungeonReadyStatusRolelessReady}

		for i = 1, 5 do
			tinsert(roleButtons, _G["LFGDungeonReadyStatusIndividualPlayer"..i])
		end

		for _, roleButton in pairs(roleButtons) do
			roleButton.texture:SetTexture(DB.media.roleIcons)
			roleButton.statusIcon:SetDrawLayer("OVERLAY", 2)

			local left = roleButton:CreateTexture(nil, "OVERLAY")
			left:SetWidth(1)
			left:SetTexture(DB.media.backdrop)
			left:SetVertexColor(0, 0, 0)
			left:Point("TOPLEFT", 7, -6)
			left:Point("BOTTOMLEFT", 7, 8)

			local right = roleButton:CreateTexture(nil, "OVERLAY")
			right:SetWidth(1)
			right:SetTexture(DB.media.backdrop)
			right:SetVertexColor(0, 0, 0)
			right:Point("TOPRIGHT", -7, -6)
			right:Point("BOTTOMRIGHT", -7, 8)

			local top = roleButton:CreateTexture(nil, "OVERLAY")
			top:SetHeight(1)
			top:SetTexture(DB.media.backdrop)
			top:SetVertexColor(0, 0, 0)
			top:Point("TOPLEFT", 7, -6)
			top:Point("TOPRIGHT", -7, -6)

			local bottom = roleButton:CreateTexture(nil, "OVERLAY")
			bottom:SetHeight(1)
			bottom:SetTexture(DB.media.backdrop)
			bottom:SetVertexColor(0, 0, 0)
			bottom:Point("BOTTOMLEFT", 7, 8)
			bottom:Point("BOTTOMRIGHT", -7, 8)
		end
	end

	LFGDungeonReadyStatusRolelessReady.texture:SetTexCoord(0.5234375, 0.78750, 0, 0.25875)

	hooksecurefunc("LFG_SetRoleIconIncentive", function(roleButton, incentiveIndex)
		if incentiveIndex then
			local tex
			if incentiveIndex == LFG_ROLE_SHORTAGE_PLENTIFUL then
				tex = "Interface\\Icons\\INV_Misc_Coin_19"
			elseif incentiveIndex == LFG_ROLE_SHORTAGE_UNCOMMON then
				tex = "Interface\\Icons\\INV_Misc_Coin_18"
			elseif incentiveIndex == LFG_ROLE_SHORTAGE_RARE then
				tex = "Interface\\Icons\\INV_Misc_Coin_17"
			end
			roleButton.incentiveIcon.texture:SetTexture(tex)
			roleButton.leftLine2:Show()
			roleButton.rightLine2:Show()
			roleButton.topLine2:Show()
			roleButton.bottomLine2:Show()
		else
			roleButton.leftLine2:Hide()
			roleButton.rightLine2:Hide()
			roleButton.topLine2:Hide()
			roleButton.bottomLine2:Hide()
		end
	end)

	hooksecurefunc("LFG_PermanentlyDisableRoleButton", function(button)
		if button.shortageBorder then
			button.leftLine2:SetVertexColor(.5, .45, .03)
			button.rightLine2:SetVertexColor(.5, .45, .03)
			button.topLine2:SetVertexColor(.5, .45, .03)
			button.bottomLine2:SetVertexColor(.5, .45, .03)
		end
	end)

	hooksecurefunc("LFG_DisableRoleButton", function(button)
		if button.shortageBorder then
			button.leftLine2:SetVertexColor(.5, .45, .03)
			button.rightLine2:SetVertexColor(.5, .45, .03)
			button.topLine2:SetVertexColor(.5, .45, .03)
			button.bottomLine2:SetVertexColor(.5, .45, .03)
		end
	end)

	hooksecurefunc("LFG_EnableRoleButton", function(button)
		if button.shortageBorder then
			button.leftLine2:SetVertexColor(1, .9, .06)
			button.rightLine2:SetVertexColor(1, .9, .06)
			button.topLine2:SetVertexColor(1, .9, .06)
			button.bottomLine2:SetVertexColor(1, .9, .06)
		end
	end)
end)