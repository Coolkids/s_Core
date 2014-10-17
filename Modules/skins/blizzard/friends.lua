﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")

local function LoadSkin()
	FriendsFrameIcon:Hide()
	FriendsFrameTopRightCorner:Hide()
	FriendsFrameTopLeftCorner:Hide()
	FriendsFrameTopBorder:Hide()
	FriendsFramePortraitFrame:Hide()
	FriendsFrameIcon:Hide()
	FriendsFrameInsetBg:Hide()
	FriendsFrameFriendsScrollFrameTop:Hide()
	FriendsFrameFriendsScrollFrameMiddle:Hide()
	FriendsFrameFriendsScrollFrameBottom:Hide()
	WhoFrameListInsetBg:Hide()
	WhoFrameEditBoxInsetBg:Hide()
	ChannelFrameLeftInsetBg:Hide()
	ChannelFrameRightInsetBg:Hide()
	IgnoreListFrameTop:Hide()
	IgnoreListFrameMiddle:Hide()
	IgnoreListFrameBottom:Hide()
	PendingListFrameTop:Hide()
	PendingListFrameMiddle:Hide()
	PendingListFrameBottom:Hide()
	ChannelFrameDaughterFrameTitlebar:Hide()
	ChannelFrameDaughterFrameCorner:Hide()
	A:ReskinDropDown(WhoFrameDropDown)
	A:ReskinDropDown(FriendsFriendsFrameDropDown)
	A:ReskinScroll(FriendsFrameFriendsScrollFrameScrollBar)
	A:ReskinScroll(WhoListScrollFrameScrollBar)
	A:ReskinScroll(FriendsFriendsScrollFrameScrollBar)
	A:ReskinScroll(ChannelRosterScrollFrameScrollBar)
	A:ReskinInput(AddFriendNameEditBox)
	A:ReskinInput(FriendsFrameBroadcastInput)
	A:ReskinInput(ChannelFrameDaughterFrameChannelName)
	A:ReskinInput(ChannelFrameDaughterFrameChannelPassword)
	A:ReskinClose(ChannelFrameDaughterFrameDetailCloseButton)
	A:ReskinClose(FriendsFrameCloseButton)
	ChannelRosterScrollFrame:Point("TOPRIGHT", ChannelFrame, "TOPRIGHT", -39, -60)
	FriendsTabHeaderSoRButton:StyleButton(true)

	for i = 1, 4 do
		A:CreateTab(_G["FriendsFrameTab"..i])
	end

	for i = 1, MAX_DISPLAY_CHANNEL_BUTTONS do
		_G["ChannelButton"..i]:SetNormalTexture("")
	end

	for i=1, MAX_CHANNEL_BUTTONS do
		_G["ChannelButton"..i.."Text"]:SetFont(S["media"].font, S["media"].fontsize)
	end

	for i = 1, 6 do
		for j = 1, 3 do
			select(i, _G["FriendsTabHeaderTab"..j]:GetRegions()):Hide()
			select(i, _G["FriendsTabHeaderTab"..j]:GetRegions()).Show = S.dummy
		end
	end

	local buttons = {
		"WhoFrameAddFriendButton",
		"WhoFrameGroupInviteButton",
		"FriendsFrameAddFriendButton",
		"FriendsFrameSendMessageButton",
		"AddFriendEntryFrameAcceptButton",
		"AddFriendEntryFrameCancelButton",
		"FriendsFriendsSendRequestButton",
		"FriendsFriendsCloseButton",
		"FriendsFrameUnsquelchButton",
		"FriendsFramePendingButton1AcceptButton",
		"FriendsFramePendingButton1DeclineButton",
		"FriendsFrameIgnorePlayerButton",
		"AddFriendInfoFrameContinueButton",
		"ChannelFrameNewButton",
		"ChannelFrameDaughterFrameOkayButton",
		"ChannelFrameDaughterFrameCancelButton",
		"WhoFrameWhoButton",
		"PendingListInfoFrameContinueButton",
		"FriendsFrameMutePlayerButton"
	}
	for i = 1, #buttons do
		local button = _G[buttons[i]]
		A:Reskin(button)
	end

	for i = 1, FRIENDS_TO_DISPLAY do
		local bu = _G["FriendsFrameFriendsScrollFrameButton"..i]
		local ic = _G["FriendsFrameFriendsScrollFrameButton"..i.."GameIcon"]
		local inv = _G["FriendsFrameFriendsScrollFrameButton"..i.."TravelPassButton"]
		local summon = _G["FriendsFrameFriendsScrollFrameButton"..i.."SummonButton"]
		bu:SetHighlightTexture(A["media"].backdrop)
		bu:GetHighlightTexture():SetVertexColor(.24, .56, 1, .2)

		ic:Size(22, 22)
		ic:SetTexCoord(.15, .85, .15, .85)

		ic:ClearAllPoints()
		ic:Point("RIGHT", bu, "RIGHT", -24, 0)
		ic.SetPoint = S.dummy

		A:Reskin(inv)
		inv:Size(15, 25)
		inv:ClearAllPoints()
		inv:Point("RIGHT", bu, "RIGHT", -4, 0)
		inv.SetPoint = S.dummy
		local text = inv:CreateFontString(nil, "OVERLAY")
		text:SetFont(S["media"].font, S["media"].fontsize)
		text:SetShadowOffset(S.mult, -S.mult)
		text:SetPoint("CENTER")
		text:SetText("+")

        select(1, summon:GetRegions()):SetTexCoord( .08, .92, .08, .92)
        select(10, summon:GetRegions()):SetAlpha(0)
        summon:StyleButton(1)
        A:CreateBD(summon, 0)

		bu.bg = CreateFrame("Frame", nil, bu)
		bu.bg:SetAllPoints(ic)
		--bu.bg:SetPoint("TOPLEFT", ic, -1, 1)
		--bu.bg:SetPoint("BOTTOMRIGHT", ic, 1, -1)
		A:CreateBD(bu.bg, 0)
	end

	local function UpdateScroll()
		for i = 1, FRIENDS_TO_DISPLAY do
			local bu = _G["FriendsFrameFriendsScrollFrameButton"..i]

			if bu.gameIcon:IsShown() then
				bu.bg:Show()
				bu.gameIcon:Point("TOPRIGHT", bu, "TOPRIGHT", -2, -2)
			else
				bu.bg:Hide()
			end
		end
	end

	local bu1 = FriendsFrameFriendsScrollFrameButton1
	bu1.bg:Point("BOTTOMRIGHT", bu1.gameIcon, 0, -1)

	hooksecurefunc("FriendsFrame_UpdateFriends", UpdateScroll)
	hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", UpdateScroll)

	FriendsFrameStatusDropDown:ClearAllPoints()
	FriendsFrameStatusDropDown:Point("TOPLEFT", FriendsFrame, "TOPLEFT", 10, -28)

	FriendsTabHeaderSoRButton:SetPushedTexture("")
	FriendsTabHeaderSoRButtonIcon:SetTexCoord(.08, .92, .08, .92)
	local SoRBg = CreateFrame("Frame", nil, FriendsTabHeaderSoRButton)
	SoRBg:Point("TOPLEFT", -1, 1)
	SoRBg:Point("BOTTOMRIGHT", 1, -1)
	A:CreateBD(SoRBg, 0)

	A:CreateBD(FriendsFrameBattlenetFrame.UnavailableInfoFrame)
	FriendsFrameBattlenetFrame.UnavailableInfoFrame:Point("TOPLEFT", FriendsFrame, "TOPRIGHT", 1, -18)

	A:ReskinInput(FriendsFrameBroadcastInput)
	FriendsFrameBattlenetFrame:GetRegions():Hide()
	A:CreateBD(FriendsFrameBattlenetFrame, .25)

	FriendsFrameBattlenetFrame.Tag:SetParent(FriendsListFrame)
	FriendsFrameBattlenetFrame.Tag:Point("TOP", FriendsFrame, "TOP", 0, -8)

	hooksecurefunc("FriendsFrame_CheckBattlenetStatus", function()
		if BNFeaturesEnabled() then
			local frame = FriendsFrameBattlenetFrame

			frame.BroadcastButton:Hide()

			if BNConnected() then
				frame:Hide()
				FriendsFrameBroadcastInput:Show()
				FriendsFrameBroadcastInput_UpdateDisplay()
			end
		end
	end)
	FriendsFrame_CheckBattlenetStatus()

	hooksecurefunc("FriendsFrame_Update", function()
		if FriendsFrame.selectedTab == 1 and FriendsTabHeader.selectedTab == 1 and FriendsFrameBattlenetFrame.Tag:IsShown() then
			FriendsFrameTitleText:Hide()
		else
			FriendsFrameTitleText:Show()
		end
	end)

	local whoBg = CreateFrame("Frame", nil, WhoFrameEditBoxInset)
	whoBg:SetPoint("TOPLEFT")
	whoBg:Point("BOTTOMRIGHT", -1, 1)
	whoBg:SetFrameLevel(WhoFrameEditBoxInset:GetFrameLevel()-1)
	A:CreateBD(whoBg, .25)

	A:ReskinPortraitFrame(FriendsFrame, true)
	A:ReskinDropDown(FriendsFrameStatusDropDown)

	-- Battletag invite frame
	for i = 1, 9 do
		select(i, BattleTagInviteFrame:GetRegions()):Hide()
	end

	A:CreateBD(BattleTagInviteFrame)
	A:CreateSD(BattleTagInviteFrame)
	--A:CreateBD(BattleTagInviteFrame.NoteFrame, .25)

	local send, cancel = BattleTagInviteFrame:GetChildren()
	A:Reskin(send)
	A:Reskin(cancel)

	A:ReskinScroll(BattleTagInviteFrameScrollFrameScrollBar)
	
	for _, button in pairs({FriendsTabHeaderSoRButton, FriendsTabHeaderRecruitAFriendButton}) do
		button:SetPushedTexture("")
		button:GetRegions():SetTexCoord(.08, .92, .08, .92)
		
		local hi,wi = button:GetHeight()-4, button:GetHeight()-4
		button:SetSize(wi, hi)
		A:CreateBDFrame(button)
	end
		
end

A:RegisterSkin("SunUI", LoadSkin)
