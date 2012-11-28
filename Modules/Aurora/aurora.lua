local S, C, L, DB = unpack(select(2, ...))
if IsAddOnLoaded("Aurora") then return end
local _
local media = {
	["arrowUp"] = "Interface\\AddOns\\SunUI\\media\\arrow-up-active",
	["arrowDown"] = "Interface\\AddOns\\SunUI\\media\\arrow-down-active",
	["arrowLeft"] = "Interface\\AddOns\\SunUI\\media\\arrow-left-active",
	["arrowRight"] = "Interface\\AddOns\\SunUI\\media\\arrow-right-active",
	["backdrop"] = "Interface\\ChatFrame\\ChatFrameBackground",
	["checked"] = "Interface\\AddOns\\SunUI\\media\\CheckButtonHilight",
	["glow"] = "Interface\\AddOns\\SunUI\\media\\glowTex",
}
local function colourClose(f)
	f.text:SetTextColor(1, .1, .1)
end

local function clearClose(f)
	f.text:SetTextColor(1, 1, 1)
end

local function colourArrow(f)
	if f:IsEnabled() then
		f.downtex:SetVertexColor(r, g, b)
	end
end

local function clearArrow(f)
	f.downtex:SetVertexColor(1, 1, 1)
end
local frames = {}
local alpha = .5
local _G = _G
local _, class = UnitClass("player")
local r, g, b
if CUSTOM_CLASS_COLORS then
	r, g, b = CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b
else
	r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
end
local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("Aurora", "AceEvent-3.0")
local _G = _G
local Skin = CreateFrame("Frame", nil, UIParent)
Skin:RegisterEvent("ADDON_LOADED")
Skin:SetScript("OnEvent", function(self, event, addon)
	if not C["MiniDB"]["Aurora"] then return end
	if addon=="SunUI" then 
		-- [[ Headers ]]
		local header = {"GameMenuFrame", "InterfaceOptionsFrame", "AudioOptionsFrame", "VideoOptionsFrame", "ChatConfigFrame", "ColorPickerFrame"}
		for i = 1, #header do
			local title = _G[header[i].."Header"]
			if title then
			title:SetTexture("")
			title:ClearAllPoints()
				if title == _G["GameMenuFrameHeader"] then
					title:Point("TOP", GameMenuFrame, 0, 7)
				else
					title:Point("TOP", header[i], 0, 0)
				end
			end
		end

		-- [[ Simple backdrops ]]

		local bds = {"AutoCompleteBox", "BNToastFrame", "TicketStatusFrameButton", "GearManagerDialogPopup", "TokenFramePopup", "ReputationDetailFrame", "RaidInfoFrame", "MissingLootFrame", "ScrollOfResurrectionSelectionFrame", "ScrollOfResurrectionFrame", "VoiceChatTalkers", "ReportPlayerNameDialog", "ReportCheatingDialog", "QueueStatusFrame"}

		for i = 1, #bds do
			local bd = _G[bds[i]]
			if bd then
				S.CreateBD(bd)
			else
				print("Aurora: "..bds[i].." was not found.")
			end
		end

		local lightbds = {"SecondaryProfession1", "SecondaryProfession2", "SecondaryProfession3", "SecondaryProfession4", "ChatConfigChatSettingsClassColorLegend", "ChatConfigChannelSettingsClassColorLegend", "FriendsFriendsList", "HelpFrameTicketScrollFrame", "HelpFrameGM_ResponseScrollFrame1", "HelpFrameGM_ResponseScrollFrame2", "FriendsFriendsNoteFrame", "AddFriendNoteFrame", "ScrollOfResurrectionSelectionFrameList", "HelpFrameReportBugScrollFrame", "HelpFrameSubmitSuggestionScrollFrame", "ReportPlayerNameDialogCommentFrame", "ReportCheatingDialogCommentFrame"}
		for i = 1, #lightbds do
			local bd = _G[lightbds[i]]
			if bd then
				S.CreateBD(bd, .25)
			else
				print("Aurora: "..lightbds[i].." was not found.")
			end
		end

		-- [[?Scroll bars ]]

		local scrollbars = {"FriendsFrameFriendsScrollFrameScrollBar", "CharacterStatsPaneScrollBar", "PVPHonorFrameTypeScrollFrameScrollBar", "PVPHonorFrameInfoScrollFrameScrollBar", "LFDQueueFrameSpecificListScrollFrameScrollBar", "HelpFrameKnowledgebaseScrollFrameScrollBar", "HelpFrameReportBugScrollFrameScrollBar", "HelpFrameSubmitSuggestionScrollFrameScrollBar", "HelpFrameTicketScrollFrameScrollBar", "PaperDollTitlesPaneScrollBar", "PaperDollEquipmentManagerPaneScrollBar", "SendMailScrollFrameScrollBar", "OpenMailScrollFrameScrollBar", "RaidInfoScrollFrameScrollBar", "ReputationListScrollFrameScrollBar", "FriendsFriendsScrollFrameScrollBar", "HelpFrameGM_ResponseScrollFrame1ScrollBar", "HelpFrameGM_ResponseScrollFrame2ScrollBar", "HelpFrameKnowledgebaseScrollFrame2ScrollBar", "WhoListScrollFrameScrollBar", "GearManagerDialogPopupScrollFrameScrollBar", "LFDQueueFrameRandomScrollFrameScrollBar", "WarGamesFrameScrollFrameScrollBar", "WarGamesFrameInfoScrollFrameScrollBar", "ScrollOfResurrectionSelectionFrameListScrollFrameScrollBar", "ChannelRosterScrollFrameScrollBar"}
		for i = 1, #scrollbars do
			local scrollbar = _G[scrollbars[i]]
			if scrollbar then
				S.ReskinScroll(scrollbar)
			else
				print("Aurora: "..scrollbars[i].." was not found.")
			end
		end

		-- [[ Dropdowns ]]

		local dropdowns = {"FriendsFrameStatusDropDown", "LFDQueueFrameTypeDropDown", "LFRBrowseFrameRaidDropDown", "WhoFrameDropDown", "FriendsFriendsFrameDropDown", "RaidFinderQueueFrameSelectionDropDown", "WorldMapShowDropDown", "Advanced_GraphicsAPIDropDown"}

		for i = 1, #dropdowns do
			local dropdown = _G[dropdowns[i]]
			if dropdown then
				S.ReskinDropDown(dropdown)
			else
				print("Aurora: "..dropdowns[i].." was not found.")
			end
		end

		-- [[ Input frames ]]

		local inputs = {"AddFriendNameEditBox", "PVPTeamManagementFrameWeeklyDisplay", "SendMailNameEditBox", "SendMailSubjectEditBox", "SendMailMoneyGold", "SendMailMoneySilver", "SendMailMoneyCopper", "StaticPopup1MoneyInputFrameGold", "StaticPopup1MoneyInputFrameSilver", "StaticPopup1MoneyInputFrameCopper", "StaticPopup2MoneyInputFrameGold", "StaticPopup2MoneyInputFrameSilver", "StaticPopup2MoneyInputFrameCopper", "GearManagerDialogPopupEditBox", "HelpFrameKnowledgebaseSearchBox", "ChannelFrameDaughterFrameChannelName", "ChannelFrameDaughterFrameChannelPassword", "BagItemSearchBox", "BankItemSearchBox", "ScrollOfResurrectionSelectionFrameTargetEditBox", "ScrollOfResurrectionFrameNoteFrame"}
		for i = 1, #inputs do
			local input = _G[inputs[i]]
			if input then
				S.ReskinInput(input)
			else
				print("Aurora: "..inputs[i].." was not found.")
			end
		end

		S.ReskinInput(FriendsFrameBroadcastInput)
		S.ReskinInput(StaticPopup1EditBox, 20)
		S.ReskinInput(StaticPopup2EditBox, 20)
		S.ReskinInput(PVPBannerFrameEditBox, 20)

			-- [[ Arrows ]]

		S.ReskinArrow(SpellBookPrevPageButton, "left")
		S.ReskinArrow(SpellBookNextPageButton, "right")
		S.ReskinArrow(InboxPrevPageButton, "left")
		S.ReskinArrow(InboxNextPageButton, "right")
		S.ReskinArrow(MerchantPrevPageButton, "left")
		S.ReskinArrow(MerchantNextPageButton, "right")
		S.ReskinArrow(CharacterFrameExpandButton, "left")
		S.ReskinArrow(PVPTeamManagementFrameWeeklyToggleLeft, "left")
		S.ReskinArrow(PVPTeamManagementFrameWeeklyToggleRight, "right")
		S.ReskinArrow(PVPBannerFrameCustomization1LeftButton, "left")
		S.ReskinArrow(PVPBannerFrameCustomization1RightButton, "right")
		S.ReskinArrow(PVPBannerFrameCustomization2LeftButton, "left")
		S.ReskinArrow(PVPBannerFrameCustomization2RightButton, "right")
		S.ReskinArrow(TabardCharacterModelRotateLeftButton, "left")
		S.ReskinArrow(TabardCharacterModelRotateRightButton, "right")

		hooksecurefunc("CharacterFrame_Expand", function()
			select(15, CharacterFrameExpandButton:GetRegions()):SetTexture(media.arrowLeft)
		end)

		hooksecurefunc("CharacterFrame_Collapse", function()
			select(15, CharacterFrameExpandButton:GetRegions()):SetTexture(media.arrowRight)
		end)

		-- [[ Check boxes ]]

		local checkboxes = {"TokenFramePopupInactiveCheckBox", "TokenFramePopupBackpackCheckBox", "ReputationDetailAtWarCheckBox", "ReputationDetailInactiveCheckBox", "ReputationDetailMainScreenCheckBox"}
		for i = 1, #checkboxes do
			local checkbox = _G[checkboxes[i]]
			if checkbox then
				S.ReskinCheck(checkbox)
			else
				print("Aurora: "..checkboxes[i].." was not found.")
			end
		end

		S.ReskinCheck(LFDQueueFrameRoleButtonTank.checkButton)
		S.ReskinCheck(LFDQueueFrameRoleButtonHealer.checkButton)
		S.ReskinCheck(LFDQueueFrameRoleButtonDPS.checkButton)
		S.ReskinCheck(LFDQueueFrameRoleButtonLeader.checkButton)
		S.ReskinCheck(LFRQueueFrameRoleButtonTank.checkButton)
		S.ReskinCheck(LFRQueueFrameRoleButtonHealer.checkButton)
		S.ReskinCheck(LFRQueueFrameRoleButtonDPS.checkButton)
		S.ReskinCheck(LFDRoleCheckPopupRoleButtonTank.checkButton)
		S.ReskinCheck(LFDRoleCheckPopupRoleButtonHealer.checkButton)
		S.ReskinCheck(LFDRoleCheckPopupRoleButtonDPS.checkButton)
		S.ReskinCheck(RaidFinderQueueFrameRoleButtonTank.checkButton)
		S.ReskinCheck(RaidFinderQueueFrameRoleButtonHealer.checkButton)
		S.ReskinCheck(RaidFinderQueueFrameRoleButtonDPS.checkButton)
		S.ReskinCheck(RaidFinderQueueFrameRoleButtonLeader.checkButton)
		S.ReskinCheck(LFGInvitePopupRoleButtonTank.checkButton)
		S.ReskinCheck(LFGInvitePopupRoleButtonHealer.checkButton)
		S.ReskinCheck(LFGInvitePopupRoleButtonDPS.checkButton)

		-- [[ Radio buttons ]]

		local radiobuttons = {"ReportPlayerNameDialogPlayerNameCheckButton", "ReportPlayerNameDialogGuildNameCheckButton", "ReportPlayerNameDialogArenaTeamNameCheckButton", "SendMailSendMoneyButton", "SendMailCODButton"}
		for i = 1, #radiobuttons do
			local radiobutton = _G[radiobuttons[i]]
			if radiobutton then
				S.ReskinRadio(radiobutton)
			else
				print("Aurora: "..radiobuttons[i].." was not found.")
			end
		end

		S.ReskinRadio(RolePollPopupRoleButtonTank.checkButton)
		S.ReskinRadio(RolePollPopupRoleButtonHealer.checkButton)
		S.ReskinRadio(RolePollPopupRoleButtonDPS.checkButton)

		-- [[ Backdrop frames ]]

		S.SetBD(DressUpFrame, 10, -12, -34, 74)
		S.SetBD(HelpFrame)
		S.SetBD(SpellBookFrame)
		S.SetBD(PVPBannerFrame)
		S.SetBD(RaidParentFrame)

		local FrameBDs = {"StaticPopup1", "StaticPopup2", "GameMenuFrame", "InterfaceOptionsFrame", "VideoOptionsFrame", "AudioOptionsFrame", "LFGDungeonReadyStatus", "ChatConfigFrame", "StackSplitFrame", "AddFriendFrame", "FriendsFriendsFrame", "ColorPickerFrame", "ReadyCheckFrame", "LFDRoleCheckPopup", "LFGDungeonReadyDialog", "RolePollPopup", "GuildInviteFrame", "ChannelFrameDaughterFrame", "LFGInvitePopup"}
		for i = 1, #FrameBDs do
			FrameBD = _G[FrameBDs[i]]
			S.CreateBD(FrameBD)
			S.CreateSD(FrameBD)
		end

		LFGDungeonReadyDialog.SetBackdrop = function() end

		-- Dropdown lists

		hooksecurefunc("UIDropDownMenu_CreateFrames", function(level, index)
			for i = 1, UIDROPDOWNMENU_MAXLEVELS do
				local menu = _G["DropDownList"..i.."MenuBackdrop"]
				local backdrop = _G["DropDownList"..i.."Backdrop"]
				if not backdrop.reskinned then
					S.CreateBD(menu)
					S.CreateBD(backdrop)
					backdrop.reskinned = true
				end
			end
		end)

		local createBackdrop = function(parent, texture)
			local bg = parent:CreateTexture(nil, "BACKGROUND")
			bg:SetTexture(0, 0, 0, .5)
			bg:SetPoint("CENTER", texture)
			bg:Size(12, 12)
			parent.bg = bg

			local left = parent:CreateTexture(nil, "BACKGROUND")
			left:Width(1)
			left:SetTexture(0, 0, 0)
			left:SetPoint("TOPLEFT", bg)
			left:SetPoint("BOTTOMLEFT", bg)
			parent.left = left

			local right = parent:CreateTexture(nil, "BACKGROUND")
			right:Width(1)
			right:SetTexture(0, 0, 0)
			right:SetPoint("TOPRIGHT", bg)
			right:SetPoint("BOTTOMRIGHT", bg)
			parent.right = right

			local top = parent:CreateTexture(nil, "BACKGROUND")
			top:Height(1)
			top:SetTexture(0, 0, 0)
			top:SetPoint("TOPLEFT", bg)
			top:SetPoint("TOPRIGHT", bg)
			parent.top = top

			local bottom = parent:CreateTexture(nil, "BACKGROUND")
			bottom:Height(1)
			bottom:SetTexture(0, 0, 0)
			bottom:SetPoint("BOTTOMLEFT", bg)
			bottom:SetPoint("BOTTOMRIGHT", bg)
			parent.bottom = bottom
		end

		local toggleBackdrop = function(bu, show)
			if show then
				bu.bg:Show()
				bu.left:Show()
				bu.right:Show()
				bu.top:Show()
				bu.bottom:Show()
			else
				bu.bg:Hide()
				bu.left:Hide()
				bu.right:Hide()
				bu.top:Hide()
				bu.bottom:Hide()
			end
		end

		hooksecurefunc("ToggleDropDownMenu", function(level, _, dropDownFrame, anchorName)
			if not level then level = 1 end
			
			local uiScale = UIParent:GetScale()
			
			local listFrame = _G["DropDownList"..level]

			if level == 1 then
				if not anchorName then
					local xOffset = dropDownFrame.xOffset and dropDownFrame.xOffset or 16
					local yOffset = dropDownFrame.yOffset and dropDownFrame.yOffset or 9
					local point = dropDownFrame.point and dropDownFrame.point or "TOPLEFT"
					local relativeTo = dropDownFrame.relativeTo and dropDownFrame.relativeTo or dropDownFrame
					local relativePoint = dropDownFrame.relativePoint and dropDownFrame.relativePoint or "BOTTOMLEFT"

					listFrame:ClearAllPoints()
					listFrame:Point(point, relativeTo, relativePoint, xOffset, yOffset)

					-- make sure it doesn't go off the screen
					local offLeft = listFrame:GetLeft()/uiScale
					local offRight = (GetScreenWidth() - listFrame:GetRight())/uiScale
					local offTop = (GetScreenHeight() - listFrame:GetTop())/uiScale
					local offBottom = listFrame:GetBottom()/uiScale

					local xAddOffset, yAddOffset = 0, 0
					if offLeft < 0 then
						xAddOffset = -offLeft
					elseif offRight < 0 then
						xAddOffset = offRight
					end

					if offTop < 0 then
						yAddOffset = offTop
					elseif offBottom < 0 then
						yAddOffset = -offBottom
					end
					listFrame:ClearAllPoints()
					listFrame:Point(point, relativeTo, relativePoint, xOffset + xAddOffset, yOffset + yAddOffset)
				elseif anchorName ~= "cursor" then
					-- this part might be a bit unreliable
					local _, _, relPoint, xOff, yOff = listFrame:GetPoint()
					if relPoint == "BOTTOMLEFT" and xOff == 0 and floor(yOff) == 5 then
						listFrame:SetPoint("TOPLEFT", anchorName, "BOTTOMLEFT", 16, 9)
					end
				end
			else
				local point, anchor, relPoint, _, y = listFrame:GetPoint()
				if point:find("RIGHT") then
					listFrame:SetPoint(point, anchor, relPoint, -14, y)
				else
					listFrame:SetPoint(point, anchor, relPoint, 9, y)
				end
			end

			for j = 1, UIDROPDOWNMENU_MAXBUTTONS do
				local bu = _G["DropDownList"..level.."Button"..j]
				local _, _, _, x = bu:GetPoint()
				if bu:IsShown() and x then
					local hl = _G["DropDownList"..level.."Button"..j.."Highlight"]
					local check = _G["DropDownList"..level.."Button"..j.."Check"]

					hl:Point("TOPLEFT", -x + 1, 0)
					hl:Point("BOTTOMRIGHT", listFrame:GetWidth() - bu:GetWidth() - x - 1, 0)

					if not bu.bg then
						createBackdrop(bu, check)
						hl:SetTexture(r, g, b, .2)
						_G["DropDownList"..level.."Button"..j.."UnCheck"]:SetTexture("")
					end

					if not bu.notCheckable then
						toggleBackdrop(bu, true)

						-- only reliable way to see if button is radio or or check...
						local _, co = check:GetTexCoord()

						if co == 0 then
							check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
							check:SetVertexColor(r, g, b, 1)
							check:Size(20, 20)
							check:SetDesaturated(true)
						else
							check:SetTexture(media.backdrop)
							check:SetVertexColor(r, g, b, .6)
							check:Size(10, 10)
							check:SetDesaturated(false)
							end

							check:SetTexCoord(0, 1, 0, 1)
					else
						toggleBackdrop(bu, false)
					end
				end
			end
		end)

		-- [[ Custom skins ]]
		-- Pet stuff
		if class == "HUNTER" or class == "MAGE" or class == "DEATHKNIGHT" or class == "WARLOCK" then
			if class == "HUNTER" then
				PetStableBottomInset:DisableDrawLayer("BACKGROUND")
				PetStableBottomInset:DisableDrawLayer("BORDER")
				PetStableLeftInset:DisableDrawLayer("BACKGROUND")
				PetStableLeftInset:DisableDrawLayer("BORDER")
				PetStableModelShadow:Hide()
				PetStableModelRotateLeftButton:Hide()
				PetStableModelRotateRightButton:Hide()
				PetStableFrameModelBg:Hide()
				PetStablePrevPageButtonIcon:SetTexture("")
				PetStableNextPageButtonIcon:SetTexture("")

				S.ReskinPortraitFrame(PetStableFrame, true)
				S.ReskinArrow(PetStablePrevPageButton, "left")
				S.ReskinArrow(PetStableNextPageButton, "right")

				PetStableSelectedPetIcon:SetTexCoord(.08, .92, .08, .92)
				S.CreateBG(PetStableSelectedPetIcon)

				for i = 1, NUM_PET_ACTIVE_SLOTS do
					local bu = _G["PetStableActivePet"..i]

					bu.Background:Hide()
					bu.Border:Hide()

					bu:SetNormalTexture("")
					bu.Checked:SetTexture(media.checked)

					_G["PetStableActivePet"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)
					S.CreateBD(bu, .25)
				end

				for i = 1, NUM_PET_STABLE_SLOTS do
					local bu = _G["PetStableStabledPet"..i]
					local bd = CreateFrame("Frame", nil, bu)
					bd:Point("TOPLEFT", -1, 1)
					bd:Point("BOTTOMRIGHT", 1, -1)
					S.CreateBD(bd, .25)
					bu:SetNormalTexture("")
					bu:DisableDrawLayer("BACKGROUND")
					_G["PetStableStabledPet"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)
				end
			end

			hooksecurefunc("PetPaperDollFrame_UpdateIsAvailable", function()
				if not HasPetUI() then
					CharacterFrameTab3:Point("LEFT", CharacterFrameTab2, "LEFT", 0, 0)
				else
					CharacterFrameTab3:Point("LEFT", CharacterFrameTab2, "RIGHT", -15, 0)
				end
			end)

			PetModelFrameRotateLeftButton:Hide()
			PetModelFrameRotateRightButton:Hide()
			PetModelFrameShadowOverlay:Hide()
			PetPaperDollXPBar1:Hide()
			select(2, PetPaperDollFrameExpBar:GetRegions()):Hide()
			PetPaperDollPetModelBg:SetAlpha(0)
			PetPaperDollFrameExpBar:SetStatusBarTexture(media.backdrop)

			local bbg = CreateFrame("Frame", nil, PetPaperDollFrameExpBar)
			bbg:Point("TOPLEFT", -1, 1)
			bbg:Point("BOTTOMRIGHT", 1, -1)
			bbg:SetFrameLevel(PetPaperDollFrameExpBar:GetFrameLevel()-1)
			S.CreateBD(bbg, .25)
		end

		-- Ghost frame

		GhostFrameContentsFrameIcon:SetTexCoord(.08, .92, .08, .92)

		local GhostBD = CreateFrame("Frame", nil, GhostFrameContentsFrame)
		GhostBD:Point("TOPLEFT", GhostFrameContentsFrameIcon, -1, 1)
		GhostBD:Point("BOTTOMRIGHT", GhostFrameContentsFrameIcon, 1, -1)
		S.CreateBD(GhostBD, 0)

		-- Mail frame

		SendMailMoneyInset:DisableDrawLayer("BORDER")
		InboxFrame:GetRegions():Hide()
		SendMailMoneyBg:Hide()
		SendMailMoneyInsetBg:Hide()
		OpenMailFrameIcon:Hide()
		OpenMailHorizontalBarLeft:Hide()
		select(18, MailFrame:GetRegions()):Hide()
		select(26, OpenMailFrame:GetRegions()):Hide()

		OpenMailLetterButton:SetNormalTexture("")
		OpenMailLetterButton:SetPushedTexture("")
		OpenMailLetterButtonIconTexture:SetTexCoord(.08, .92, .08, .92)

		local bgmail = CreateFrame("Frame", nil, OpenMailLetterButton)
		bgmail:Point("TOPLEFT", -1, 1)
		bgmail:Point("BOTTOMRIGHT", 1, -1)
		bgmail:SetFrameLevel(OpenMailLetterButton:GetFrameLevel()-1)
		S.CreateBD(bgmail)

		OpenMailMoneyButton:SetNormalTexture("")
		OpenMailMoneyButton:SetPushedTexture("")
		OpenMailMoneyButtonIconTexture:SetTexCoord(.08, .92, .08, .92)

		local bgmoney = CreateFrame("Frame", nil, OpenMailMoneyButton)
		bgmoney:Point("TOPLEFT", -1, 1)
		bgmoney:Point("BOTTOMRIGHT", 1, -1)
		bgmoney:SetFrameLevel(OpenMailMoneyButton:GetFrameLevel()-1)
		S.CreateBD(bgmoney)

		for i = 1, INBOXITEMS_TO_DISPLAY do
			local it = _G["MailItem"..i]
			local bu = _G["MailItem"..i.."Button"]
			local st = _G["MailItem"..i.."ButtonSlot"]
			local ic = _G["MailItem"..i.."Button".."Icon"]
			local line = select(3, _G["MailItem"..i]:GetRegions())

			local a, b = it:GetRegions()
			a:Hide()
			b:Hide()

			bu:SetCheckedTexture(media.checked)

			st:Hide()
			line:Hide()
			ic:SetTexCoord(.08, .92, .08, .92)

			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, 0)
		end

		for i = 1, ATTACHMENTS_MAX_SEND do
			local button = _G["SendMailAttachment"..i]
			button:GetRegions():Hide()

			local bg = CreateFrame("Frame", nil, button)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(0)
			S.CreateBD(bg, .25)
		end

		for i = 1, ATTACHMENTS_MAX_RECEIVE do
			local bu = _G["OpenMailAttachmentButton"..i]
			local ic = _G["OpenMailAttachmentButton"..i.."IconTexture"]

			bu:SetNormalTexture("")
			bu:SetPushedTexture("")
			ic:SetTexCoord(.08, .92, .08, .92)

			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(0)
			S.CreateBD(bg, .25)
		end

		hooksecurefunc("SendMailFrame_Update", function()
			for i = 1, ATTACHMENTS_MAX_SEND do
				local button = _G["SendMailAttachment"..i]
				if button:GetNormalTexture() then
					button:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
				end
			end
		end)

		S.ReskinPortraitFrame(MailFrame, true)
		S.ReskinPortraitFrame(OpenMailFrame, true)

		-- Currency frame

		TokenFrame:HookScript("OnShow", function()
			for i=1, GetCurrencyListSize() do
				local button = _G["TokenFrameContainerButton"..i]

				if button and not button.reskinned then
					button.highlight:Point("TOPLEFT", 1, 0)
					button.highlight:Point("BOTTOMRIGHT", -1, 0)
					button.highlight.SetPoint = function() end
					button.highlight:SetTexture(r, g, b, .2)
					button.highlight.SetTexture = function() end
					button.categoryMiddle:SetAlpha(0)
					button.categoryLeft:SetAlpha(0)
					button.categoryRight:SetAlpha(0)

					if button.icon and button.icon:GetTexture() then
						button.icon:SetTexCoord(.08, .92, .08, .92)
						S.CreateBorder(button, button.icon)
					end
					button.reskinned = true
				end
			end
		end)

		-- Reputation frame

		local function UpdateFactionSkins()
			for i = 1, GetNumFactions() do
				local statusbar = _G["ReputationBar"..i.."ReputationBar"]

				if statusbar then
					statusbar:SetStatusBarTexture(DB.Statusbar)

					if not statusbar.reskinned then
						S.CreateBD(statusbar, .25)
						statusbar.reskinned = true
					end

					_G["ReputationBar"..i.."Background"]:SetTexture(nil)
					_G["ReputationBar"..i.."LeftLine"]:SetAlpha(0)
					_G["ReputationBar"..i.."BottomLine"]:SetAlpha(0)
					_G["ReputationBar"..i.."ReputationBarHighlight1"]:SetTexture(nil)
					_G["ReputationBar"..i.."ReputationBarHighlight2"]:SetTexture(nil)
					_G["ReputationBar"..i.."ReputationBarAtWarHighlight1"]:SetTexture(nil)
					_G["ReputationBar"..i.."ReputationBarAtWarHighlight2"]:SetTexture(nil)
					_G["ReputationBar"..i.."ReputationBarLeftTexture"]:SetTexture(nil)
					_G["ReputationBar"..i.."ReputationBarRightTexture"]:SetTexture(nil)
				end
			end
		end

		ReputationFrame:HookScript("OnShow", UpdateFactionSkins)
		ReputationFrame:HookScript("OnEvent", UpdateFactionSkins)

		for i = 1, NUM_FACTIONS_DISPLAYED do
			local bu = _G["ReputationBar"..i.."ExpandOrCollapseButton"]
			S.ReskinExpandOrCollapse(bu)
		end

		hooksecurefunc("ReputationFrame_Update", function()
			local numFactions = GetNumFactions()
			local factionIndex, factionButton, isCollapsed
			local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)

			for i = 1, NUM_FACTIONS_DISPLAYED do
				factionIndex = factionOffset + i
				factionButton = _G["ReputationBar"..i.."ExpandOrCollapseButton"]
				
				if factionIndex <= numFactions then
					_, _, _, _, _, _, _, _, _, isCollapsed = GetFactionInfo(factionIndex)
					if isCollapsed then
						factionButton.plus:Show()
					else
						factionButton.plus:Hide()
					end
				end
			end
		end)

		-- PVE frame

		PVEFrame:DisableDrawLayer("ARTWORK")
		PVEFrameLeftInset:DisableDrawLayer("BORDER")
		PVEFrameBlueBg:Hide()
		PVEFrameLeftInsetBg:Hide()
		PVEFrame.shadows:Hide()
		select(24, PVEFrame:GetRegions()):Hide()
		select(25, PVEFrame:GetRegions()):Hide()

		PVEFrameTab2:SetPoint("LEFT", PVEFrameTab1, "RIGHT", -15, 0)

		GroupFinderFrameGroupButton1.icon:SetTexture("Interface\\Icons\\INV_Helmet_08")
		GroupFinderFrameGroupButton2.icon:SetTexture("Interface\\Icons\\inv_helmet_06")
		GroupFinderFrameGroupButton3.icon:SetTexture("Interface\\Icons\\Icon_Scenarios")

		local function onMouseDown(self)
			self.icon:Size(64, 64)
		end

		local function onMouseUp(self)
			self.icon:Size(66, 66)
		end

		for i = 1, 3 do
			local bu = GroupFinderFrame["groupButton"..i]

			bu.ring:Hide()
			bu.bg:SetTexture(media.backdrop)
			bu.bg:SetVertexColor(r, g, b, .2)
			bu.bg:SetAllPoints()

			S.Reskin(bu, true)
			
			bu.icon:SetTexCoord(.08, .92, .08, .92)
			bu.icon:SetPoint("LEFT", bu, "LEFT")
			bu.icon:SetSize(bu.icon:GetWidth()-8, bu.icon:GetHeight()-8)
			bu.icon:SetDrawLayer("OVERLAY")
			bu.icon.bg = S.CreateBG(bu.icon)
			bu.icon.bg:SetDrawLayer("ARTWORK")
			
			bu:HookScript("OnMouseDown", onMouseDown)
			bu:HookScript("OnMouseUp", onMouseUp)
		end
			
		hooksecurefunc("GroupFinderFrame_SelectGroupButton", function(index)
			local self = GroupFinderFrame
			for i = 1, 3 do
				local button = self["groupButton"..i]
				if i == index then
					button.bg:Show()
				else
					button.bg:Hide()
				end
			end
		end)

		S.ReskinPortraitFrame(PVEFrame)
		S.CreateTab(PVEFrameTab1)
		S.CreateTab(PVEFrameTab2)
		-- LFD frame

		--LFDQueueFrameRandomScrollFrame:SetWidth(304)

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

		for i = 1, NUM_LFR_CHOICE_BUTTONS do
			local bu = _G["LFRQueueFrameSpecificListButton"..i].enableButton
			S.ReskinCheck(bu)
			bu.SetNormalTexture = function() end
			bu.SetPushedTexture = function() end

			S.ReskinExpandOrCollapse(_G["LFRQueueFrameSpecificListButton"..i].expandOrCollapseButton)
		end

		hooksecurefunc("LFRQueueFrameSpecificListButton_SetDungeon", function(button, dungeonID)
			if LFGCollapseList[dungeonID] then
				button.expandOrCollapseButton.plus:Show()
			else
				button.expandOrCollapseButton.plus:Hide()
			end

			button.enableButton:GetCheckedTexture():SetDesaturated(true)
		end)

		-- Raid Finder

		RaidFinderFrameBottomInset:DisableDrawLayer("BORDER")
		RaidFinderFrameBottomInsetBg:Hide()
		RaidFinderFrameBtnCornerRight:Hide()
		RaidFinderFrameButtonBottomBorder:Hide()

		for i = 1, LFD_MAX_REWARDS do
			local button = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i]
				
			if button then
				local icon = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."IconTexture"]
				local cta = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."ShortageBorder"]
				local count = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."Count"]
				local na = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."NameFrame"]

				S.CreateBG(icon)
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:SetDrawLayer("OVERLAY")
				count:SetDrawLayer("OVERLAY")
				na:SetTexture(0, 0, 0, .25)
				na:Size(118, 39)
				cta:SetAlpha(0)

				button.bg2 = CreateFrame("Frame", nil, button)
				button.bg2:Point("TOPLEFT", na, "TOPLEFT", 10, 0)
				button.bg2:SetPoint("BOTTOMRIGHT", na, "BOTTOMRIGHT")
				S.CreateBD(button.bg2, 0)		
			end
		end


		-- Scenario finder

		ScenarioFinderFrameInset:DisableDrawLayer("BORDER")
		ScenarioFinderFrame.TopTileStreaks:Hide()
		ScenarioFinderFrameBtnCornerRight:Hide()
		ScenarioFinderFrameButtonBottomBorder:Hide()
		ScenarioQueueFrame.Bg:Hide()
		ScenarioFinderFrameInset:GetRegions():Hide()
		ScenarioQueueFrameRandomScrollFrame:SetWidth(304)

		hooksecurefunc("ScenarioQueueFrameRandom_UpdateFrame", function()
			for i = 1, 2 do
				local button = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i]

				if button and not button.styled then
					local icon = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
					local cta = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i.."ShortageBorder"]
					local count = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
					local na = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i.."NameFrame"]

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
		S.Reskin(ScenarioQueueFrameFindGroupButton)
		S.ReskinDropDown(ScenarioQueueFrameTypeDropDown)
		
		-- Raid frame (social frame)

		S.Reskin(RaidFrameRaidBrowserButton)
		S.ReskinCheck(RaidFrameAllAssistCheckButton)

		-- Looking for raid

		LFRBrowseFrameRoleInset:DisableDrawLayer("BORDER")
		LFRQueueFrameSpecificListScrollFrameScrollBackgroundTopLeft:Hide()
		LFRQueueFrameSpecificListScrollFrameScrollBackgroundBottomRight:Hide()
		LFRBrowseFrameRoleInsetBg:Hide()

		S.ReskinPortraitFrame(RaidBrowserFrame)
		S.ReskinScroll(LFRQueueFrameSpecificListScrollFrameScrollBar)
		S.ReskinScroll(LFRQueueFrameCommentScrollFrameScrollBar)

		for i = 1, 2 do
			local tab = _G["LFRParentFrameSideTab"..i]
			tab:GetRegions():Hide()
			tab:SetCheckedTexture(media.checked)
			if i == 1 then
				local a1, p, a2, x, y = tab:GetPoint()
				tab:SetPoint(a1, p, a2, x + 11, y)
			end
			S.CreateBG(tab)
			S.CreateSD(tab, 5, 0, 0, 0, 1, 1)
			select(2, tab:GetRegions()):SetTexCoord(.08, .92, .08, .92)
		end

		-- Spellbook frame

		for i = 1, SPELLS_PER_PAGE do
			local bu = _G["SpellButton"..i]
			local ic = _G["SpellButton"..i.."IconTexture"]

			_G["SpellButton"..i.."SlotFrame"]:SetAlpha(0)
			_G["SpellButton"..i.."Highlight"]:SetAlpha(0)

			bu.EmptySlot:SetAlpha(0)
			bu.TextBackground:Hide()
			bu.TextBackground2:Hide()
			bu.UnlearnedFrame:SetAlpha(0)

			bu:SetCheckedTexture("")
			bu:SetPushedTexture("")

			ic:SetTexCoord(.08, .92, .08, .92)

			ic.bg = S.CreateBG(bu)
		end

		hooksecurefunc("SpellButton_UpdateButton", function(self)
			local slot, slotType = SpellBook_GetSpellBookSlot(self);
			local name = self:GetName();
			local subSpellString = _G[name.."SubSpellName"]

			subSpellString:SetTextColor(1, 1, 1)
			if slotType == "FUTURESPELL" then
				local level = GetSpellAvailableLevel(slot, SpellBookFrame.bookType)
				if (level and level > UnitLevel("player")) then
					self.RequiredLevelString:SetTextColor(.7, .7, .7)
					self.SpellName:SetTextColor(.7, .7, .7)
					subSpellString:SetTextColor(.7, .7, .7)
				end
			end

			local ic = _G[name.."IconTexture"]
			if not ic.bg then return end
			if ic:IsShown() then
				ic.bg:Show()
			else
				ic.bg:Hide()
			end
		end)
		SpellBookSkillLineTab1:SetPoint("TOPLEFT", SpellBookSideTabsFrame, "TOPRIGHT", 11, -36)

		local tabsSkinned = false
		hooksecurefunc("SpellBookFrame_UpdateSkillLineTabs", function()
			for i = 1, GetNumSpellTabs() do
				local tab = _G["SpellBookSkillLineTab"..i]

				if not tab.styled then
					tab:GetRegions():Hide()
					tab:SetCheckedTexture(media.checked)

					S.CreateBG(tab)
					S.CreateSD(tab, 5, 0, 0, 0, 1, 1)

					tab:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)

					tab.styled = true
				end
			end
		end)

		local coreTabsSkinned = false
		hooksecurefunc("SpellBookCoreAbilities_UpdateTabs", function()
			if coreTabsSkinned then return end
			coreTabsSkinned = true
			for i = 1, GetNumSpecializations() do
				local tab = SpellBookCoreAbilitiesFrame.SpecTabs[i]

				tab:GetRegions():Hide()
				tab:SetCheckedTexture(media.checked)

				S.CreateBG(tab)
				S.CreateSD(tab, 5, 0, 0, 0, 1, 1)

				tab:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)

				if i == 1 then
					tab:SetPoint("TOPLEFT", SpellBookCoreAbilitiesFrame, "TOPRIGHT", 11, -53)
				end
			end
		end)

		hooksecurefunc("SpellBook_UpdateCoreAbilitiesTab", function()
			for i = 1, #SpellBookCoreAbilitiesFrame.Abilities do
				local bu = SpellBook_GetCoreAbilityButton(i)
				if not bu.reskinned then
					bu.EmptySlot:SetAlpha(0)
					bu.ActiveTexture:SetAlpha(0)
					bu.FutureTexture:SetAlpha(0)
					bu.RequiredLevel:SetTextColor(1, 1, 1)

					bu.iconTexture:SetTexCoord(.08, .92, .08, .92)
					bu.iconTexture.bg = S.CreateBG(bu.iconTexture)

					if bu.FutureTexture:IsShown() then
						bu.Name:SetTextColor(.8, .8, .8)
						bu.InfoText:SetTextColor(.7, .7, .7)
					else
						bu.Name:SetTextColor(1, 1, 1)
						bu.InfoText:SetTextColor(.9, .9, .9)
					end
					bu.reskinned = true
				end
			end
		end)

		hooksecurefunc("SpellBook_UpdateWhatHasChangedTab", function()
			for i = 1, #SpellBookWhatHasChanged.ChangedItems do
				local bu = SpellBook_GetWhatChangedItem(i)
				bu.Ring:Hide()
				select(2, bu:GetRegions()):Hide()
				bu:SetTextColor(.9, .9, .9)
				bu.Title:SetTextColor(1, 1, 1)
			end
		end)

		SpellBookFrameTutorialButton.Ring:Hide()
		SpellBookFrameTutorialButton:Point("TOPLEFT", SpellBookFrame, "TOPLEFT", -12, 12)

		-- Professions

		local professions = {"PrimaryProfession1", "PrimaryProfession2", "SecondaryProfession1", "SecondaryProfession2", "SecondaryProfession3", "SecondaryProfession4"}

		for _, button in pairs(professions) do
			local bu = _G[button]
			bu.professionName:SetTextColor(1, 1, 1)
			bu.missingHeader:SetTextColor(1, 1, 1)
			bu.missingText:SetTextColor(1, 1, 1)

			bu.statusBar:Height(13)
			bu.statusBar:SetStatusBarTexture(DB.Statusbar)
			bu.statusBar:GetStatusBarTexture():SetGradient("VERTICAL", 0, .6, 0, 0, .8, 0)
			bu.statusBar.rankText:SetPoint("CENTER")

			local _, p = bu.statusBar:GetPoint()
			bu.statusBar:SetPoint("TOPLEFT", p, "BOTTOMLEFT", 1, -3)

			_G[button.."StatusBarLeft"]:Hide()
			bu.statusBar.capRight:SetAlpha(0)
			_G[button.."StatusBarBGLeft"]:Hide()
			_G[button.."StatusBarBGMiddle"]:Hide()
			_G[button.."StatusBarBGRight"]:Hide()
				
			local bg = CreateFrame("Frame", nil, bu.statusBar)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, .25)
		end

		local professionbuttons = {"PrimaryProfession1SpellButtonTop", "PrimaryProfession1SpellButtonBottom", "PrimaryProfession2SpellButtonTop", "PrimaryProfession2SpellButtonBottom", "SecondaryProfession1SpellButtonLeft", "SecondaryProfession1SpellButtonRight", "SecondaryProfession2SpellButtonLeft", "SecondaryProfession2SpellButtonRight", "SecondaryProfession3SpellButtonLeft", "SecondaryProfession3SpellButtonRight", "SecondaryProfession4SpellButtonLeft", "SecondaryProfession4SpellButtonRight"}

		for _, button in pairs(professionbuttons) do
			local icon = _G[button.."IconTexture"]
			local bu = _G[button]
			_G[button.."NameFrame"]:SetAlpha(0)

			bu:SetPushedTexture("")
			bu:SetCheckedTexture(media.checked)
			bu:GetHighlightTexture():Hide()

			if icon then
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				S.CreateBG(icon)
			end
		end

		for i = 1, 2 do
			local bu = _G["PrimaryProfession"..i]
			local bg = CreateFrame("Frame", nil, bu)
			bg:SetPoint("TOPLEFT")
			bg:Point("BOTTOMRIGHT", 0, -4)
			bg:SetFrameLevel(0)
			S.CreateBD(bg, .25)
		end

		-- Merchant Frame

		MerchantMoneyInset:DisableDrawLayer("BORDER")
		MerchantExtraCurrencyInset:DisableDrawLayer("BORDER")
		BuybackBG:SetAlpha(0)
		MerchantMoneyBg:Hide()
		MerchantMoneyInsetBg:Hide()
		MerchantFrameBottomLeftBorder:SetAlpha(0)
		MerchantFrameBottomRightBorder:SetAlpha(0)
		MerchantExtraCurrencyBg:SetAlpha(0)
		MerchantExtraCurrencyInsetBg:Hide()

		S.ReskinPortraitFrame(MerchantFrame, true)
		S.ReskinDropDown(MerchantFrameLootFilter)

		for i = 1, BUYBACK_ITEMS_PER_PAGE do
			local button = _G["MerchantItem"..i]
			local bu = _G["MerchantItem"..i.."ItemButton"]
			local ic = _G["MerchantItem"..i.."ItemButtonIconTexture"]
			local mo = _G["MerchantItem"..i.."MoneyFrame"]

			_G["MerchantItem"..i.."SlotTexture"]:Hide()
			_G["MerchantItem"..i.."NameFrame"]:Hide()
			_G["MerchantItem"..i.."Name"]:Height(20)

			local a1, p, a2= bu:GetPoint()
			bu:SetPoint(a1, p, a2, -2, -2)
			bu:SetNormalTexture("")
			bu:SetPushedTexture("")
			bu:Size(40, 40)

			local a3, p2, a4, x, y = mo:GetPoint()
			mo:SetPoint(a3, p2, a4, x, y+2)

			S.CreateBD(bu, 0)

			button.bd = CreateFrame("Frame", nil, button)
			button.bd:Point("TOPLEFT", 39, 0)
			button.bd:SetPoint("BOTTOMRIGHT")
			button.bd:SetFrameLevel(0)
			S.CreateBD(button.bd, .25)

			ic:SetTexCoord(.08, .92, .08, .92)
			ic:ClearAllPoints()
			ic:Point("TOPLEFT", 1, -1)
			ic:Point("BOTTOMRIGHT", -1, 1)

			for j = 1, 3 do
				S.CreateBG(_G["MerchantItem"..i.."AltCurrencyFrameItem"..j.."Texture"])
				_G["MerchantItem"..i.."AltCurrencyFrameItem"..j.."Texture"]:SetTexCoord(.08, .92, .08, .92)
			end
		end

		hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
			local numMerchantItems = GetMerchantNumItems()
			for i = 1, MERCHANT_ITEMS_PER_PAGE do
				local index = ((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i
				if index <= numMerchantItems then
					local name, texture, price, stackCount, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(index)
					if extendedCost and (price <= 0) then
						_G["MerchantItem"..i.."AltCurrencyFrame"]:Point("BOTTOMLEFT", "MerchantItem"..i.."NameFrame", "BOTTOMLEFT", 0, 35)
					end
				end
			end
		end)

		MerchantBuyBackItemSlotTexture:Hide()
		MerchantBuyBackItemNameFrame:Hide()
		MerchantBuyBackItemItemButton:SetNormalTexture("")
		MerchantBuyBackItemItemButton:SetPushedTexture("")

		S.CreateBD(MerchantBuyBackItemItemButton, 0)
		S.CreateBD(MerchantBuyBackItem, .25)

		MerchantBuyBackItemItemButtonIconTexture:SetTexCoord(.08, .92, .08, .92)
		MerchantBuyBackItemItemButtonIconTexture:ClearAllPoints()
		MerchantBuyBackItemItemButtonIconTexture:Point("TOPLEFT", 1, -1)
		MerchantBuyBackItemItemButtonIconTexture:Point("BOTTOMRIGHT", -1, 1)

		MerchantGuildBankRepairButton:SetPushedTexture("")
		S.CreateBG(MerchantGuildBankRepairButton)
		MerchantGuildBankRepairButtonIcon:SetTexCoord(0.595, 0.8075, 0.05, 0.52)

		MerchantRepairAllButton:SetPushedTexture("")
		S.CreateBG(MerchantRepairAllButton)
		MerchantRepairAllIcon:SetTexCoord(0.31375, 0.53, 0.06, 0.52)

		MerchantRepairItemButton:SetPushedTexture("")
		S.CreateBG(MerchantRepairItemButton)
		local ic = MerchantRepairItemButton:GetRegions()
		ic:SetTexture("Interface\\Icons\\INV_Hammer_20")
		ic:SetTexCoord(.08, .92, .08, .92)

		hooksecurefunc("MerchantFrame_UpdateCurrencies", function()
			for i = 1, MAX_MERCHANT_CURRENCIES do
				local bu = _G["MerchantToken"..i]
				if bu and not bu.reskinned then
					local ic = _G["MerchantToken"..i.."Icon"]
					local co = _G["MerchantToken"..i.."Count"]

					ic:SetTexCoord(.08, .92, .08, .92)
					ic:SetDrawLayer("OVERLAY")
					ic:Point("LEFT", co, "RIGHT", 2, 0)
					co:Point("TOPLEFT", bu, "TOPLEFT", -2, 0)

					S.CreateBG(ic)
					bu.reskinned = true
				end
			end
		end)

		-- Friends Frame
		FriendsFrameIcon:Hide()
		
		S.ReskinPortraitFrame(FriendsFrame, true)

		S.Reskin(FriendsFrameAddFriendButton)
		S.Reskin(FriendsFrameSendMessageButton)
		S.Reskin(FriendsFrameIgnorePlayerButton)
		S.Reskin(FriendsFrameUnsquelchButton)
		S.Reskin(FriendsFrameMutePlayerButton)
		S.ReskinDropDown(FriendsFrameStatusDropDown)

		for i = 1, FRIENDS_TO_DISPLAY do
			local bu = _G["FriendsFrameFriendsScrollFrameButton"..i]
			local ic = bu.gameIcon
			local inv = _G["FriendsFrameFriendsScrollFrameButton"..i.."TravelPassButton"]

			bu:SetHighlightTexture(media.backdrop)
			bu:GetHighlightTexture():SetVertexColor(.24, .56, 1, .2)

			ic:SetSize(22, 22)
			ic:SetTexCoord(.15, .85, .15, .85)

			inv:SetAlpha(0)
			inv:EnableMouse(false)

			_G["FriendsFrameFriendsScrollFrameButton"..i.."Background"]:Hide()
		end

		local function UpdateScroll()
			for i = 1, FRIENDS_TO_DISPLAY do
				local bu = _G["FriendsFrameFriendsScrollFrameButton"..i]
				if not bu.bg then
					bu.bg = CreateFrame("Frame", nil, bu)
					bu.bg:SetPoint("TOPLEFT", bu.gameIcon)
					bu.bg:SetPoint("BOTTOMRIGHT", bu.gameIcon)
					S.CreateBD(bu.bg, 0)
				end
				if bu.gameIcon:IsShown() then
					if i == 1 then
						bu.bg:Point("BOTTOMRIGHT", bu.gameIcon, 0, -1)
					else
						bu.bg:SetPoint("BOTTOMRIGHT", bu.gameIcon)
					end
					bu.bg:Show()
					bu.gameIcon:Point("TOPRIGHT", bu, "TOPRIGHT", -2, -2)
				else
					bu.bg:Hide()
				end
			end
		end
		
		hooksecurefunc("FriendsFrame_UpdateFriends", UpdateScroll)
		hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", UpdateScroll)
		
		FriendsFrameStatusDropDown:ClearAllPoints()
		FriendsFrameStatusDropDown:Point("TOPLEFT", FriendsFrame, "TOPLEFT", 10, -28)

		FriendsTabHeaderSoRButton:SetPushedTexture("")
		FriendsTabHeaderSoRButtonIcon:SetTexCoord(.08, .92, .08, .92)
		local sorbg = CreateFrame("Frame", nil, FriendsTabHeaderSoRButton)
		sorbg:Point("TOPLEFT", -1, 1)
		sorbg:Point("BOTTOMRIGHT", 1, -1)
		S.CreateBD(sorbg, 0)
		
		FriendsFrameBattlenetFrame:GetRegions():Hide()
		S.CreateBD(FriendsFrameBattlenetFrame, .25)

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
		S.CreateBD(whoBg, .25)

		-- Battletag invite frame

		for i = 1, 9 do
			select(i, BattleTagInviteFrame.NoteFrame:GetRegions()):Hide()
		end

		S.CreateBD(BattleTagInviteFrame)
		S.CreateSD(BattleTagInviteFrame)
		S.CreateBD(BattleTagInviteFrame.NoteFrame, .25)

		local _, send, cancel = BattleTagInviteFrame:GetChildren()
		S.Reskin(send)
		S.Reskin(cancel)

		S.ReskinScroll(BattleTagInviteFrameScrollFrameScrollBar)
		
		-- Nav Bar

		local function navButtonFrameLevel(self)
			for i=1, #self.navList do
				local navButton = self.navList[i]
				local lastNav = self.navList[i-1]
				if navButton and lastNav then
					navButton:SetFrameLevel(lastNav:GetFrameLevel() - 2)
					navButton:ClearAllPoints()
					navButton:Point("LEFT", lastNav, "RIGHT", 1, 0)
				end
			end
		end

		hooksecurefunc("NavBar_AddButton", function(self, buttonData)
			local navButton = self.navList[#self.navList]

			if not navButton.skinned then
				S.Reskin(navButton)
				navButton:GetRegions():SetAlpha(0)
				select(2, navButton:GetRegions()):SetAlpha(0)
				select(3, navButton:GetRegions()):SetAlpha(0)

				navButton.skinned = true

				navButton:HookScript("OnClick", function()
					navButtonFrameLevel(self)
				end)
			end

			navButtonFrameLevel(self)
		end)

		-- Character frame

		S.ReskinPortraitFrame(CharacterFrame, true)

		local slots = {
			"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
			"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
			"SecondaryHand", "Tabard",
		}

		for i = 1, #slots do
			local slot = _G["Character"..slots[i].."Slot"]
			local ic = _G["Character"..slots[i].."SlotIconTexture"]
			_G["Character"..slots[i].."SlotFrame"]:Hide()

			slot:SetNormalTexture("")
			slot:SetPushedTexture("")
			ic:SetTexCoord(.08, .92, .08, .92)

			slot.bg = S.CreateBG(slot)
		end

		select(10, CharacterMainHandSlot:GetRegions()):Hide()
		select(10, CharacterSecondaryHandSlot:GetRegions()):Hide()

		hooksecurefunc("PaperDollItemSlotButton_Update", function()
			for i = 1, #slots do
				local slot = _G["Character"..slots[i].."Slot"]
				local ic = _G["Character"..slots[i].."SlotIconTexture"]
				if i == 18 then i = 19 end
				if GetInventoryItemLink("player", i) then
					ic:SetAlpha(1)
					slot.bg:SetAlpha(1)
				else
					ic:SetAlpha(0)
					slot.bg:SetAlpha(0)
				end
			end
		end)

		for i = 1, #PAPERDOLL_SIDEBARS do
			local tab = _G["PaperDollSidebarTab"..i]

			if i == 1 then
				for i = 1, 4 do
					local region = select(i, tab:GetRegions())
					region:SetTexCoord(0.16, 0.86, 0.16, 0.86)
					region.SetTexCoord = function() end
				end
			end

			tab.Highlight:SetTexture(r, g, b, .2)
			tab.Highlight:Point("TOPLEFT", 3, -4)
			tab.Highlight:Point("BOTTOMRIGHT", -1, 0)
			tab.Hider:SetTexture(.3, .3, .3, .4)
			tab.TabBg:SetAlpha(0)

			select(2, tab:GetRegions()):ClearAllPoints()
			if i == 1 then
				select(2, tab:GetRegions()):Point("TOPLEFT", 3, -4)
				select(2, tab:GetRegions()):Point("BOTTOMRIGHT", -1, 0)
			else
				select(2, tab:GetRegions()):Point("TOPLEFT", 2, -4)
				select(2, tab:GetRegions()):Point("BOTTOMRIGHT", -1, -1)
			end

			tab.bg = CreateFrame("Frame", nil, tab)
			tab.bg:Point("TOPLEFT", 2, -3)
			tab.bg:Point("BOTTOMRIGHT", 0, -1)
			tab.bg:SetFrameLevel(0)
			S.CreateBD(tab.bg)

			tab.Hider:Point("TOPLEFT", tab.bg, 1, -1)
			tab.Hider:Point("BOTTOMRIGHT", tab.bg, -1, 1)
		end

		for i = 1, NUM_GEARSET_ICONS_SHOWN do
			local bu = _G["GearManagerDialogPopupButton"..i]
			local ic = _G["GearManagerDialogPopupButton"..i.."Icon"]

			bu:SetCheckedTexture(media.checked)
			select(2, bu:GetRegions()):Hide()
			ic:Point("TOPLEFT", 1, -1)
			ic:Point("BOTTOMRIGHT", -1, 1)
			ic:SetTexCoord(.08, .92, .08, .92)

			S.CreateBD(bu, .25)
		end

		local sets = false
		PaperDollSidebarTab3:HookScript("OnClick", function()
			if sets == false then
				for i = 1, 9 do
					local bu = _G["PaperDollEquipmentManagerPaneButton"..i]
					local bd = _G["PaperDollEquipmentManagerPaneButton"..i.."Stripe"]
					local ic = _G["PaperDollEquipmentManagerPaneButton"..i.."Icon"]
					_G["PaperDollEquipmentManagerPaneButton"..i.."BgTop"]:SetAlpha(0)
					_G["PaperDollEquipmentManagerPaneButton"..i.."BgMiddle"]:Hide()
					_G["PaperDollEquipmentManagerPaneButton"..i.."BgBottom"]:SetAlpha(0)

					bd:Hide()
					bd.Show = function() end
					ic:SetTexCoord(.08, .92, .08, .92)

					S.CreateBG(ic)
				end
				sets = true
			end
		end)

		EquipmentFlyoutFrameButtons:HookScript("OnShow", function(self)
			for i = 1, 10 do
				local bu = _G["EquipmentFlyoutFrameButton"..i]
				if bu and not bu.reskinned then
					bu:SetNormalTexture("")
					bu:SetPushedTexture("")
					S.CreateBG(bu)

					_G["EquipmentFlyoutFrameButton"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)

					bu.reskinned = true
				end

			end
		end)

		-- Quest Frame

		S.ReskinPortraitFrame(QuestLogFrame, true)
		S.ReskinPortraitFrame(QuestLogDetailFrame, true)
		S.ReskinPortraitFrame(QuestFrame, true)

		S.CreateBD(QuestLogCount, .25)

		QuestFrameDetailPanel:DisableDrawLayer("BACKGROUND")
		QuestFrameProgressPanel:DisableDrawLayer("BACKGROUND")
		QuestFrameRewardPanel:DisableDrawLayer("BACKGROUND")
		QuestFrameGreetingPanel:DisableDrawLayer("BACKGROUND")
		EmptyQuestLogFrame:DisableDrawLayer("BACKGROUND")
		QuestFrameDetailPanel:DisableDrawLayer("BORDER")
		QuestFrameRewardPanel:DisableDrawLayer("BORDER")

		select(18, QuestLogFrame:GetRegions()):Hide()
		select(18, QuestLogDetailFrame:GetRegions()):Hide()

		QuestLogFramePageBg:Hide()
		QuestLogFrameBookBg:Hide()
		QuestLogDetailFramePageBg:Hide()
		QuestLogScrollFrameTop:Hide()
		QuestLogScrollFrameBottom:Hide()
		QuestLogScrollFrameMiddle:Hide()
		QuestLogDetailScrollFrameTop:Hide()
		QuestLogDetailScrollFrameBottom:Hide()
		QuestLogDetailScrollFrameMiddle:Hide()
		QuestDetailScrollFrameTop:Hide()
		QuestDetailScrollFrameBottom:Hide()
		QuestDetailScrollFrameMiddle:Hide()
		QuestProgressScrollFrameTop:Hide()
		QuestProgressScrollFrameBottom:Hide()
		QuestProgressScrollFrameMiddle:Hide()
		QuestRewardScrollFrameTop:Hide()
		QuestRewardScrollFrameBottom:Hide()
		QuestRewardScrollFrameMiddle:Hide()
		QuestGreetingScrollFrameTop:Hide()
		QuestGreetingScrollFrameBottom:Hide()
		QuestGreetingScrollFrameMiddle:Hide()
		QuestDetailLeftBorder:Hide()
		QuestDetailBotLeftCorner:Hide()
		QuestDetailTopLeftCorner:Hide()

		QuestNPCModelShadowOverlay:Hide()
		QuestNPCModelBg:Hide()
		QuestNPCModel:DisableDrawLayer("OVERLAY")
		QuestNPCModelNameText:SetDrawLayer("ARTWORK")
		QuestNPCModelTextFrameBg:Hide()
		QuestNPCModelTextFrame:DisableDrawLayer("OVERLAY")

		for i = 1, 9 do
			select(i, QuestLogCount:GetRegions()):Hide()
		end

		QuestLogDetailTitleText:SetDrawLayer("OVERLAY")
		QuestInfoItemHighlight:GetRegions():Hide()
		QuestInfoSpellObjectiveFrameNameFrame:Hide()
		QuestFrameProgressPanelMaterialTopLeft:SetAlpha(0)
		QuestFrameProgressPanelMaterialTopRight:SetAlpha(0)
		QuestFrameProgressPanelMaterialBotLeft:SetAlpha(0)
		QuestFrameProgressPanelMaterialBotRight:SetAlpha(0)

		QuestLogFramePushQuestButton:ClearAllPoints()
		QuestLogFramePushQuestButton:Point("LEFT", QuestLogFrameAbandonButton, "RIGHT", 1, 0)
		QuestLogFramePushQuestButton:Width(100)
		QuestLogFrameTrackButton:ClearAllPoints()
		QuestLogFrameTrackButton:Point("LEFT", QuestLogFramePushQuestButton, "RIGHT", 1, 0)

		QuestLogFrameShowMapButton.texture:Hide()
		QuestLogFrameShowMapButtonHighlight:SetAlpha(0)
		QuestLogFrameShowMapButton:Size(QuestLogFrameShowMapButton.text:GetStringWidth() + 14, 22)
		QuestLogFrameShowMapButton.text:ClearAllPoints()
		QuestLogFrameShowMapButton.text:Point("CENTER", 1, 0)
		S.Reskin(QuestLogFrameShowMapButton)
		
		local line = QuestFrameGreetingPanel:CreateTexture()
		line:SetTexture(1, 1, 1, .2)
		line:SetSize(256, 1)
		line:SetPoint("CENTER", QuestGreetingFrameHorizontalBreak)

		QuestGreetingFrameHorizontalBreak:SetTexture("")

		QuestFrameGreetingPanel:HookScript("OnShow", function()
			line:SetShown(QuestGreetingFrameHorizontalBreak:IsShown())
		end)

		local npcbd = CreateFrame("Frame", nil, QuestNPCModel)
		npcbd:Point("TOPLEFT", 0, 1)
		npcbd:Point("RIGHT", 1, 0)
		npcbd:SetPoint("BOTTOM", QuestNPCModelTextScrollFrame)
		npcbd:SetFrameLevel(QuestNPCModel:GetFrameLevel()-1)
		S.CreateBD(npcbd)

		local npcLine = CreateFrame("Frame", nil, QuestNPCModel)
		npcLine:Point("BOTTOMLEFT", 0, -1)
		npcLine:Point("BOTTOMRIGHT", 0, -1)
		npcLine:Height(1)
		npcLine:SetFrameLevel(QuestNPCModel:GetFrameLevel()-1)
		S.CreateBD(npcLine, 0)

		QuestInfoSkillPointFrameIconTexture:Size(40, 40)
		QuestInfoSkillPointFrameIconTexture:SetTexCoord(.08, .92, .08, .92)

		local bg = CreateFrame("Frame", nil, QuestInfoSkillPointFrame)
		bg:Point("TOPLEFT", -3, 0)
		bg:Point("BOTTOMRIGHT", -3, 0)
		bg:Lower()
		S.CreateBD(bg, .25)
		
		QuestInfoSkillPointFrameNameFrame:Hide()
		QuestInfoSkillPointFrameName:SetParent(bg)
		QuestInfoSkillPointFrameIconTexture:SetParent(bg)
		QuestInfoSkillPointFrameSkillPointBg:SetParent(bg)
		QuestInfoSkillPointFrameSkillPointBgGlow:SetParent(bg)
		QuestInfoSkillPointFramePoints:SetParent(bg)

		local skillPointLine = QuestInfoSkillPointFrame:CreateTexture(nil, "BACKGROUND")
		skillPointLine:Size(1, 40)
		skillPointLine:Point("RIGHT", QuestInfoSkillPointFrameIconTexture, 1, 0)
		skillPointLine:SetTexture(media.backdrop)
		skillPointLine:SetVertexColor(0, 0, 0)

		QuestInfoRewardSpellIconTexture:SetSize(40, 40)
		QuestInfoRewardSpellIconTexture:SetTexCoord(.08, .92, .08, .92)
		QuestInfoRewardSpellIconTexture:SetDrawLayer("OVERLAY")

		local bg = CreateFrame("Frame", nil, QuestInfoRewardSpell)
		bg:Point("TOPLEFT", 9, -1)
		bg:Point("BOTTOMRIGHT", -10, 13)
		bg:Lower()
		S.CreateBD(bg, .25)

		QuestInfoRewardSpellNameFrame:Hide()
		QuestInfoRewardSpellSpellBorder:Hide()
		QuestInfoRewardSpellName:SetParent(bg)
		QuestInfoRewardSpellIconTexture:SetParent(bg)

		local spellLine = QuestInfoRewardSpell:CreateTexture(nil, "BACKGROUND")
		spellLine:Size(1, 40)
		spellLine:SetPoint("RIGHT", QuestInfoRewardSpellIconTexture, 1, 0)
		spellLine:SetTexture(media.backdrop)
		spellLine:SetVertexColor(0, 0, 0)

		local function clearHighlight()
			for i = 1, MAX_NUM_ITEMS do
				_G["QuestInfoItem"..i]:SetBackdropColor(0, 0, 0, .25)
			end
		end

		local function setHighlight(self)
			clearHighlight()

			local _, point = self:GetPoint()
			point:SetBackdropColor(r, g, b, .2)
		end

		hooksecurefunc(QuestInfoItemHighlight, "SetPoint", setHighlight)
		QuestInfoItemHighlight:HookScript("OnShow", setHighlight)
		QuestInfoItemHighlight:HookScript("OnHide", clearHighlight)

		for i = 1, MAX_REQUIRED_ITEMS do
			local bu = _G["QuestProgressItem"..i]
			local ic = _G["QuestProgressItem"..i.."IconTexture"]
			local na = _G["QuestProgressItem"..i.."NameFrame"]
			local co = _G["QuestProgressItem"..i.."Count"]
				
			ic:Size(40, 40)
			ic:SetTexCoord(.08, .92, .08, .92)
			ic:SetDrawLayer("OVERLAY")

			S.CreateBD(bu, .25)

			na:Hide()
			co:SetDrawLayer("OVERLAY")

			local line = CreateFrame("Frame", nil, bu)
			line:Size(1, 40)
			line:Point("RIGHT", ic, 1, 0)
			S.CreateBD(line)
		end

		for i = 1, MAX_NUM_ITEMS do
			local bu = _G["QuestInfoItem"..i]
			local ic = _G["QuestInfoItem"..i.."IconTexture"]
			local na = _G["QuestInfoItem"..i.."NameFrame"]
			local co = _G["QuestInfoItem"..i.."Count"]

			ic:Point("TOPLEFT", 1, -1)
			ic:Size(39, 39)
			ic:SetTexCoord(.08, .92, .08, .92)
			ic:SetDrawLayer("OVERLAY")

			S.CreateBD(bu, .25)

			na:Hide()
			co:SetDrawLayer("OVERLAY")

			local line = CreateFrame("Frame", nil, bu)
			line:Size(1, 40)
			line:Point("RIGHT", ic, 1, 0)
			S.CreateBD(line)
		end

		local function updateQuest()
			local numEntries = GetNumQuestLogEntries()

			local buttons = QuestLogScrollFrame.buttons
			local numButtons = #buttons
			local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
			local questLogTitle, questIndex
			local isHeader, isCollapsed

			for i = 1, numButtons do
				questLogTitle = buttons[i]
				questIndex = i + scrollOffset

				if not questLogTitle.reskinned then
					questLogTitle.reskinned = true

					questLogTitle:SetNormalTexture("")
					questLogTitle.SetNormalTexture = function() end
					questLogTitle:SetPushedTexture("")
					questLogTitle:SetHighlightTexture("")
					questLogTitle.SetHighlightTexture = function() end

					questLogTitle.bg = CreateFrame("Frame", nil, questLogTitle)
					questLogTitle.bg:Size(13, 13)
					questLogTitle.bg:Point("LEFT", 4, 0)
					questLogTitle.bg:SetFrameLevel(questLogTitle:GetFrameLevel()-1)
					S.CreateBD(questLogTitle.bg, 0)

					questLogTitle.tex = questLogTitle:CreateTexture(nil, "BACKGROUND")
					questLogTitle.tex:SetAllPoints(questLogTitle.bg)
					questLogTitle.tex:SetTexture(media.backdrop)
					questLogTitle.tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

					questLogTitle.minus = questLogTitle:CreateTexture(nil, "OVERLAY")
					questLogTitle.minus:Size(7, 1)
					questLogTitle.minus:SetPoint("CENTER", questLogTitle.bg)
					questLogTitle.minus:SetTexture(media.backdrop)
					questLogTitle.minus:SetVertexColor(1, 1, 1)

					questLogTitle.plus = questLogTitle:CreateTexture(nil, "OVERLAY")
					questLogTitle.plus:Size(1, 7)
					questLogTitle.plus:SetPoint("CENTER", questLogTitle.bg)
					questLogTitle.plus:SetTexture(media.backdrop)
					questLogTitle.plus:SetVertexColor(1, 1, 1)
				end

				if questIndex <= numEntries then
					_, _, _, _, isHeader, isCollapsed = GetQuestLogTitle(questIndex)
					if isHeader then
						questLogTitle.bg:Show()
						questLogTitle.tex:Show()
						questLogTitle.minus:Show()
						if isCollapsed then
							questLogTitle.plus:Show()
						else
							questLogTitle.plus:Hide()
						end
					else
						questLogTitle.bg:Hide()
						questLogTitle.tex:Hide()
						questLogTitle.minus:Hide()
						questLogTitle.plus:Hide()
					end
				end
			end
		end

		hooksecurefunc("QuestLog_Update", updateQuest)
		QuestLogScrollFrame:HookScript("OnVerticalScroll", updateQuest)
		QuestLogScrollFrame:HookScript("OnMouseWheel", updateQuest)

		hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, x, y)
			QuestNPCModel:Point("TOPLEFT", parentFrame, "TOPRIGHT", x+6, y)
		end)

		local questButtons = {"QuestLogFrameAbandonButton", "QuestLogFramePushQuestButton", "QuestLogFrameTrackButton", "QuestLogFrameCancelButton", "QuestFrameAcceptButton", "QuestFrameDeclineButton", "QuestFrameCompleteQuestButton", "QuestFrameCompleteButton", "QuestFrameGoodbyeButton", "QuestFrameGreetingGoodbyeButton", "QuestLogFrameCompleteButton"}
		for i = 1, #questButtons do
			S.Reskin(_G[questButtons[i]])
		end

		S.ReskinScroll(QuestLogScrollFrameScrollBar)
		S.ReskinScroll(QuestLogDetailScrollFrameScrollBar)
		S.ReskinScroll(QuestProgressScrollFrameScrollBar)
		S.ReskinScroll(QuestRewardScrollFrameScrollBar)
		S.ReskinScroll(QuestDetailScrollFrameScrollBar)
		S.ReskinScroll(QuestGreetingScrollFrameScrollBar)
		S.ReskinScroll(QuestNPCModelTextScrollFrameScrollBar)

		-- Gossip Frame

		GossipGreetingScrollFrameTop:Hide()
		GossipGreetingScrollFrameBottom:Hide()
		GossipGreetingScrollFrameMiddle:Hide()
		select(19, GossipFrame:GetRegions()):Hide()

		GossipGreetingText:SetTextColor(1, 1, 1)
		
		NPCFriendshipStatusBar:GetRegions():Hide()
		NPCFriendshipStatusBarNotch1:SetTexture(0, 0, 0)
		NPCFriendshipStatusBarNotch1:SetSize(1, 16)
		NPCFriendshipStatusBarNotch2:SetTexture(0, 0, 0)
		NPCFriendshipStatusBarNotch2:SetSize(1, 16)
		NPCFriendshipStatusBarNotch3:SetTexture(0, 0, 0)
		NPCFriendshipStatusBarNotch3:SetSize(1, 16)
		NPCFriendshipStatusBarNotch4:SetTexture(0, 0, 0)
		NPCFriendshipStatusBarNotch4:SetSize(1, 16)
		select(7, NPCFriendshipStatusBar:GetRegions()):Hide()

		NPCFriendshipStatusBar.icon:SetPoint("TOPLEFT", -30, 7)
		S.CreateBDFrame(NPCFriendshipStatusBar, .25)
		S.ReskinPortraitFrame(GossipFrame, true)
		S.Reskin(GossipFrameGreetingGoodbyeButton)
		S.ReskinScroll(GossipGreetingScrollFrameScrollBar)

		-- PVP Frame

		PVPFrameTopInset:DisableDrawLayer("BORDER")
		PVPFrameTopInsetBg:Hide()

		PVPTeamManagementFrameFlag2Header:SetAlpha(0)
		PVPTeamManagementFrameFlag3Header:SetAlpha(0)
		PVPTeamManagementFrameFlag5Header:SetAlpha(0)
		PVPTeamManagementFrameFlag2HeaderSelected:SetAlpha(0)
		PVPTeamManagementFrameFlag3HeaderSelected:SetAlpha(0)
		PVPTeamManagementFrameFlag5HeaderSelected:SetAlpha(0)
		PVPTeamManagementFrameFlag2Title:SetTextColor(1, 1, 1)
		PVPTeamManagementFrameFlag3Title:SetTextColor(1, 1, 1)
		PVPTeamManagementFrameFlag5Title:SetTextColor(1, 1, 1)
		PVPTeamManagementFrameFlag2Title.SetTextColor = function() end
		PVPTeamManagementFrameFlag3Title.SetTextColor = function() end
		PVPTeamManagementFrameFlag5Title.SetTextColor = function() end

		local pvpbg = CreateFrame("Frame", nil, PVPTeamManagementFrame)
		pvpbg:SetPoint("TOPLEFT", PVPTeamManagementFrameFlag2)
		pvpbg:SetPoint("BOTTOMRIGHT", PVPTeamManagementFrameFlag5)
		S.CreateBD(pvpbg, .25)

		PVPFrameConquestBarLeft:Hide()
		PVPFrameConquestBarMiddle:Hide()
		PVPFrameConquestBarRight:Hide()
		PVPFrameConquestBarBG:Hide()
		PVPFrameConquestBarShadow:Hide()
		PVPFrameConquestBarCap1:SetAlpha(0)

		for i = 1, 4 do
			_G["PVPFrameConquestBarDivider"..i]:Hide()
		end

		PVPFrameConquestBarProgress:SetTexture(media.backdrop)
		PVPFrameConquestBarProgress:SetGradient("VERTICAL", .7, 0, 0, .8, 0, 0)

		local qbg = CreateFrame("Frame", nil, PVPFrameConquestBar)
		qbg:Point("TOPLEFT", -1, -2)
		qbg:Point("BOTTOMRIGHT", 1, 2)
		qbg:SetFrameLevel(PVPFrameConquestBar:GetFrameLevel()-1)
		S.CreateBD(qbg, .25)

		S.ReskinPortraitFrame(PVPFrame, true)

		-- StaticPopup

		for i = 1, 2 do
			local bu = _G["StaticPopup"..i.."ItemFrame"]
			_G["StaticPopup"..i.."ItemFrameNameFrame"]:Hide()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:SetTexCoord(.08, .92, .08, .92)

			bu:SetNormalTexture("")
			S.CreateBG(bu)
		end

		-- PvP cap bar

		local function CaptureBar()
			if not NUM_EXTENDED_UI_FRAMES then return end
			for i = 1, NUM_EXTENDED_UI_FRAMES do
				local barname = "WorldStateCaptureBar"..i
				local bar = _G[barname]

				if bar and bar:IsVisible() then
					bar:ClearAllPoints()
					bar:Point("TOP", UIParent, "TOP", 0, -120)
					if not bar.skinned then
						local left = _G[barname.."LeftBar"]
						local right = _G[barname.."RightBar"]
						local middle = _G[barname.."MiddleBar"]

						left:SetTexture(media.backdrop)
						right:SetTexture(media.backdrop)
						middle:SetTexture(media.backdrop)
						left:SetDrawLayer("BORDER")
						middle:SetDrawLayer("ARTWORK")
						right:SetDrawLayer("BORDER")

						left:SetGradient("VERTICAL", .1, .4, .9, .2, .6, 1)
						right:SetGradient("VERTICAL", .7, .1, .1, .9, .2, .2)
						middle:SetGradient("VERTICAL", .8, .8, .8, 1, 1, 1)

						_G[barname.."RightLine"]:SetAlpha(0)
						_G[barname.."LeftLine"]:SetAlpha(0)
						select(4, bar:GetRegions()):Hide()
						_G[barname.."LeftIconHighlight"]:SetAlpha(0)
						_G[barname.."RightIconHighlight"]:SetAlpha(0)

						bar.bg = bar:CreateTexture(nil, "BACKGROUND")
						bar.bg:Point("TOPLEFT", left, -1, 1)
						bar.bg:Point("BOTTOMRIGHT", right, 1, -1)
						bar.bg:SetTexture(media.backdrop)
						bar.bg:SetVertexColor(0, 0, 0)

						bar.bgmiddle = CreateFrame("Frame", nil, bar)
						bar.bgmiddle:SetPoint("TOPLEFT", middle, -1, 1)
						bar.bgmiddle:SetPoint("BOTTOMRIGHT", middle, 1, -1)
						S.CreateBD(bar.bgmiddle, 0)

						bar.skinned = true
					end
				end
			end
		end

		hooksecurefunc("UIParent_ManageFramePositions", CaptureBar)
		-- Achievement popup

		local function fixBg(f)
			if f:GetObjectType() == "AnimationGroup" then
				f = f:GetParent()
			end
			f.bg:SetBackdropColor(0, 0, 0, alpha)
		end

		hooksecurefunc("AlertFrame_FixAnchors", function()
			for i = 1, MAX_ACHIEVEMENT_ALERTS do
				local frame = _G["AchievementAlertFrame"..i]

				if frame then
					frame:SetAlpha(1)
					frame.SetAlpha = function() end

					local ic = _G["AchievementAlertFrame"..i.."Icon"]
					local texture = _G["AchievementAlertFrame"..i.."IconTexture"]
					local guildName = _G["AchievementAlertFrame"..i.."GuildName"]

					ic:ClearAllPoints()
					ic:Point("LEFT", frame, "LEFT", -26, 0)

					if not frame.bg then
						frame.bg = CreateFrame("Frame", nil, frame)
						frame.bg:Point("TOPLEFT", texture, -10, 12)
						frame.bg:Point("BOTTOMRIGHT", texture, "BOTTOMRIGHT", 240, -12)
						frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
						S.CreateBD(frame.bg)

						frame:HookScript("OnEnter", fixBg)
						frame:HookScript("OnShow", fixBg)
						frame.animIn:HookScript("OnFinished", fixBg)
						S.CreateBD(frame.bg)

						S.CreateBG(texture)

						_G["AchievementAlertFrame"..i.."Background"]:Hide()
						_G["AchievementAlertFrame"..i.."IconOverlay"]:Hide()
						_G["AchievementAlertFrame"..i.."GuildBanner"]:SetTexture("")
						_G["AchievementAlertFrame"..i.."GuildBorder"]:SetTexture("")
						_G["AchievementAlertFrame"..i.."OldAchievement"]:SetTexture("")
							
						guildName:ClearAllPoints()
						guildName:Point("TOPLEFT", 50, -14)
						guildName:Point("TOPRIGHT", -50, -14)

						_G["AchievementAlertFrame"..i.."Unlocked"]:SetTextColor(1, 1, 1)
						_G["AchievementAlertFrame"..i.."Unlocked"]:SetShadowOffset(1, -1)
					end

					frame.glow:Hide()
					frame.shine:Hide()
					frame.glow.Show = function() end
					frame.shine.Show = function() end

					texture:SetTexCoord(.08, .92, .08, .92)

					if guildName:IsShown() then
						_G["AchievementAlertFrame"..i.."Shield"]:Point("TOPRIGHT", -10, -22)
					end
				end
			end
		end)

		-- Guild challenges

		local challenge = CreateFrame("Frame", nil, GuildChallengeAlertFrame)
		challenge:Point("TOPLEFT", 8, -12)
		challenge:Point("BOTTOMRIGHT", -8, 13)
		challenge:SetFrameLevel(GuildChallengeAlertFrame:GetFrameLevel()-1)
		S.CreateBD(challenge)
		S.CreateBG(GuildChallengeAlertFrameEmblemBackground)

		GuildChallengeAlertFrameGlow:SetTexture("")
		GuildChallengeAlertFrameShine:SetTexture("")
		GuildChallengeAlertFrameEmblemBorder:SetTexture("")

		-- Dungeon completion rewards

		local bg = CreateFrame("Frame", nil, DungeonCompletionAlertFrame1)
		bg:Point("TOPLEFT", 6, -14)
		bg:Point("BOTTOMRIGHT", -6, 6)
		bg:SetFrameLevel(DungeonCompletionAlertFrame1:GetFrameLevel()-1)
		S.CreateBD(bg)

		DungeonCompletionAlertFrame1DungeonTexture:SetDrawLayer("ARTWORK")
		DungeonCompletionAlertFrame1DungeonTexture:SetTexCoord(.02, .98, .02, .98)
		S.CreateBG(DungeonCompletionAlertFrame1DungeonTexture)

		DungeonCompletionAlertFrame1.dungeonArt1:SetAlpha(0)
		DungeonCompletionAlertFrame1.dungeonArt2:SetAlpha(0)
		DungeonCompletionAlertFrame1.dungeonArt3:SetAlpha(0)
		DungeonCompletionAlertFrame1.dungeonArt4:SetAlpha(0)
		DungeonCompletionAlertFrame1.raidArt:SetAlpha(0)

		DungeonCompletionAlertFrame1.dungeonTexture:Point("BOTTOMLEFT", DungeonCompletionAlertFrame1, "BOTTOMLEFT", 13, 13)
		DungeonCompletionAlertFrame1.dungeonTexture.SetPoint = function() end
		
		DungeonCompletionAlertFrame1.shine:Hide()
		DungeonCompletionAlertFrame1.shine.Show = function() end
		DungeonCompletionAlertFrame1.glow:Hide()
		DungeonCompletionAlertFrame1.glow.Show = function() end
		
		hooksecurefunc("DungeonCompletionAlertFrame_ShowAlert", function()
			for i = 1, 3 do
				local bu = _G["DungeonCompletionAlertFrame1Reward"..i]
				if bu and not bu.reskinned then
					_G["DungeonCompletionAlertFrame1Reward"..i.."Border"]:Hide()

					bu.texture:SetTexCoord(.08, .92, .08, .92)
					S.CreateBG(bu.texture)

					bu.rekinned = true
				end
			end
		end)

		-- Challenge popup

		hooksecurefunc("AlertFrame_SetChallengeModeAnchors", function()
			local frame = ChallengeModeAlertFrame1

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = function() end

				if not frame.bg then
					frame.bg = CreateFrame("Frame", nil, frame)
					frame.bg:Point("TOPLEFT", ChallengeModeAlertFrame1DungeonTexture, -12, 12)
					frame.bg:Point("BOTTOMRIGHT", ChallengeModeAlertFrame1DungeonTexture, 243, -12)
					frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
					S.CreateBD(frame.bg)

					frame:HookScript("OnEnter", fixBg)
					frame:HookScript("OnShow", fixBg)
					frame.animIn:HookScript("OnFinished", fixBg)

					S.CreateBG(ChallengeModeAlertFrame1DungeonTexture)
				end

				frame:GetRegions():Hide()

				ChallengeModeAlertFrame1Shine:Hide()
				ChallengeModeAlertFrame1Shine.Show = function() end
				ChallengeModeAlertFrame1GlowFrame:Hide()
				ChallengeModeAlertFrame1GlowFrame.Show = function() end
				ChallengeModeAlertFrame1Border:Hide()
				ChallengeModeAlertFrame1Border.Show = function() end

				ChallengeModeAlertFrame1DungeonTexture:SetTexCoord(.08, .92, .08, .92)
			end
		end)

		-- Scenario alert

		hooksecurefunc("AlertFrame_SetScenarioAnchors", function()
			local frame = ScenarioAlertFrame1

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = function() end

				if not frame.bg then
					frame.bg = CreateFrame("Frame", nil, frame)
					frame.bg:Point("TOPLEFT", ScenarioAlertFrame1DungeonTexture, -12, 12)
					frame.bg:Point("BOTTOMRIGHT", ScenarioAlertFrame1DungeonTexture, 244, -12)
					frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
					S.CreateBD(frame.bg)

					--frame:HookScript("OnEnter", fixBg)
					--frame:HookScript("OnShow", fixBg)
					--frame.animIn:HookScript("OnFinished", fixBg)

					S.CreateBG(ScenarioAlertFrame1DungeonTexture)
					ScenarioAlertFrame1DungeonTexture:SetDrawLayer("OVERLAY")
				end

				frame:GetRegions():Hide()
				select(3, frame:GetRegions()):Hide()
				
				ScenarioAlertFrame1Shine:Hide()
				ScenarioAlertFrame1Shine.Show = function() end
				ScenarioAlertFrame1GlowFrame:Hide()
				ScenarioAlertFrame1GlowFrame.Show = function() end
				ScenarioAlertFrame1GlowFrame.glow:Hide()
				ScenarioAlertFrame1GlowFrame.Show = function() end
				
				ScenarioAlertFrame1DungeonTexture:SetTexCoord(.08, .92, .08, .92)
			end
		end)

		-- Loot won alert

		-- I still don't know why I can't parent bg to frame
		local function showHideBg(self)
			self.bg:SetShown(self:IsShown())
		end
		local function onUpdate(self)
			self.bg:SetAlpha(self:GetAlpha())
		end
		hooksecurefunc("LootWonAlertFrame_ShowAlert", function()
			for i = 1, #LOOT_WON_ALERT_FRAMES do
				local frame = LOOT_WON_ALERT_FRAMES[i]
				if not frame.bg then
					frame.bg = CreateFrame("Frame", nil, UIParent)
					frame.bg:Point("TOPLEFT", frame, 10, -10)
					frame.bg:Point("BOTTOMRIGHT", frame, -10, 10)
					frame.bg:SetFrameStrata("DIALOG")
					frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
					frame.bg:SetShown(frame:IsShown())
					S.CreateBD(frame.bg)

					frame:HookScript("OnShow", showHideBg)
					frame:HookScript("OnHide", showHideBg)
					frame:HookScript("OnUpdate", onUpdate)
					
					frame.Background:Hide()
					frame.IconBorder:Hide()
					frame.glow:SetTexture("")
					frame.shine:SetTexture("")

					frame.Icon:SetTexCoord(.08, .92, .08, .92)
					S.CreateBG(frame.Icon)
				end
			end
		end)
		
		-- Money won alert

		hooksecurefunc("MoneyWonAlertFrame_SetUp", function()
			for i = 1, #MONEY_WON_ALERT_FRAMES do
				local frame = MONEY_WON_ALERT_FRAMES[i]
				if not frame.bg then
					frame.bg = CreateFrame("Frame", nil, UIParent)
					frame.bg:Point("TOPLEFT", frame, 10, -10)
					frame.bg:Point("BOTTOMRIGHT", frame, -10, 10)
					frame.bg:SetFrameStrata("DIALOG")
					frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
					frame.bg:SetShown(frame:IsShown())
					S.CreateBD(frame.bg)

					frame:HookScript("OnShow", showHideBg)
					frame:HookScript("OnHide", showHideBg)
					frame:HookScript("OnUpdate", onUpdate)

					frame.Background:Hide()
					frame.IconBorder:Hide()

					frame.Icon:SetTexCoord(.08, .92, .08, .92)
					S.CreateBG(frame.Icon)
				end
			end
		end)
		
		-- Criteria alert

		hooksecurefunc("AlertFrame_SetCriteriaAnchors", function()
			for i = 1, MAX_ACHIEVEMENT_ALERTS do
				local frame = _G["CriteriaAlertFrame"..i]
				if frame and not frame.bg then
					local icon = _G["CriteriaAlertFrame"..i.."IconTexture"]

					frame.bg = CreateFrame("Frame", nil, UIParent)
					frame.bg:Point("TOPLEFT", icon, -6, 5)
					frame.bg:Point("BOTTOMRIGHT", icon, 236, -5)
					frame.bg:SetFrameStrata("DIALOG")
					frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
					S.CreateBD(frame.bg)

					frame:SetScript("OnShow", showHideBg)
					frame:SetScript("OnHide", showHideBg)
					frame:HookScript("OnUpdate", onUpdate)

					_G["CriteriaAlertFrame"..i.."Background"]:Hide()
					_G["CriteriaAlertFrame"..i.."IconOverlay"]:Hide()
					frame.glow:Hide()
					frame.glow.Show = function() end
					frame.shine:Hide()
					frame.shine.Show = function() end

					_G["CriteriaAlertFrame"..i.."Unlocked"]:SetTextColor(.9, .9, .9)

					icon:SetTexCoord(.08, .92, .08, .92)
					S.CreateBG(icon)
				end
			end
		end)
		--BonusRoll
		BonusRollFrame:StripTextures()
		S.CreateBD(BonusRollFrame)
		BonusRollFrame.PromptFrame.Icon:SetTexCoord(.08, .92, .08, .92)
		BonusRollFrame.PromptFrame.IconBackdrop = CreateFrame("Frame", nil, BonusRollFrame.PromptFrame)
		BonusRollFrame.PromptFrame.IconBackdrop:SetFrameLevel(BonusRollFrame.PromptFrame.IconBackdrop:GetFrameLevel() - 1)
		BonusRollFrame.PromptFrame.IconBackdrop:SetOutside(BonusRollFrame.PromptFrame.Icon, 1, 1)
		S.CreateBD(BonusRollFrame.PromptFrame.IconBackdrop)
		BonusRollFrame.BlackBackgroundHoist:Kill()
		BonusRollFrame.PromptFrame.Timer.Bar:SetTexture(media.backdrop)
		-- BonusRollFrame.PromptFrame.Timer.Bar:SetVertexColor(1, 1, 1)
		BonusRollFrame.PromptFrame.Timer.border = CreateFrame("Frame", nil, BonusRollFrame.PromptFrame.Timer)
		BonusRollFrame.PromptFrame.Timer.border:SetFrameLevel(BonusRollFrame.PromptFrame.Timer:GetFrameLevel() - 1)
		BonusRollFrame.PromptFrame.Timer.border:SetOutside(BonusRollFrame.PromptFrame.Timer, 1, 1)
		S.CreateBD(BonusRollFrame.PromptFrame.Timer.border)

		BonusRollMoneyWonFrame:SetAlpha(1)
		BonusRollMoneyWonFrame.SetAlpha = function() end

		if not BonusRollMoneyWonFrame.bg then
			BonusRollMoneyWonFrame.bg = CreateFrame("Frame", nil, BonusRollMoneyWonFrame)
			BonusRollMoneyWonFrame.bg:SetPoint("TOPLEFT", BonusRollMoneyWonFrame, "TOPLEFT", 8, -8)
			BonusRollMoneyWonFrame.bg:SetPoint("BOTTOMRIGHT", BonusRollMoneyWonFrame, "BOTTOMRIGHT", -6, 8)
			BonusRollMoneyWonFrame.bg:SetFrameLevel(BonusRollMoneyWonFrame:GetFrameLevel()-1)

			-- Icon border
			if not BonusRollMoneyWonFrame.Icon.b then
				BonusRollMoneyWonFrame.Icon.b = S.CreateBG(BonusRollMoneyWonFrame.Icon)
			end

			BonusRollMoneyWonFrame:HookScript("OnEnter", function()
				S.CreateBD(BonusRollMoneyWonFrame.bg)
			end)

			BonusRollMoneyWonFrame.animIn:HookScript("OnFinished", function()
				S.CreateBD(BonusRollMoneyWonFrame.bg)
			end)
		end
		BonusRollMoneyWonFrame.Background:Kill()
		BonusRollMoneyWonFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		BonusRollMoneyWonFrame.IconBorder:Kill()
	
		-- Help frame

		for i = 1, 15 do
			local bu = _G["HelpFrameKnowledgebaseScrollFrameButton"..i]
			bu:DisableDrawLayer("ARTWORK")
			S.CreateBD(bu, 0)

			S.CreateGradient(bu)
		end

		HelpFrameCharacterStuckHearthstone:Size(56, 56)
		S.CreateBG(HelpFrameCharacterStuckHearthstone)
		HelpFrameCharacterStuckHearthstoneIconTexture:SetTexCoord(.08, .92, .08, .92)

		-- Option panels

		local options = false
		VideoOptionsFrame:HookScript("OnShow", function()
			if options == true then return end
			options = true

			local line = VideoOptionsFrame:CreateTexture(nil, "ARTWORK")
			line:Size(1, 512)
			line:Point("LEFT", 205, 30)
			line:SetTexture(1, 1, 1, .2)

			S.CreateBD(AudioOptionsSoundPanelPlayback, .25)
			S.CreateBD(AudioOptionsSoundPanelHardware, .25)
			S.CreateBD(AudioOptionsSoundPanelVolume, .25)
			S.CreateBD(AudioOptionsVoicePanelTalking, .25)
			S.CreateBD(AudioOptionsVoicePanelBinding, .25)
			S.CreateBD(AudioOptionsVoicePanelListening, .25)

			AudioOptionsSoundPanelPlaybackTitle:Point("BOTTOMLEFT", AudioOptionsSoundPanelPlayback, "TOPLEFT", 5, 2)
			AudioOptionsSoundPanelHardwareTitle:Point("BOTTOMLEFT", AudioOptionsSoundPanelHardware, "TOPLEFT", 5, 2)
			AudioOptionsSoundPanelVolumeTitle:Point("BOTTOMLEFT", AudioOptionsSoundPanelVolume, "TOPLEFT", 5, 2)
			AudioOptionsVoicePanelTalkingTitle:Point("BOTTOMLEFT", AudioOptionsVoicePanelTalking, "TOPLEFT", 5, 2)
			AudioOptionsVoicePanelListeningTitle:Point("BOTTOMLEFT", AudioOptionsVoicePanelListening, "TOPLEFT", 5, 2)

			local dropdowns = {"Graphics_DisplayModeDropDown", "Graphics_ResolutionDropDown", "Graphics_RefreshDropDown", "Graphics_PrimaryMonitorDropDown", "Graphics_MultiSampleDropDown", "Graphics_VerticalSyncDropDown", "Graphics_TextureResolutionDropDown", "Graphics_FilteringDropDown", "Graphics_ProjectedTexturesDropDown", "Graphics_ShadowsDropDown", "Graphics_LiquidDetailDropDown", "Graphics_SunshaftsDropDown", "Graphics_ParticleDensityDropDown", "Graphics_ViewDistanceDropDown", "Graphics_EnvironmentalDetailDropDown", "Graphics_GroundClutterDropDown", "Graphics_SSAODropDown", "Advanced_BufferingDropDown", "Advanced_LagDropDown", "Advanced_HardwareCursorDropDown", "InterfaceOptionsLanguagesPanelLocaleDropDown", "AudioOptionsSoundPanelHardwareDropDown", "AudioOptionsSoundPanelSoundChannelsDropDown", "AudioOptionsVoicePanelInputDeviceDropDown", "AudioOptionsVoicePanelChatModeDropDown", "AudioOptionsVoicePanelOutputDeviceDropDown"}
			for i = 1, #dropdowns do
				S.ReskinDropDown(_G[dropdowns[i]])
			end

			Graphics_RightQuality:GetRegions():Hide()
			Graphics_RightQuality:DisableDrawLayer("BORDER")

			local sliders = {"Graphics_Quality", "Advanced_UIScaleSlider", "Advanced_MaxFPSSlider", "Advanced_MaxFPSBKSlider", "Advanced_GammaSlider", "AudioOptionsSoundPanelSoundQuality", "AudioOptionsSoundPanelMasterVolume", "AudioOptionsSoundPanelSoundVolume", "AudioOptionsSoundPanelMusicVolume", "AudioOptionsSoundPanelAmbienceVolume", "AudioOptionsVoicePanelMicrophoneVolume", "AudioOptionsVoicePanelSpeakerVolume", "AudioOptionsVoicePanelSoundFade", "AudioOptionsVoicePanelMusicFade", "AudioOptionsVoicePanelAmbienceFade"}
			for i = 1, #sliders do
				S.ReskinSlider(_G[sliders[i]])
			end

			Graphics_Quality.SetBackdrop = function() end

			local checkboxes = {"InterfaceOptionsControlsPanelStickyTargeting", "InterfaceOptionsControlsPanelAutoDismount", "InterfaceOptionsControlsPanelAutoClearAFK", "InterfaceOptionsControlsPanelBlockTrades", "InterfaceOptionsControlsPanelBlockGuildInvites", "InterfaceOptionsControlsPanelLootAtMouse", "InterfaceOptionsControlsPanelAutoLootCorpse", "InterfaceOptionsControlsPanelInteractOnLeftClick", "InterfaceOptionsCombatPanelAttackOnAssist", "InterfaceOptionsCombatPanelStopAutoAttack", "InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors", "InterfaceOptionsCombatPanelTargetOfTarget", "InterfaceOptionsCombatPanelShowSpellAlerts", "InterfaceOptionsCombatPanelReducedLagTolerance", "InterfaceOptionsCombatPanelActionButtonUseKeyDown", "InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait", "InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates", "InterfaceOptionsCombatPanelAutoSelfCast", "InterfaceOptionsDisplayPanelShowCloak", "InterfaceOptionsDisplayPanelShowHelm", "InterfaceOptionsDisplayPanelShowAggroPercentage", "InterfaceOptionsDisplayPanelPlayAggroSounds", "InterfaceOptionsDisplayPanelShowSpellPointsAvg", "InterfaceOptionsDisplayPanelShowFreeBagSpace", "InterfaceOptionsDisplayPanelCinematicSubtitles", "InterfaceOptionsDisplayPanelRotateMinimap", "InterfaceOptionsDisplayPanelShowAccountAchievments", "InterfaceOptionsObjectivesPanelAutoQuestTracking", "InterfaceOptionsObjectivesPanelMapQuestDifficulty", "InterfaceOptionsObjectivesPanelWatchFrameWidth", "InterfaceOptionsSocialPanelProfanityFilter", "InterfaceOptionsSocialPanelSpamFilter", "InterfaceOptionsSocialPanelChatBubbles", "InterfaceOptionsSocialPanelPartyChat", "InterfaceOptionsSocialPanelChatHoverDelay", "InterfaceOptionsSocialPanelGuildMemberAlert", "InterfaceOptionsSocialPanelChatMouseScroll", "InterfaceOptionsSocialPanelWholeChatWindowClickable", "InterfaceOptionsActionBarsPanelBottomLeft", "InterfaceOptionsActionBarsPanelBottomRight", "InterfaceOptionsActionBarsPanelRight", "InterfaceOptionsActionBarsPanelRightTwo", "InterfaceOptionsActionBarsPanelLockActionBars", "InterfaceOptionsActionBarsPanelAlwaysShowActionBars", "InterfaceOptionsActionBarsPanelSecureAbilityToggle", "InterfaceOptionsNamesPanelMyName", "InterfaceOptionsNamesPanelFriendlyPlayerNames", "InterfaceOptionsNamesPanelFriendlyPets", "InterfaceOptionsNamesPanelFriendlyGuardians", "InterfaceOptionsNamesPanelFriendlyTotems", "InterfaceOptionsNamesPanelUnitNameplatesFriends", "InterfaceOptionsNamesPanelUnitNameplatesFriendlyPets", "InterfaceOptionsNamesPanelUnitNameplatesFriendlyGuardians", "InterfaceOptionsNamesPanelUnitNameplatesFriendlyTotems", "InterfaceOptionsNamesPanelGuilds", "InterfaceOptionsNamesPanelGuildTitles", "InterfaceOptionsNamesPanelTitles", "InterfaceOptionsNamesPanelNonCombatCreature", "InterfaceOptionsNamesPanelEnemyPlayerNames", "InterfaceOptionsNamesPanelEnemyPets", "InterfaceOptionsNamesPanelEnemyGuardians", "InterfaceOptionsNamesPanelEnemyTotems", "InterfaceOptionsNamesPanelUnitNameplatesEnemies", "InterfaceOptionsNamesPanelUnitNameplatesEnemyPets", "InterfaceOptionsNamesPanelUnitNameplatesEnemyGuardians", "InterfaceOptionsNamesPanelUnitNameplatesEnemyTotems", "InterfaceOptionsCombatTextPanelTargetDamage", "InterfaceOptionsCombatTextPanelPeriodicDamage", "InterfaceOptionsCombatTextPanelPetDamage", "InterfaceOptionsCombatTextPanelHealing", "InterfaceOptionsCombatTextPanelTargetEffects", "InterfaceOptionsCombatTextPanelOtherTargetEffects", "InterfaceOptionsCombatTextPanelEnableFCT", "InterfaceOptionsCombatTextPanelDodgeParryMiss", "InterfaceOptionsCombatTextPanelDamageReduction", "InterfaceOptionsCombatTextPanelRepChanges", "InterfaceOptionsCombatTextPanelReactiveAbilities", "InterfaceOptionsCombatTextPanelFriendlyHealerNames", "InterfaceOptionsCombatTextPanelCombatState", "InterfaceOptionsCombatTextPanelComboPoints", "InterfaceOptionsCombatTextPanelLowManaHealth", "InterfaceOptionsCombatTextPanelEnergyGains", "InterfaceOptionsCombatTextPanelPeriodicEnergyGains", "InterfaceOptionsCombatTextPanelHonorGains", "InterfaceOptionsCombatTextPanelAuras", "InterfaceOptionsStatusTextPanelPlayer", "InterfaceOptionsStatusTextPanelPet", "InterfaceOptionsStatusTextPanelParty", "InterfaceOptionsStatusTextPanelTarget", "InterfaceOptionsStatusTextPanelAlternateResource", "InterfaceOptionsStatusTextPanelPercentages", "InterfaceOptionsStatusTextPanelXP", "InterfaceOptionsBattlenetPanelOnlineFriends", "InterfaceOptionsBattlenetPanelOfflineFriends", "InterfaceOptionsBattlenetPanelBroadcasts", "InterfaceOptionsBattlenetPanelFriendRequests", "InterfaceOptionsBattlenetPanelConversations", "InterfaceOptionsBattlenetPanelShowToastWindow", "InterfaceOptionsCameraPanelFollowTerrain", "InterfaceOptionsCameraPanelHeadBob", "InterfaceOptionsCameraPanelWaterCollision", "InterfaceOptionsCameraPanelSmartPivot", "InterfaceOptionsMousePanelInvertMouse", "InterfaceOptionsMousePanelClickToMove", "InterfaceOptionsMousePanelWoWMouse", "InterfaceOptionsHelpPanelShowTutorials", "InterfaceOptionsHelpPanelEnhancedTooltips", "InterfaceOptionsHelpPanelShowLuaErrors", "InterfaceOptionsHelpPanelColorblindMode", "InterfaceOptionsHelpPanelMovePad", "InterfaceOptionsControlsPanelAutoOpenLootHistory", "InterfaceOptionsUnitFramePanelPartyPets", "InterfaceOptionsUnitFramePanelArenaEnemyFrames", "InterfaceOptionsUnitFramePanelArenaEnemyCastBar", "InterfaceOptionsUnitFramePanelArenaEnemyPets", "InterfaceOptionsUnitFramePanelFullSizeFocusFrame", "CompactUnitFrameProfilesRaidStylePartyFrames", "CompactUnitFrameProfilesGeneralOptionsFrameKeepGroupsTogether", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayIncomingHeals", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayPowerBar", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayAggroHighlight", "CompactUnitFrameProfilesGeneralOptionsFrameUseClassColors", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayPets", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayMainTankAndAssist", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayBorder", "CompactUnitFrameProfilesGeneralOptionsFrameShowDebuffs", "CompactUnitFrameProfilesGeneralOptionsFrameDisplayOnlyDispellableDebuffs", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate2Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate3Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate5Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate10Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate15Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate25Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate40Players", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec1", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec2", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivatePvP", "CompactUnitFrameProfilesGeneralOptionsFrameAutoActivatePvE", "InterfaceOptionsBuffsPanelDispellableDebuffs", "InterfaceOptionsBuffsPanelCastableBuffs", "InterfaceOptionsBuffsPanelConsolidateBuffs", "InterfaceOptionsBuffsPanelShowAllEnemyDebuffs"}
			for i = 1, #checkboxes do
				S.ReskinCheck(_G[checkboxes[i]])
			end

			S.Reskin(RecordLoopbackSoundButton)
			S.Reskin(PlayLoopbackSoundButton)
			S.Reskin(AudioOptionsVoicePanelChatMode1KeyBindingButton)
		end)

		local interface = false
		InterfaceOptionsFrame:HookScript("OnShow", function()
			if interface == true then return end
			interface = true

			local line = InterfaceOptionsFrame:CreateTexture(nil, "ARTWORK")
			line:Size(1, 546)
			line:Point("LEFT", 205, 10)
			line:SetTexture(1, 1, 1, .2)

			local checkboxes = {"InterfaceOptionsControlsPanelStickyTargeting", "InterfaceOptionsControlsPanelAutoDismount", "InterfaceOptionsControlsPanelAutoClearAFK", "InterfaceOptionsControlsPanelBlockTrades", "InterfaceOptionsControlsPanelBlockGuildInvites", "InterfaceOptionsControlsPanelLootAtMouse", "InterfaceOptionsControlsPanelAutoLootCorpse", "InterfaceOptionsControlsPanelInteractOnLeftClick", "InterfaceOptionsCombatPanelAttackOnAssist", "InterfaceOptionsCombatPanelStopAutoAttack", "InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors", "InterfaceOptionsCombatPanelTargetOfTarget", "InterfaceOptionsCombatPanelShowSpellAlerts", "InterfaceOptionsCombatPanelReducedLagTolerance", "InterfaceOptionsCombatPanelActionButtonUseKeyDown", "InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait", "InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates", "InterfaceOptionsCombatPanelAutoSelfCast", "InterfaceOptionsDisplayPanelShowCloak", "InterfaceOptionsDisplayPanelShowHelm", "InterfaceOptionsDisplayPanelShowAggroPercentage", "InterfaceOptionsDisplayPanelPlayAggroSounds", "InterfaceOptionsDisplayPanelShowSpellPointsAvg", "InterfaceOptionsDisplayPanelShowFreeBagSpace", "InterfaceOptionsDisplayPanelCinematicSubtitles", "InterfaceOptionsDisplayPanelRotateMinimap", "InterfaceOptionsDisplayPanelShowAccountAchievments", "InterfaceOptionsObjectivesPanelAutoQuestTracking", "InterfaceOptionsObjectivesPanelMapQuestDifficulty", "InterfaceOptionsObjectivesPanelWatchFrameWidth", "InterfaceOptionsSocialPanelProfanityFilter", "InterfaceOptionsSocialPanelSpamFilter", "InterfaceOptionsSocialPanelChatBubbles", "InterfaceOptionsSocialPanelPartyChat", "InterfaceOptionsSocialPanelChatHoverDelay", "InterfaceOptionsSocialPanelGuildMemberAlert", "InterfaceOptionsSocialPanelChatMouseScroll", "InterfaceOptionsSocialPanelWholeChatWindowClickable", "InterfaceOptionsActionBarsPanelBottomLeft", "InterfaceOptionsActionBarsPanelBottomRight", "InterfaceOptionsActionBarsPanelRight", "InterfaceOptionsActionBarsPanelRightTwo", "InterfaceOptionsActionBarsPanelLockActionBars", "InterfaceOptionsActionBarsPanelAlwaysShowActionBars", "InterfaceOptionsActionBarsPanelSecureAbilityToggle", "InterfaceOptionsNamesPanelMyName", "InterfaceOptionsNamesPanelFriendlyPlayerNames", "InterfaceOptionsNamesPanelFriendlyPets", "InterfaceOptionsNamesPanelFriendlyGuardians", "InterfaceOptionsNamesPanelFriendlyTotems", "InterfaceOptionsNamesPanelUnitNameplatesFriends", "InterfaceOptionsNamesPanelUnitNameplatesFriendlyPets", "InterfaceOptionsNamesPanelUnitNameplatesFriendlyGuardians", "InterfaceOptionsNamesPanelUnitNameplatesFriendlyTotems", "InterfaceOptionsNamesPanelGuilds", "InterfaceOptionsNamesPanelGuildTitles", "InterfaceOptionsNamesPanelTitles", "InterfaceOptionsNamesPanelNonCombatCreature", "InterfaceOptionsNamesPanelEnemyPlayerNames", "InterfaceOptionsNamesPanelEnemyPets", "InterfaceOptionsNamesPanelEnemyGuardians", "InterfaceOptionsNamesPanelEnemyTotems", "InterfaceOptionsNamesPanelUnitNameplatesEnemies", "InterfaceOptionsNamesPanelUnitNameplatesEnemyPets", "InterfaceOptionsNamesPanelUnitNameplatesEnemyGuardians", "InterfaceOptionsNamesPanelUnitNameplatesEnemyTotems", "InterfaceOptionsCombatTextPanelTargetDamage", "InterfaceOptionsCombatTextPanelPeriodicDamage", "InterfaceOptionsCombatTextPanelPetDamage", "InterfaceOptionsCombatTextPanelHealing", "InterfaceOptionsCombatTextPanelTargetEffects", "InterfaceOptionsCombatTextPanelOtherTargetEffects", "InterfaceOptionsCombatTextPanelEnableFCT", "InterfaceOptionsCombatTextPanelDodgeParryMiss", "InterfaceOptionsCombatTextPanelDamageReduction", "InterfaceOptionsCombatTextPanelRepChanges", "InterfaceOptionsCombatTextPanelReactiveAbilities", "InterfaceOptionsCombatTextPanelFriendlyHealerNames", "InterfaceOptionsCombatTextPanelCombatState", "InterfaceOptionsCombatTextPanelComboPoints", "InterfaceOptionsCombatTextPanelLowManaHealth", "InterfaceOptionsCombatTextPanelEnergyGains", "InterfaceOptionsCombatTextPanelPeriodicEnergyGains", "InterfaceOptionsCombatTextPanelHonorGains", "InterfaceOptionsCombatTextPanelAuras", "InterfaceOptionsStatusTextPanelPlayer", "InterfaceOptionsStatusTextPanelPet", "InterfaceOptionsStatusTextPanelParty", "InterfaceOptionsStatusTextPanelTarget", "InterfaceOptionsStatusTextPanelAlternateResource", "InterfaceOptionsStatusTextPanelPercentages", "InterfaceOptionsStatusTextPanelXP", "InterfaceOptionsBattlenetPanelOnlineFriends", "InterfaceOptionsBattlenetPanelOfflineFriends", "InterfaceOptionsBattlenetPanelBroadcasts", "InterfaceOptionsBattlenetPanelFriendRequests", "InterfaceOptionsBattlenetPanelConversations", "InterfaceOptionsBattlenetPanelShowToastWindow", "InterfaceOptionsCameraPanelFollowTerrain", "InterfaceOptionsCameraPanelHeadBob", "InterfaceOptionsCameraPanelWaterCollision", "InterfaceOptionsCameraPanelSmartPivot", "InterfaceOptionsMousePanelInvertMouse", "InterfaceOptionsMousePanelClickToMove", "InterfaceOptionsMousePanelWoWMouse", "InterfaceOptionsHelpPanelShowTutorials", "InterfaceOptionsHelpPanelEnhancedTooltips", "InterfaceOptionsHelpPanelShowLuaErrors", "InterfaceOptionsHelpPanelColorblindMode", "InterfaceOptionsHelpPanelMovePad", "InterfaceOptionsControlsPanelAutoOpenLootHistory", "InterfaceOptionsUnitFramePanelPartyPets", "InterfaceOptionsUnitFramePanelArenaEnemyFrames", "InterfaceOptionsUnitFramePanelArenaEnemyCastBar", "InterfaceOptionsUnitFramePanelArenaEnemyPets", "InterfaceOptionsUnitFramePanelFullSizeFocusFrame", "InterfaceOptionsBuffsPanelDispellableDebuffs", "InterfaceOptionsBuffsPanelCastableBuffs", "InterfaceOptionsBuffsPanelConsolidateBuffs", "InterfaceOptionsBuffsPanelShowAllEnemyDebuffs"}
			for i = 1, #checkboxes do
				S.ReskinCheck(_G[checkboxes[i]])
			end

			local dropdowns = {"InterfaceOptionsControlsPanelAutoLootKeyDropDown", "InterfaceOptionsCombatPanelFocusCastKeyDropDown", "InterfaceOptionsCombatPanelSelfCastKeyDropDown", "InterfaceOptionsSocialPanelChatStyle", "InterfaceOptionsSocialPanelTimestamps", "InterfaceOptionsSocialPanelWhisperMode", "InterfaceOptionsSocialPanelBnWhisperMode", "InterfaceOptionsSocialPanelConversationMode", "InterfaceOptionsActionBarsPanelPickupActionKeyDropDown", "InterfaceOptionsNamesPanelNPCNamesDropDown", "InterfaceOptionsNamesPanelUnitNameplatesMotionDropDown", "InterfaceOptionsCombatTextPanelFCTDropDown", "InterfaceOptionsCameraPanelStyleDropDown", "InterfaceOptionsMousePanelClickMoveStyleDropDown"}
			for i = 1, #dropdowns do
				S.ReskinDropDown(_G[dropdowns[i]])
			end

			local sliders = {"InterfaceOptionsCombatPanelSpellAlertOpacitySlider", "InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset", "InterfaceOptionsBattlenetPanelToastDurationSlider", "InterfaceOptionsCameraPanelMaxDistanceSlider", "InterfaceOptionsCameraPanelFollowSpeedSlider", "InterfaceOptionsMousePanelMouseSensitivitySlider", "InterfaceOptionsMousePanelMouseLookSpeedSlider"}
			for i = 1, #sliders do
				S.ReskinSlider(_G[sliders[i]])
			end

			S.Reskin(InterfaceOptionsHelpPanelResetTutorials)

			if IsAddOnLoaded("Blizzard_CompactRaidFrames") then
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateBG:Hide()

				local boxes = {CompactUnitFrameProfilesRaidStylePartyFrames, CompactUnitFrameProfilesGeneralOptionsFrameKeepGroupsTogether, CompactUnitFrameProfilesGeneralOptionsFrameDisplayIncomingHeals, CompactUnitFrameProfilesGeneralOptionsFrameDisplayPowerBar, CompactUnitFrameProfilesGeneralOptionsFrameDisplayAggroHighlight, CompactUnitFrameProfilesGeneralOptionsFrameUseClassColors, CompactUnitFrameProfilesGeneralOptionsFrameDisplayPets, CompactUnitFrameProfilesGeneralOptionsFrameDisplayMainTankAndAssist, CompactUnitFrameProfilesGeneralOptionsFrameDisplayBorder, CompactUnitFrameProfilesGeneralOptionsFrameShowDebuffs, CompactUnitFrameProfilesGeneralOptionsFrameDisplayOnlyDispellableDebuffs, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate2Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate3Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate5Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate10Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate15Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate25Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate40Players, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec1, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec2, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivatePvP, CompactUnitFrameProfilesGeneralOptionsFrameAutoActivatePvE}

				for _, box in next, boxes do
					S.ReskinCheck(box)
				end

				S.Reskin(CompactUnitFrameProfilesSaveButton)
				S.Reskin(CompactUnitFrameProfilesDeleteButton)
				S.Reskin(CompactUnitFrameProfilesGeneralOptionsFrameResetPositionButton)
				S.ReskinDropDown(CompactUnitFrameProfilesProfileSelector)
				S.ReskinDropDown(CompactUnitFrameProfilesGeneralOptionsFrameSortByDropdown)
				S.ReskinDropDown(CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdown)
				S.ReskinSlider(CompactUnitFrameProfilesGeneralOptionsFrameHeightSlider)
				S.ReskinSlider(CompactUnitFrameProfilesGeneralOptionsFrameWidthSlider)
			end
		end)

		hooksecurefunc("InterfaceOptions_AddCategory", function()
			local num = #INTERFACEOPTIONS_ADDONCATEGORIES
			for i = 1, num do
				local bu = _G["InterfaceOptionsFrameAddOnsButton"..i.."Toggle"]
				if bu and not bu.reskinned then
					S.ReskinExpandOrCollapse(bu)
					bu:SetPushedTexture("")
					bu.SetPushedTexture = function() end
					bu.reskinned = true
				end
			end
		end)

		hooksecurefunc("OptionsListButtonToggle_OnClick", function(self)
			if self:GetParent().element.collapsed then
				self.plus:Show()
			else
				self.plus:Hide()
			end
		end)

		-- SideDressUp

		SideDressUpModel:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:Point("LEFT", self:GetParent():GetParent(), "RIGHT", 1, 0)
		end)

		SideDressUpModel.bg = CreateFrame("Frame", nil, SideDressUpModel)
		SideDressUpModel.bg:Point("TOPLEFT", 0, 1)
		SideDressUpModel.bg:Point("BOTTOMRIGHT", 1, -1)
		SideDressUpModel.bg:SetFrameLevel(SideDressUpModel:GetFrameLevel()-1)
		S.CreateBD(SideDressUpModel.bg)

		-- Trade Frame

		TradePlayerEnchantInset:DisableDrawLayer("BORDER")
		TradePlayerItemsInset:DisableDrawLayer("BORDER")
		TradeRecipientEnchantInset:DisableDrawLayer("BORDER")
		TradeRecipientItemsInset:DisableDrawLayer("BORDER")
		TradePlayerInputMoneyInset:DisableDrawLayer("BORDER")
		TradeRecipientMoneyInset:DisableDrawLayer("BORDER")
		TradeRecipientBG:Hide()
		TradePlayerEnchantInsetBg:Hide()
		TradePlayerItemsInsetBg:Hide()
		TradePlayerInputMoneyInsetBg:Hide()
		TradeRecipientEnchantInsetBg:Hide()
		TradeRecipientItemsInsetBg:Hide()
		TradeRecipientMoneyBg:Hide()
		TradeRecipientPortraitFrame:Hide()
		TradeRecipientBotLeftCorner:Hide()
		TradeRecipientLeftBorder:Hide()
		select(4, TradePlayerItem7:GetRegions()):Hide()
		select(4, TradeRecipientItem7:GetRegions()):Hide()

		S.ReskinPortraitFrame(TradeFrame, true)
		S.Reskin(TradeFrameTradeButton)
		S.Reskin(TradeFrameCancelButton)
		S.ReskinInput(TradePlayerInputMoneyFrameGold)
		S.ReskinInput(TradePlayerInputMoneyFrameSilver)
		S.ReskinInput(TradePlayerInputMoneyFrameCopper)

		TradePlayerInputMoneyFrameSilver:Point("LEFT", TradePlayerInputMoneyFrameGold, "RIGHT", 1, 0)
		TradePlayerInputMoneyFrameCopper:Point("LEFT", TradePlayerInputMoneyFrameSilver, "RIGHT", 1, 0)

		for i = 1, MAX_TRADE_ITEMS do
			local bu1 = _G["TradePlayerItem"..i.."ItemButton"]
			local bu2 = _G["TradeRecipientItem"..i.."ItemButton"]

			_G["TradePlayerItem"..i.."SlotTexture"]:Hide()
			_G["TradePlayerItem"..i.."NameFrame"]:Hide()
			_G["TradeRecipientItem"..i.."SlotTexture"]:Hide()
			_G["TradeRecipientItem"..i.."NameFrame"]:Hide()

			bu1:SetNormalTexture("")
			bu1:SetPushedTexture("")
			bu1.icon:SetTexCoord(.08, .92, .08, .92)
			bu2:SetNormalTexture("")
			bu2:SetPushedTexture("")
			bu2.icon:SetTexCoord(.08, .92, .08, .92)

			local bg1 = CreateFrame("Frame", nil, bu1)
			bg1:Point("TOPLEFT", -1, 1)
			bg1:Point("BOTTOMRIGHT", 1, -1)
			bg1:SetFrameLevel(bu1:GetFrameLevel()-1)
			S.CreateBD(bg1, .25)

			local bg2 = CreateFrame("Frame", nil, bu2)
			bg2:Point("TOPLEFT", -1, 1)
			bg2:Point("BOTTOMRIGHT", 1, -1)
			bg2:SetFrameLevel(bu2:GetFrameLevel()-1)
			S.CreateBD(bg2, .25)
		end

		-- Tutorial Frame

		S.CreateBD(TutorialFrame)
		S.CreateSD(TutorialFrame)

		TutorialFrameBackground:Hide()
		TutorialFrameBackground.Show = function() end
		TutorialFrame:DisableDrawLayer("BORDER")

		S.Reskin(TutorialFrameOkayButton, true)
		S.ReskinClose(TutorialFrameCloseButton)
		S.ReskinArrow(TutorialFramePrevButton, "left")
		S.ReskinArrow(TutorialFrameNextButton, "right")

		TutorialFrameOkayButton:ClearAllPoints()
		TutorialFrameOkayButton:Point("BOTTOMLEFT", TutorialFrameNextButton, "BOTTOMRIGHT", 10, 0)

		-- because gradient alpha and OnUpdate doesn't work for some reason...

		select(15, TutorialFrameOkayButton:GetRegions()):Hide()
		select(15, TutorialFramePrevButton:GetRegions()):Hide()
		select(15, TutorialFrameNextButton:GetRegions()):Hide()
		select(14, TutorialFrameCloseButton:GetRegions()):Hide()
		TutorialFramePrevButton:SetScript("OnEnter", nil)
		TutorialFrameNextButton:SetScript("OnEnter", nil)
		TutorialFrameOkayButton:SetBackdropColor(0, 0, 0, .25)
		TutorialFramePrevButton:SetBackdropColor(0, 0, 0, .25)
		TutorialFrameNextButton:SetBackdropColor(0, 0, 0, .25)

		-- Loot history

		for i = 1, 9 do
			select(i, LootHistoryFrame:GetRegions()):Hide()
		end
		LootHistoryFrameScrollFrame:GetRegions():Hide()

		LootHistoryFrame.ResizeButton:Point("TOP", LootHistoryFrame, "BOTTOM", 0, -1)
		LootHistoryFrame.ResizeButton:SetFrameStrata("LOW")

		S.ReskinArrow(LootHistoryFrame.ResizeButton, "down")
		LootHistoryFrame.ResizeButton:Size(32, 12)

		S.CreateBD(LootHistoryFrame)
		S.CreateSD(LootHistoryFrame)

		S.ReskinClose(LootHistoryFrame.CloseButton)
		S.ReskinScroll(LootHistoryFrameScrollFrameScrollBar)

		hooksecurefunc("LootHistoryFrame_UpdateItemFrame", function(self, frame)
			local rollID, _, _, isDone, winnerIdx = C_LootHistory.GetItem(frame.itemIdx)
			local expanded = self.expandedRolls[rollID]

			if not frame.styled then
				frame.Divider:Hide()
				frame.NameBorderLeft:Hide()
				frame.NameBorderRight:Hide()
				frame.NameBorderMid:Hide()
				frame.IconBorder:Hide()

				frame.Icon:SetTexCoord(.08, .92, .08, .92)
				frame.Icon:SetDrawLayer("ARTWORK")
				frame.bg = S.CreateBG(frame.Icon)
				frame.bg:SetVertexColor(frame.IconBorder:GetVertexColor())

				S.ReskinExpandOrCollapse(frame.ToggleButton)
				frame.ToggleButton:GetNormalTexture():SetAlpha(0)
				frame.ToggleButton:GetPushedTexture():SetAlpha(0)
				frame.ToggleButton:GetDisabledTexture():SetAlpha(0)

				frame.styled = true
			end

			if isDone and not expanded and winnerIdx then
				local name, class = C_LootHistory.GetPlayerInfo(frame.itemIdx, winnerIdx)
				if name then
					local color = RAID_CLASS_COLORS[class]
					frame.WinnerName:SetVertexColor(color.r, color.g, color.b)
				end
			end

			frame.bg:SetVertexColor(frame.IconBorder:GetVertexColor())
			frame.ToggleButton.plus:SetShown(not expanded)
		end)

		hooksecurefunc("LootHistoryFrame_UpdatePlayerFrame", function(_, playerFrame)
			if playerFrame.playerIdx then
				local name, class = C_LootHistory.GetPlayerInfo(playerFrame.itemIdx, playerFrame.playerIdx)

				if name then
					local color = RAID_CLASS_COLORS[class]
					playerFrame.PlayerName:SetTextColor(color.r, color.g, color.b)
				end
			end
		end)

		LootHistoryDropDown.initialize = function(self)
			local info = UIDropDownMenu_CreateInfo();
			info.isTitle = 1;
			info.text = MASTER_LOOTER;
			info.fontObject = GameFontNormalLeft;
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info);

			info = UIDropDownMenu_CreateInfo();
			info.notCheckable = 1;
			local name, class = C_LootHistory.GetPlayerInfo(self.itemIdx, self.playerIdx);
			local colorCode = string.format("|cFF%02x%02x%02x",  r*255,  g*255,  b*255);
			info.text = string.format(MASTER_LOOTER_GIVE_TO, colorCode..name.."|r");
			info.func = LootHistoryDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end

		-- Master looter frame

		for i = 1, 9 do
			select(i, MasterLooterFrame:GetRegions()):Hide()
		end

		MasterLooterFrame.Item.NameBorderLeft:Hide()
		MasterLooterFrame.Item.NameBorderRight:Hide()
		MasterLooterFrame.Item.NameBorderMid:Hide()
		MasterLooterFrame.Item.IconBorder:Hide()
		
		MasterLooterFrame.Item.Icon:SetTexCoord(.08, .92, .08, .92)
		MasterLooterFrame.Item.Icon:SetDrawLayer("ARTWORK")
		MasterLooterFrame.Item.bg = S.CreateBG(MasterLooterFrame.Item.Icon)
		MasterLooterFrame:HookScript("OnShow", function(self)
			self.Item.bg:SetVertexColor(self.Item.IconBorder:GetVertexColor())
			LootFrame:SetAlpha(.4)
			self:SetPoint("TOPLEFT", DropDownList1, 170, 0);
		end)

		MasterLooterFrame:HookScript("OnHide", function(self)
			LootFrame:SetAlpha(1)
		end)

		S.CreateBD(MasterLooterFrame)
		S.ReskinClose(select(3, MasterLooterFrame:GetChildren()))

		hooksecurefunc("MasterLooterFrame_UpdatePlayers", function()
			for i = 1, MAX_RAID_MEMBERS do
				local playerFrame = MasterLooterFrame["player"..i]
				if playerFrame then
					if not playerFrame.styled then
						playerFrame.Bg:Point("TOPLEFT", 1, -1)
						playerFrame.Bg:Point("BOTTOMRIGHT", -1, 1)
						playerFrame.Highlight:Point("TOPLEFT", 1, -1)
						playerFrame.Highlight:Point("BOTTOMRIGHT", -1, 1)

						playerFrame.Highlight:SetTexture(media.backdrop)

						S.CreateBD(playerFrame, 0)

						playerFrame.styled = true
					end
					--playerFrame.Name:SetTextColor(r, g, b)
					--playerFrame.Highlight:SetVertexColor(r, g, b, .2)
				else
					break
				end
			end
		end)

		-- Missing loot frame

		MissingLootFrameCorner:Hide()

		hooksecurefunc("MissingLootFrame_Show", function()
			for i = 1, GetNumMissingLootItems() do
				local bu = _G["MissingLootFrameItem"..i]

				if not bu.styled then
					_G["MissingLootFrameItem"..i.."NameFrame"]:Hide()

					bu.icon:SetTexCoord(.08, .92, .08, .92)
					bu.icon.bg = S.CreateBG(bu.icon)

					bu.styled = true
				end

				bu.icon.bg:SetVertexColor(bu.name:GetVertexColor())
			end
		end)

		S.CreateBD(MissingLootFrame)
		S.ReskinClose(MissingLootFramePassButton)

		-- BN conversation

		BNConversationInviteDialogHeader:SetTexture("")

		S.CreateBD(BNConversationInviteDialog)
		S.CreateBD(BNConversationInviteDialogList, .25)

		S.Reskin(BNConversationInviteDialogInviteButton)
		S.Reskin(BNConversationInviteDialogCancelButton)
		S.ReskinScroll(BNConversationInviteDialogListScrollFrameScrollBar)
		for i = 1, BN_CONVERSATION_INVITE_NUM_DISPLAYED do
			S.ReskinCheck(_G["BNConversationInviteDialogListFriend"..i].checkButton)
		end

		-- Taxi Frame

		TaxiFrame:DisableDrawLayer("BORDER")
		TaxiFrame:DisableDrawLayer("OVERLAY")
		TaxiFrame.Bg:Hide()
		TaxiFrame.TitleBg:Hide()

		S.SetBD(TaxiFrame, 3, -23, -5, 3)
		S.ReskinClose(TaxiFrame.CloseButton, "TOPRIGHT", TaxiRouteMap, "TOPRIGHT", -4, -4)

		-- Tabard frame

		TabardFrameMoneyInset:DisableDrawLayer("BORDER")
		TabardFrameCustomizationBorder:Hide()
		TabardFrameMoneyBg:Hide()
		TabardFrameMoneyInsetBg:Hide()

		for i = 19, 28 do
			select(i, TabardFrame:GetRegions()):Hide()
		end

		for i = 1, 5 do
			_G["TabardFrameCustomization"..i.."Left"]:Hide()
			_G["TabardFrameCustomization"..i.."Middle"]:Hide()
			_G["TabardFrameCustomization"..i.."Right"]:Hide()
			S.ReskinArrow(_G["TabardFrameCustomization"..i.."LeftButton"], "left")
			S.ReskinArrow(_G["TabardFrameCustomization"..i.."RightButton"], "right")
		end

		S.ReskinPortraitFrame(TabardFrame, true)
		S.CreateBD(TabardFrameCostFrame, .25)
		S.Reskin(TabardFrameAcceptButton)
		S.Reskin(TabardFrameCancelButton)

		-- Guild registrar frame

		GuildRegistrarFrameTop:Hide()
		GuildRegistrarFrameBottom:Hide()
		GuildRegistrarFrameMiddle:Hide()
		select(19, GuildRegistrarFrame:GetRegions()):Hide()
		select(6, GuildRegistrarFrameEditBox:GetRegions()):Hide()
		select(7, GuildRegistrarFrameEditBox:GetRegions()):Hide()

		GuildRegistrarFrameEditBox:SetHeight(20)

		S.ReskinPortraitFrame(GuildRegistrarFrame, true)
		S.CreateBD(GuildRegistrarFrameEditBox, .25)
		S.Reskin(GuildRegistrarFrameGoodbyeButton)
		S.Reskin(GuildRegistrarFramePurchaseButton)
		S.Reskin(GuildRegistrarFrameCancelButton)

		-- World state score frame

		select(2, WorldStateScoreScrollFrame:GetRegions()):Hide()
		select(3, WorldStateScoreScrollFrame:GetRegions()):Hide()

		WorldStateScoreFrameTab2:Point("LEFT", WorldStateScoreFrameTab1, "RIGHT", -15, 0)
		WorldStateScoreFrameTab3:Point("LEFT", WorldStateScoreFrameTab2, "RIGHT", -15, 0)

		S.ReskinPortraitFrame(WorldStateScoreFrame, true)
		S.Reskin(WorldStateScoreFrameLeaveButton)
		S.ReskinScroll(WorldStateScoreScrollFrameScrollBar)

		for i = 1, 3 do
			S.CreateTab(_G["WorldStateScoreFrameTab"..i])
		end

		-- Item text

		select(18, ItemTextFrame:GetRegions()):Hide()
		InboxFrameBg:Hide()
		ItemTextScrollFrameMiddle:SetAlpha(0)
		ItemTextScrollFrameTop:SetAlpha(0)
		ItemTextScrollFrameBottom:SetAlpha(0)
		ItemTextPrevPageButton:GetRegions():Hide()
		ItemTextNextPageButton:GetRegions():Hide()
		ItemTextMaterialTopLeft:SetAlpha(0)
		ItemTextMaterialTopRight:SetAlpha(0)
		ItemTextMaterialBotLeft:SetAlpha(0)
		ItemTextMaterialBotRight:SetAlpha(0)

		S.ReskinPortraitFrame(ItemTextFrame, true)
		S.ReskinScroll(ItemTextScrollFrameScrollBar)
		S.ReskinArrow(ItemTextPrevPageButton, "left")
		S.ReskinArrow(ItemTextNextPageButton, "right")

		-- Petition frame

		select(18, PetitionFrame:GetRegions()):Hide()
		select(19, PetitionFrame:GetRegions()):Hide()
		select(23, PetitionFrame:GetRegions()):Hide()
		select(24, PetitionFrame:GetRegions()):Hide()
		PetitionFrameTop:Hide()
		PetitionFrameBottom:Hide()
		PetitionFrameMiddle:Hide()

		S.ReskinPortraitFrame(PetitionFrame, true)
		S.Reskin(PetitionFrameSignButton)
		S.Reskin(PetitionFrameRequestButton)
		S.Reskin(PetitionFrameRenameButton)
		S.Reskin(PetitionFrameCancelButton)
		-- Mac options

		if IsMacClient() then
			S.CreateBD(MacOptionsFrame)
			MacOptionsFrameHeader:SetTexture("")
			MacOptionsFrameHeader:ClearAllPoints()
			MacOptionsFrameHeader:SetPoint("TOP", MacOptionsFrame, 0, 0)

			S.CreateBD(MacOptionsFrameMovieRecording, .25)
			S.CreateBD(MacOptionsITunesRemote, .25)
			S.CreateBD(MacOptionsFrameMisc, .25)

			S.Reskin(MacOptionsButtonKeybindings)
			S.Reskin(MacOptionsButtonCompress)
			S.Reskin(MacOptionsFrameCancel)
			S.Reskin(MacOptionsFrameOkay)
			S.Reskin(MacOptionsFrameDefaults)

			S.ReskinDropDown(MacOptionsFrameResolutionDropDown)
			S.ReskinDropDown(MacOptionsFrameFramerateDropDown)
			S.ReskinDropDown(MacOptionsFrameCodecDropDown)

			for i = 1, 10 do
				S.ReskinCheck(_G["MacOptionsFrameCheckButton"..i])
			end
			S.ReskinSlider(MacOptionsFrameQualitySlider)

			MacOptionsButtonCompress:SetWidth(136)

			MacOptionsFrameCancel:SetWidth(96)
			MacOptionsFrameCancel:SetHeight(22)
			MacOptionsFrameCancel:ClearAllPoints()
			MacOptionsFrameCancel:SetPoint("LEFT", MacOptionsButtonKeybindings, "RIGHT", 107, 0)

			MacOptionsFrameOkay:SetWidth(96)
			MacOptionsFrameOkay:SetHeight(22)
			MacOptionsFrameOkay:ClearAllPoints()
			MacOptionsFrameOkay:SetPoint("LEFT", MacOptionsButtonKeybindings, "RIGHT", 5, 0)

			MacOptionsButtonKeybindings:SetWidth(96)
			MacOptionsButtonKeybindings:SetHeight(22)
			MacOptionsButtonKeybindings:ClearAllPoints()
			MacOptionsButtonKeybindings:SetPoint("LEFT", MacOptionsFrameDefaults, "RIGHT", 5, 0)

			MacOptionsFrameDefaults:SetWidth(96)
			MacOptionsFrameDefaults:SetHeight(22)
		end

		-- Micro button alerts

		local microButtons = {TalentMicroButtonAlert, CompanionsMicroButtonAlert}
			for _, button in pairs(microButtons) do
			button:DisableDrawLayer("BACKGROUND")
			button:DisableDrawLayer("BORDER")
			button.Arrow:Hide()

			S.SetBD(button)
			S.ReskinClose(button.CloseButton)
		end
		-- Cinematic popup

		CinematicFrameCloseDialog:HookScript("OnShow", function(self)
			self:SetScale(UIParent:GetScale())
		end)

		S.CreateBD(CinematicFrameCloseDialog)
		S.CreateSD(CinematicFrameCloseDialog)
		S.Reskin(CinematicFrameCloseDialogConfirmButton)
		S.Reskin(CinematicFrameCloseDialogResumeButton)

		-- Bonus roll

		BonusRollFrame.Background:SetAlpha(0)
		BonusRollFrame.IconBorder:Hide()
		BonusRollFrame.BlackBackgroundHoist.Background:Hide()

		BonusRollFrame.PromptFrame.Icon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(BonusRollFrame.PromptFrame.Icon)

		BonusRollFrame.PromptFrame.Timer.Bar:SetTexture(media.backdrop)
		BonusRollFrame.PromptFrame.Timer.Bar:SetGradient("VERTICAL", 1, 1, 0, .7, .7, 0)

		S.CreateBD(BonusRollFrame)
		S.CreateBDFrame(BonusRollFrame.PromptFrame.Timer, .25)

		-- Chat config

		hooksecurefunc("ChatConfig_CreateCheckboxes", function(frame, checkBoxTable, checkBoxTemplate)
			if frame.styled then return end

			frame:SetBackdrop(nil)

			local checkBoxNameString = frame:GetName().."CheckBox"

			if checkBoxTemplate == "ChatConfigCheckBoxTemplate" then
				for index, value in ipairs(checkBoxTable) do
					local checkBoxName = checkBoxNameString..index
					local checkbox = _G[checkBoxName]

					checkbox:SetBackdrop(nil)

					local bg = CreateFrame("Frame", nil, checkbox)
					bg:SetPoint("TOPLEFT")
					bg:Point("BOTTOMRIGHT", 0, 1)
					bg:SetFrameLevel(checkbox:GetFrameLevel()-1)
					S.CreateBD(bg, .25)

					S.ReskinCheck(_G[checkBoxName.."Check"])
				end
			elseif checkBoxTemplate == "ChatConfigCheckBoxWithSwatchTemplate" or checkBoxTemplate == "ChatConfigCheckBoxWithSwatchAndClassColorTemplate" then
				for index, value in ipairs(checkBoxTable) do
					local checkBoxName = checkBoxNameString..index
					local checkbox = _G[checkBoxName]

					checkbox:SetBackdrop(nil)

					local bg = CreateFrame("Frame", nil, checkbox)
					bg:SetPoint("TOPLEFT")
					bg:Point("BOTTOMRIGHT", 0, 1)
					bg:SetFrameLevel(checkbox:GetFrameLevel()-1)
					S.CreateBD(bg, .25)

					S.ReskinColourSwatch(_G[checkBoxName.."ColorSwatch"])

					S.ReskinCheck(_G[checkBoxName.."Check"])

					if checkBoxTemplate == "ChatConfigCheckBoxWithSwatchAndClassColorTemplate" then
						S.ReskinCheck(_G[checkBoxName.."ColorClasses"])
					end
				end
			end

			frame.styled = true
		end)

		hooksecurefunc("ChatConfig_CreateTieredCheckboxes", function(frame, checkBoxTable, checkBoxTemplate, subCheckBoxTemplate)
			if frame.styled then return end

			local checkBoxNameString = frame:GetName().."CheckBox"

			for index, value in ipairs(checkBoxTable) do
				local checkBoxName = checkBoxNameString..index

				S.ReskinCheck(_G[checkBoxName])

				if value.subTypes then
					local subCheckBoxNameString = checkBoxName.."_"

					for k, v in ipairs(value.subTypes) do
						S.ReskinCheck(_G[subCheckBoxNameString..k])
					end
				end
			end

			frame.styled = true
		end)

		hooksecurefunc("ChatConfig_CreateColorSwatches", function(frame, swatchTable, swatchTemplate)
			if frame.styled then return end

			frame:SetBackdrop(nil)

			local nameString = frame:GetName().."Swatch"

			for index, value in ipairs(swatchTable) do
				local swatchName = nameString..index
				local swatch = _G[swatchName]

				swatch:SetBackdrop(nil)

				local bg = CreateFrame("Frame", nil, swatch)
				bg:SetPoint("TOPLEFT")
				bg:Point("BOTTOMRIGHT", 0, 1)
				bg:SetFrameLevel(swatch:GetFrameLevel()-1)
				S.CreateBD(bg, .25)

				S.ReskinColourSwatch(_G[swatchName.."ColorSwatch"])
			end

			frame.styled = true
		end)

		for i = 1, 5 do
			_G["CombatConfigTab"..i.."Left"]:Hide()
			_G["CombatConfigTab"..i.."Middle"]:Hide()
			_G["CombatConfigTab"..i.."Right"]:Hide()
		end

		local line = ChatConfigFrame:CreateTexture()
		line:Size(1, 460)
		line:SetPoint("TOPLEFT", ChatConfigCategoryFrame, "TOPRIGHT")
		line:SetTexture(1, 1, 1, .2)

		ChatConfigCategoryFrame:SetBackdrop(nil)
		ChatConfigBackgroundFrame:SetBackdrop(nil)
		ChatConfigCombatSettingsFilters:SetBackdrop(nil)
		CombatConfigColorsHighlighting:SetBackdrop(nil)
		CombatConfigColorsColorizeUnitName:SetBackdrop(nil)
		CombatConfigColorsColorizeSpellNames:SetBackdrop(nil)
		CombatConfigColorsColorizeDamageNumber:SetBackdrop(nil)
		CombatConfigColorsColorizeDamageSchool:SetBackdrop(nil)
		CombatConfigColorsColorizeEntireLine:SetBackdrop(nil)

		local combatBoxes = {CombatConfigColorsHighlightingLine, CombatConfigColorsHighlightingAbility, CombatConfigColorsHighlightingDamage, CombatConfigColorsHighlightingSchool, CombatConfigColorsColorizeUnitNameCheck, CombatConfigColorsColorizeSpellNamesCheck, CombatConfigColorsColorizeSpellNamesSchoolColoring, CombatConfigColorsColorizeDamageNumberCheck, CombatConfigColorsColorizeDamageNumberSchoolColoring, CombatConfigColorsColorizeDamageSchoolCheck, CombatConfigColorsColorizeEntireLineCheck, CombatConfigFormattingShowTimeStamp, CombatConfigFormattingShowBraces, CombatConfigFormattingUnitNames, CombatConfigFormattingSpellNames, CombatConfigFormattingItemNames, CombatConfigFormattingFullText, CombatConfigSettingsShowQuickButton, CombatConfigSettingsSolo, CombatConfigSettingsParty, CombatConfigSettingsRaid}

		for _, box in next, combatBoxes do
			S.ReskinCheck(box)
		end

		local bg = CreateFrame("Frame", nil, ChatConfigCombatSettingsFilters)
		bg:Point("TOPLEFT", 3, 0)
		bg:Point("BOTTOMRIGHT", 0, 1)
		bg:SetFrameLevel(ChatConfigCombatSettingsFilters:GetFrameLevel()-1)
		S.CreateBD(bg, .25)

		S.Reskin(CombatLogDefaultButton)
		S.Reskin(ChatConfigCombatSettingsFiltersCopyFilterButton)
		S.Reskin(ChatConfigCombatSettingsFiltersAddFilterButton)
		S.Reskin(ChatConfigCombatSettingsFiltersDeleteButton)
		S.Reskin(CombatConfigSettingsSaveButton)
		S.ReskinArrow(ChatConfigMoveFilterUpButton, "up")
		S.ReskinArrow(ChatConfigMoveFilterDownButton, "down")
		S.ReskinInput(CombatConfigSettingsNameEditBox)
		S.ReskinRadio(CombatConfigColorsColorizeEntireLineBySource)
		S.ReskinRadio(CombatConfigColorsColorizeEntireLineByTarget)
		S.ReskinColourSwatch(CombatConfigColorsColorizeSpellNamesColorSwatch)
		S.ReskinColourSwatch(CombatConfigColorsColorizeDamageNumberColorSwatch)

		ChatConfigMoveFilterUpButton:SetSize(28, 28)
		ChatConfigMoveFilterDownButton:SetSize(28, 28)

		ChatConfigCombatSettingsFiltersAddFilterButton:Point("RIGHT", ChatConfigCombatSettingsFiltersDeleteButton, "LEFT", -1, 0)
		ChatConfigCombatSettingsFiltersCopyFilterButton:Point("RIGHT", ChatConfigCombatSettingsFiltersAddFilterButton, "LEFT", -1, 0)
		ChatConfigMoveFilterUpButton:Point("TOPLEFT", ChatConfigCombatSettingsFilters, "BOTTOMLEFT", 3, 0)
		ChatConfigMoveFilterDownButton:Point("LEFT", ChatConfigMoveFilterUpButton, "RIGHT", 1, 0)
		-- [[ Hide regions ]]

		local bglayers = {"SpellBookFrame", "LFDParentFrame", "LFDParentFrameInset", "WhoFrameColumnHeader1", "WhoFrameColumnHeader2", "WhoFrameColumnHeader3", "WhoFrameColumnHeader4", "RaidInfoInstanceLabel", "RaidInfoIDLabel", "CharacterFrameInsetRight", "PVPTeamManagementFrame", "PVPTeamManagementFrameHeader1", "PVPTeamManagementFrameHeader2", "PVPTeamManagementFrameHeader3", "PVPTeamManagementFrameHeader4", "PVPBannerFrame", "PVPBannerFrameInset", "LFRQueueFrame", "LFRBrowseFrame", "HelpFrameMainInset", "CharacterModelFrame", "HelpFrame", "HelpFrameLeftInset", "EquipmentFlyoutFrameButtons", "VideoOptionsFrameCategoryFrame", "InterfaceOptionsFrameCategories", "InterfaceOptionsFrameAddOns", "RaidParentFrame"}
		for i = 1, #bglayers do
			_G[bglayers[i]]:DisableDrawLayer("BACKGROUND")
		end
		local borderlayers = {"WhoFrameListInset", "WhoFrameEditBoxInset", "ChannelFrameLeftInset", "ChannelFrameRightInset", "SpellBookFrame", "SpellBookFrameInset", "LFDParentFrame", "LFDParentFrameInset", "CharacterFrameInsetRight", "PVPConquestFrameInfoButton", "PVPTeamManagementFrame", "PVPBannerFrame", "PVPBannerFrameInset", "HelpFrame", "HelpFrameLeftInset", "HelpFrameMainInset", "CharacterModelFrame", "VideoOptionsFramePanelContainer", "InterfaceOptionsFramePanelContainer", "RaidParentFrame", "RaidParentFrameInset", "RaidFinderFrameRoleInset", "LFRQueueFrameRoleInset", "LFRQueueFrameListInset", "LFRQueueFrameCommentInset"}
		for i = 1, #borderlayers do
			_G[borderlayers[i]]:DisableDrawLayer("BORDER")
		end
		local overlayers = {"SpellBookFrame", "LFDParentFrame", "CharacterModelFrame"}
		for i = 1, #overlayers do
			_G[overlayers[i]]:DisableDrawLayer("OVERLAY")
		end
		local artlayers = {"PVPConquestFrame", "EquipmentFlyoutFrameButtons"}
		for i = 1, #artlayers do
			_G[artlayers[i]]:DisableDrawLayer("ARTWORK")
		end
		for i = 1, 3 do
			for j = 1, 2 do
				select(i, _G["PVPBannerFrameCustomization"..j]:GetRegions()):Hide()
			end
		end
		for i = 1, 6 do
			_G["HelpFrameButton"..i.."Selected"]:SetAlpha(0)
			for j = 1, 3 do
				select(i, _G["FriendsTabHeaderTab"..j]:GetRegions()):Hide()
				select(i, _G["FriendsTabHeaderTab"..j]:GetRegions()).Show = function() end
			end
			select(i, ScrollOfResurrectionFrameNoteFrame:GetRegions()):Hide()
		end
		HelpFrameButton16Selected:SetAlpha(0)
		PVPHonorFrameBGTex:Hide()
		OpenStationeryBackgroundLeft:Hide()
		OpenStationeryBackgroundRight:Hide()
		for i = 4, 7 do
			select(i, SendMailFrame:GetRegions()):Hide()
		end
		SendStationeryBackgroundLeft:Hide()
		SendStationeryBackgroundRight:Hide()
		DressUpFramePortrait:Hide()
		DressUpBackgroundTopLeft:Hide()
		DressUpBackgroundTopRight:Hide()
		DressUpBackgroundBotLeft:Hide()
		DressUpBackgroundBotRight:Hide()
		for i = 1, 4 do
			select(i, GearManagerDialogPopup:GetRegions()):Hide()
			select(i, SideDressUpFrame:GetRegions()):Hide()
		end
		StackSplitFrame:GetRegions():Hide()
		ReputationDetailCorner:Hide()
		ReputationDetailDivider:Hide()
		RaidInfoDetailFooter:Hide()
		RaidInfoDetailHeader:Hide()
		RaidInfoDetailCorner:Hide()
		RaidInfoFrameHeader:Hide()
		for i = 1, 9 do
			select(i, FriendsFriendsNoteFrame:GetRegions()):Hide()
			select(i, AddFriendNoteFrame:GetRegions()):Hide()
			select(i, ReportPlayerNameDialogCommentFrame:GetRegions()):Hide()
			select(i, ReportCheatingDialogCommentFrame:GetRegions()):Hide()
			select(i, QueueStatusFrame:GetRegions()):Hide()
		end
		PVPBannerFramePortrait:Hide()
		HelpFrameHeader:Hide()
		ReadyCheckPortrait:SetAlpha(0)
		select(2, ReadyCheckListenerFrame:GetRegions()):Hide()
		HelpFrameLeftInsetBg:Hide()
		LFDQueueFrameBackground:Hide()
		select(3, HelpFrameReportBug:GetChildren()):Hide()
		select(3, HelpFrameSubmitSuggestion:GetChildren()):Hide()
		select(4, HelpFrameTicket:GetChildren()):Hide()
		HelpFrameKnowledgebaseStoneTex:Hide()
		HelpFrameKnowledgebaseNavBarOverlay:Hide()
		GhostFrameLeft:Hide()
		GhostFrameRight:Hide()
		GhostFrameMiddle:Hide()
		for i = 3, 6 do
			select(i, GhostFrame:GetRegions()):Hide()
		end
		PaperDollSidebarTabs:GetRegions():Hide()
		select(2, PaperDollSidebarTabs:GetRegions()):Hide()
		select(6, PaperDollEquipmentManagerPaneEquipSet:GetRegions()):Hide()
		select(5, HelpFrameGM_Response:GetChildren()):Hide()
		select(6, HelpFrameGM_Response:GetChildren()):Hide()

		select(2, PVPHonorFrameInfoScrollFrameScrollBar:GetRegions()):Hide()
		select(3, PVPHonorFrameInfoScrollFrameScrollBar:GetRegions()):Hide()
		select(4, PVPHonorFrameInfoScrollFrameScrollBar:GetRegions()):Hide()
		PVPHonorFrameTypeScrollFrame:GetRegions():Hide()
		select(2, PVPHonorFrameTypeScrollFrame:GetRegions()):Hide()
		HelpFrameKnowledgebaseNavBarHomeButtonLeft:Hide()
		TokenFramePopupCorner:Hide()
		GearManagerDialogPopupScrollFrame:GetRegions():Hide()
		select(2, GearManagerDialogPopupScrollFrame:GetRegions()):Hide()
		for i = 1, 10 do
			select(i, GuildInviteFrame:GetRegions()):Hide()
		end
		CharacterFrameExpandButton:GetNormalTexture():SetAlpha(0)
		CharacterFrameExpandButton:GetPushedTexture():SetAlpha(0)
		InboxPrevPageButton:GetRegions():Hide()
		InboxNextPageButton:GetRegions():Hide()
		MerchantPrevPageButton:GetRegions():Hide()
		MerchantNextPageButton:GetRegions():Hide()
		select(2, MerchantPrevPageButton:GetRegions()):Hide()
		select(2, MerchantNextPageButton:GetRegions()):Hide()
		BNToastFrameCloseButton:SetAlpha(0)
		LFDQueueFrameRandomScrollFrameScrollBackground:Hide()
		ChannelFrameDaughterFrameCorner:Hide()
		LFDQueueFrameSpecificListScrollFrameScrollBackgroundTopLeft:Hide()
		LFDQueueFrameSpecificListScrollFrameScrollBackgroundBottomRight:Hide()
		for i = 1, MAX_DISPLAY_CHANNEL_BUTTONS do
			_G["ChannelButton"..i]:SetNormalTexture("")
		end
		CharacterStatsPaneTop:Hide()
		CharacterStatsPaneBottom:Hide()
		hooksecurefunc("PaperDollFrame_CollapseStatCategory", function(categoryFrame)
			categoryFrame.BgMinimized:Hide()
		end)
		hooksecurefunc("PaperDollFrame_ExpandStatCategory", function(categoryFrame)
			categoryFrame.BgTop:Hide()
			categoryFrame.BgMiddle:Hide()
			categoryFrame.BgBottom:Hide()
		end)
		local titles = false
		hooksecurefunc("PaperDollTitlesPane_Update", function()
			if titles == false then
				for i = 1, 17 do
					_G["PaperDollTitlesPaneButton"..i]:DisableDrawLayer("BACKGROUND")
				end
				titles = true
			end
		end)
		ReputationListScrollFrame:GetRegions():Hide()
		select(2, ReputationListScrollFrame:GetRegions()):Hide()
		select(3, ReputationDetailFrame:GetRegions()):Hide()
		MerchantNameText:SetDrawLayer("ARTWORK")
		SendScrollBarBackgroundTop:Hide()
		select(4, SendMailScrollFrame:GetRegions()):Hide()
		PVPBannerFrameCustomizationBorder:Hide()
		PVPBannerFramePortraitFrame:Hide()
		PVPBannerFrameTopBorder:Hide()
		PVPBannerFrameTopRightCorner:Hide()
		for i = 1, 7 do
			_G["LFRBrowseFrameColumnHeader"..i]:DisableDrawLayer("BACKGROUND")
			_G["WarGamesFrameScrollFrameButton"..i.."WarGameBg"]:Hide()
		end
		HelpFrameKnowledgebaseTopTileStreaks:Hide()
		for i = 2, 5 do
			select(i, DressUpFrame:GetRegions()):Hide()
		end
		ChannelFrameDaughterFrameTitlebar:Hide()
		OpenScrollBarBackgroundTop:Hide()
		select(2, OpenMailScrollFrame:GetRegions()):Hide()
		select(2, WarGamesFrameInfoScrollFrameScrollBar:GetRegions()):Hide()
		select(3, WarGamesFrameInfoScrollFrameScrollBar:GetRegions()):Hide()
		select(4, WarGamesFrameInfoScrollFrameScrollBar:GetRegions()):Hide()
		HelpFrameKnowledgebaseNavBar:GetRegions():Hide()
		WarGamesFrameBGTex:Hide()
		WarGamesFrameBarLeft:Hide()
		select(3, WarGamesFrame:GetRegions()):Hide()
		WhoListScrollFrame:GetRegions():Hide()
		select(2, WhoListScrollFrame:GetRegions()):Hide()
		select(2, GuildChallengeAlertFrame:GetRegions()):Hide()
		LFGDungeonReadyDialogBackground:Hide()
		LFGDungeonReadyDialogBottomArt:Hide()
		LFGDungeonReadyDialogFiligree:Hide()
		InterfaceOptionsFrameTab1TabSpacer:SetAlpha(0)
		for i = 1, 2 do
			_G["InterfaceOptionsFrameTab"..i.."Left"]:SetAlpha(0)
			_G["InterfaceOptionsFrameTab"..i.."Middle"]:SetAlpha(0)
			_G["InterfaceOptionsFrameTab"..i.."Right"]:SetAlpha(0)
			_G["InterfaceOptionsFrameTab"..i.."LeftDisabled"]:SetAlpha(0)
			_G["InterfaceOptionsFrameTab"..i.."MiddleDisabled"]:SetAlpha(0)
			_G["InterfaceOptionsFrameTab"..i.."RightDisabled"]:SetAlpha(0)
			_G["InterfaceOptionsFrameTab2TabSpacer"..i]:SetAlpha(0)
		end
		ChannelRosterScrollFrameTop:SetAlpha(0)
		ChannelRosterScrollFrameBottom:SetAlpha(0)
		FriendsFrameFriendsScrollFrameTop:Hide()
		FriendsFrameFriendsScrollFrameMiddle:Hide()
		FriendsFrameFriendsScrollFrameBottom:Hide()
		WhoFrameListInsetBg:Hide()
		WhoFrameEditBoxInsetBg:Hide()
		ChannelFrameLeftInsetBg:Hide()
		ChannelFrameRightInsetBg:Hide()
		RaidFinderQueueFrameBackground:Hide()
		RaidParentFrameInsetBg:Hide()
		RaidFinderFrameRoleInsetBg:Hide()
		RaidFinderFrameRoleBackground:Hide()
		RaidParentFramePortraitFrame:Hide()
		RaidParentFramePortrait:Hide()
		RaidParentFrameTopBorder:Hide()
		RaidParentFrameTopRightCorner:Hide()
		LFRQueueFrameRoleInsetBg:Hide()
		LFRQueueFrameListInsetBg:Hide()
		LFRQueueFrameCommentInsetBg:Hide()
		select(5, SideDressUpModelCloseButton:GetRegions()):Hide()
		IgnoreListFrameTop:Hide()
		IgnoreListFrameMiddle:Hide()
		IgnoreListFrameBottom:Hide()
		PendingListFrameTop:Hide()
		PendingListFrameMiddle:Hide()
		PendingListFrameBottom:Hide()
		ScrollOfResurrectionSelectionFrameBackground:Hide()

		ReadyCheckFrame:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end)

		-- [[ Text colour functions ]]

		NORMAL_QUEST_DISPLAY = "|cffffffff%s|r"
		TRIVIAL_QUEST_DISPLAY = "|cffffffff%s (low level)|r"

		GameFontBlackMedium:SetTextColor(1, 1, 1)
		QuestFont:SetTextColor(1, 1, 1)
		MailFont_Large:SetTextColor(1, 1, 1)
		MailFont_Large:SetShadowColor(0, 0, 0)
		MailFont_Large:SetShadowOffset(1, -1)
		MailTextFontNormal:SetTextColor(1, 1, 1)
		MailTextFontNormal:SetShadowOffset(1, -1)
		MailTextFontNormal:SetShadowColor(0, 0, 0)
		InvoiceTextFontNormal:SetTextColor(1, 1, 1)
		InvoiceTextFontSmall:SetTextColor(1, 1, 1)
		SpellBookPageText:SetTextColor(.8, .8, .8)
		QuestProgressRequiredItemsText:SetTextColor(1, 1, 1)
		QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
		QuestInfoRewardsHeader:SetShadowColor(0, 0, 0)
		QuestProgressTitleText:SetShadowColor(0, 0, 0)
		QuestInfoTitleHeader:SetShadowColor(0, 0, 0)
		AvailableServicesText:SetTextColor(1, 1, 1)
		AvailableServicesText:SetShadowColor(0, 0, 0)
		PetitionFrameCharterTitle:SetTextColor(1, 1, 1)
		PetitionFrameCharterTitle:SetShadowColor(0, 0, 0)
		PetitionFrameMasterTitle:SetTextColor(1, 1, 1)
		PetitionFrameMasterTitle:SetShadowColor(0, 0, 0)
		PetitionFrameMemberTitle:SetTextColor(1, 1, 1)
		PetitionFrameMemberTitle:SetShadowColor(0, 0, 0)
		QuestInfoTitleHeader:SetTextColor(1, 1, 1)
		QuestInfoTitleHeader.SetTextColor = function() end
		QuestInfoDescriptionHeader:SetTextColor(1, 1, 1)
		QuestInfoDescriptionHeader.SetTextColor = function() end
		QuestInfoDescriptionHeader:SetShadowColor(0, 0, 0)
		QuestInfoObjectivesHeader:SetTextColor(1, 1, 1)
		QuestInfoObjectivesHeader.SetTextColor = function() end
		QuestInfoObjectivesHeader:SetShadowColor(0, 0, 0)
		QuestInfoRewardsHeader:SetTextColor(1, 1, 1)
		QuestInfoRewardsHeader.SetTextColor = function() end
		QuestInfoDescriptionText:SetTextColor(1, 1, 1)
		QuestInfoDescriptionText.SetTextColor = function() end
		QuestInfoObjectivesText:SetTextColor(1, 1, 1)
		QuestInfoObjectivesText.SetTextColor = function() end
		QuestInfoGroupSize:SetTextColor(1, 1, 1)
		QuestInfoGroupSize.SetTextColor = function() end
		QuestInfoRewardText:SetTextColor(1, 1, 1)
		QuestInfoRewardText.SetTextColor = function() end
		QuestInfoItemChooseText:SetTextColor(1, 1, 1)
		QuestInfoItemChooseText.SetTextColor = function() end
		QuestInfoItemReceiveText:SetTextColor(1, 1, 1)
		QuestInfoItemReceiveText.SetTextColor = function() end
		QuestInfoSpellLearnText:SetTextColor(1, 1, 1)
		QuestInfoSpellLearnText.SetTextColor = function() end
		QuestInfoXPFrameReceiveText:SetTextColor(1, 1, 1)
		QuestInfoXPFrameReceiveText.SetTextColor = function() end
		QuestProgressTitleText:SetTextColor(1, 1, 1)
		QuestProgressTitleText.SetTextColor = function() end
		QuestProgressText:SetTextColor(1, 1, 1)
		QuestProgressText.SetTextColor = function() end
		ItemTextPageText:SetTextColor(1, 1, 1)
		ItemTextPageText.SetTextColor = function() end
		GreetingText:SetTextColor(1, 1, 1)
		GreetingText.SetTextColor = function() end
		AvailableQuestsText:SetTextColor(1, 1, 1)
		AvailableQuestsText.SetTextColor = function() end
		AvailableQuestsText:SetShadowColor(0, 0, 0)
		QuestInfoSpellObjectiveLearnLabel:SetTextColor(1, 1, 1)
		QuestInfoSpellObjectiveLearnLabel.SetTextColor = function() end
		CurrentQuestsText:SetTextColor(1, 1, 1)
		CurrentQuestsText.SetTextColor = function() end
		CurrentQuestsText:SetShadowColor(0, 0, 0)
		CoreAbilityFont:SetTextColor(1, 1, 1)
		SystemFont_Large:SetTextColor(1, 1, 1)

		for i = 1, MAX_OBJECTIVES do
			local objective = _G["QuestInfoObjective"..i]
			objective:SetTextColor(1, 1, 1)
			objective.SetTextColor = function() end
		end

		hooksecurefunc("UpdateProfessionButton", function(self)
			self.spellString:SetTextColor(1, 1, 1);
			self.subSpellString:SetTextColor(1, 1, 1)
		end)

		function PaperDollFrame_SetLevel()
			local primaryTalentTree = GetSpecialization()
			local classDisplayName, class = UnitClass("player")
			local classColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
			local classColorString = format("ff%.2x%.2x%.2x", classColor.r * 255, classColor.g * 255, classColor.b * 255)
			local specName

			if (primaryTalentTree) then
				_, specName = GetSpecializationInfo(primaryTalentTree);
			end

			if (specName and specName ~= "") then
				CharacterLevelText:SetFormattedText(PLAYER_LEVEL, UnitLevel("player"), classColorString, specName, classDisplayName);
			else
				CharacterLevelText:SetFormattedText(PLAYER_LEVEL_NO_SPEC, UnitLevel("player"), classColorString, classDisplayName);
			end
		end

		-- [[ Change positions ]]

		ChatConfigFrameDefaultButton:Width(125)
		ChatConfigFrameDefaultButton:Point("TOPLEFT", ChatConfigCategoryFrame, "BOTTOMLEFT", 0, -4)
		ChatConfigFrameOkayButton:Point("TOPRIGHT", ChatConfigBackgroundFrame, "BOTTOMRIGHT", 0, -4)
		ReputationDetailFrame:Point("TOPLEFT", ReputationFrame, "TOPRIGHT", 1, -28)
		PaperDollEquipmentManagerPaneEquipSet:Width(PaperDollEquipmentManagerPaneEquipSet:GetWidth()-1)
		PaperDollEquipmentManagerPaneSaveSet:Point("LEFT", PaperDollEquipmentManagerPaneEquipSet, "RIGHT", 1, 0)
		GearManagerDialogPopup:Point("LEFT", PaperDollFrame, "RIGHT", 1, 0)
		DressUpFrameResetButton:Point("RIGHT", DressUpFrameCancelButton, "LEFT", -1, 0)
		SendMailMailButton:Point("RIGHT", SendMailCancelButton, "LEFT", -1, 0)
		OpenMailDeleteButton:Point("RIGHT", OpenMailCancelButton, "LEFT", -1, 0)
		OpenMailReplyButton:Point("RIGHT", OpenMailDeleteButton, "LEFT", -1, 0)
		HelpFrameReportBugScrollFrameScrollBar:Point("TOPLEFT", HelpFrameReportBugScrollFrame, "TOPRIGHT", 1, -16)
		HelpFrameSubmitSuggestionScrollFrameScrollBar:Point("TOPLEFT", HelpFrameSubmitSuggestionScrollFrame, "TOPRIGHT", 1, -16)
		HelpFrameTicketScrollFrameScrollBar:Point("TOPLEFT", HelpFrameTicketScrollFrame, "TOPRIGHT", 1, -16)
		HelpFrameGM_ResponseScrollFrame1ScrollBar:Point("TOPLEFT", HelpFrameGM_ResponseScrollFrame1, "TOPRIGHT", 1, -16)
		HelpFrameGM_ResponseScrollFrame2ScrollBar:Point("TOPLEFT", HelpFrameGM_ResponseScrollFrame2, "TOPRIGHT", 1, -16)
		RaidInfoFrame:Point("TOPLEFT", RaidFrame, "TOPRIGHT", 1, -28)
		TokenFramePopup:Point("TOPLEFT", TokenFrame, "TOPRIGHT", 1, -28)
		CharacterFrameExpandButton:Point("BOTTOMRIGHT", CharacterFrameInset, "BOTTOMRIGHT", -14, 6)
		PVPTeamManagementFrameWeeklyDisplay:Point("RIGHT", PVPTeamManagementFrameWeeklyToggleRight, "LEFT", -2, 0)
		TabardCharacterModelRotateRightButton:Point("TOPLEFT", TabardCharacterModelRotateLeftButton, "TOPRIGHT", 1, 0)
		LFDQueueFrameSpecificListScrollFrameScrollBarScrollDownButton:Point("TOP", LFDQueueFrameSpecificListScrollFrameScrollBar, "BOTTOM", 0, 2)
		LFDQueueFrameRandomScrollFrameScrollBarScrollDownButton:Point("TOP", LFDQueueFrameRandomScrollFrameScrollBar, "BOTTOM", 0, 2)
		MerchantFrameTab2:Point("LEFT", MerchantFrameTab1, "RIGHT", -15, 0)
		SendMailMoneySilver:Point("LEFT", SendMailMoneyGold, "RIGHT", 1, 0)
		SendMailMoneyCopper:Point("LEFT", SendMailMoneySilver, "RIGHT", 1, 0)
		StaticPopup1MoneyInputFrameSilver:Point("LEFT", StaticPopup1MoneyInputFrameGold, "RIGHT", 1, 0)
		StaticPopup1MoneyInputFrameCopper:Point("LEFT", StaticPopup1MoneyInputFrameSilver, "RIGHT", 1, 0)
		StaticPopup2MoneyInputFrameSilver:Point("LEFT", StaticPopup2MoneyInputFrameGold, "RIGHT", 1, 0)
		StaticPopup2MoneyInputFrameCopper:Point("LEFT", StaticPopup2MoneyInputFrameSilver, "RIGHT", 1, 0)
		WhoFrameWhoButton:Point("RIGHT", WhoFrameAddFriendButton, "LEFT", -1, 0)
		WhoFrameAddFriendButton:Point("RIGHT", WhoFrameGroupInviteButton, "LEFT", -1, 0)
		WarGameStartButton:ClearAllPoints()
		WarGameStartButton:Point("BOTTOMRIGHT", PVPFrame, "BOTTOMRIGHT", -4, 4)
		FriendsFrameTitleText:Point("TOP", FriendsFrame, "TOP", 0, -8)
		VideoOptionsFrameOkay:Point("BOTTOMRIGHT", VideoOptionsFrameCancel, "BOTTOMLEFT", -1, 0)
		InterfaceOptionsFrameOkay:Point("BOTTOMRIGHT", InterfaceOptionsFrameCancel, "BOTTOMLEFT", -1, 0)

		-- [[ Tabs ]]

		for i = 1, 5 do
			S.CreateTab(_G["SpellBookFrameTabButton"..i])
		end

		for i = 1, 4 do
			S.CreateTab(_G["FriendsFrameTab"..i])
			S.CreateTab(_G["PVPFrameTab"..i])
			if _G["CharacterFrameTab"..i] then
				S.CreateTab(_G["CharacterFrameTab"..i])
			end
		end

		for i = 1, 2 do
			S.CreateTab(_G["MerchantFrameTab"..i])
			S.CreateTab(_G["MailFrameTab"..i])
		end

		-- [[ Buttons ]]

		for i = 1, 2 do
			for j = 1, 3 do
				S.Reskin(_G["StaticPopup"..i.."Button"..j])
			end
		end

		local buttons = {"VideoOptionsFrameOkay", "VideoOptionsFrameCancel", "VideoOptionsFrameDefaults", "VideoOptionsFrameApply", "AudioOptionsFrameOkay", "AudioOptionsFrameCancel", "AudioOptionsFrameDefaults", "InterfaceOptionsFrameDefaults", "InterfaceOptionsFrameOkay", "InterfaceOptionsFrameCancel", "ChatConfigFrameOkayButton", "ChatConfigFrameDefaultButton", "DressUpFrameCancelButton", "DressUpFrameResetButton", "WhoFrameWhoButton", "WhoFrameAddFriendButton", "WhoFrameGroupInviteButton", "SendMailMailButton", "SendMailCancelButton", "OpenMailReplyButton", "OpenMailDeleteButton", "OpenMailCancelButton", "OpenMailReportSpamButton", "ChannelFrameNewButton", "RaidFrameRaidInfoButton", "RaidFrameConvertToRaidButton", "GearManagerDialogPopupOkay", "GearManagerDialogPopupCancel", "StackSplitOkayButton", "StackSplitCancelButton", "GameMenuButtonHelp", "GameMenuButtonOptions", "GameMenuButtonUIOptions", "GameMenuButtonKeybindings", "GameMenuButtonMacros", "GameMenuButtonLogout", "GameMenuButtonQuit", "GameMenuButtonContinue", "GameMenuButtonMacOptions", "FriendsFrameAddFriendButton", "FriendsFrameSendMessageButton", "LFDQueueFrameFindGroupButton", "LFRQueueFrameFindGroupButton", "LFRQueueFrameAcceptCommentButton", "PVPFrameLeftButton", "PVPFrameRightButton", "AddFriendEntryFrameAcceptButton", "AddFriendEntryFrameCancelButton", "FriendsFriendsSendRequestButton", "FriendsFriendsCloseButton", "ColorPickerOkayButton", "ColorPickerCancelButton", "FriendsFrameIgnorePlayerButton", "FriendsFrameUnsquelchButton", "LFGDungeonReadyDialogEnterDungeonButton", "LFGDungeonReadyDialogLeaveQueueButton", "LFRBrowseFrameSendMessageButton", "LFRBrowseFrameInviteButton", "LFRBrowseFrameRefreshButton", "LFDRoleCheckPopupAcceptButton", "LFDRoleCheckPopupDeclineButton", "GuildInviteFrameJoinButton", "GuildInviteFrameDeclineButton", "FriendsFramePendingButton1AcceptButton", "FriendsFramePendingButton1DeclineButton", "RaidInfoExtendButton", "RaidInfoCancelButton", "PaperDollEquipmentManagerPaneEquipSet", "PaperDollEquipmentManagerPaneSaveSet", "PVPBannerFrameAcceptButton", "PVPColorPickerButton1", "PVPColorPickerButton2", "PVPColorPickerButton3", "HelpFrameButton1", "HelpFrameButton2", "HelpFrameButton3", "HelpFrameButton4", "HelpFrameButton5", "HelpFrameButton16", "HelpFrameButton6", "HelpFrameAccountSecurityOpenTicket", "HelpFrameCharacterStuckStuck", "HelpFrameOpenTicketHelpTopIssues", "HelpFrameOpenTicketHelpOpenTicket", "ReadyCheckFrameYesButton", "ReadyCheckFrameNoButton", "RolePollPopupAcceptButton", "HelpFrameTicketSubmit", "HelpFrameTicketCancel", "HelpFrameKnowledgebaseSearchButton", "GhostFrame", "HelpFrameGM_ResponseNeedMoreHelp", "HelpFrameGM_ResponseCancel", "GMChatOpenLog", "HelpFrameKnowledgebaseNavBarHomeButton", "AddFriendInfoFrameContinueButton", "LFDQueueFramePartyBackfillBackfillButton", "LFDQueueFramePartyBackfillNoBackfillButton", "ChannelFrameDaughterFrameOkayButton", "ChannelFrameDaughterFrameCancelButton", "WarGameStartButton", "PendingListInfoFrameContinueButton", "LFDQueueFrameNoLFDWhileLFRLeaveQueueButton", "InterfaceOptionsHelpPanelResetTutorials", "RaidFinderFrameFindRaidButton", "RaidFinderQueueFrameIneligibleFrameLeaveQueueButton", "SideDressUpModelResetButton", "LFGInvitePopupAcceptButton", "LFGInvitePopupDeclineButton", "RaidFinderQueueFramePartyBackfillBackfillButton", "RaidFinderQueueFramePartyBackfillNoBackfillButton", "ScrollOfResurrectionSelectionFrameAcceptButton", "ScrollOfResurrectionSelectionFrameCancelButton", "ScrollOfResurrectionFrameAcceptButton", "ScrollOfResurrectionFrameCancelButton", "HelpFrameReportBugSubmit", "HelpFrameSubmitSuggestionSubmit", "ReportPlayerNameDialogReportButton", "ReportPlayerNameDialogCancelButton", "ReportCheatingDialogReportButton", "ReportCheatingDialogCancelButton", "HelpFrameOpenTicketHelpItemRestoration"}
		for i = 1, #buttons do
		local reskinbutton = _G[buttons[i]]
			if reskinbutton then
				S.Reskin(reskinbutton)
			else
				print("Aurora: "..buttons[i].." was not found.")
			end
		end

		S.Reskin(select(6, PVPBannerFrame:GetChildren()))

		if IsAddOnLoaded("ACP") then S.Reskin(GameMenuButtonAddOns) end

		local closebuttons = {"SpellBookFrameCloseButton", "HelpFrameCloseButton", "PVPBannerFrameCloseButton", "RaidInfoCloseButton", "RolePollPopupCloseButton", "ItemRefCloseButton", "TokenFramePopupCloseButton", "ReputationDetailCloseButton", "ChannelFrameDaughterFrameDetailCloseButton", "LFGDungeonReadyStatusCloseButton", "RaidParentFrameCloseButton", "SideDressUpModelCloseButton", "LFGDungeonReadyDialogCloseButton", "StaticPopup1CloseButton"}
		for i = 1, #closebuttons do
			local closebutton = _G[closebuttons[i]]
			S.ReskinClose(closebutton)
		end

		S.ReskinClose(DressUpFrameCloseButton, "TOPRIGHT", DressUpFrame, "TOPRIGHT", -38, -16)

	-- [[ Load on Demand Addons ]]

	elseif addon == "Blizzard_ArchaeologyUI" then
		S.SetBD(ArchaeologyFrame)
		S.Reskin(ArchaeologyFrameArtifactPageSolveFrameSolveButton)
		S.Reskin(ArchaeologyFrameArtifactPageBackButton)
		ArchaeologyFramePortrait:Hide()
		ArchaeologyFrame:DisableDrawLayer("BACKGROUND")
		ArchaeologyFrame:DisableDrawLayer("BORDER")
		ArchaeologyFrame:DisableDrawLayer("OVERLAY")
		ArchaeologyFrameInset:DisableDrawLayer("BACKGROUND")
		ArchaeologyFrameInset:DisableDrawLayer("BORDER")
		ArchaeologyFrameSummaryPageTitle:SetTextColor(1, 1, 1)
		ArchaeologyFrameArtifactPageHistoryTitle:SetTextColor(1, 1, 1)
		ArchaeologyFrameArtifactPageHistoryScrollChildText:SetTextColor(1, 1, 1)
		ArchaeologyFrameHelpPageTitle:SetTextColor(1, 1, 1)
		ArchaeologyFrameHelpPageDigTitle:SetTextColor(1, 1, 1)
		ArchaeologyFrameHelpPageHelpScrollHelpText:SetTextColor(1, 1, 1)
		ArchaeologyFrameCompletedPage:GetRegions():SetTextColor(1, 1, 1)
		ArchaeologyFrameCompletedPageTitle:SetTextColor(1, 1, 1)
		ArchaeologyFrameCompletedPageTitleTop:SetTextColor(1, 1, 1)
		ArchaeologyFrameCompletedPageTitleMid:SetTextColor(1, 1, 1)
		ArchaeologyFrameCompletedPagePageText:SetTextColor(1, 1, 1)

		for i = 1, ARCHAEOLOGY_MAX_RACES do
			_G["ArchaeologyFrameSummaryPageRace"..i]:GetRegions():SetTextColor(1, 1, 1)
		end
		for i = 1, ARCHAEOLOGY_MAX_COMPLETED_SHOWN do
			local bu = _G["ArchaeologyFrameCompletedPageArtifact"..i]
			bu:GetRegions():Hide()
			select(2, bu:GetRegions()):Hide()
			select(3, bu:GetRegions()):SetTexCoord(.08, .92, .08, .92)
			select(4, bu:GetRegions()):SetTextColor(1, 1, 1)
			select(5, bu:GetRegions()):SetTextColor(1, 1, 1)
			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, .25)
			local vline = CreateFrame("Frame", nil, bu)
			vline:Point("LEFT", 44, 0)
			vline:Size(1, 44)
			S.CreateBD(vline)
		end

		ArchaeologyFrameInfoButton:SetPoint("TOPLEFT", 3, -3)

		S.ReskinDropDown(ArchaeologyFrameRaceFilter)
		S.ReskinClose(ArchaeologyFrameCloseButton)
		S.ReskinScroll(ArchaeologyFrameArtifactPageHistoryScrollScrollBar)
		S.ReskinArrow(ArchaeologyFrameCompletedPagePrevPageButton, "left")
		S.ReskinArrow(ArchaeologyFrameCompletedPageNextPageButton, "right")
		ArchaeologyFrameCompletedPagePrevPageButtonIcon:Hide()
		ArchaeologyFrameCompletedPageNextPageButtonIcon:Hide()

		ArchaeologyFrameRankBarBorder:Hide()
		ArchaeologyFrameRankBarBackground:Hide()
		ArchaeologyFrameRankBarBar:SetTexture(media.backdrop)
		ArchaeologyFrameRankBarBar:SetGradient("VERTICAL", 0, .65, 0, 0, .75, 0)
		ArchaeologyFrameRankBar:Height(14)
		S.CreateBD(ArchaeologyFrameRankBar, .25)

		ArchaeologyFrameArtifactPageSolveFrameStatusBarBarBG:Hide()
		local bar = select(3, ArchaeologyFrameArtifactPageSolveFrameStatusBar:GetRegions())
		bar:SetTexture(media.backdrop)
		bar:SetGradient("VERTICAL", .65, .25, 0, .75, .35, .1)

		local bg = CreateFrame("Frame", nil, ArchaeologyFrameArtifactPageSolveFrameStatusBar)
		bg:Point("TOPLEFT", -1, 1)
		bg:Point("BOTTOMRIGHT", 1, -1)
		bg:SetFrameLevel(0)
		S.CreateBD(bg, .25)

		ArchaeologyFrameArtifactPageIcon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(ArchaeologyFrameArtifactPageIcon)
	elseif addon == "Blizzard_AuctionUI" then
		S.SetBD(AuctionFrame, 2, -10, 0, 10)
		S.CreateBD(AuctionProgressFrame)

		AuctionProgressBar:SetStatusBarTexture(DB.Statusbar)
		local ABBD = CreateFrame("Frame", nil, AuctionProgressBar)
		ABBD:Point("TOPLEFT", -1, 1)
		ABBD:Point("BOTTOMRIGHT", 1, -1)
		ABBD:SetFrameLevel(AuctionProgressBar:GetFrameLevel()-1)
		S.CreateBD(ABBD, .25)

		AuctionProgressBarIcon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(AuctionProgressBarIcon)

		AuctionProgressBarText:ClearAllPoints()
		AuctionProgressBarText:SetPoint("CENTER", 0, 1)

		S.ReskinClose(AuctionProgressFrameCancelButton, "LEFT", AuctionProgressBar, "RIGHT", 4, 0)
		select(15, AuctionProgressFrameCancelButton:GetRegions()):Point("CENTER", 0, 2)

		AuctionFrame:DisableDrawLayer("ARTWORK")
		AuctionPortraitTexture:Hide()
		for i = 1, 4 do
			select(i, AuctionProgressFrame:GetRegions()):Hide()
		end
		AuctionProgressBarBorder:Hide()
		BrowseFilterScrollFrame:GetRegions():Hide()
		select(2, BrowseFilterScrollFrame:GetRegions()):Hide()
		BrowseScrollFrame:GetRegions():Hide()
		select(2, BrowseScrollFrame:GetRegions()):Hide()
		BidScrollFrame:GetRegions():Hide()
		select(2, BidScrollFrame:GetRegions()):Hide()
		AuctionsScrollFrame:GetRegions():Hide()
		select(2, AuctionsScrollFrame:GetRegions()):Hide()
		BrowseQualitySort:DisableDrawLayer("BACKGROUND")
		BrowseLevelSort:DisableDrawLayer("BACKGROUND")
		BrowseDurationSort:DisableDrawLayer("BACKGROUND")
		BrowseHighBidderSort:DisableDrawLayer("BACKGROUND")
		BrowseCurrentBidSort:DisableDrawLayer("BACKGROUND")
		BidQualitySort:DisableDrawLayer("BACKGROUND")
		BidLevelSort:DisableDrawLayer("BACKGROUND")
		BidDurationSort:DisableDrawLayer("BACKGROUND")
		BidBuyoutSort:DisableDrawLayer("BACKGROUND")
		BidStatusSort:DisableDrawLayer("BACKGROUND")
		BidBidSort:DisableDrawLayer("BACKGROUND")
		AuctionsQualitySort:DisableDrawLayer("BACKGROUND")
		AuctionsDurationSort:DisableDrawLayer("BACKGROUND")
		AuctionsHighBidderSort:DisableDrawLayer("BACKGROUND")
		AuctionsBidSort:DisableDrawLayer("BACKGROUND")

		for i = 1, NUM_FILTERS_TO_DISPLAY do
			_G["AuctionFilterButton"..i]:SetNormalTexture("")
		end

		for i = 1, 3 do
			S.CreateTab(_G["AuctionFrameTab"..i])
		end

		local abuttons = {"BrowseBidButton", "BrowseBuyoutButton", "BrowseCloseButton", "BrowseSearchButton", "BrowseResetButton", "BidBidButton", "BidBuyoutButton", "BidCloseButton", "AuctionsCloseButton", "AuctionsCancelAuctionButton", "AuctionsCreateAuctionButton", "AuctionsNumStacksMaxButton", "AuctionsStackSizeMaxButton"}
		for i = 1, #abuttons do
			local reskinbutton = _G[abuttons[i]]
			if reskinbutton then
				S.Reskin(reskinbutton)
			end
		end
		local a,b,c,d,e = BrowseName:GetPoint()  --����
		BrowseName:ClearAllPoints()
		BrowseName:SetPoint(a,b,c,d-30,e)
		
		local a,b,c,d,e = BrowseMinLevel:GetPoint() --��С�ȼ�
		BrowseMinLevel:ClearAllPoints()
		BrowseMinLevel:SetPoint(a,b,c,d-25,e)
		
		local a,b,c,d,e = BrowseSearchButton:GetPoint() --����
		BrowseSearchButton:ClearAllPoints()
		BrowseSearchButton:SetPoint(a,b,c,d-5,e-10)
		
		local a,b,c,d,e = BrowsePrevPageButton:GetPoint() --��һҳ
		BrowsePrevPageButton:ClearAllPoints()
		BrowsePrevPageButton:SetPoint(a,b,c,d-10,e)
		
		BrowseCloseButton:ClearAllPoints()
		BrowseCloseButton:Point("BOTTOMRIGHT", AuctionFrameBrowse, "BOTTOMRIGHT", 66, 13)
		BrowseBuyoutButton:ClearAllPoints()
		BrowseBuyoutButton:Point("RIGHT", BrowseCloseButton, "LEFT", -1, 0)
		BrowseBidButton:ClearAllPoints()
		BrowseBidButton:Point("RIGHT", BrowseBuyoutButton, "LEFT", -1, 0)
		BidBuyoutButton:ClearAllPoints()
		BidBuyoutButton:Point("RIGHT", BidCloseButton, "LEFT", -1, 0)
		BidBidButton:ClearAllPoints()
		BidBidButton:Point("RIGHT", BidBuyoutButton, "LEFT", -1, 0)
		AuctionsCancelAuctionButton:ClearAllPoints()
		AuctionsCancelAuctionButton:Point("RIGHT", AuctionsCloseButton, "LEFT", -1, 0)

		-- Blizz needs to be more consistent

		BrowseBidPriceSilver:Point("LEFT", BrowseBidPriceGold, "RIGHT", 1, 0)
		BrowseBidPriceCopper:Point("LEFT", BrowseBidPriceSilver, "RIGHT", 1, 0)
		BidBidPriceSilver:Point("LEFT", BidBidPriceGold, "RIGHT", 1, 0)
		BidBidPriceCopper:Point("LEFT", BidBidPriceSilver, "RIGHT", 1, 0)
		StartPriceSilver:Point("LEFT", StartPriceGold, "RIGHT", 1, 0)
		StartPriceCopper:Point("LEFT", StartPriceSilver, "RIGHT", 1, 0)
		BuyoutPriceSilver:Point("LEFT", BuyoutPriceGold, "RIGHT", 1, 0)
		BuyoutPriceCopper:Point("LEFT", BuyoutPriceSilver, "RIGHT", 1, 0)

		for i = 1, NUM_BROWSE_TO_DISPLAY do
			local bu = _G["BrowseButton"..i]
			local it = _G["BrowseButton"..i.."Item"]
			local ic = _G["BrowseButton"..i.."ItemIconTexture"]

			if bu and it then
				it:SetNormalTexture("")
				it:SetPushedTexture("")
				ic:SetTexCoord(.08, .92, .08, .92)

				S.CreateBG(it)

				_G["BrowseButton"..i.."Left"]:Hide()
				select(6, _G["BrowseButton"..i]:GetRegions()):Hide()
				_G["BrowseButton"..i.."Right"]:Hide()

				local bd = CreateFrame("Frame", nil, bu)
				bd:SetPoint("TOPLEFT")
				bd:Point("BOTTOMRIGHT", 0, 5)
				bd:SetFrameLevel(bu:GetFrameLevel()-1)
				S.CreateBD(bd, .25)

				bu:SetHighlightTexture(media.backdrop)
				local hl = bu:GetHighlightTexture()
				hl:SetVertexColor(r, g, b, .2)
				hl:ClearAllPoints()
				hl:SetPoint("TOPLEFT", 0, -1)
				hl:SetPoint("BOTTOMRIGHT", -1, 6)
			end
		end

		for i = 1, NUM_BIDS_TO_DISPLAY do
			local bu = _G["BidButton"..i]
			local it = _G["BidButton"..i.."Item"]
			local ic = _G["BidButton"..i.."ItemIconTexture"]

			it:SetNormalTexture("")
			it:SetPushedTexture("")
			ic:SetTexCoord(.08, .92, .08, .92)

			S.CreateBG(it)

			_G["BidButton"..i.."Left"]:Hide()
			select(6, _G["BidButton"..i]:GetRegions()):Hide()
			_G["BidButton"..i.."Right"]:Hide()

			local bd = CreateFrame("Frame", nil, bu)
			bd:SetPoint("TOPLEFT")
			bd:Point("BOTTOMRIGHT", 0, 5)
			bd:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bd, .25)

			bu:SetHighlightTexture(media.backdrop)
			local hl = bu:GetHighlightTexture()
			hl:SetVertexColor(r, g, b, .2)
			hl:ClearAllPoints()
			hl:Point("TOPLEFT", 0, -1)
			hl:Point("BOTTOMRIGHT", -1, 6)
		end

		for i = 1, NUM_AUCTIONS_TO_DISPLAY do
			local bu = _G["AuctionsButton"..i]
			local it = _G["AuctionsButton"..i.."Item"]
			local ic = _G["AuctionsButton"..i.."ItemIconTexture"]

			it:SetNormalTexture("")
			it:SetPushedTexture("")
			ic:SetTexCoord(.08, .92, .08, .92)

			S.CreateBG(it)

			_G["AuctionsButton"..i.."Left"]:Hide()
			select(5, _G["AuctionsButton"..i]:GetRegions()):Hide()
			_G["AuctionsButton"..i.."Right"]:Hide()

			local bd = CreateFrame("Frame", nil, bu)
			bd:SetPoint("TOPLEFT")
			bd:Point("BOTTOMRIGHT", 0, 5)
			bd:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bd, .25)

			bu:SetHighlightTexture(media.backdrop)
			local hl = bu:GetHighlightTexture()
			hl:SetVertexColor(r, g, b, .2)
			hl:ClearAllPoints()
			hl:Point("TOPLEFT", 0, -1)
			hl:Point("BOTTOMRIGHT", -1, 6)
		end

		local auctionhandler = CreateFrame("Frame")
		auctionhandler:RegisterEvent("NEW_AUCTION_UPDATE")
		auctionhandler:SetScript("OnEvent", function()
			local _, _, _, _, _, _, _, _, _, _, _, _, _, AuctionsItemButtonIconTexture = AuctionsItemButton:GetRegions() -- blizzard, please name your textures
			if AuctionsItemButtonIconTexture then
				AuctionsItemButtonIconTexture:SetTexCoord(.08, .92, .08, .92)
				AuctionsItemButtonIconTexture:Point("TOPLEFT", 1, -1)
				AuctionsItemButtonIconTexture:Point("BOTTOMRIGHT", -1, 1)
			end
		end)

		S.CreateBD(AuctionsItemButton, .25)
		local _, AuctionsItemButtonNameFrame = AuctionsItemButton:GetRegions()
		AuctionsItemButtonNameFrame:Hide()

		S.ReskinClose(AuctionFrameCloseButton, "TOPRIGHT", AuctionFrame, "TOPRIGHT", -4, -14)
		S.ReskinScroll(BrowseScrollFrameScrollBar)
		S.ReskinScroll(AuctionsScrollFrameScrollBar)
		S.ReskinScroll(BrowseFilterScrollFrameScrollBar)
		S.ReskinDropDown(PriceDropDown)
		S.ReskinDropDown(DurationDropDown)
		S.ReskinInput(BrowseName)
		S.ReskinArrow(BrowsePrevPageButton, "left")
		S.ReskinArrow(BrowseNextPageButton, "right")
		S.ReskinCheck(IsUsableCheckButton)
		S.ReskinCheck(ShowOnPlayerCheckButton)

		BrowsePrevPageButton:GetRegions():SetPoint("LEFT", BrowsePrevPageButton, "RIGHT", 2, 0)

		-- seriously, consistency
		BrowseDropDownLeft:SetAlpha(0)
		BrowseDropDownMiddle:SetAlpha(0)
		BrowseDropDownRight:SetAlpha(0)

		local a1, p, a2, x, y = BrowseDropDownButton:GetPoint()
		BrowseDropDownButton:SetPoint(a1, p, a2, x, y-4)
		BrowseDropDownButton:Size(16, 16)
		S.Reskin(BrowseDropDownButton, true)

		BrowseDropDownButton:HookScript("OnEnter", colourArrow)
		BrowseDropDownButton:HookScript("OnLeave", clearArrow)

		local downtex = BrowseDropDownButton:CreateTexture(nil, "OVERLAY")
		downtex:SetTexture(media.arrowDown)
		downtex:Size(8, 8)
		downtex:SetPoint("CENTER")
		downtex:SetVertexColor(1, 1, 1)
		BrowseDropDownButton.downtex = downtex

		local bg = CreateFrame("Frame", nil, BrowseDropDown)
		bg:Point("TOPLEFT", 16, -5)
		bg:Point("BOTTOMRIGHT", 109, 11)
		bg:SetFrameLevel(BrowseDropDown:GetFrameLevel(-1))
		S.CreateBD(bg, 0)

		S.CreateGradient(bg)

		local inputs = {"BrowseMinLevel", "BrowseMaxLevel", "BrowseBidPriceGold", "BrowseBidPriceSilver", "BrowseBidPriceCopper", "BidBidPriceGold", "BidBidPriceSilver", "BidBidPriceCopper", "StartPriceGold", "StartPriceSilver", "StartPriceCopper", "BuyoutPriceGold", "BuyoutPriceSilver", "BuyoutPriceCopper", "AuctionsStackSizeEntry", "AuctionsNumStacksEntry"}
		for i = 1, #inputs do
			S.ReskinInput(_G[inputs[i]])
		end
	elseif addon == "Blizzard_AchievementUI" then
		S.CreateBD(AchievementFrame)
		S.CreateSD(AchievementFrame)
		AchievementFrameCategories:SetBackdrop(nil)
		AchievementFrameSummary:SetBackdrop(nil)
		for i = 1, 17 do
			select(i, AchievementFrame:GetRegions()):Hide()
		end
		AchievementFrameSummaryBackground:Hide()
		AchievementFrameSummary:GetChildren():Hide()
		AchievementFrameCategoriesContainerScrollBarBG:SetAlpha(0)
		for i = 1, 4 do
			select(i, AchievementFrameHeader:GetRegions()):Hide()
		end
		AchievementFrameHeaderRightDDLInset:SetAlpha(0)
		select(2, AchievementFrameAchievements:GetChildren()):Hide()
		AchievementFrameAchievementsBackground:Hide()
		select(3, AchievementFrameAchievements:GetRegions()):Hide()
		AchievementFrameStatsBG:Hide()
		AchievementFrameSummaryAchievementsHeaderHeader:Hide()
		AchievementFrameSummaryCategoriesHeaderTexture:Hide()
		select(3, AchievementFrameStats:GetChildren()):Hide()
		select(5, AchievementFrameComparison:GetChildren()):Hide()
		AchievementFrameComparisonHeaderBG:Hide()
		AchievementFrameComparisonHeaderPortrait:Hide()
		AchievementFrameComparisonHeaderPortraitBg:Hide()
		AchievementFrameComparisonBackground:Hide()
		AchievementFrameComparisonDark:SetAlpha(0)
		AchievementFrameComparisonSummaryPlayerBackground:Hide()
		AchievementFrameComparisonSummaryFriendBackground:Hide()

		local first = 1
		hooksecurefunc("AchievementFrameCategories_Update", function()
			if first == 1 then
				for i = 1, 19 do
					_G["AchievementFrameCategoriesContainerButton"..i.."Background"]:Hide()
				end
				first = 0
			end
		end)

		AchievementFrameHeaderPoints:Point("TOP", AchievementFrame, "TOP", 0, -6)
		AchievementFrameFilterDropDown:Point("TOPRIGHT", AchievementFrame, "TOPRIGHT", -98, 1)
		AchievementFrameFilterDropDownText:ClearAllPoints()
		AchievementFrameFilterDropDownText:Point("CENTER", -10, 1)

		AchievementFrameSummaryCategoriesStatusBar:SetStatusBarTexture(DB.Statusbar)
		AchievementFrameSummaryCategoriesStatusBar:GetStatusBarTexture():SetGradient("VERTICAL", 0, .4, 0, 0, .6, 0)
		AchievementFrameSummaryCategoriesStatusBarLeft:Hide()
		AchievementFrameSummaryCategoriesStatusBarMiddle:Hide()
		AchievementFrameSummaryCategoriesStatusBarRight:Hide()
		AchievementFrameSummaryCategoriesStatusBarFillBar:Hide()
		AchievementFrameSummaryCategoriesStatusBarTitle:SetTextColor(1, 1, 1)
		AchievementFrameSummaryCategoriesStatusBarTitle:Point("LEFT", AchievementFrameSummaryCategoriesStatusBar, "LEFT", 6, 0)
		AchievementFrameSummaryCategoriesStatusBarText:Point("RIGHT", AchievementFrameSummaryCategoriesStatusBar, "RIGHT", -5, 0)

		local bg = CreateFrame("Frame", nil, AchievementFrameSummaryCategoriesStatusBar)
		bg:Point("TOPLEFT", -1, 1)
		bg:Point("BOTTOMRIGHT", 1, -1)
		bg:SetFrameLevel(AchievementFrameSummaryCategoriesStatusBar:GetFrameLevel()-1)
		S.CreateBD(bg, .25)

		for i = 1, 3 do
			local tab = _G["AchievementFrameTab"..i]
			if tab then
				S.CreateTab(tab)
			end
		end

		for i = 1, 7 do
			local bu = _G["AchievementFrameAchievementsContainerButton"..i]
			bu:DisableDrawLayer("BORDER")

			bu.background:SetTexture(media.backdrop)
			bu.background:SetVertexColor(0, 0, 0, .25)

			bu.description:SetTextColor(.9, .9, .9)
			bu.description.SetTextColor = function() end
			bu.description:SetShadowOffset(1, -1)
			bu.description.SetShadowOffset = function() end

			_G["AchievementFrameAchievementsContainerButton"..i.."TitleBackground"]:Hide()
			_G["AchievementFrameAchievementsContainerButton"..i.."Glow"]:Hide()
			_G["AchievementFrameAchievementsContainerButton"..i.."RewardBackground"]:SetAlpha(0)
			_G["AchievementFrameAchievementsContainerButton"..i.."PlusMinus"]:SetAlpha(0)
			_G["AchievementFrameAchievementsContainerButton"..i.."Highlight"]:SetAlpha(0)
			_G["AchievementFrameAchievementsContainerButton"..i.."IconOverlay"]:Hide()
			_G["AchievementFrameAchievementsContainerButton"..i.."GuildCornerL"]:SetAlpha(0)
			_G["AchievementFrameAchievementsContainerButton"..i.."GuildCornerR"]:SetAlpha(0)

			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", 2, -2)
			bg:Point("BOTTOMRIGHT", -2, 2)
			S.CreateBD(bg, 0)

			bu.icon.texture:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(bu.icon.texture)

			-- can't get a backdrop frame to appear behind the checked texture for some reason
			
			local ch = bu.tracked
			ch:SetNormalTexture("")
			ch:SetPushedTexture("")
			ch:SetHighlightTexture(media.backdrop)
				
			local hl = ch:GetHighlightTexture()
			hl:Point("TOPLEFT", 4, -4)
			hl:Point("BOTTOMRIGHT", -4, 4)
			hl:SetVertexColor(r, g, b, .2)

			local check = ch:GetCheckedTexture()
			check:SetDesaturated(true)
			check:SetVertexColor(r, g, b)

			local tex = ch:CreateTexture(nil, "BACKGROUND")
			tex:Point("TOPLEFT", 4, -4)
			tex:Point("BOTTOMRIGHT", -4, 4)
			tex:SetTexture(media.backdrop)
			tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

			local left = ch:CreateTexture(nil, "BACKGROUND")
			left:Width(1)
			left:SetTexture(0, 0, 0)
			left:Point("TOPLEFT", tex, -1, 1)
			left:Point("BOTTOMLEFT", tex, -1, -1)

			local right = ch:CreateTexture(nil, "BACKGROUND")
			right:Width(1)
			right:SetTexture(0, 0, 0)
			right:Point("TOPRIGHT", tex, 1, 1)
			right:Point("BOTTOMRIGHT", tex, 1, -1)

			local top = ch:CreateTexture(nil, "BACKGROUND")
			top:Height(1)
			top:SetTexture(0, 0, 0)
			top:Point("TOPLEFT", tex, -1, 1)
			top:Point("TOPRIGHT", tex, 1, -1)

			local bottom = ch:CreateTexture(nil, "BACKGROUND")
			bottom:Height(1)
			bottom:SetTexture(0, 0, 0)
			bottom:Point("BOTTOMLEFT", tex, -1, -1)
			bottom:Point("BOTTOMRIGHT", tex, 1, -1)
		end

		hooksecurefunc("AchievementButton_DisplayAchievement", function(button, category, achievement)
			local _, _, _, completed = GetAchievementInfo(category, achievement)
			if completed then
				if button.accountWide then
					button.label:SetTextColor(0, .6, 1)
				else
					button.label:SetTextColor(.9, .9, .9)
				end
			else
				if button.accountWide then
					button.label:SetTextColor(0, .3, .5)
				else
					button.label:SetTextColor(.65, .65, .65)
				end
			end
		end)

		hooksecurefunc("AchievementObjectives_DisplayCriteria", function(objectivesFrame, id)
			for i = 1, GetAchievementNumCriteria(id) do
				local name = _G["AchievementFrameCriteria"..i.."Name"]
				if name and select(2, name:GetTextColor()) == 0 then
					name:SetTextColor(1, 1, 1)
				end

				local bu = _G["AchievementFrameMeta"..i]
				if bu and select(2, bu.label:GetTextColor()) == 0 then
					bu.label:SetTextColor(1, 1, 1)
				end
			end
		end)

		hooksecurefunc("AchievementButton_GetProgressBar", function(index)
			local bar = _G["AchievementFrameProgressBar"..index]
			if not bar.reskinned then
				bar:SetStatusBarTexture(DB.Statusbar)

				_G["AchievementFrameProgressBar"..index.."BG"]:SetTexture(0, 0, 0, .25)
				_G["AchievementFrameProgressBar"..index.."BorderLeft"]:Hide()
				_G["AchievementFrameProgressBar"..index.."BorderCenter"]:Hide()
				_G["AchievementFrameProgressBar"..index.."BorderRight"]:Hide()

				local bg = CreateFrame("Frame", nil, bar)
				bg:Point("TOPLEFT", -1, 1)
				bg:Point("BOTTOMRIGHT", 1, -1)
				S.CreateBD(bg, 0)

				bar.reskinned = true
			end
		end)

		hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
			for i = 1, ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
				local bu = _G["AchievementFrameSummaryAchievement"..i]
				if not bu.reskinned then
					bu:DisableDrawLayer("BORDER")

					local bd = _G["AchievementFrameSummaryAchievement"..i.."Background"]

					bd:SetTexture(media.backdrop)
					bd:SetVertexColor(0, 0, 0, .25)

					_G["AchievementFrameSummaryAchievement"..i.."TitleBackground"]:Hide()
					_G["AchievementFrameSummaryAchievement"..i.."Glow"]:Hide()
					_G["AchievementFrameSummaryAchievement"..i.."Highlight"]:SetAlpha(0)
					_G["AchievementFrameSummaryAchievement"..i.."IconOverlay"]:Hide()

					local text = _G["AchievementFrameSummaryAchievement"..i.."Description"]
					text:SetTextColor(.9, .9, .9)
					text.SetTextColor = function() end
					text:SetShadowOffset(1, -1)
					text.SetShadowOffset = function() end

					local bg = CreateFrame("Frame", nil, bu)
					bg:Point("TOPLEFT", 2, -2)
					bg:Point("BOTTOMRIGHT", -2, 2)
					S.CreateBD(bg, 0)

					local ic = _G["AchievementFrameSummaryAchievement"..i.."IconTexture"]
					ic:SetTexCoord(.08, .92, .08, .92)
					S.CreateBG(ic)

					bu.reskinned = true
				end
			end
		end)

		for i = 1, 10 do
			local bu = _G["AchievementFrameSummaryCategoriesCategory"..i]
			local bar = bu:GetStatusBarTexture()
			local label = _G["AchievementFrameSummaryCategoriesCategory"..i.."Label"]

			bu:SetStatusBarTexture(DB.Statusbar)
			bar:SetGradient("VERTICAL", 0, .4, 0, 0, .6, 0)
			label:SetTextColor(1, 1, 1)
			label:Point("LEFT", bu, "LEFT", 6, 0)

			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, .25)

			_G["AchievementFrameSummaryCategoriesCategory"..i.."Left"]:Hide()
			_G["AchievementFrameSummaryCategoriesCategory"..i.."Middle"]:Hide()
			_G["AchievementFrameSummaryCategoriesCategory"..i.."Right"]:Hide()
			_G["AchievementFrameSummaryCategoriesCategory"..i.."FillBar"]:Hide()
			_G["AchievementFrameSummaryCategoriesCategory"..i.."ButtonHighlight"]:SetAlpha(0)
			_G["AchievementFrameSummaryCategoriesCategory"..i.."Text"]:Point("RIGHT", bu, "RIGHT", -5, 0)
		end

		for i = 1, 20 do
			_G["AchievementFrameStatsContainerButton"..i.."BG"]:Hide()
			_G["AchievementFrameStatsContainerButton"..i.."BG"].Show = function() end
			_G["AchievementFrameStatsContainerButton"..i.."HeaderLeft"]:SetAlpha(0)
			_G["AchievementFrameStatsContainerButton"..i.."HeaderMiddle"]:SetAlpha(0)
			_G["AchievementFrameStatsContainerButton"..i.."HeaderRight"]:SetAlpha(0)
		end

		AchievementFrameComparisonHeader:Point("BOTTOMRIGHT", AchievementFrameComparison, "TOPRIGHT", 39, 25)

		local headerbg = CreateFrame("Frame", nil, AchievementFrameComparisonHeader)
		headerbg:Point("TOPLEFT", 20, -20)
		headerbg:Point("BOTTOMRIGHT", -28, -5)
		headerbg:SetFrameLevel(AchievementFrameComparisonHeader:GetFrameLevel()-1)
		S.CreateBD(headerbg, .25)

		local summaries = {AchievementFrameComparisonSummaryPlayer, AchievementFrameComparisonSummaryFriend}

		for _, frame in pairs(summaries) do
			frame:SetBackdrop(nil)
			local bg = CreateFrame("Frame", nil, frame)
			bg:Point("TOPLEFT", 2, -2)
			bg:Point("BOTTOMRIGHT", -2, 0)
			bg:SetFrameLevel(frame:GetFrameLevel()-1)
			S.CreateBD(bg, .25)
		end

		local bars = {AchievementFrameComparisonSummaryPlayerStatusBar, AchievementFrameComparisonSummaryFriendStatusBar}

		for _, bar in pairs(bars) do
			local name = bar:GetName()
			bar:SetStatusBarTexture(DB.Statusbar)
			bar:GetStatusBarTexture():SetGradient("VERTICAL", 0, .4, 0, 0, .6, 0)
			_G[name.."Left"]:Hide()
			_G[name.."Middle"]:Hide()
			_G[name.."Right"]:Hide()
			_G[name.."FillBar"]:Hide()
			_G[name.."Title"]:SetTextColor(1, 1, 1)
			_G[name.."Title"]:Point("LEFT", bar, "LEFT", 6, 0)
			_G[name.."Text"]:Point("RIGHT", bar, "RIGHT", -5, 0)

			local bg = CreateFrame("Frame", nil, bar)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(bar:GetFrameLevel()-1)
			S.CreateBD(bg, .25)
		end

		for i = 1, 9 do
			local buttons = {_G["AchievementFrameComparisonContainerButton"..i.."Player"], _G["AchievementFrameComparisonContainerButton"..i.."Friend"]}

			for _, button in pairs(buttons) do
				button:DisableDrawLayer("BORDER")
				local bg = CreateFrame("Frame", nil, button)
				bg:Point("TOPLEFT", 2, -3)
				bg:Point("BOTTOMRIGHT", -2, 2)
				S.CreateBD(bg, 0)
			end

			local bd = _G["AchievementFrameComparisonContainerButton"..i.."PlayerBackground"]
			bd:SetTexture(media.backdrop)
			bd:SetVertexColor(0, 0, 0, .25)

			local bd = _G["AchievementFrameComparisonContainerButton"..i.."FriendBackground"]
			bd:SetTexture(media.backdrop)
			bd:SetVertexColor(0, 0, 0, .25)

			local text = _G["AchievementFrameComparisonContainerButton"..i.."PlayerDescription"]
			text:SetTextColor(.9, .9, .9)
			text.SetTextColor = function() end
			text:SetShadowOffset(1, -1)
			text.SetShadowOffset = function() end

			_G["AchievementFrameComparisonContainerButton"..i.."PlayerTitleBackground"]:Hide()
			_G["AchievementFrameComparisonContainerButton"..i.."PlayerGlow"]:Hide()
			_G["AchievementFrameComparisonContainerButton"..i.."PlayerIconOverlay"]:Hide()
			_G["AchievementFrameComparisonContainerButton"..i.."FriendTitleBackground"]:Hide()
			_G["AchievementFrameComparisonContainerButton"..i.."FriendGlow"]:Hide()
			_G["AchievementFrameComparisonContainerButton"..i.."FriendIconOverlay"]:Hide()

			local ic = _G["AchievementFrameComparisonContainerButton"..i.."PlayerIconTexture"]
			ic:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(ic)

			local ic = _G["AchievementFrameComparisonContainerButton"..i.."FriendIconTexture"]
			ic:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(ic)
		end

		S.ReskinClose(AchievementFrameCloseButton)
		S.ReskinScroll(AchievementFrameAchievementsContainerScrollBar)
		S.ReskinScroll(AchievementFrameStatsContainerScrollBar)
		S.ReskinScroll(AchievementFrameCategoriesContainerScrollBar)
		S.ReskinScroll(AchievementFrameComparisonContainerScrollBar)
		S.ReskinDropDown(AchievementFrameFilterDropDown)
	elseif addon == "Blizzard_BarbershopUI" then
		S.SetBD(BarberShopFrame, 44, -75, -40, 44)
		BarberShopFrameBackground:Hide()
		BarberShopFrameMoneyFrame:GetRegions():Hide()
		S.Reskin(BarberShopFrameOkayButton)
		S.Reskin(BarberShopFrameCancelButton)
		S.Reskin(BarberShopFrameResetButton)
		S.ReskinArrow(BarberShopFrameSelector1Prev, "left")
		S.ReskinArrow(BarberShopFrameSelector1Next, "right")
		S.ReskinArrow(BarberShopFrameSelector2Prev, "left")
		S.ReskinArrow(BarberShopFrameSelector2Next, "right")
		S.ReskinArrow(BarberShopFrameSelector3Prev, "left")
		S.ReskinArrow(BarberShopFrameSelector3Next, "right")
	elseif addon == "Blizzard_BattlefieldMinimap" then
		S.SetBD(BattlefieldMinimap, -1, 1, -5, 3)
		BattlefieldMinimapCorner:Hide()
		BattlefieldMinimapBackground:Hide()
		BattlefieldMinimapCloseButton:Hide()
	elseif addon == "Blizzard_BindingUI" then
		S.SetBD(KeyBindingFrame, 2, 0, -38, 10)
		KeyBindingFrame:DisableDrawLayer("BACKGROUND")
		KeyBindingFrameOutputText:SetDrawLayer("OVERLAY")
		KeyBindingFrameHeader:SetTexture("")
		S.Reskin(KeyBindingFrameDefaultButton)
		S.Reskin(KeyBindingFrameUnbindButton)
		S.Reskin(KeyBindingFrameOkayButton)
		S.Reskin(KeyBindingFrameCancelButton)
		KeyBindingFrameOkayButton:ClearAllPoints()
		KeyBindingFrameOkayButton:SetPoint("RIGHT", KeyBindingFrameCancelButton, "LEFT", -1, 0)
		KeyBindingFrameUnbindButton:ClearAllPoints()
		KeyBindingFrameUnbindButton:SetPoint("RIGHT", KeyBindingFrameOkayButton, "LEFT", -1, 0)

		for i = 1, KEY_BINDINGS_DISPLAYED do
			local button1 = _G["KeyBindingFrameBinding"..i.."Key1Button"]
			local button2 = _G["KeyBindingFrameBinding"..i.."Key2Button"]

			button2:SetPoint("LEFT", button1, "RIGHT", 1, 0)
			S.Reskin(button1)
			S.Reskin(button2)
		end

		S.ReskinScroll(KeyBindingFrameScrollFrameScrollBar)
		S.ReskinCheck(KeyBindingFrameCharacterButton)
	elseif addon == "Blizzard_BlackMarketUI" then
		BlackMarketFrame:DisableDrawLayer("BACKGROUND")
		BlackMarketFrame:DisableDrawLayer("BORDER")
		BlackMarketFrame:DisableDrawLayer("OVERLAY")
		BlackMarketFrame.Inset:DisableDrawLayer("BORDER")
		select(9, BlackMarketFrame.Inset:GetRegions()):Hide()
		BlackMarketFrame.MoneyFrameBorder:Hide()
		BlackMarketFrame.HotDeal.Left:Hide()
		BlackMarketFrame.HotDeal.Right:Hide()
		select(4, BlackMarketFrame.HotDeal:GetRegions()):Hide()

		S.CreateBG(BlackMarketFrame.HotDeal.Item)
		BlackMarketFrame.HotDeal.Item.IconTexture:SetTexCoord(.08, .92, .08, .92)

		local headers = {"ColumnName", "ColumnLevel", "ColumnType", "ColumnDuration", "ColumnHighBidder", "ColumnCurrentBid"}
		for _, header in pairs(headers) do
			local header = BlackMarketFrame[header]
			header.Left:Hide()
			header.Middle:Hide()
			header.Right:Hide()

			local bg = CreateFrame("Frame", nil, header)
			bg:Point("TOPLEFT", 2, 0)
			bg:Point("BOTTOMRIGHT", -1, 0)
			bg:SetFrameLevel(header:GetFrameLevel()-1)
			S.CreateBD(bg, .25)
		end

		S.SetBD(BlackMarketFrame)
		S.CreateBD(BlackMarketFrame.HotDeal, .25)
		S.Reskin(BlackMarketFrame.BidButton)
		S.Reskin(BlackMarketFrame.HotDeal.BidButton)
		S.ReskinClose(BlackMarketFrame.CloseButton)
		S.ReskinInput(BlackMarketBidPriceGold)
		S.ReskinInput(BlackMarketHotItemBidPriceGold)
		S.ReskinScroll(BlackMarketScrollFrameScrollBar)

		hooksecurefunc("BlackMarketScrollFrame_Update", function()
			local buttons = BlackMarketScrollFrame.buttons
			for i = 1, #buttons do
				local bu = buttons[i]

				bu.Item.IconTexture:SetTexCoord(.08, .92, .08, .92)
				if not bu.reskinned then
					bu.Left:Hide()
					bu.Right:Hide()
					select(3, bu:GetRegions()):Hide()

					bu.Item:SetNormalTexture("")
					bu.Item:SetPushedTexture("")
					S.CreateBG(bu.Item)

					local bg = CreateFrame("Frame", nil, bu)
					bg:SetPoint("TOPLEFT")
					bg:Point("BOTTOMRIGHT", 0, 5)
					bg:SetFrameLevel(bu:GetFrameLevel()-1)
					S.CreateBD(bg, 0)

					local tex = bu:CreateTexture(nil, "BACKGROUND")
					tex:SetPoint("TOPLEFT")
					tex:Point("BOTTOMRIGHT", 0, 5)
					tex:SetTexture(0, 0, 0, .25)

					bu:SetHighlightTexture(media.backdrop)
					local hl = bu:GetHighlightTexture()
					hl:SetVertexColor(r, g, b, .2)
					hl.SetAlpha = function() end
					hl:ClearAllPoints()
					hl:SetPoint("TOPLEFT", 0, -1)
					hl:SetPoint("BOTTOMRIGHT", -1, 6)

					bu.reskinned = true
				end
				if bu:IsShown() and bu.itemLink then
					local _, _, quality = GetItemInfo(bu.itemLink)
					bu.Name:SetTextColor(GetItemQualityColor(quality))
				end
			end
		end)

		hooksecurefunc("BlackMarketFrame_UpdateHotItem", function(self)
			local hotDeal = self.HotDeal
			if hotDeal:IsShown() and hotDeal.itemLink then
				local _, _, quality = GetItemInfo(hotDeal.itemLink)
				hotDeal.Name:SetTextColor(GetItemQualityColor(quality))
			end
		end)
	elseif addon == "Blizzard_Calendar" then
		CalendarFrame:DisableDrawLayer("BORDER")

		for i = 1, 9 do
			select(i, CalendarViewEventFrame:GetRegions()):Hide()
		end
		select(15, CalendarViewEventFrame:GetRegions()):Hide()

		for i = 1, 9 do
			select(i, CalendarViewHolidayFrame:GetRegions()):Hide()
			select(i, CalendarViewRaidFrame:GetRegions()):Hide()
		end

		for i = 1, 3 do
			select(i, CalendarCreateEventTitleFrame:GetRegions()):Hide()
			select(i, CalendarViewEventTitleFrame:GetRegions()):Hide()
			select(i, CalendarViewHolidayTitleFrame:GetRegions()):Hide()
			select(i, CalendarViewRaidTitleFrame:GetRegions()):Hide()
			select(i, CalendarMassInviteTitleFrame:GetRegions()):Hide()
		end

		for i = 1, 42 do
			_G["CalendarDayButton"..i.."DarkFrame"]:SetAlpha(.5)
			local bu = _G["CalendarDayButton"..i]
			bu:DisableDrawLayer("BACKGROUND")
			bu:SetHighlightTexture(media.backdrop)
			local hl = bu:GetHighlightTexture()
			hl:SetVertexColor(r, g, b, .2)
			hl.SetAlpha = function() end
			hl:SetPoint("TOPLEFT", -1, 1)
			hl:SetPoint("BOTTOMRIGHT")
		end

		for i = 1, 7 do
			_G["CalendarWeekday"..i.."Background"]:SetAlpha(0)
		end

		CalendarViewEventDivider:Hide()
		CalendarCreateEventDivider:Hide()
		CalendarViewEventInviteList:GetRegions():Hide()
		CalendarViewEventDescriptionContainer:GetRegions():Hide()
		select(5, CalendarCreateEventCloseButton:GetRegions()):Hide()
		select(5, CalendarViewEventCloseButton:GetRegions()):Hide()
		select(5, CalendarViewHolidayCloseButton:GetRegions()):Hide()
		select(5, CalendarViewRaidCloseButton:GetRegions()):Hide()
		select(5, CalendarMassInviteCloseButton:GetRegions()):Hide()
		CalendarCreateEventBackground:Hide()
		CalendarCreateEventFrameButtonBackground:Hide()
		CalendarCreateEventMassInviteButtonBorder:Hide()
		CalendarCreateEventCreateButtonBorder:Hide()
		CalendarEventPickerTitleFrameBackgroundLeft:Hide()
		CalendarEventPickerTitleFrameBackgroundMiddle:Hide()
		CalendarEventPickerTitleFrameBackgroundRight:Hide()
		CalendarEventPickerFrameButtonBackground:Hide()
		CalendarEventPickerCloseButtonBorder:Hide()
		CalendarCreateEventRaidInviteButtonBorder:Hide()
		CalendarMonthBackground:SetAlpha(0)
		CalendarYearBackground:SetAlpha(0)
		CalendarFrameModalOverlay:SetAlpha(.25)
		CalendarViewHolidayInfoTexture:SetAlpha(0)
		CalendarTexturePickerTitleFrameBackgroundLeft:Hide()
		CalendarTexturePickerTitleFrameBackgroundMiddle:Hide()
		CalendarTexturePickerTitleFrameBackgroundRight:Hide()
		CalendarTexturePickerFrameButtonBackground:Hide()
		CalendarTexturePickerAcceptButtonBorder:Hide()
		CalendarTexturePickerCancelButtonBorder:Hide()
		CalendarClassTotalsButtonBackgroundTop:Hide()
		CalendarClassTotalsButtonBackgroundMiddle:Hide()
		CalendarClassTotalsButtonBackgroundBottom:Hide()
		CalendarFilterFrameLeft:Hide()
		CalendarFilterFrameMiddle:Hide()
		CalendarFilterFrameRight:Hide()
			CalendarMassInviteFrameDivider:Hide()

		S.SetBD(CalendarFrame, 12, 0, -9, 4)
		S.CreateBD(CalendarViewEventFrame)
		S.CreateBD(CalendarViewHolidayFrame)
		S.CreateBD(CalendarViewRaidFrame)
		S.CreateBD(CalendarCreateEventFrame)
		S.CreateBD(CalendarClassTotalsButton)
		S.CreateBD(CalendarTexturePickerFrame)
		S.CreateBD(CalendarViewEventInviteList, .25)
		S.CreateBD(CalendarViewEventDescriptionContainer, .25)
		S.CreateBD(CalendarCreateEventInviteList, .25)
		S.CreateBD(CalendarCreateEventDescriptionContainer, .25)
		S.CreateBD(CalendarEventPickerFrame, .25)
		S.CreateBD(CalendarMassInviteFrame)

		CalendarWeekdaySelectedTexture:SetVertexColor(r, g, b)

		hooksecurefunc("CalendarFrame_SetToday", function()
			CalendarTodayFrame:SetAllPoints()
		end)

		CalendarTodayFrame:SetScript("OnUpdate", nil)
		CalendarTodayTextureGlow:Hide()
		CalendarTodayTexture:Hide()

		CalendarTodayFrame:SetBackdrop({
			edgeFile = media.backdrop,
			edgeSize = 1,
		})
		CalendarTodayFrame:SetBackdropBorderColor(r, g, b)

		for i, class in ipairs(CLASS_SORT_ORDER) do
			local bu = _G["CalendarClassButton"..i]
			bu:GetRegions():Hide()
			S.CreateBG(bu)

			local tcoords = CLASS_ICON_TCOORDS[class]
			local ic = bu:GetNormalTexture()
			ic:SetTexCoord(tcoords[1] + 0.015, tcoords[2] - 0.02, tcoords[3] + 0.018, tcoords[4] - 0.02)
		end

		local bd = CreateFrame("Frame", nil, CalendarFilterFrame)
		bd:Point("TOPLEFT", 40, 0)
		bd:Point("BOTTOMRIGHT", -19, 0)
		bd:SetFrameLevel(CalendarFilterFrame:GetFrameLevel()-1)
		S.CreateBD(bd, 0)

		S.CreateGradient(bd)

		local downtex = CalendarFilterButton:CreateTexture(nil, "ARTWORK")
		downtex:SetTexture(media.arrowDown)
		downtex:Size(8, 8)
		downtex:SetPoint("CENTER")
		downtex:SetVertexColor(1, 1, 1)

		for i = 1, 6 do
			local vline = CreateFrame("Frame", nil, _G["CalendarDayButton"..i])
			vline:Height(546)
			vline:Width(1)
			vline:SetPoint("TOP", _G["CalendarDayButton"..i], "TOPRIGHT")
			S.CreateBD(vline)
		end
		for i = 1, 36, 7 do
			local hline = CreateFrame("Frame", nil, _G["CalendarDayButton"..i])
			hline:Width(637)
			hline:Height(1)
			hline:SetPoint("LEFT", _G["CalendarDayButton"..i], "TOPLEFT")
			S.CreateBD(hline)
		end

		if not(IsAddOnLoaded("CowTip") or IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("lolTip") or IsAddOnLoaded("StarTip") or IsAddOnLoaded("TipTop")) then
			local tooltips = {CalendarContextMenu, CalendarInviteStatusContextMenu}

			for _, tooltip in pairs(tooltips) do
				tooltip:SetBackdrop(nil)
				local bg = CreateFrame("Frame", nil, tooltip)
				bg:Point("TOPLEFT", 2, -2)
				bg:Point("BOTTOMRIGHT", -1, 2)
				bg:SetFrameLevel(tooltip:GetFrameLevel()-1)
				S.CreateBD(bg)
			end
		end

		CalendarViewEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", -8, -24)
		CalendarViewHolidayFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", -8, -24)
		CalendarViewRaidFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", -8, -24)
		CalendarCreateEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", -8, -24)
		CalendarCreateEventInviteButton:Point("TOPLEFT", CalendarCreateEventInviteEdit, "TOPRIGHT", 1, 1)
		CalendarClassButton1:Point("TOPLEFT", CalendarClassButtonContainer, "TOPLEFT", 5, 0)

		CalendarCreateEventHourDropDown:SetWidth(80)
		CalendarCreateEventMinuteDropDown:SetWidth(80)
		CalendarCreateEventAMPMDropDown:SetWidth(90)

		local line = CalendarMassInviteFrame:CreateTexture(nil, "BACKGROUND")
		line:Size(240, 1)
		line:Point("TOP", CalendarMassInviteFrame, "TOP", 0, -150)
		line:SetTexture(media.backdrop)
		line:SetVertexColor(0, 0, 0)

		CalendarMassInviteFrame:ClearAllPoints()
		CalendarMassInviteFrame:Point("BOTTOMLEFT", CalendarCreateEventCreateButton, "TOPRIGHT", 10, 0)

		CalendarTexturePickerFrame:ClearAllPoints()
		CalendarTexturePickerFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 311, -24)

		local cbuttons = {"CalendarViewEventAcceptButton", "CalendarViewEventTentativeButton", "CalendarViewEventDeclineButton", "CalendarViewEventRemoveButton", "CalendarCreateEventMassInviteButton", "CalendarCreateEventCreateButton", "CalendarCreateEventInviteButton", "CalendarEventPickerCloseButton", "CalendarCreateEventRaidInviteButton", "CalendarTexturePickerAcceptButton", "CalendarTexturePickerCancelButton", "CalendarFilterButton", "CalendarMassInviteGuildAcceptButton", "CalendarMassInviteArenaButton2", "CalendarMassInviteArenaButton3", "CalendarMassInviteArenaButton5"}
		for i = 1, #cbuttons do
			local cbutton = _G[cbuttons[i]]
			S.Reskin(cbutton)
		end

		S.ReskinClose(CalendarCloseButton, "TOPRIGHT", CalendarFrame, "TOPRIGHT", -14, -4)
		S.ReskinClose(CalendarCreateEventCloseButton)
		S.ReskinClose(CalendarViewEventCloseButton)
		S.ReskinClose(CalendarViewHolidayCloseButton)
		S.ReskinClose(CalendarViewRaidCloseButton)
		S.ReskinClose(CalendarMassInviteCloseButton)
		S.ReskinScroll(CalendarTexturePickerScrollBar)
		S.ReskinScroll(CalendarViewEventInviteListScrollFrameScrollBar)
		S.ReskinScroll(CalendarViewEventDescriptionScrollFrameScrollBar)
		S.ReskinScroll(CalendarCreateEventInviteListScrollFrameScrollBar)
		S.ReskinScroll(CalendarCreateEventDescriptionScrollFrameScrollBar)
		S.ReskinDropDown(CalendarCreateEventTypeDropDown)
		S.ReskinDropDown(CalendarCreateEventHourDropDown)
		S.ReskinDropDown(CalendarCreateEventMinuteDropDown)
		S.ReskinDropDown(CalendarCreateEventAMPMDropDown)
		S.ReskinDropDown(CalendarMassInviteGuildRankMenu)
		S.ReskinInput(CalendarCreateEventTitleEdit)
		S.ReskinInput(CalendarCreateEventInviteEdit)
		S.ReskinInput(CalendarMassInviteGuildMinLevelEdit)
		S.ReskinInput(CalendarMassInviteGuildMaxLevelEdit)
		S.ReskinArrow(CalendarPrevMonthButton, "left")
		S.ReskinArrow(CalendarNextMonthButton, "right")
		CalendarPrevMonthButton:SetSize(19, 19)
		CalendarNextMonthButton:SetSize(19, 19)
		S.ReskinCheck(CalendarCreateEventLockEventCheck)
	elseif addon == "Blizzard_ChallengesUI" then
		ChallengesFrameInset:DisableDrawLayer("BORDER")
		ChallengesFrameInsetBg:Hide()
		ChallengesFrameDetails.bg:Hide()
		select(2, ChallengesFrameDetails:GetRegions()):Hide()
		select(9, ChallengesFrameDetails:GetRegions()):Hide()
		select(10, ChallengesFrameDetails:GetRegions()):Hide()
		select(11, ChallengesFrameDetails:GetRegions()):Hide()
		ChallengesFrameLeaderboard:GetRegions():Hide()

		S.Reskin(ChallengesFrameLeaderboard)

		local bg = CreateFrame("Frame", nil, ChallengesFrameDetails)
		bg:Point("TOPLEFT", 1, -73)
		bg:Size(332, 49)
		bg:SetFrameLevel(ChallengesFrameDetails:GetFrameLevel())
		S.CreateBD(bg, .25)

		ChallengesFrameDungeonButton1:SetPoint("TOPLEFT", ChallengesFrame, "TOPLEFT", 8, -83)

		for i = 1, 9 do
			local bu = ChallengesFrame["button"..i]
			S.CreateBD(bu, .25)
			bu:SetHighlightTexture("")
			bu.selectedTex:SetTexture(media.backdrop)
			bu.selectedTex:SetAlpha(.2)
			bu.selectedTex:Point("TOPLEFT", 1, -1)
			bu.selectedTex:Point("BOTTOMRIGHT", -1, 1)
		end

		for i = 1, 3 do
			local rewardsRow = ChallengesFrame["RewardRow"..i]
			for j = 1, 2 do
				local bu = rewardsRow["Reward"..j]

				bu.Icon:SetTexCoord(.08, .92, .08, .92)
				S.CreateBG(bu.Icon)
			end
		end
	elseif addon == "Blizzard_DebugTools" then
		ScriptErrorsFrame:SetScale(UIParent:GetScale())
		ScriptErrorsFrame:SetSize(386, 274)
		ScriptErrorsFrame:DisableDrawLayer("OVERLAY")
		ScriptErrorsFrameTitleBG:Hide()
		ScriptErrorsFrameDialogBG:Hide()
		S.CreateBD(ScriptErrorsFrame)
		S.CreateSD(ScriptErrorsFrame)

		FrameStackTooltip:SetScale(UIParent:GetScale())
		FrameStackTooltip:SetBackdrop(nil)

		local bg = CreateFrame("Frame", nil, FrameStackTooltip)
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
		bg:SetFrameLevel(FrameStackTooltip:GetFrameLevel()-1)
		S.CreateBD(bg, .6)

		S.ReskinClose(ScriptErrorsFrameClose)
		S.ReskinScroll(ScriptErrorsFrameScrollFrameScrollBar)
		S.Reskin(select(4, ScriptErrorsFrame:GetChildren()))
		S.Reskin(select(5, ScriptErrorsFrame:GetChildren()))
		S.Reskin(select(6, ScriptErrorsFrame:GetChildren()))
	elseif addon == "Blizzard_EncounterJournal" then
		EncounterJournalEncounterFrameInfo:DisableDrawLayer("BACKGROUND")
		EncounterJournal:DisableDrawLayer("BORDER")
		EncounterJournalInset:DisableDrawLayer("BORDER")
		EncounterJournalNavBar:DisableDrawLayer("BORDER")
		EncounterJournalSearchResults:DisableDrawLayer("BORDER")
		EncounterJournal:DisableDrawLayer("OVERLAY")
		EncounterJournalInstanceSelectDungeonTab:DisableDrawLayer("OVERLAY")
		EncounterJournalInstanceSelectRaidTab:DisableDrawLayer("OVERLAY")

		EncounterJournalPortrait:Hide()
		EncounterJournalInstanceSelectBG:Hide()
		EncounterJournalNavBar:GetRegions():Hide()
		EncounterJournalNavBarOverlay:Hide()
		EncounterJournalBg:Hide()
		EncounterJournalTitleBg:Hide()
		EncounterJournalInsetBg:Hide()
		EncounterJournalInstanceSelectDungeonTabMid:Hide()
		EncounterJournalInstanceSelectDungeonTabLeft:Hide()
		EncounterJournalInstanceSelectDungeonTabRight:Hide()
		EncounterJournalInstanceSelectRaidTabMid:Hide()
		EncounterJournalInstanceSelectRaidTabLeft:Hide()
		EncounterJournalInstanceSelectRaidTabRight:Hide()
		EncounterJournalNavBarHomeButtonLeft:Hide()
		for i = 8, 10 do
			select(i, EncounterJournalInstanceSelectDungeonTab:GetRegions()):SetAlpha(0)
			select(i, EncounterJournalInstanceSelectRaidTab:GetRegions()):SetAlpha(0)
		end
		EncounterJournalEncounterFrameModelFrameShadow:Hide()
		EncounterJournalEncounterFrameInfoDifficultyUpLeft:SetAlpha(0)
		EncounterJournalEncounterFrameInfoDifficultyUpRIGHT:SetAlpha(0)
		EncounterJournalEncounterFrameInfoDifficultyDownLeft:SetAlpha(0)
		EncounterJournalEncounterFrameInfoDifficultyDownRIGHT:SetAlpha(0)
		select(5, EncounterJournalEncounterFrameInfoDifficulty:GetRegions()):Hide()
		select(6, EncounterJournalEncounterFrameInfoDifficulty:GetRegions()):Hide()
		EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggleUpLeft:SetAlpha(0)
		EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggleUpRIGHT:SetAlpha(0)
		EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggleDownLeft:SetAlpha(0)
		EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggleDownRIGHT:SetAlpha(0)
		select(5, EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle:GetRegions()):Hide()
		select(6, EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle:GetRegions()):Hide()
		EncounterJournalSearchResultsBg:Hide()

		S.SetBD(EncounterJournal)
		S.CreateBD(EncounterJournalSearchResults, .75)

		EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoBossTab:SetPoint("TOPRIGHT", EncounterJournalEncounterFrame, "TOPRIGHT", 75, 20)
		EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoLootTab:SetPoint("TOP", EncounterJournalEncounterFrameInfoBossTab, "BOTTOM", 0, -4)

		local tabs = {EncounterJournalEncounterFrameInfoBossTab, EncounterJournalEncounterFrameInfoLootTab}
		for _, tab in pairs(tabs) do
			tab:SetScale(.75)

			tab:SetBackdrop({
				bgFile = media.backdrop,
				edgeFile = media.backdrop,
				edgeSize = 1 / .75,
			})

			tab:SetBackdropColor(0, 0, 0, .5)
			tab:SetBackdropBorderColor(0, 0, 0)

			tab:SetNormalTexture("")
			tab:SetPushedTexture("")
			tab:SetDisabledTexture("")
			tab:SetHighlightTexture("")
		end

		EncounterJournalInstanceSelectScrollFrameScrollChildInstanceButton1:SetNormalTexture("")
		EncounterJournalInstanceSelectScrollFrameScrollChildInstanceButton1:SetHighlightTexture("")

		local bg = CreateFrame("Frame", nil, EncounterJournalInstanceSelectScrollFrameScrollChildInstanceButton1)
		bg:Point("TOPLEFT", 4, -4)
		bg:Point("BOTTOMRIGHT", -5, 3)
		S.CreateBD(bg, 0)

		local index = 2

		local function listInstances()
			while true do
				local bu = EncounterJournal.instanceSelect.scroll.child["instance"..index]
				if not bu then return end

				bu:SetNormalTexture("")
				bu:SetHighlightTexture("")

				local bg = CreateFrame("Frame", nil, bu)
				bg:SetPoint("TOPLEFT", 4, -4)
				bg:SetPoint("BOTTOMRIGHT", -5, 3)
				S.CreateBD(bg, 0)

				index = index + 1
			end
		end

		hooksecurefunc("EncounterJournal_ListInstances", listInstances)
		listInstances()

		EncounterJournalEncounterFrameInstanceFrameLoreScrollFrameScrollChildLore:SetTextColor(1, 1, 1)
		EncounterJournalEncounterFrameInstanceFrameLoreScrollFrameScrollChildLore:SetShadowOffset(1, -1)
		EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription:SetTextColor(1, 1, 1)
		EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription:SetShadowOffset(1, -1)
		EncounterJournalEncounterFrameInfoEncounterTitle:SetTextColor(1, 1, 1)

		S.CreateBDFrame(EncounterJournalEncounterFrameModelFrame, .25)


		hooksecurefunc("EncounterJournal_DisplayInstance", function()
			local bossIndex = 1;
			local name, description, bossID, _, link = EJ_GetEncounterInfoByIndex(bossIndex)
			while bossID do
				local bossButton = _G["EncounterJournalBossButton"..bossIndex]

				if not bossButton.reskinned then
					bossButton.reskinned = true

					S.Reskin(bossButton, true)
					bossButton.text:SetTextColor(1, 1, 1)
					bossButton.text.SetTextColor = function() end
				end


				bossIndex = bossIndex + 1
				name, description, bossID, _, link = EJ_GetEncounterInfoByIndex(bossIndex)
			end
		end)

		hooksecurefunc("EncounterJournal_ToggleHeaders", function()
			local index = 1
			local name = "EncounterJournalInfoHeader"..index
			local header = _G[name]
			while header do
				if not header.reskinned then
					header.reskinned = true

					header.flashAnim.Play = function() end

					header.description:SetTextColor(1, 1, 1)
					header.description:SetShadowOffset(1, -1)
					header.button.title:SetTextColor(1, 1, 1)
					header.button.title.SetTextColor = function() end
					header.button.expandedIcon:SetTextColor(1, 1, 1)
					header.button.expandedIcon.SetTextColor = function() end
					header.descriptionBG:SetAlpha(0)
					header.descriptionBGBottom:SetAlpha(0)

					S.Reskin(header.button, true)

					header.button.abilityIcon:SetTexCoord(.08, .92, .08, .92)

					_G[name.."HeaderButtonELeftUp"]:SetAlpha(0)
					_G[name.."HeaderButtonERightUp"]:SetAlpha(0)
					_G[name.."HeaderButtonEMidUp"]:SetAlpha(0)
					_G[name.."HeaderButtonCLeftUp"]:SetAlpha(0)
					_G[name.."HeaderButtonCRightUp"]:SetAlpha(0)
					_G[name.."HeaderButtonCMidUp"]:SetAlpha(0)
					_G[name.."HeaderButtonELeftDown"]:SetAlpha(0)
					_G[name.."HeaderButtonERightDown"]:SetAlpha(0)
					_G[name.."HeaderButtonEMidDown"]:SetAlpha(0)
					_G[name.."HeaderButtonCLeftDown"]:SetAlpha(0)
					_G[name.."HeaderButtonCRightDown"]:SetAlpha(0)
					_G[name.."HeaderButtonCMidDown"]:SetAlpha(0)
					_G[name.."HeaderButtonHighlightLeft"]:Hide()
					_G[name.."HeaderButtonHighlightMid"]:Hide()
					_G[name.."HeaderButtonHighlightRight"]:Hide()

					header.button.bg = header.button:CreateTexture(nil, "BACKGROUND")
					header.button.bg:Point("TOPLEFT", header.button.abilityIcon, -1, 1)
					header.button.bg:Point("BOTTOMRIGHT", header.button.abilityIcon, 1, -1)
					header.button.bg:SetTexture(media.backdrop)
					header.button.bg:SetVertexColor(0, 0, 0)
				end

				if header.button.abilityIcon:IsShown() then
					header.button.bg:Show()
				else
					header.button.bg:Hide()
				end

				index = index + 1
				name = "EncounterJournalInfoHeader"..index
				header = _G[name]
			end
		end)

		local items = EncounterJournal.encounter.info.lootScroll.buttons

		for i = 1, #items do
			local item = items[i]

			item.boss:SetTextColor(1, 1, 1)
			item.slot:SetTextColor(1, 1, 1)
			item.armorType:SetTextColor(1, 1, 1)

			item.bossTexture:SetAlpha(0)
			item.bosslessTexture:SetAlpha(0)

			item.icon:Point("TOPLEFT", 1, -1)
			item.icon:SetTexCoord(.08, .92, .08, .92)
			item.icon:SetDrawLayer("OVERLAY")
			S.CreateBG(item.icon)

			local bg = CreateFrame("Frame", nil, item)
			bg:SetPoint("TOPLEFT")
			bg:Point("BOTTOMRIGHT", 0, 1)
			bg:SetFrameStrata("BACKGROUND")
			S.CreateBD(bg, 0)

			local tex = item:CreateTexture(nil, "BACKGROUND")
			tex:SetPoint("TOPLEFT")
			tex:Point("BOTTOMRIGHT", -1, 2)
			tex:SetTexture(media.backdrop)
			tex:SetVertexColor(0, 0, 0, .25)
		end

		hooksecurefunc("EncounterJournal_SearchUpdate", function()
			local results = EncounterJournal.searchResults.scrollFrame.buttons
			local result

			for i = 1, #results do
				results[i]:SetNormalTexture("")
			end
		end)

		S.Reskin(EncounterJournalNavBarHomeButton)
		S.Reskin(EncounterJournalInstanceSelectDungeonTab)
		S.Reskin(EncounterJournalInstanceSelectRaidTab)
		S.Reskin(EncounterJournalEncounterFrameInfoDifficulty)
		S.Reskin(EncounterJournalEncounterFrameInfoResetButton)
		S.Reskin(EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle)
		S.ReskinClose(EncounterJournalCloseButton)
		S.ReskinClose(EncounterJournalSearchResultsCloseButton)
		S.ReskinInput(EncounterJournalSearchBox)
		S.ReskinScroll(EncounterJournalInstanceSelectScrollFrameScrollBar)
		S.ReskinScroll(EncounterJournalEncounterFrameInstanceFrameLoreScrollFrameScrollBar)
		S.ReskinScroll(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
		S.ReskinScroll(EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar)
		S.ReskinScroll(EncounterJournalSearchResultsScrollFrameScrollBar)
	elseif addon == "Blizzard_GlyphUI" then
		GlyphFrameBackground:Hide()
		GlyphFrameSideInset:DisableDrawLayer("BACKGROUND")
		GlyphFrameSideInset:DisableDrawLayer("BORDER")
		GlyphFrame.specRing:SetTexture("")
		S.CreateBG(GlyphFrameClearInfoFrame)
		GlyphFrameClearInfoFrameIcon:SetTexCoord(.08, .92, .08, .92)

		for i = 1, 2 do
			_G["GlyphFrameHeader"..i.."Left"]:Hide()
			_G["GlyphFrameHeader"..i.."Middle"]:Hide()
			_G["GlyphFrameHeader"..i.."Right"]:Hide()

		end

		S.CreateBDFrame(GlyphFrame.specIcon, 0)
		GlyphFrame.specIcon:SetTexCoord(.08, .92, .08, .92)

		local function onUpdate(self)
			local id = self:GetID()
			if GlyphMatchesSocket(id) then
				self.bg:SetBackdropBorderColor(r, g, b)
			else
				self.bg:SetBackdropBorderColor(0, 0, 0)
			end
		end

		for i = 1, NUM_GLYPH_SLOTS do
			local glyph = _G["GlyphFrameGlyph"..i]

			glyph.ring:SetAlpha(0)
			glyph.glyph:SetTexCoord(.08, .92, .08, .92)
			glyph.highlight:SetTexture("")

			glyph.bg = S.CreateBDFrame(glyph.glyph, .25)

			glyph:HookScript("OnUpdate", onUpdate)
		end

		hooksecurefunc("GlyphFrame_Update", function()
			local spec = GetSpecialization(_, _, PlayerTalentFrame.talentGroup)
			if spec then
				local _, _, _, icon = GetSpecializationInfo(spec, false, self.isPet)
				GlyphFrame.specIcon:SetTexture(icon)
			end
		end)

		hooksecurefunc("GlyphFrameGlyph_UpdateSlot", function(self)
			local id = self:GetID();
			local talentGroup = PlayerTalentFrame and PlayerTalentFrame.talentGroup
			local enabled, glyphType, glyphTooltipIndex, glyphSpell, iconFilename = GetGlyphSocketInfo(id, talentGroup)

			if not glyphType then return end

			if enabled and glyphSpell and iconFilename then
				self.glyph:SetTexture(iconFilename)
			end
		end)

		for i = 1, #GlyphFrame.scrollFrame.buttons do
			local bu = _G["GlyphFrameScrollFrameButton"..i]
			local ic = _G["GlyphFrameScrollFrameButton"..i.."Icon"]

			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", 38, -2)
			bg:Point("BOTTOMRIGHT", 0, 2)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, .25)

			_G["GlyphFrameScrollFrameButton"..i.."Name"]:SetParent(bg)
			_G["GlyphFrameScrollFrameButton"..i.."TypeName"]:SetParent(bg)
			bu:SetHighlightTexture("")
			bu.disabledBG:SetTexture("")
			select(4, bu:GetRegions()):SetAlpha(0)

			local check = select(2, bu:GetRegions())
			check:Point("TOPLEFT", 39, -3)
			check:Point("BOTTOMRIGHT", -1, 3)
			check:SetTexture(media.texture)
			check:SetVertexColor(r, g, b, .2)

			S.CreateBG(ic)

			ic:SetTexCoord(.08, .92, .08, .92)
		end

		S.ReskinInput(GlyphFrameSearchBox)
		S.ReskinScroll(GlyphFrameScrollFrameScrollBar)
		S.ReskinDropDown(GlyphFrameFilterDropDown)
	elseif addon == "Blizzard_GMSurveyUI" then
		S.SetBD(GMSurveyFrame, 0, 0, -32, 4)
		S.CreateBD(GMSurveyCommentFrame, .25)
		for i = 1, 11 do
			S.CreateBD(_G["GMSurveyQuestion"..i], .25)
			for j = 0, 5 do
				S.ReskinRadio(_G["GMSurveyQuestion"..i.."RadioButton"..j])
			end
		end

		for i = 1, 12 do
			select(i, GMSurveyFrame:GetRegions()):Hide()
		end
		GMSurveyHeaderLeft:Hide()
		GMSurveyHeaderRight:Hide()
		GMSurveyHeaderCenter:Hide()
		GMSurveyScrollFrameTop:SetAlpha(0)
		GMSurveyScrollFrameMiddle:SetAlpha(0)
		GMSurveyScrollFrameBottom:SetAlpha(0)
		S.Reskin(GMSurveySubmitButton)
		S.Reskin(GMSurveyCancelButton)
		S.ReskinClose(GMSurveyCloseButton, "TOPRIGHT", GMSurveyFrame, "TOPRIGHT", -36, -4)
		S.ReskinScroll(GMSurveyScrollFrameScrollBar)
	elseif addon == "Blizzard_GuildBankUI" then
		GuildBankFrame:DisableDrawLayer("BACKGROUND")
		GuildBankFrame:DisableDrawLayer("BORDER")
		GuildBankFrame:DisableDrawLayer("OVERLAY")
		GuildBankTabTitle:SetDrawLayer("ARTWORK")

		GuildBankEmblemFrame:Hide()
		GuildBankPopupFrameTopLeft:Hide()
		GuildBankPopupFrameBottomLeft:Hide()
		GuildBankMoneyFrameBackground:Hide()
		select(2, GuildBankPopupFrame:GetRegions()):Hide()
		select(4, GuildBankPopupFrame:GetRegions()):Hide()
		GuildBankPopupNameLeft:Hide()
		GuildBankPopupNameMiddle:Hide()
		GuildBankPopupNameRight:Hide()
		GuildBankPopupScrollFrame:GetRegions():Hide()
		select(2, GuildBankPopupScrollFrame:GetRegions()):Hide()
		local a, b = GuildBankTransactionsScrollFrame:GetRegions()
		a:Hide()
		b:Hide()
		a, b = GuildBankInfoScrollFrame:GetRegions()
		a:Hide()
		b:Hide()

		S.SetBD(GuildBankFrame)
		S.Reskin(GuildBankFrameWithdrawButton)
		S.Reskin(GuildBankFrameDepositButton)
		S.Reskin(GuildBankFramePurchaseButton)
		S.Reskin(GuildBankPopupOkayButton)
		S.Reskin(GuildBankPopupCancelButton)
		S.Reskin(GuildBankInfoSaveButton)
		S.ReskinClose(GuildBankFrame.CloseButton)
		S.ReskinScroll(GuildBankTransactionsScrollFrameScrollBar)
		S.ReskinScroll(GuildBankInfoScrollFrameScrollBar)
		S.ReskinScroll(GuildBankPopupScrollFrameScrollBar)
		S.ReskinInput(GuildItemSearchBox)

		for i = 1, 4 do
			local tab = _G["GuildBankFrameTab"..i]
			S.CreateTab(tab)

			if i ~= 1 then
				tab:Point("LEFT", _G["GuildBankFrameTab"..i-1], "RIGHT", -15, 0)
			end
		end

		local bd = CreateFrame("Frame", nil, GuildBankPopupFrame)
		bd:SetPoint("TOPLEFT")
		bd:Point("BOTTOMRIGHT", -28, 26)
		bd:SetFrameLevel(GuildBankPopupFrame:GetFrameLevel()-1)
		S.CreateBD(bd)
		S.CreateBD(GuildBankPopupEditBox, .25)

		GuildBankPopupFrame:Point("TOPLEFT", GuildBankFrame, "TOPRIGHT", 2, -30)

		GuildBankFrameWithdrawButton:Point("RIGHT", GuildBankFrameDepositButton, "LEFT", -1, 0)

		for i = 1, NUM_GUILDBANK_COLUMNS do
			_G["GuildBankColumn"..i]:GetRegions():Hide()
			for j = 1, NUM_SLOTS_PER_GUILDBANK_GROUP do
				_G["GuildBankColumn"..i.."Button"..j]:SetPushedTexture("")
				_G["GuildBankColumn"..i.."Button"..j.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)
				_G["GuildBankColumn"..i.."Button"..j.."NormalTexture"]:SetAlpha(0)
			end
		end

		for i = 1, 8 do
			local tb = _G["GuildBankTab"..i]
			local bu = _G["GuildBankTab"..i.."Button"]
			local ic = _G["GuildBankTab"..i.."ButtonIconTexture"]
			local nt = _G["GuildBankTab"..i.."ButtonNormalTexture"]

			bu:SetCheckedTexture(media.checked)
			S.CreateBG(bu)
			S.CreateSD(bu, 5, 0, 0, 0, 1, 1)

			local a1, p, a2, x, y = bu:GetPoint()
			bu:SetPoint(a1, p, a2, x + 11, y)

			ic:SetTexCoord(.08, .92, .08, .92)
			tb:GetRegions():Hide()
			nt:SetAlpha(0)
		end

		for i = 1, NUM_GUILDBANK_ICONS_PER_ROW * NUM_GUILDBANK_ICON_ROWS do
			local bu = _G["GuildBankPopupButton"..i]

			bu:SetCheckedTexture(media.checked)
			select(2, bu:GetRegions()):Hide()

			_G["GuildBankPopupButton"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)

			S.CreateBG(_G["GuildBankPopupButton"..i.."Icon"])
		end
	elseif addon == "Blizzard_GuildControlUI" then
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
						ch:SetHighlightTexture(media.backdrop)

						local hl = ch:GetHighlightTexture()
						hl:Point("TOPLEFT", 5, -5)
						hl:Point("BOTTOMRIGHT", -5, 5)
						hl:SetVertexColor(r, g, b, .2)

						local check = ch:GetCheckedTexture()
						check:SetDesaturated(true)
						check:SetVertexColor(r, g, b)

						local tex = ch:CreateTexture(nil, "BACKGROUND")
						tex:Point("TOPLEFT", 5, -5)
						tex:Point("BOTTOMRIGHT", -5, 5)
						tex:SetTexture(media.backdrop)
						tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

						local left = ch:CreateTexture(nil, "BACKGROUND")
						left:Width(1)
						left:SetTexture(0, 0, 0)
						left:Point("TOPLEFT", tex, -1, 1)
						left:point("BOTTOMLEFT", tex, -1, -1)

						local right = ch:CreateTexture(nil, "BACKGROUND")
						right:Width(1)
						right:SetTexture(0, 0, 0)
						right:Point("TOPRIGHT", tex, 1, 1)
						right:Point("BOTTOMRIGHT", tex, 1, -1)

						local top = ch:CreateTexture(nil, "BACKGROUND")
						top:Height(1)
						top:SetTexture(0, 0, 0)
						top:Point("TOPLEFT", tex, -1, 1)
						top:Point("TOPRIGHT", tex, 1, 1)

						local bottom = ch:CreateTexture(nil, "BACKGROUND")
						bottom:Height(1)
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
	elseif addon == "Blizzard_GuildUI" then
		S.ReskinPortraitFrame(GuildFrame, true)
		S.CreateBD(GuildMemberDetailFrame)
		S.CreateBD(GuildMemberNoteBackground, .25)
		S.CreateBD(GuildMemberOfficerNoteBackground, .25)
		S.CreateBD(GuildLogFrame)
		S.CreateBD(GuildLogContainer, .25)
		S.CreateBD(GuildNewsFiltersFrame)
		S.CreateBD(GuildTextEditFrame)
		S.CreateBD(GuildTextEditContainer, .25)
		S.CreateBD(GuildRecruitmentInterestFrame, .25)
		S.CreateBD(GuildRecruitmentAvailabilityFrame, .25)
		S.CreateBD(GuildRecruitmentRolesFrame, .25)
		S.CreateBD(GuildRecruitmentLevelFrame, .25)
		for i = 1, 5 do
			S.CreateTab(_G["GuildFrameTab"..i])
		end
		GuildFrameTabardBackground:Hide()
		GuildFrameTabardEmblem:Hide()
		GuildFrameTabardBorder:Hide()
		select(5, GuildInfoFrameInfo:GetRegions()):Hide()
		select(11, GuildMemberDetailFrame:GetRegions()):Hide()
		GuildMemberDetailCorner:Hide()
		for i = 1, 9 do
			select(i, GuildLogFrame:GetRegions()):Hide()
			select(i, GuildNewsFiltersFrame:GetRegions()):Hide()
			select(i, GuildTextEditFrame:GetRegions()):Hide()
		end
		select(2, GuildNewPerksFrame:GetRegions()):Hide()
		select(3, GuildNewPerksFrame:GetRegions()):Hide()
		GuildAllPerksFrame:GetRegions():Hide()
		GuildNewsFrame:GetRegions():Hide()
		GuildRewardsFrame:GetRegions():Hide()
		GuildNewsBossModelShadowOverlay:Hide()
		GuildPerksToggleButtonLeft:Hide()
		GuildPerksToggleButtonMiddle:Hide()
		GuildPerksToggleButtonRight:Hide()
		GuildPerksToggleButtonHighlightLeft:Hide()
		GuildPerksToggleButtonHighlightMiddle:Hide()
		GuildPerksToggleButtonHighlightRight:Hide()
		GuildNewPerksFrameHeader1:SetAlpha(0)
		GuildInfoFrameInfoHeader1:SetAlpha(0)
		GuildInfoFrameInfoHeader2:SetAlpha(0)
		GuildInfoFrameInfoHeader3:SetAlpha(0)
		select(9, GuildInfoFrameInfo:GetRegions()):Hide()
		GuildRecruitmentCommentInputFrameTop:Hide()
		GuildRecruitmentCommentInputFrameTopLeft:Hide()
		GuildRecruitmentCommentInputFrameTopRight:Hide()
		GuildRecruitmentCommentInputFrameBottom:Hide()
		GuildRecruitmentCommentInputFrameBottomLeft:Hide()
		GuildRecruitmentCommentInputFrameBottomRight:Hide()
		GuildRecruitmentInterestFrameBg:Hide()
		GuildRecruitmentAvailabilityFrameBg:Hide()
		GuildRecruitmentRolesFrameBg:Hide()
		GuildRecruitmentLevelFrameBg:Hide()
		GuildRecruitmentCommentFrameBg:Hide()
		GuildNewsFrameHeader:SetAlpha(0)

		GuildFrameBottomInset:DisableDrawLayer("BACKGROUND")
		GuildFrameBottomInset:DisableDrawLayer("BORDER")
		GuildInfoFrameInfoBar1Left:SetAlpha(0)
		GuildInfoFrameInfoBar2Left:SetAlpha(0)
		select(2, GuildInfoFrameInfo:GetRegions()):SetAlpha(0)
		select(4, GuildInfoFrameInfo:GetRegions()):SetAlpha(0)
		GuildRosterColumnButton1:DisableDrawLayer("BACKGROUND")
		GuildRosterColumnButton2:DisableDrawLayer("BACKGROUND")
		GuildRosterColumnButton3:DisableDrawLayer("BACKGROUND")
		GuildRosterColumnButton4:DisableDrawLayer("BACKGROUND")
		GuildNewsBossModel:DisableDrawLayer("BACKGROUND")
		GuildNewsBossModel:DisableDrawLayer("OVERLAY")
		GuildNewsBossNameText:SetDrawLayer("ARTWORK")
		GuildNewsBossModelTextFrame:DisableDrawLayer("BACKGROUND")
		for i = 2, 6 do
			select(i, GuildNewsBossModelTextFrame:GetRegions()):Hide()
		end

		GuildMemberRankDropdown:HookScript("OnShow", function()
			GuildMemberDetailRankText:Hide()
		end)
		GuildMemberRankDropdown:HookScript("OnHide", function()
			GuildMemberDetailRankText:Show()
		end)

		hooksecurefunc("GuildNews_Update", function()
			local buttons = GuildNewsContainer.buttons
			for i = 1, #buttons do
				buttons[i].header:SetAlpha(0)
			end
		end)

		S.ReskinClose(GuildNewsFiltersFrameCloseButton)
		S.ReskinClose(GuildLogFrameCloseButton)
		S.ReskinClose(GuildMemberDetailCloseButton)
		S.ReskinClose(GuildTextEditFrameCloseButton)
		S.ReskinScroll(GuildPerksContainerScrollBar)
		S.ReskinScroll(GuildRosterContainerScrollBar)
		S.ReskinScroll(GuildNewsContainerScrollBar)
		S.ReskinScroll(GuildRewardsContainerScrollBar)
		S.ReskinScroll(GuildInfoDetailsFrameScrollBar)
		S.ReskinScroll(GuildLogScrollFrameScrollBar)
		S.ReskinScroll(GuildTextEditScrollFrameScrollBar)
		S.ReskinScroll(GuildInfoFrameApplicantsContainerScrollBar)
		S.ReskinDropDown(GuildRosterViewDropdown)
		S.ReskinDropDown(GuildMemberRankDropdown)
		S.ReskinInput(GuildRecruitmentCommentInputFrame)
		GuildRecruitmentCommentInputFrame:SetWidth(312)
		GuildRecruitmentCommentEditBox:SetWidth(284)
		GuildRecruitmentCommentFrame:ClearAllPoints()
		GuildRecruitmentCommentFrame:Point("TOPLEFT", GuildRecruitmentLevelFrame, "BOTTOMLEFT", 0, 1)
		S.ReskinCheck(GuildRosterShowOfflineButton)
		for i = 1, 7 do
			S.ReskinCheck(_G["GuildNewsFilterButton"..i])
		end

		local a1, p, a2, x, y = GuildNewsBossModel:GetPoint()
		GuildNewsBossModel:ClearAllPoints()
		GuildNewsBossModel:SetPoint(a1, p, a2, x+5, y)

		local f = CreateFrame("Frame", nil, GuildNewsBossModel)
		f:Point("TOPLEFT", 0, 1)
		f:Point("BOTTOMRIGHT", 1, -52)
		f:SetFrameLevel(GuildNewsBossModel:GetFrameLevel()-1)
		S.CreateBD(f)

		local line = CreateFrame("Frame", nil, GuildNewsBossModel)
		line:Point("BOTTOMLEFT", 0, -1)
		line:Point("BOTTOMRIGHT", 0, -1)
		line:Height(1)
		line:SetFrameLevel(GuildNewsBossModel:GetFrameLevel()-1)
		S.CreateBD(line, 0)

		GuildNewsFiltersFrame:Width(224)
		GuildNewsFiltersFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 1, -20)
		GuildMemberDetailFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 1, -28)
		GuildLogFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 1, 0)
		GuildTextEditFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 1, 0)

		for i = 1, 5 do
			local bu = _G["GuildInfoFrameApplicantsContainerButton"..i]
			S.CreateBD(bu, .25)
			bu:SetHighlightTexture("")
			bu:GetRegions():SetTexture(media.backdrop)
			bu:GetRegions():SetVertexColor(r, g, b, .2)
		end

		GuildFactionBarProgress:SetTexture(media.backdrop)
		GuildFactionBarLeft:Hide()
		GuildFactionBarMiddle:Hide()
		GuildFactionBarRight:Hide()
		GuildFactionBarShadow:SetAlpha(0)
		GuildFactionBarBG:Hide()
		GuildFactionBarCap:SetAlpha(0)
		GuildFactionBar.bg = CreateFrame("Frame", nil, GuildFactionFrame)
		GuildFactionBar.bg:Point("TOPLEFT", GuildFactionFrame, -1, -1)
		GuildFactionBar.bg:Point("BOTTOMRIGHT", GuildFactionFrame, -3, 0)
		GuildFactionBar.bg:SetFrameLevel(0)
		S.CreateBD(GuildFactionBar.bg, .25)

		GuildXPFrame:ClearAllPoints()
		GuildXPFrame:SetPoint("TOP", GuildFrame, "TOP", 0, -40)
		GuildXPBarProgress:SetTexture(media.backdrop)
		GuildXPBarLeft:SetAlpha(0)
		GuildXPBarRight:SetAlpha(0)
		GuildXPBarMiddle:SetAlpha(0)
		GuildXPBarBG:SetAlpha(0)
		GuildXPBarShadow:SetAlpha(0)
		GuildXPBarShadow:SetAlpha(0)
		GuildXPBarCap:SetAlpha(0)
		GuildXPBarDivider1:Hide()
		GuildXPBarDivider2:Hide()
		GuildXPBarDivider3:Hide()
		GuildXPBarDivider4:Hide()
		GuildXPBar.bg = CreateFrame("Frame", nil, GuildXPBar)
		GuildXPBar.bg:Point("TOPLEFT", GuildXPBar, 0, -3)
		GuildXPBar.bg:Point("BOTTOMRIGHT", GuildXPBar, 0, 1)
		GuildXPBar.bg:SetFrameLevel(0)
		S.CreateBD(GuildXPBar.bg, .25)

		local perkbuttons = {"GuildLatestPerkButton", "GuildNextPerkButton"}
		for _, button in pairs(perkbuttons) do
			local bu = _G[button]
			local ic = _G[button.."IconTexture"]
			local na = _G[button.."NameFrame"]

			na:SetAlpha(0)
			ic:SetTexCoord(.08, .92, .08, .92)
			ic:SetDrawLayer("OVERLAY")
			S.CreateBG(ic)

			bu.bg = CreateFrame("Frame", nil, bu)
			bu.bg:SetPoint("TOPLEFT", 0, -1)
			bu.bg:SetPoint("BOTTOMRIGHT", 0, 2)
			bu.bg:SetFrameLevel(0)
			S.CreateBD(bu.bg, .25)
		end

		select(5, GuildLatestPerkButton:GetRegions()):Hide()
		select(6, GuildLatestPerkButton:GetRegions()):Hide()

		local reskinnedperks = false
		GuildPerksToggleButton:HookScript("OnClick", function()
			if not reskinnedperks == true then
				for i = 1, 8 do
					local button = "GuildPerksContainerButton"..i
					local bu = _G[button]
					local ic = _G[button.."IconTexture"]

					bu:DisableDrawLayer("BACKGROUND")
					bu:DisableDrawLayer("BORDER")
					bu.EnableDrawLayer = function() end
					ic:SetTexCoord(.08, .92, .08, .92)

					ic.bg = CreateFrame("Frame", nil, bu)
					ic.bg:Point("TOPLEFT", ic, -1, 1)
					ic.bg:Point("BOTTOMRIGHT", ic, 1, -1)
					S.CreateBD(ic.bg, 0)
				end
				reskinnedperks = true
			end
		end)

		local reskinnedRewards = false
		hooksecurefunc("GuildRewards_Update", function()
			if reskinnedRewards == true then return end

			for i = 1, 8 do
				local button = "GuildRewardsContainerButton"..i
				local bu = _G[button]
				local ic = _G[button.."Icon"]
				local locked = select(6, bu:GetRegions())
				local bd = select(7, bu:GetRegions())

				local bg = CreateFrame("Frame", nil, bu)
				bg:Point("TOPLEFT", 0, -1)
				bg:SetPoint("BOTTOMRIGHT")
				S.CreateBD(bg, 0)

				bu:SetHighlightTexture(media.backdrop)
				local hl = bu:GetHighlightTexture()
				hl:SetVertexColor(r, g, b, .2)
				hl:Point("TOPLEFT", 0, -1)
				hl:SetPoint("BOTTOMRIGHT")

				ic:SetTexCoord(.08, .92, .08, .92)

				locked:Hide()
				locked.Show = function() end
				bd:SetTexture(media.backdrop)
				bd:SetVertexColor(0, 0, 0, .25)
				bd:Point("TOPLEFT", 0, -1)
				bd:Point("BOTTOMRIGHT", 0, 1)

				S.CreateBG(ic)
			end
			reskinnedRewards = true
		end)

		local tcoords = {
			["WARRIOR"]     = {0.02, 0.23, 0.02, 0.23},
			["MAGE"]        = {0.27, 0.47609375, 0.02, 0.23},
			["ROGUE"]       = {0.51609375, 0.7221875, 0.02, 0.23},
			["DRUID"]       = {0.7621875, 0.96828125, 0.02, 0.23},
			["HUNTER"]      = {0.02, 0.23, 0.27, 0.48},
			["SHAMAN"]      = {0.27, 0.47609375, 0.27, 0.48},
			["PRIEST"]      = {0.51609375, 0.7221875, 0.27, 0.48},
			["WARLOCK"]     = {0.7621875, 0.96828125, 0.27, 0.48},
			["PALADIN"]     = {0.02, 0.23, 0.52, 0.73},
			["DEATHKNIGHT"] = {0.27, .48, 0.52, .73},
			["MONK"]		= {0.52, 0.71828125, 0.52, .73},
		}
		
		local UpdateIcons = function()
			local index
			local offset = HybridScrollFrame_GetOffset(GuildRosterContainer)
			local totalMembers, onlineMembers = GetNumGuildMembers()
			local visibleMembers = onlineMembers
			local numbuttons = #GuildRosterContainer.buttons
			if GetGuildRosterShowOffline() then
				visibleMembers = totalMembers
			end

			for i = 1, numbuttons do
				local bu = GuildRosterContainer.buttons[i]

				if not bu.bg then
					bu:SetHighlightTexture(media.backdrop)
					bu:GetHighlightTexture():SetVertexColor(r, g, b, .2)

					bu.bg = S.CreateBG(bu.icon)
				end
				
				index = offset + i
				local name, _, _, _, _, _, _, _, _, _, classFileName  = GetGuildRosterInfo(index)
				if name and index <= visibleMembers and bu.icon:IsShown() then
					bu.icon:SetTexCoord(unpack(tcoords[classFileName]))
					bu.bg:Show()
				else
					bu.bg:Hide()
				end
			end
		end

		hooksecurefunc("GuildRoster_Update", UpdateIcons)
		hooksecurefunc(GuildRosterContainer, "update", UpdateIcons)

		GuildLevelFrame:SetAlpha(0)
		local closebutton = select(4, GuildTextEditFrame:GetChildren())
		S.Reskin(closebutton)
		local logbutton = select(3, GuildLogFrame:GetChildren())
		S.Reskin(logbutton)
		local gbuttons = {"GuildAddMemberButton", "GuildViewLogButton", "GuildControlButton", "GuildTextEditFrameAcceptButton", "GuildMemberGroupInviteButton", "GuildMemberRemoveButton", "GuildRecruitmentInviteButton", "GuildRecruitmentMessageButton", "GuildRecruitmentDeclineButton", "GuildPerksToggleButton", "GuildRecruitmentListGuildButton"}
		for i = 1, #gbuttons do
			S.Reskin(_G[gbuttons[i]])
		end

		local checkboxes = {"GuildRecruitmentQuestButton", "GuildRecruitmentDungeonButton", "GuildRecruitmentRaidButton", "GuildRecruitmentPvPButton", "GuildRecruitmentRPButton", "GuildRecruitmentWeekdaysButton", "GuildRecruitmentWeekendsButton"}
		for i = 1, #checkboxes do
			S.ReskinCheck(_G[checkboxes[i]])
		end

		S.ReskinCheck(GuildRecruitmentTankButton:GetChildren())
		S.ReskinCheck(GuildRecruitmentHealerButton:GetChildren())
		S.ReskinCheck(GuildRecruitmentDamagerButton:GetChildren())

		S.ReskinRadio(GuildRecruitmentLevelAnyButton)
		S.ReskinRadio(GuildRecruitmentLevelMaxButton)

		for i = 1, 3 do
			for j = 1, 6 do
				select(j, _G["GuildInfoFrameTab"..i]:GetRegions()):Hide()
				select(j, _G["GuildInfoFrameTab"..i]:GetRegions()).Show = function() end
			end
		end
	elseif addon == "Blizzard_InspectUI" then
		InspectModelFrame:DisableDrawLayer("OVERLAY")
		InspectPVPTeam1:DisableDrawLayer("BACKGROUND")
		InspectPVPTeam2:DisableDrawLayer("BACKGROUND")
		InspectPVPTeam3:DisableDrawLayer("BACKGROUND")

		InspectTalentFrame:GetRegions():Hide()
		select(2, InspectTalentFrame:GetRegions()):Hide()
		InspectGuildFrameBG:Hide()
		for i = 1, 5 do
			select(i, InspectModelFrame:GetRegions()):Hide()
		end
		InspectPVPFrameBG:SetAlpha(0)
		InspectPVPFrameBottom:SetAlpha(0)
		select(9, InspectMainHandSlot:GetRegions()):Hide()

		local slots = {
			"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist",
			"Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand",
			"SecondaryHand", "Tabard",
		}

		for i = 1, #slots do
			local slot = _G["Inspect"..slots[i].."Slot"]
			_G["Inspect"..slots[i].."SlotFrame"]:Hide()

			slot:SetNormalTexture("")
			slot:SetPushedTexture("")
			_G["Inspect"..slots[i].."SlotIconTexture"]:SetTexCoord(.08, .92, .08, .92)
		end

		InspectTalentFrame.InspectSpec.ring:Hide()

		for i = 1, 6 do
			local row = InspectTalentFrame.InspectTalents["tier"..i]
			for j = 1, 3 do
				local bu = row["talent"..j]

				bu.Slot:Hide()
				bu.border:SetTexture("")

				bu.icon:SetDrawLayer("ARTWORK")
				bu.icon:SetTexCoord(.08, .92, .08, .92)

				S.CreateBG(bu.icon)
			end
		end

		InspectTalentFrame.InspectSpec.specIcon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(InspectTalentFrame.InspectSpec.specIcon)

		local function updateIcon(self)
			local spec = nil
			if INSPECTED_UNIT ~= nil then
				spec = GetInspectSpecialization(INSPECTED_UNIT)
			end
			if spec ~= nil and spec > 0 then
				local role1 = GetSpecializationRoleByID(spec)
				if role1 ~= nil then
					local _, _, _, icon = GetSpecializationInfoByID(spec)
					self.specIcon:SetTexture(icon)
				end
			end
		end

		InspectTalentFrame.InspectSpec:HookScript("OnShow", updateIcon)
		InspectTalentFrame:HookScript("OnEvent", function(self, event, unit)
			if not InspectFrame:IsShown() then return end
			if event == "INSPECT_READY" and InspectFrame.unit and UnitGUID(InspectFrame.unit) == unit then
				updateIcon(self.InspectSpec)
			end
		end)

		local function updateGlyph(self, clear)
			local id = self:GetID()
			local talentGroup = PlayerTalentFrame and PlayerTalentFrame.talentGroup
			local enabled, glyphType, glyphTooltipIndex, glyphSpell, iconFilename = GetGlyphSocketInfo(id, talentGroup, true, INSPECTED_UNIT);

			if not glyphType then return end

			if enabled and glyphSpell and not clear then
				if iconFilename then
					self.glyph:SetTexture(iconFilename)
				else
					self.glyph:SetTexture("Interface\\Spellbook\\UI-Glyph-Rune1")
				end
			end
		end

		hooksecurefunc("InspectGlyphFrameGlyph_UpdateSlot", updateGlyph)

		for i = 1, 6 do
			local glyph = InspectTalentFrame.InspectGlyphs["Glyph"..i]

			glyph:HookScript("OnShow", updateGlyph)

			glyph.ring:Hide()

			glyph.glyph:SetDrawLayer("ARTWORK")
			glyph.glyph:SetTexCoord(.08, .92, .08, .92)
			S.CreateBDFrame(glyph.glyph)
		end

		for i = 1, 4 do
			local tab = _G["InspectFrameTab"..i]
			S.CreateTab(tab)
			if i ~= 1 then
				tab:Point("LEFT", _G["InspectFrameTab"..i-1], "RIGHT", -15, 0)
			end
		end

		S.ReskinPortraitFrame(InspectFrame, true)
	elseif addon == "Blizzard_ItemSocketingUI" then
		ItemSocketingFrame:DisableDrawLayer("BORDER")
		ItemSocketingFrame:DisableDrawLayer("ARTWORK")
		ItemSocketingScrollFrameTop:SetAlpha(0)
		ItemSocketingScrollFrameMiddle:SetAlpha(0)
		ItemSocketingScrollFrameBottom:SetAlpha(0)
		ItemSocketingSocket1Left:SetAlpha(0)
		ItemSocketingSocket1Right:SetAlpha(0)
		ItemSocketingSocket2Left:SetAlpha(0)
		ItemSocketingSocket2Right:SetAlpha(0)
		ItemSocketingSocket3Left:SetAlpha(0)
		ItemSocketingSocket3Right:SetAlpha(0)

		for i = 1, MAX_NUM_SOCKETS do
			local bu = _G["ItemSocketingSocket"..i]

			_G["ItemSocketingSocket"..i.."BracketFrame"]:Hide()
			_G["ItemSocketingSocket"..i.."Background"]:SetAlpha(0)
			select(2, bu:GetRegions()):Hide()

			bu:SetPushedTexture("")
			bu.icon:SetTexCoord(.08, .92, .08, .92)

			local bg = CreateFrame("Frame", nil, bu)
			bg:SetAllPoints(bu)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, .25)

			bu.glow = CreateFrame("Frame", nil, bu)
			bu.glow:SetBackdrop({
				edgeFile = media.glow,
				edgeSize = 4,
			})
			bu.glow:Point("TOPLEFT", -4, 4)
			bu.glow:Point("BOTTOMRIGHT", 4, -4)
		end

		hooksecurefunc("ItemSocketingFrame_Update", function()
			for i = 1, MAX_NUM_SOCKETS do
				local color = GEM_TYPE_INFO[GetSocketTypes(i)]
				_G["ItemSocketingSocket"..i].glow:SetBackdropBorderColor(color.r, color.g, color.b)

			end

			local num = GetNumSockets()
			if num == 3 then
				ItemSocketingSocket1:Point("BOTTOM", ItemSocketingFrame, "BOTTOM", -75, 39)
			elseif num == 2 then
				ItemSocketingSocket1:Point("BOTTOM", ItemSocketingFrame, "BOTTOM", -35, 39)
			else
				ItemSocketingSocket1:Point("BOTTOM", ItemSocketingFrame, "BOTTOM", 0, 39)
			end
		end)

		S.ReskinPortraitFrame(ItemSocketingFrame, true)
		S.CreateBD(ItemSocketingScrollFrame, .25)
		S.Reskin(ItemSocketingSocketButton)
		S.ReskinScroll(ItemSocketingScrollFrameScrollBar)
	elseif addon == "Blizzard_ItemUpgradeUI" then
		BackgroundHighlight:Hide()
		ItemUpgradeFrameShadows:Hide()
		ItemUpgradeFrame.ItemButton.ItemFrame:Hide()
		ItemUpgradeFrame.ItemButton.TextureFrameLeft:Hide()
		ItemUpgradeFrame.ItemButton.TextureFrameMiddle:Hide()
		ItemUpgradeFrame.ItemButton.TextureFrameRight:Hide()
		ItemUpgradeFrameMoneyFrameLeft:Hide()
		ItemUpgradeFrameMoneyFrameMiddle:Hide()
		ItemUpgradeFrameMoneyFrameRight:Hide()

		S.CreateBD(ItemUpgradeFrame.ItemButton, .25)
		ItemUpgradeFrame.ItemButton:SetHighlightTexture("")
		ItemUpgradeFrame.ItemButton:SetPushedTexture("")

		local bg = CreateFrame("Frame", nil, ItemUpgradeFrame.ItemButton)
		bg:SetSize(341, 50)
		bg:Point("LEFT", ItemUpgradeFrame.ItemButton, "RIGHT", -1, 0)
		bg:SetFrameLevel(ItemUpgradeFrame.ItemButton:GetFrameLevel()-1)
		S.CreateBD(bg, .25)

		hooksecurefunc("ItemUpgradeFrame_Update", function()
			if GetItemUpgradeItemInfo() then
				ItemUpgradeFrame.ItemButton.IconTexture:SetTexCoord(.08, .92, .08, .92)
			else
				ItemUpgradeFrame.ItemButton.IconTexture:SetTexture("")
			end
		end)

		S.ReskinPortraitFrame(ItemUpgradeFrame, true)
		S.Reskin(ItemUpgradeFrameUpgradeButton)

	elseif addon == "Blizzard_LookingForGuildUI" then
		S.SetBD(LookingForGuildFrame)
		S.CreateBD(LookingForGuildInterestFrame, .25)
		LookingForGuildInterestFrameBg:Hide()
		S.CreateBD(LookingForGuildAvailabilityFrame, .25)
		LookingForGuildAvailabilityFrameBg:Hide()
		S.CreateBD(LookingForGuildRolesFrame, .25)
		LookingForGuildRolesFrameBg:Hide()
		S.CreateBD(LookingForGuildCommentFrame, .25)
		LookingForGuildCommentFrameBg:Hide()
		S.CreateBD(LookingForGuildCommentInputFrame, .12)
		LookingForGuildFrame:DisableDrawLayer("BACKGROUND")
		LookingForGuildFrame:DisableDrawLayer("BORDER")
		LookingForGuildFrameInset:DisableDrawLayer("BACKGROUND")
		LookingForGuildFrameInset:DisableDrawLayer("BORDER")
		S.CreateBD(GuildFinderRequestMembershipFrame)
		S.CreateSD(GuildFinderRequestMembershipFrame)
		for i = 1, 5 do
			local bu = _G["LookingForGuildBrowseFrameContainerButton"..i]
			S.CreateBD(bu, .25)
			bu:SetHighlightTexture("")
			bu:GetRegions():SetTexture(media.backdrop)
			bu:GetRegions():SetVertexColor(r, g, b, .2)
		end
		for i = 1, 9 do
			select(i, LookingForGuildCommentInputFrame:GetRegions()):Hide()
		end
		for i = 1, 3 do
			for j = 1, 6 do
				select(j, _G["LookingForGuildFrameTab"..i]:GetRegions()):Hide()
				select(j, _G["LookingForGuildFrameTab"..i]:GetRegions()).Show = function() end
			end
		end
		for i = 1, 6 do
			select(i, GuildFinderRequestMembershipFrameInputFrame:GetRegions()):Hide()
		end
		LookingForGuildFrameTabardBackground:Hide()
		LookingForGuildFrameTabardEmblem:Hide()
		LookingForGuildFrameTabardBorder:Hide()
		LookingForGuildFramePortraitFrame:Hide()
		LookingForGuildFrameTopBorder:Hide()
		LookingForGuildFrameTopRightCorner:Hide()

		S.Reskin(LookingForGuildBrowseButton)
		S.Reskin(LookingForGuildRequestButton)
		S.Reskin(GuildFinderRequestMembershipFrameAcceptButton)
		S.Reskin(GuildFinderRequestMembershipFrameCancelButton)

		S.ReskinScroll(LookingForGuildBrowseFrameContainerScrollBar)
		S.ReskinClose(LookingForGuildFrameCloseButton)
		S.ReskinCheck(LookingForGuildQuestButton)
		S.ReskinCheck(LookingForGuildDungeonButton)
		S.ReskinCheck(LookingForGuildRaidButton)
		S.ReskinCheck(LookingForGuildPvPButton)
		S.ReskinCheck(LookingForGuildRPButton)
		S.ReskinCheck(LookingForGuildWeekdaysButton)
		S.ReskinCheck(LookingForGuildWeekendsButton)
		S.ReskinCheck(LookingForGuildTankButton:GetChildren())
		S.ReskinCheck(LookingForGuildHealerButton:GetChildren())
		S.ReskinCheck(LookingForGuildDamagerButton:GetChildren())
		S.ReskinInput(GuildFinderRequestMembershipFrameInputFrame)
	elseif addon == "Blizzard_MacroUI" then
		select(18, MacroFrame:GetRegions()):Hide()
		MacroHorizontalBarLeft:Hide()
		select(21, MacroFrame:GetRegions()):Hide()

		for i = 1, 6 do
			select(i, MacroFrameTab1:GetRegions()):Hide()
			select(i, MacroFrameTab2:GetRegions()):Hide()
			select(i, MacroFrameTab1:GetRegions()).Show = function() end
			select(i, MacroFrameTab2:GetRegions()).Show = function() end
		end
		for i = 1, 5 do
			select(i, MacroPopupFrame:GetRegions()):Hide()
		end
		MacroPopupScrollFrame:GetRegions():Hide()
		select(2, MacroPopupScrollFrame:GetRegions()):Hide()
		MacroPopupNameLeft:Hide()
		MacroPopupNameMiddle:Hide()
		MacroPopupNameRight:Hide()
		MacroFrameTextBackground:SetBackdrop(nil)
		select(2, MacroFrameSelectedMacroButton:GetRegions()):Hide()
		MacroFrameSelectedMacroBackground:SetAlpha(0)
		MacroButtonScrollFrameTop:Hide()
		MacroButtonScrollFrameBottom:Hide()

		MacroFrameSelectedMacroButton:Point("TOPLEFT", MacroFrameSelectedMacroBackground, "TOPLEFT", 12, -16)
		MacroFrameSelectedMacroButtonIcon:Point("TOPLEFT", 1, -1)
		MacroFrameSelectedMacroButtonIcon:Point("BOTTOMRIGHT", -1, 1)
		MacroFrameSelectedMacroButtonIcon:SetTexCoord(.08, .92, .08, .92)

		MacroPopupFrame:Point("TOPLEFT", MacroFrame, "TOPRIGHT", 1, 0)

		for i = 1, MAX_ACCOUNT_MACROS do
			local bu = _G["MacroButton"..i]
			local ic = _G["MacroButton"..i.."Icon"]

			bu:SetCheckedTexture(media.checked)
			select(2, bu:GetRegions()):Hide()

			ic:Point("TOPLEFT", 1, -1)
			ic:Point("BOTTOMRIGHT", -1, 1)
			ic:SetTexCoord(.08, .92, .08, .92)

			S.CreateBD(bu, .25)
		end

		for i = 1, NUM_MACRO_ICONS_SHOWN do
			local bu = _G["MacroPopupButton"..i]
			local ic = _G["MacroPopupButton"..i.."Icon"]

			bu:SetCheckedTexture(media.checked)
			select(2, bu:GetRegions()):Hide()

			ic:Point("TOPLEFT", 1, -1)
			ic:Point("BOTTOMRIGHT", -1, 1)
			ic:SetTexCoord(.08, .92, .08, .92)

			S.CreateBD(bu, .25)
		end

		S.ReskinPortraitFrame(MacroFrame, true)
		S.CreateBD(MacroFrameScrollFrame, .25)
		S.CreateBD(MacroPopupFrame)
		S.CreateBD(MacroPopupEditBox, .25)
		S.CreateBD(MacroFrameSelectedMacroButton, .25)
		S.Reskin(MacroDeleteButton)
		S.Reskin(MacroNewButton)
		S.Reskin(MacroExitButton)
		S.Reskin(MacroEditButton)
		S.Reskin(MacroPopupOkayButton)
		S.Reskin(MacroPopupCancelButton)
		S.Reskin(MacroSaveButton)
		S.Reskin(MacroCancelButton)
		S.ReskinScroll(MacroButtonScrollFrameScrollBar)
		S.ReskinScroll(MacroFrameScrollFrameScrollBar)
		S.ReskinScroll(MacroPopupScrollFrameScrollBar)
	elseif addon == "Blizzard_PetJournal" then
		local PetJournal = PetJournal
		local MountJournal = MountJournal

		for i = 1, 14 do
			if i ~= 8 then
				select(i, PetJournalParent:GetRegions()):Hide()
			end
		end
		for i = 1, 9 do
			select(i, MountJournal.MountCount:GetRegions()):Hide()
			select(i, PetJournal.PetCount:GetRegions()):Hide()
		end

		MountJournal.LeftInset:Hide()
		MountJournal.RightInset:Hide()
		PetJournal.LeftInset:Hide()
		PetJournal.RightInset:Hide()
		PetJournal.PetCardInset:Hide()
		PetJournal.loadoutBorder:Hide()
		MountJournal.MountDisplay.YesMountsTex:SetAlpha(0)
		MountJournal.MountDisplay.NoMountsTex:SetAlpha(0)
		MountJournal.MountDisplay.ShadowOverlay:Hide()
		PetJournalFilterButtonLeft:Hide()
		PetJournalFilterButtonRight:Hide()
		PetJournalFilterButtonMiddle:Hide()
		PetJournalTutorialButton.Ring:Hide()

		S.CreateBD(PetJournalParent)
		S.CreateSD(PetJournalParent)
		S.CreateBD(MountJournal.MountCount, .25)
		S.CreateBD(PetJournal.PetCount, .25)
		S.CreateBD(MountJournal.MountDisplay.ModelFrame, .25)

		S.Reskin(MountJournalMountButton)
		S.Reskin(PetJournalSummonButton)
		S.Reskin(PetJournalFindBattle)
		S.Reskin(PetJournalFilterButton)
		S.CreateTab(PetJournalParentTab1)
		S.CreateTab(PetJournalParentTab2)
		S.ReskinClose(PetJournalParentCloseButton)
		S.ReskinScroll(MountJournalListScrollFrameScrollBar)
		S.ReskinScroll(PetJournalListScrollFrameScrollBar)
		S.ReskinInput(PetJournalSearchBox)
		S.ReskinArrow(MountJournal.MountDisplay.ModelFrame.RotateLeftButton, "left")
		S.ReskinArrow(MountJournal.MountDisplay.ModelFrame.RotateRightButton, "right")

		PetJournalTutorialButton:Point("TOPLEFT", PetJournal, "TOPLEFT", -14, 14)

		PetJournalParentTab2:Point("LEFT", PetJournalParentTab1, "RIGHT", -15, 0)

		PetJournalHealPetButtonBorder:Hide()
		PetJournalHealPetButtonIconTexture:SetTexCoord(.08, .92, .08, .92)
		PetJournal.HealPetButton:SetPushedTexture("")
		S.CreateBG(PetJournal.HealPetButton)

		local scrollFrames = {MountJournal.ListScrollFrame.buttons, PetJournal.listScroll.buttons}
		for _, scrollFrame in pairs(scrollFrames) do
			for i = 1, #scrollFrame do
				local bu = scrollFrame[i]

				bu:GetRegions():Hide()
				bu:SetHighlightTexture("")

				bu.selectedTexture:Point("TOPLEFT", 0, -1)
				bu.selectedTexture:Point("BOTTOMRIGHT", 0, 1)
				bu.selectedTexture:SetTexture(media.backdrop)
				bu.selectedTexture:SetVertexColor(r, g, b, .2)

				local bg = CreateFrame("Frame", nil, bu)
				bg:Point("TOPLEFT", 0, -1)
				bg:Point("BOTTOMRIGHT", 0, 1)
				bg:SetFrameLevel(bu:GetFrameLevel()-1)
				S.CreateBD(bg, .25)
				bu.bg = bg

				bu.icon:SetTexCoord(.08, .92, .08, .92)
				bu.icon:SetDrawLayer("OVERLAY")
				S.CreateBG(bu.icon)

				bu.name:SetParent(bg)

				if bu.DragButton then
					bu.DragButton.ActiveTexture:SetTexture(media.checked)
				else
					bu.dragButton.ActiveTexture:SetTexture(media.checked)
					bu.dragButton.levelBG:SetAlpha(0)
					bu.dragButton.level:SetFontObject(GameFontNormal)
					bu.dragButton.level:SetTextColor(1, 1, 1)
				end
			end
		end

		local function updateScroll()
			local buttons = MountJournal.ListScrollFrame.buttons
			for i = 1, #buttons do
				local bu = buttons[i]
				if i == 2 then
					bu:Point("TOPLEFT", buttons[i-1], "BOTTOMLEFT", 0, -1)
				elseif i > 2 then
					bu:SetPoint("TOPLEFT", buttons[i-1], "BOTTOMLEFT", 0, 0)
				end
			end
		end

		hooksecurefunc("MountJournal_UpdateMountList", updateScroll)
		MountJournalListScrollFrame:HookScript("OnVerticalScroll", updateScroll)
		MountJournalListScrollFrame:HookScript("OnMouseWheel", updateScroll)

		local tooltips = {PetJournalPrimaryAbilityTooltip, PetJournalSecondaryAbilityTooltip}
		for _, f in pairs(tooltips) do
			f:DisableDrawLayer("BACKGROUND")
			local bg = CreateFrame("Frame", nil, f)
			bg:SetAllPoints()
			bg:SetFrameLevel(0)
			S.CreateBD(bg)
		end

		PetJournalLoadoutBorderSlotHeaderText:SetParent(PetJournal)
		PetJournalLoadoutBorderSlotHeaderText:Point("CENTER", PetJournalLoadoutBorderTop, "TOP", 0, 4)

		local card = PetJournalPetCard

		PetJournalPetCardBG:Hide()
		card.AbilitiesBG:SetAlpha(0)
		card.PetInfo.levelBG:SetAlpha(0)

		card.PetInfo.level:SetFontObject(GameFontNormal)
		card.PetInfo.level:SetTextColor(1, 1, 1)

		card.PetInfo.icon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(card.PetInfo.icon)

		S.CreateBD(card, .25)

		for i = 2, 12 do
			select(i, card.xpBar:GetRegions()):Hide()
		end

		card.xpBar:SetStatusBarTexture(DB.Statusbar)
		S.CreateBDFrame(card.xpBar, .25)

		PetJournalPetCardHealthFramehealthStatusBarLeft:Hide()
		PetJournalPetCardHealthFramehealthStatusBarRight:Hide()
		PetJournalPetCardHealthFramehealthStatusBarMiddle:Hide()
		PetJournalPetCardHealthFramehealthStatusBarBGMiddle:Hide()

		card.HealthFrame.healthBar:SetStatusBarTexture(DB.Statusbar)
		S.CreateBDFrame(card.HealthFrame.healthBar, .25)

		for i = 1, 6 do
			local bu = card["spell"..i]

			bu.icon:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(bu.icon)
		end

		for i = 1, 3 do
			local bu = PetJournal.Loadout["Pet"..i]

			_G["PetJournalLoadoutPet"..i.."BG"]:Hide()

			bu.iconBorder:SetAlpha(0)
			bu.levelBG:SetAlpha(0)
			bu.helpFrame:GetRegions():Hide()

			bu.level:SetFontObject(GameFontNormal)
			bu.level:SetTextColor(1, 1, 1)

			bu.icon:SetTexCoord(.08, .92, .08, .92)
			bu.icon.bg = CreateFrame("Frame", nil, bu)
			bu.icon.bg:Point("TOPLEFT", bu.icon, -1, 1)
			bu.icon.bg:Point("BOTTOMRIGHT", bu.icon, 1, -1)
			bu.icon.bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bu.icon.bg, .25)

			bu.setButton:GetRegions():Point("TOPLEFT", bu.icon, -5, 5)
			bu.setButton:GetRegions():Point("BOTTOMRIGHT", bu.icon, 5, -5)

			S.CreateBD(bu, .25)

			for i = 2, 12 do
				select(i, bu.xpBar:GetRegions()):Hide()
			end

			bu.xpBar:SetStatusBarTexture(DB.Statusbar)
			S.CreateBDFrame(bu.xpBar, .25)

			_G["PetJournalLoadoutPet"..i.."HealthFramehealthStatusBarLeft"]:Hide()
			_G["PetJournalLoadoutPet"..i.."HealthFramehealthStatusBarRight"]:Hide()
			_G["PetJournalLoadoutPet"..i.."HealthFramehealthStatusBarMiddle"]:Hide()
			_G["PetJournalLoadoutPet"..i.."HealthFramehealthStatusBarBGMiddle"]:Hide()

			bu.healthFrame.healthBar:SetStatusBarTexture(DB.Statusbar)
			S.CreateBDFrame(bu.healthFrame.healthBar, .25)

			for j = 1, 3 do
				local spell = bu["spell"..j]
				spell:SetPushedTexture("")
				spell.selected:SetTexture(media.checked)

				spell:GetRegions():Hide()

				spell.FlyoutArrow:SetTexture(media.arrowDown)
				spell.FlyoutArrow:SetSize(8, 8)
				spell.FlyoutArrow:SetTexCoord(0, 1, 0, 1)

				spell.icon:SetTexCoord(.08, .92, .08, .92)
				S.CreateBG(spell.icon)
			end
		end

		hooksecurefunc("PetJournal_UpdatePetLoadOut", function()
			for i = 1, 3 do
				local bu = PetJournal.Loadout["Pet"..i]
				bu.icon.bg:SetShown(not bu.helpFrame:IsShown())
				bu.dragButton:SetEnabled(not bu.helpFrame:IsShown())
			end
		end)

		PetJournal.SpellSelect.BgEnd:Hide()
		PetJournal.SpellSelect.BgTiled:Hide()

		for i = 1, 2 do
			local bu = PetJournal.SpellSelect["Spell"..i]
			bu:SetPushedTexture("")
			bu:SetCheckedTexture(media.checked)

			bu.icon:SetDrawLayer("ARTWORK")
			bu.icon:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(bu.icon)
		end
		local function ColourPetQuality()
			local petButtons = PetJournal.listScroll.buttons
			if petButtons then
				for i = 1, #petButtons do
					local index = petButtons[i].index
					if index then
						local petID = C_PetJournal.GetPetInfoByIndex(index)

						if petID then
							local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petID)
							local text = petButtons[i].name

							if rarity then
								local color = ITEM_QUALITY_COLORS[rarity-1]
								text:SetTextColor(color.r, color.g, color.b)
							else
								text:SetTextColor(1, 1, 1)
							end
						end
					end
				end
			end
		end

		hooksecurefunc("PetJournal_UpdatePetList", ColourPetQuality)
		PetJournalListScrollFrame:HookScript("OnVerticalScroll", ColourPetQuality)
		PetJournalListScrollFrame:HookScript("OnMouseWheel", ColourPetQuality)
	elseif addon == "Blizzard_ReforgingUI" then
		S.CreateBD(ReforgingFrame)
		S.CreateSD(ReforgingFrame)

		ReforgingFrame:DisableDrawLayer("BORDER")
		for i = 15, 25 do
			select(i, ReforgingFrame:GetRegions()):Hide()
		end
		select(27, ReforgingFrame:GetRegions()):Hide()
		ReforgingFrame.Lines:SetAlpha(0)
		ReforgingFrame.ReceiptBG:SetAlpha(0)
		ReforgingFrame.MissingFadeOut:SetAlpha(0)
		ReforgingFramePortrait:Hide()
		ReforgingFrameBg:Hide()
		ReforgingFrameTitleBg:Hide()
		ReforgingFramePortraitFrame:Hide()
		ReforgingFrameTopBorder:Hide()
		ReforgingFrameTopRightCorner:Hide()
		ReforgingFrame.ButtonFrame:GetRegions():Hide()
		ReforgingFrame.ButtonFrame.ButtonBorder:Hide()
		ReforgingFrame.ButtonFrame.ButtonBottomBorder:Hide()
		ReforgingFrame.ButtonFrame.MoneyLeft:Hide()
		ReforgingFrame.ButtonFrame.MoneyRight:Hide()
		ReforgingFrame.ButtonFrame.MoneyMiddle:Hide()
		ReforgingFrame.ItemButton.Frame:Hide()
		ReforgingFrame.ItemButton.Grabber:Hide()
		ReforgingFrame.ItemButton.TextFrame:Hide()
		ReforgingFrame.ItemButton.TextGrabber:Hide()

		S.CreateBD(ReforgingFrame.ItemButton, .25)
		ReforgingFrame.ItemButton:SetHighlightTexture("")
		ReforgingFrame.ItemButton:SetPushedTexture("")

		ReforgingFrame.ItemButton:HookScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, .56, .85)
		end)
		ReforgingFrame.ItemButton:HookScript("OnLeave", function(self)
			self:SetBackdropBorderColor(0, 0, 0)
		end)

		local bg = CreateFrame("Frame", nil, ReforgingFrame.ItemButton)
		bg:Size(341, 50)
		bg:Point("LEFT", ReforgingFrame.ItemButton, "RIGHT", -1, 0)
		bg:SetFrameLevel(ReforgingFrame.ItemButton:GetFrameLevel()-1)
		S.CreateBD(bg, .25)

		ReforgingFrame.RestoreMessage:SetTextColor(.9, .9, .9)

		hooksecurefunc("ReforgingFrame_Update", function()
			local _, icon = GetReforgeItemInfo()
			if not icon then
				ReforgingFrame.ItemButton.IconTexture:SetTexture("")
			else
				ReforgingFrame.ItemButton.IconTexture:SetTexCoord(.08, .92, .08, .92)
			end
		end)

		ReforgingFrameRestoreButton:SetPoint("LEFT", ReforgingFrameMoneyFrame, "RIGHT", 0, 1)

		S.Reskin(ReforgingFrameRestoreButton)
		S.Reskin(ReforgingFrameReforgeButton)
		S.ReskinClose(ReforgingFrameCloseButton)
	elseif addon == "Blizzard_TalentUI" then
		PlayerTalentFrameTalents:DisableDrawLayer("BORDER")
		PlayerTalentFrameTalentsBg:Hide()
		PlayerTalentFrameActiveSpecTabHighlight:SetTexture("")
		PlayerTalentFrameTitleGlowLeft:SetTexture("")
		PlayerTalentFrameTitleGlowRight:SetTexture("")
		PlayerTalentFrameTitleGlowCenter:SetTexture("")

		for i = 1, 6 do
			select(i, PlayerTalentFrameSpecialization:GetRegions()):Hide()
		end

		select(7, PlayerTalentFrameSpecialization:GetChildren()):DisableDrawLayer("OVERLAY")

		for i = 1, 5 do
			select(i, PlayerTalentFrameSpecializationSpellScrollFrameScrollChild:GetRegions()):Hide()
		end

		S.CreateBG(PlayerTalentFrameTalentsClearInfoFrame)
		PlayerTalentFrameTalentsClearInfoFrameIcon:SetTexCoord(.08, .92, .08, .92)

		PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.Seperator:SetTexture(1, 1, 1)
		PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.Seperator:SetAlpha(.2)

		if class == "HUNTER" then
			for i = 1, 6 do
				select(i, PlayerTalentFramePetSpecialization:GetRegions()):Hide()
			end
			select(7, PlayerTalentFramePetSpecialization:GetChildren()):DisableDrawLayer("OVERLAY")
			for i = 1, 5 do
				select(i, PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild:GetRegions()):Hide()
			end

			PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.Seperator:SetTexture(1, 1, 1)
			PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.Seperator:SetAlpha(.2)

			for i = 1, GetNumSpecializations(false, true) do
				local _, _, _, icon = GetSpecializationInfo(i, false, true)
				PlayerTalentFramePetSpecialization["specButton"..i].specIcon:SetTexture(icon)
			end
		end

		for i = 1, NUM_TALENT_FRAME_TABS do
			local tab = _G["PlayerTalentFrameTab"..i]
			S.CreateTab(tab)
		end

		PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.ring:Hide()
		PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.specIcon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.specIcon)
		PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.ring:Hide()
		PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.specIcon:SetTexCoord(.08, .92, .08, .92)
		S.CreateBG(PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.specIcon)

		hooksecurefunc("PlayerTalentFrame_UpdateSpecFrame", function(self, spec)
			local playerTalentSpec = GetSpecialization(nil, self.isPet, PlayerSpecTab2:GetChecked() and 2 or 1)
			local shownSpec = spec or playerTalentSpec or 1

			local id, _, _, icon = GetSpecializationInfo(shownSpec, nil, self.isPet)
			local scrollChild = self.spellsScroll.child

			scrollChild.specIcon:SetTexture(icon)

			local index = 1
			local bonuses
			if self.isPet then
				bonuses = {GetSpecializationSpells(shownSpec, nil, self.isPet)}
			else
				bonuses = SPEC_SPELLS_DISPLAY[id]
			end
			for i = 1, #bonuses, 2 do
				local frame = scrollChild["abilityButton"..index]
				local _, icon = GetSpellTexture(bonuses[i])
				frame.icon:SetTexture(icon)
				frame.subText:SetTextColor(.75, .75, .75)
				if not frame.reskinned then
					frame.reskinned = true
					frame.ring:Hide()
					frame.icon:SetTexCoord(.08, .92, .08, .92)
					S.CreateBG(frame.icon)
				end
				index = index + 1
			end

			for i = 1, GetNumSpecializations(nil, self.isPet) do
				local bu = self["specButton"..i]
				if bu.selected then
					bu.glowTex:Show()
				else
					bu.glowTex:Hide()
				end
			end
		end)

		for i = 1, GetNumSpecializations(false, nil) do
			local _, _, _, icon = GetSpecializationInfo(i, false, nil)
			PlayerTalentFrameSpecialization["specButton"..i].specIcon:SetTexture(icon)
		end

		local buttons = {"PlayerTalentFrameSpecializationSpecButton", "PlayerTalentFramePetSpecializationSpecButton"}

		for _, name in pairs(buttons) do
			for i = 1, 4 do
				local bu = _G[name..i]

				bu.bg:SetAlpha(0)
				bu.ring:Hide()
				bu.learnedTex:Point("TOPLEFT", 1, -1)
				bu.learnedTex:Point("BOTTOMRIGHT", -1, 1)
				_G["PlayerTalentFrameSpecializationSpecButton"..i.."Glow"]:Hide()
				_G["PlayerTalentFrameSpecializationSpecButton"..i.."Glow"].Show = function() end

				S.Reskin(bu, true)

				bu.selectedTex:SetTexture("")
				bu.learnedTex:SetTexture(media.backdrop)
				bu.learnedTex:SetVertexColor(r, g, b, .2)
				bu.learnedTex:SetDrawLayer("BACKGROUND")

				bu.specIcon:SetTexCoord(.08, .92, .08, .92)
				bu.specIcon:Size(58, 58)
				bu.specIcon:SetPoint("LEFT", bu, "LEFT")
				bu.specIcon:SetDrawLayer("OVERLAY")
				local bg = S.CreateBG(bu.specIcon)
				bg:SetDrawLayer("BORDER")

				bu.glowTex = CreateFrame("Frame", nil, bu)
				bu.glowTex:SetBackdrop({
					edgeFile = media.glow,
					edgeSize = 5,
				})
				bu.glowTex:Point("TOPLEFT", -6, 5)
				bu.glowTex:Point("BOTTOMRIGHT", 5, -5)
				bu.glowTex:SetBackdropBorderColor(r, g, b)
				bu.glowTex:SetFrameLevel(bu:GetFrameLevel()-1)
				bu.glowTex:Hide()
			end
		end

		for i = 1, MAX_NUM_TALENT_TIERS do
			local row = _G["PlayerTalentFrameTalentsTalentRow"..i]
			_G["PlayerTalentFrameTalentsTalentRow"..i.."Bg"]:Hide()
			row:DisableDrawLayer("BORDER")

			row.TopLine:SetDesaturated(true)
			row.TopLine:SetVertexColor(r, g, b)
			row.BottomLine:SetDesaturated(true)
			row.BottomLine:SetVertexColor(r, g, b)

			for j = 1, NUM_TALENT_COLUMNS do
				local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
				local ic = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j.."IconTexture"]

				bu:SetHighlightTexture("")
				bu.Slot:SetAlpha(0)
				bu.knownSelection:SetAlpha(0)
				bu.learnSelection:SetAlpha(0)

				ic:SetDrawLayer("ARTWORK")
				ic:SetTexCoord(.08, .92, .08, .92)
				S.CreateBG(ic)

				bu.bg = CreateFrame("Frame", nil, bu)
				bu.bg:Point("TOPLEFT", 10, 0)
				bu.bg:SetPoint("BOTTOMRIGHT")
				bu.bg:SetFrameLevel(bu:GetFrameLevel()-1)
				S.CreateBD(bu.bg, .25)
			end
		end

		hooksecurefunc("TalentFrame_Update", function()
			for i = 1, MAX_NUM_TALENT_TIERS do
				for j = 1, NUM_TALENT_COLUMNS do
					local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
					if bu.knownSelection:IsShown() then
						bu.bg:SetBackdropColor(r, g, b, .2)
					else
						bu.bg:SetBackdropColor(0, 0, 0, .25)
					end
					if bu.learnSelection:IsShown() then
						bu.bg:SetBackdropBorderColor(r, g, b)
					else
						bu.bg:SetBackdropBorderColor(0, 0, 0)
					end
				end
			end
		end)

		for i = 1, 2 do
			local tab = _G["PlayerSpecTab"..i]
			_G["PlayerSpecTab"..i.."Background"]:Hide()

			tab:SetCheckedTexture(media.checked)

			local bg = CreateFrame("Frame", nil, tab)
			bg:Point("TOPLEFT", -1, 1)
			bg:Point("BOTTOMRIGHT", 1, -1)
			bg:SetFrameLevel(tab:GetFrameLevel()-1)
			S.CreateBD(bg)

			S.CreateSD(tab, 5, 0, 0, 0, 1, 1)

			select(2, tab:GetRegions()):SetTexCoord(.08, .92, .08, .92)
		end

		hooksecurefunc("PlayerTalentFrame_UpdateSpecs", function()
			PlayerSpecTab1:Point("TOPLEFT", PlayerTalentFrame, "TOPRIGHT", 11, -36)
			PlayerSpecTab2:SetPoint("TOP", PlayerSpecTab1, "BOTTOM")
		end)

		PlayerTalentFrameTalentsTutorialButton.Ring:Hide()
		PlayerTalentFrameTalentsTutorialButton:Point("TOPLEFT", PlayerTalentFrame, "TOPLEFT", -12, 12)
		PlayerTalentFrameSpecializationTutorialButton.Ring:Hide()
		PlayerTalentFrameSpecializationTutorialButton:Point("TOPLEFT", PlayerTalentFrame, "TOPLEFT", -12, 12)

		S.ReskinPortraitFrame(PlayerTalentFrame, true)
		S.Reskin(PlayerTalentFrameSpecializationLearnButton)
		S.Reskin(PlayerTalentFrameTalentsLearnButton)
		S.Reskin(PlayerTalentFrameActivateButton)
		S.Reskin(PlayerTalentFramePetSpecializationLearnButton)
	elseif addon == "Blizzard_TimeManager" then
		TimeManagerGlobe:Hide()
		StopwatchFrameBackgroundLeft:Hide()
		select(2, StopwatchFrame:GetRegions()):Hide()
		StopwatchTabFrameLeft:Hide()
		StopwatchTabFrameMiddle:Hide()
		StopwatchTabFrameRight:Hide()

		TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
		TimeManagerStopwatchCheck:SetCheckedTexture(media.checked)
		S.CreateBG(TimeManagerStopwatchCheck)

		TimeManagerAlarmHourDropDown:SetWidth(80)
		TimeManagerAlarmMinuteDropDown:SetWidth(80)
		TimeManagerAlarmAMPMDropDown:SetWidth(90)

		S.ReskinPortraitFrame(TimeManagerFrame, true)
		S.CreateBD(StopwatchFrame)
		S.ReskinDropDown(TimeManagerAlarmHourDropDown)
		S.ReskinDropDown(TimeManagerAlarmMinuteDropDown)
		S.ReskinDropDown(TimeManagerAlarmAMPMDropDown)
		S.ReskinInput(TimeManagerAlarmMessageEditBox)
		S.ReskinCheck(TimeManagerAlarmEnabledButton)
		S.ReskinCheck(TimeManagerMilitaryTimeCheck)
		S.ReskinCheck(TimeManagerLocalTimeCheck)
		S.ReskinClose(StopwatchCloseButton, "TOPRIGHT", StopwatchFrame, "TOPRIGHT", -2, -2)
	elseif addon == "Blizzard_TradeSkillUI" then
		S.CreateBD(TradeSkillFrame)
		S.CreateSD(TradeSkillFrame)
		S.CreateBD(TradeSkillGuildFrame)
		S.CreateSD(TradeSkillGuildFrame)
		S.CreateBD(TradeSkillGuildFrameContainer, .25)

		TradeSkillFrame:DisableDrawLayer("BORDER")
		TradeSkillFrameInset:DisableDrawLayer("BORDER")
		TradeSkillFramePortrait:Hide()
		TradeSkillFramePortrait.Show = function() end
		for i = 18, 20 do
			select(i, TradeSkillFrame:GetRegions()):Hide()
			select(i, TradeSkillFrame:GetRegions()).Show = function() end
		end
		TradeSkillHorizontalBarLeft:Hide()
		select(22, TradeSkillFrame:GetRegions()):Hide()
		for i = 1, 3 do
			select(i, TradeSkillExpandButtonFrame:GetRegions()):SetAlpha(0)
			select(i, TradeSkillFilterButton:GetRegions()):Hide()
		end
		for i = 1, 9 do
			select(i, TradeSkillGuildFrame:GetRegions()):Hide()
		end
		TradeSkillListScrollFrame:GetRegions():Hide()
		select(2, TradeSkillListScrollFrame:GetRegions()):Hide()
		TradeSkillDetailHeaderLeft:Hide()
		select(6, TradeSkillDetailScrollChildFrame:GetRegions()):Hide()
		TradeSkillDetailScrollFrameTop:SetAlpha(0)
		TradeSkillDetailScrollFrameBottom:SetAlpha(0)
		TradeSkillFrameBg:Hide()
		TradeSkillFrameInsetBg:Hide()
		TradeSkillFrameTitleBg:Hide()
		TradeSkillFramePortraitFrame:Hide()
		TradeSkillFrameTopBorder:Hide()
		TradeSkillFrameTopRightCorner:Hide()
		TradeSkillGuildCraftersFrameTrack:Hide()
		TradeSkillRankFrameBorder:Hide()
		TradeSkillRankFrameBackground:Hide()

		TradeSkillDetailScrollFrame:SetHeight(176)

		local a1, p, a2, x, y = TradeSkillGuildFrame:GetPoint()
		TradeSkillGuildFrame:ClearAllPoints()
		TradeSkillGuildFrame:SetPoint(a1, p, a2, x + 16, y)

		TradeSkillLinkButton:Point("LEFT", 0, -1)

		S.Reskin(TradeSkillCreateButton)
		S.Reskin(TradeSkillCreateAllButton)
		S.Reskin(TradeSkillCancelButton)
		S.Reskin(TradeSkillViewGuildCraftersButton)
		S.Reskin(TradeSkillFilterButton)

		TradeSkillRankFrame:SetStatusBarTexture(DB.Statusbar)
		TradeSkillRankFrame.SetStatusBarColor = function() end
		TradeSkillRankFrame:GetStatusBarTexture():SetGradient("VERTICAL", .1, .3, .9, .2, .4, 1)

		local bg = CreateFrame("Frame", nil, TradeSkillRankFrame)
		bg:Point("TOPLEFT", -1, 1)
		bg:Point("BOTTOMRIGHT", 1, -1)
		bg:SetFrameLevel(TradeSkillRankFrame:GetFrameLevel()-1)
		S.CreateBD(bg, .25)

		for i = 1, MAX_TRADE_SKILL_REAGENTS do
			local bu = _G["TradeSkillReagent"..i]
			local ic = _G["TradeSkillReagent"..i.."IconTexture"]

			_G["TradeSkillReagent"..i.."NameFrame"]:SetAlpha(0)

			ic:SetTexCoord(.08, .92, .08, .92)
			ic:SetDrawLayer("ARTWORK")
			S.CreateBG(ic)

			local bd = CreateFrame("Frame", nil, bu)
			bd:Point("TOPLEFT", 39, -1)
			bd:Point("BOTTOMRIGHT", 0, 1)
			bd:SetFrameLevel(0)
			S.CreateBD(bd, .25)

			_G["TradeSkillReagent"..i.."Name"]:SetParent(bd)
		end

		hooksecurefunc("TradeSkillFrame_SetSelection", function()
			local ic = TradeSkillSkillIcon:GetNormalTexture()
			if ic then
				ic:SetTexCoord(.08, .92, .08, .92)
				ic:Point("TOPLEFT", 1, -1)
				ic:Point("BOTTOMRIGHT", -1, 1)
				S.CreateBD(TradeSkillSkillIcon)
			else
				TradeSkillSkillIcon:SetBackdrop(nil)
			end
		end)

		local all = TradeSkillCollapseAllButton
		all:SetNormalTexture("")
		all.SetNormalTexture = function() end
		all:SetHighlightTexture("")
		all:SetPushedTexture("")

		all.bg = CreateFrame("Frame", nil, all)
		all.bg:Size(13, 13)
		all.bg:Point("LEFT", 4, 0)
		all.bg:SetFrameLevel(all:GetFrameLevel()-1)
		S.CreateBD(all.bg, 0)

		all.tex = all:CreateTexture(nil, "BACKGROUND")
		all.tex:SetAllPoints(all.bg)
		all.tex:SetTexture(media.backdrop)
		all.tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

		all.minus = all:CreateTexture(nil, "OVERLAY")
		all.minus:Size(7, 1)
		all.minus:SetPoint("CENTER", all.bg)
		all.minus:SetTexture(media.backdrop)
		all.minus:SetVertexColor(1, 1, 1)

		all.plus = all:CreateTexture(nil, "OVERLAY")
		all.plus:Size(1, 7)
		all.plus:SetPoint("CENTER", all.bg)
		all.plus:SetTexture(media.backdrop)
		all.plus:SetVertexColor(1, 1, 1)

		hooksecurefunc("TradeSkillFrame_Update", function()
			local numTradeSkills = GetNumTradeSkills()
			local skillOffset = FauxScrollFrame_GetOffset(TradeSkillListScrollFrame)
			local skillIndex, skillButton
			local buttonHighlight
			local diplayedSkills = TRADE_SKILLS_DISPLAYED
			local hasFilterBar = TradeSkillFilterBar:IsShown()
			if  hasFilterBar then
				diplayedSkills = TRADE_SKILLS_DISPLAYED - 1
			end
			local buttonIndex = 0

			for i = 1, diplayedSkills do
				skillIndex = i + skillOffset
				_, skillType, _, isExpanded = GetTradeSkillInfo(skillIndex)
				if hasFilterBar then
					buttonIndex = i + 1
				else
					buttonIndex = i
				end

				local skillButton = _G["TradeSkillSkill"..buttonIndex]

				if not skillButton.reskinned then
					skillButton.reskinned = true

					skillButton:SetNormalTexture("")
					skillButton.SetNormalTexture = function() end
					skillButton:SetPushedTexture("")
					local buttonHighlight = _G["TradeSkillSkill"..buttonIndex.."Highlight"]
					buttonHighlight:SetTexture("")
					buttonHighlight.SetTexture = function() end

					skillButton.bg = CreateFrame("Frame", nil, skillButton)
					skillButton.bg:Size(13, 13)
					skillButton.bg:Point("LEFT", 4, 0)
					skillButton.bg:SetFrameLevel(skillButton:GetFrameLevel()-1)
					S.CreateBD(skillButton.bg, 0)

					skillButton.tex = skillButton:CreateTexture(nil, "BACKGROUND")
					skillButton.tex:SetAllPoints(skillButton.bg)
					skillButton.tex:SetTexture(media.backdrop)
					skillButton.tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

					skillButton.minus = skillButton:CreateTexture(nil, "OVERLAY")
					skillButton.minus:Size(7, 1)
					skillButton.minus:SetPoint("CENTER", skillButton.bg)
					skillButton.minus:SetTexture(media.backdrop)
					skillButton.minus:SetVertexColor(1, 1, 1)

					skillButton.plus = skillButton:CreateTexture(nil, "OVERLAY")
					skillButton.plus:Size(1, 7)
					skillButton.plus:SetPoint("CENTER", skillButton.bg)
					skillButton.plus:SetTexture(media.backdrop)
					skillButton.plus:SetVertexColor(1, 1, 1)
					
					skillButton.SubSkillRankBar.BorderLeft:Hide()
					skillButton.SubSkillRankBar.BorderRight:Hide()
					skillButton.SubSkillRankBar.BorderMid:Hide()

					skillButton.SubSkillRankBar:SetHeight(12)
					skillButton.SubSkillRankBar:SetStatusBarTexture(media.backdrop)
					skillButton.SubSkillRankBar:GetStatusBarTexture():SetGradient("VERTICAL", .1, .3, .9, .2, .4, 1)
					S.CreateBDFrame(skillButton.SubSkillRankBar, .25)

				end

				if skillIndex <= numTradeSkills then
					if skillType == "header" then
						skillButton.bg:Show()
						skillButton.tex:Show()
						skillButton.minus:Show()
						if isExpanded then
							skillButton.plus:Hide()
						else
							skillButton.plus:Show()
						end
					else
						skillButton.bg:Hide()
						skillButton.tex:Hide()
						skillButton.minus:Hide()
						skillButton.plus:Hide()
					end
				end

				if TradeSkillCollapseAllButton.collapsed == 1 then
					TradeSkillCollapseAllButton.plus:Show()
				else
					TradeSkillCollapseAllButton.plus:Hide()
				end
			end
		end)

		TradeSkillCollapseAllButton:SetDisabledTexture("")

		TradeSkillIncrementButton:Point("RIGHT", TradeSkillCreateButton, "LEFT", -9, 0)

		S.ReskinClose(TradeSkillFrameCloseButton)
		S.ReskinClose(TradeSkillGuildFrameCloseButton)
		S.ReskinScroll(TradeSkillDetailScrollFrameScrollBar)
		S.ReskinScroll(TradeSkillListScrollFrameScrollBar)
		S.ReskinScroll(TradeSkillGuildCraftersFrameScrollBar)
		S.ReskinInput(TradeSkillInputBox, nil, 33)
		S.ReskinInput(TradeSkillFrameSearchBox)
		S.ReskinArrow(TradeSkillDecrementButton, "left")
		S.ReskinArrow(TradeSkillIncrementButton, "right")
		S.ReskinArrow(TradeSkillLinkButton, "right")
	elseif addon == "Blizzard_TrainerUI" then
		ClassTrainerFrameBottomInset:DisableDrawLayer("BORDER")
		ClassTrainerFrame.BG:Hide()
		ClassTrainerFrameBottomInsetBg:Hide()
		ClassTrainerFrameMoneyBg:SetAlpha(0)

		ClassTrainerStatusBarSkillRank:ClearAllPoints()
		ClassTrainerStatusBarSkillRank:SetPoint("CENTER", ClassTrainerStatusBar, "CENTER", 0, 0)

		local bg = CreateFrame("Frame", nil, ClassTrainerFrameSkillStepButton)
		bg:Point("TOPLEFT", 42, -2)
		bg:Point("BOTTOMRIGHT", 0, 2)
		bg:SetFrameLevel(ClassTrainerFrameSkillStepButton:GetFrameLevel()-1)
		S.CreateBD(bg, .25)

		ClassTrainerFrameSkillStepButton:SetNormalTexture("")
		ClassTrainerFrameSkillStepButton:SetHighlightTexture("")
		ClassTrainerFrameSkillStepButton.disabledBG:SetTexture("")

		ClassTrainerFrameSkillStepButton.selectedTex:Point("TOPLEFT", 43, -3)
		ClassTrainerFrameSkillStepButton.selectedTex:Point("BOTTOMRIGHT", -1, 3)
		ClassTrainerFrameSkillStepButton.selectedTex:SetTexture(media.backdrop)
		ClassTrainerFrameSkillStepButton.selectedTex:SetVertexColor(r, g, b, .2)

		local icbg = CreateFrame("Frame", nil, ClassTrainerFrameSkillStepButton)
		icbg:Point("TOPLEFT", ClassTrainerFrameSkillStepButtonIcon, -1, 1)
		icbg:Point("BOTTOMRIGHT", ClassTrainerFrameSkillStepButtonIcon, 1, -1)
		S.CreateBD(icbg, 0)

		ClassTrainerFrameSkillStepButtonIcon:SetTexCoord(.08, .92, .08, .92)

		for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED do
			local bu = _G["ClassTrainerScrollFrameButton"..i]

			local bg = CreateFrame("Frame", nil, bu)
			bg:Point("TOPLEFT", 42, -6)
			bg:Point("BOTTOMRIGHT", 0, 6)
			bg:SetFrameLevel(bu:GetFrameLevel()-1)
			S.CreateBD(bg, .25)

			bu.name:SetParent(bg)
			bu.name:Point("TOPLEFT", bu.icon, "TOPRIGHT", 6, -2)
			bu.subText:SetParent(bg)
			bu.money:SetParent(bg)
			bu.money:Point("TOPRIGHT", bu, "TOPRIGHT", 5, -8)
			bu:SetNormalTexture("")
			bu:SetHighlightTexture("")
			bu.disabledBG:Hide()
			bu.disabledBG.Show = function() end

			bu.selectedTex:Point("TOPLEFT", 43, -6)
			bu.selectedTex:Point("BOTTOMRIGHT", -1, 7)
			bu.selectedTex:SetTexture(media.backdrop)
			bu.selectedTex:SetVertexColor(r, g, b, .2)

			bu.icon:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(bu.icon)
		end

		ClassTrainerStatusBarLeft:Hide()
		ClassTrainerStatusBarMiddle:Hide()
		ClassTrainerStatusBarRight:Hide()
		ClassTrainerStatusBarBackground:Hide()
		ClassTrainerStatusBar:Point("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 64, -35)
		ClassTrainerStatusBar:SetStatusBarTexture(DB.Statusbar)

		ClassTrainerStatusBar:GetStatusBarTexture():SetGradient("VERTICAL", .1, .3, .9, .2, .4, 1)

		local bd = CreateFrame("Frame", nil, ClassTrainerStatusBar)
		bd:Point("TOPLEFT", -1, 1)
		bd:Point("BOTTOMRIGHT", 1, -1)
		bd:SetFrameLevel(ClassTrainerStatusBar:GetFrameLevel()-1)
		S.CreateBD(bd, .25)

		S.ReskinPortraitFrame(ClassTrainerFrame, true)
		S.Reskin(ClassTrainerTrainButton)
		S.ReskinScroll(ClassTrainerScrollFrameScrollBar)
		S.ReskinDropDown(ClassTrainerFrameFilterDropDown)
	elseif addon == "Blizzard_VoidStorageUI" then
		S.SetBD(VoidStorageFrame, 20, 0, 0, 20)
		S.CreateBD(VoidStoragePurchaseFrame)

		VoidStorageBorderFrame:DisableDrawLayer("BORDER")
		VoidStorageBorderFrame:DisableDrawLayer("BACKGROUND")
		VoidStorageBorderFrame:DisableDrawLayer("OVERLAY")
		VoidStorageDepositFrame:DisableDrawLayer("BACKGROUND")
		VoidStorageDepositFrame:DisableDrawLayer("BORDER")
		VoidStorageWithdrawFrame:DisableDrawLayer("BACKGROUND")
		VoidStorageWithdrawFrame:DisableDrawLayer("BORDER")
		VoidStorageCostFrame:DisableDrawLayer("BACKGROUND")
		VoidStorageCostFrame:DisableDrawLayer("BORDER")
		VoidStorageStorageFrame:DisableDrawLayer("BACKGROUND")
		VoidStorageStorageFrame:DisableDrawLayer("BORDER")
		VoidStorageFrameMarbleBg:Hide()
		select(2, VoidStorageFrame:GetRegions()):Hide()
		VoidStorageFrameLines:Hide()
		VoidStorageStorageFrameLine1:Hide()
		VoidStorageStorageFrameLine2:Hide()
		VoidStorageStorageFrameLine3:Hide()
		VoidStorageStorageFrameLine4:Hide()
		select(12, VoidStorageDepositFrame:GetRegions()):Hide()
		select(12, VoidStorageWithdrawFrame:GetRegions()):Hide()
		for i = 1, 10 do
			select(i, VoidStoragePurchaseFrame:GetRegions()):Hide()
		end

		for i = 1, 9 do
			local bu1 = _G["VoidStorageDepositButton"..i]
			local bu2 = _G["VoidStorageWithdrawButton"..i]

			bu1:SetPushedTexture("")
			bu2:SetPushedTexture("")

			_G["VoidStorageDepositButton"..i.."Bg"]:Hide()
			_G["VoidStorageWithdrawButton"..i.."Bg"]:Hide()

			_G["VoidStorageDepositButton"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)
			_G["VoidStorageWithdrawButton"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)

			local bg1 = CreateFrame("Frame", nil, bu1)
			bg1:Point("TOPLEFT", -1, 1)
			bg1:Point("BOTTOMRIGHT", 1, -1)
			bg1:SetFrameLevel(bu1:GetFrameLevel()-1)
			S.CreateBD(bg1, .25)

			local bg2 = CreateFrame("Frame", nil, bu2)
			bg2:Point("TOPLEFT", -1, 1)
			bg2:Point("BOTTOMRIGHT", 1, -1)
			bg2:SetFrameLevel(bu2:GetFrameLevel()-1)
			S.CreateBD(bg2, .25)
		end

		for i = 1, 80 do
			local bu = _G["VoidStorageStorageButton"..i]

			bu:SetPushedTexture("")

			_G["VoidStorageStorageButton"..i.."Bg"]:Hide()
			_G["VoidStorageStorageButton"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)
		end

		hooksecurefunc("VoidStorage_ItemsFilteredUpdate", function()
			local button, isFiltered, _
			for i = 1, 80 do
				_, _, _, _, isFiltered = GetVoidItemInfo(i)
				button = _G["VoidStorageStorageButton"..i]

				if isFiltered then
					button.glow:SetAlpha(0)
				else
					button.glow:SetAlpha(1)
				end
			end
		end)

		S.Reskin(VoidStoragePurchaseButton)
		S.Reskin(VoidStorageHelpBoxButton)
		S.Reskin(VoidStorageTransferButton)
		S.ReskinClose(VoidStorageBorderFrame:GetChildren(), nil)
		S.ReskinInput(VoidItemSearchBox)
	elseif addon == "DBM-Core" then
	--[[ 	local first = true
		hooksecurefunc(DBM.RangeCheck, "Show", function()
			if first == true then
				DBMRangeCheck:SetBackdrop(nil)
				local bd = CreateFrame("Frame", nil, DBMRangeCheck)
				bd:SetPoint("TOPLEFT")
				bd:SetPoint("BOTTOMRIGHT")
				bd:SetFrameLevel(DBMRangeCheck:GetFrameLevel()-1)
				S.CreateBD(bd)
				first = false
			end
		end) ]]
	elseif addon == "Recount" then
	--[[ 	if IsAddOnLoaded("CowTip") or IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("lolTip") or IsAddOnLoaded("StarTip") or IsAddOnLoaded("TipTop") then return end

		hooksecurefunc(LibStub("LibDropdown-1.0"), "OpenAce3Menu", function()
			S.CreateBD(LibDropdownFrame0, alpha)
		end) ]]
	end
	--RaidFrame Skin
		-- for i = 1, 8 do
			-- if _G["RaidGroup"..i] then 
				-- _G["RaidGroup"..i]:StripTextures()
			-- else
				-- return
			-- end
			-- for f = 1, 5 do
				-- if _G["RaidGroup"..i.."Slot"..f] then 
					-- _G["RaidGroup"..i.."Slot"..f]:Kill()
				-- else
					-- return
				-- end
			-- end
		-- end
		-- for i = 1, 40 do
			-- if _G["RaidGroupButton"..i] then
				-- _G["RaidGroupButton"..i]:StripTextures()
				-- S.Reskin(_G["RaidGroupButton"..i])
			-- else
				-- return
			-- end
		-- end
end)

local Delay = CreateFrame("Frame")
Delay:RegisterEvent("PLAYER_ENTERING_WORLD")
Delay:SetScript("OnEvent", function()
	Delay:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if not(IsAddOnLoaded("CowTip") or IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("lolTip") or IsAddOnLoaded("StarTip") or IsAddOnLoaded("TipTop")) then
		local tooltips = {
			"GameTooltip",
			"ItemRefTooltip",
			"ShoppingTooltip1",
			"ShoppingTooltip2",
			"ShoppingTooltip3",
			"WorldMapTooltip",
			"ChatMenu",
			"EmoteMenu",
			"LanguageMenu",
			"VoiceMacroMenu",
		}

		local backdrop = {
			bgFile = media.backdrop,
			edgeFile = media.backdrop,
			edgeSize = S.mult,
		}

		-- so other stuff which tries to look like GameTooltip doesn't mess up
		local getBackdrop = function()
			return backdrop
		end

		local getBackdropColor = function()
			return 0, 0, 0, .6
		end

		local getBackdropBorderColor = function()
			return 0, 0, 0
		end

		for i = 1, #tooltips do
			local t = _G[tooltips[i]]
			t:SetBackdrop(nil)
			local bg = CreateFrame("Frame", nil, t)
			bg:SetPoint("TOPLEFT")
			bg:SetPoint("BOTTOMRIGHT")
			bg:SetFrameLevel(t:GetFrameLevel()-1)
			bg:SetBackdrop(backdrop)
			bg:SetBackdropColor(0, 0, 0, .6)
			bg:SetBackdropBorderColor(0, 0, 0)

			t.GetBackdrop = getBackdrop
			t.GetBackdropColor = getBackdropColor
			t.GetBackdropBorderColor = getBackdropBorderColor
		end

		local sb = _G["GameTooltipStatusBar"]
		sb:Height(6)
		sb:ClearAllPoints()
		sb:Point("BOTTOMLEFT", GameTooltip, "TOPLEFT", 1, 3)
		sb:Point("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -1, 3)
		sb:SetStatusBarTexture(DB.Statusbar)
		S.CreateBD(FriendsTooltip)
		S.CreateMark(sb)
		-- pet battle stuff

		local tooltips = {PetBattlePrimaryAbilityTooltip, PetBattlePrimaryUnitTooltip, FloatingBattlePetTooltip, BattlePetTooltip, FloatingPetBattleAbilityTooltip}
		for _, f in pairs(tooltips) do
			f:DisableDrawLayer("BACKGROUND")
			local bg = CreateFrame("Frame", nil, f)
			bg:SetAllPoints()
			bg:SetFrameLevel(0)
			S.CreateBD(bg)
		end

		PetBattlePrimaryUnitTooltip.Delimiter:SetTexture(0, 0, 0)
		PetBattlePrimaryUnitTooltip.Delimiter:SetHeight(1)
		PetBattlePrimaryAbilityTooltip.Delimiter1:SetHeight(1)
		PetBattlePrimaryAbilityTooltip.Delimiter1:SetTexture(0, 0, 0)
		PetBattlePrimaryAbilityTooltip.Delimiter2:SetHeight(1)
		PetBattlePrimaryAbilityTooltip.Delimiter2:SetTexture(0, 0, 0)
		FloatingPetBattleAbilityTooltip.Delimiter1:SetHeight(1)
		FloatingPetBattleAbilityTooltip.Delimiter1:SetTexture(0, 0, 0)
		FloatingPetBattleAbilityTooltip.Delimiter2:SetHeight(1)
		FloatingPetBattleAbilityTooltip.Delimiter2:SetTexture(0, 0, 0)
		FloatingBattlePetTooltip.Delimiter:SetTexture(0, 0, 0)
		FloatingBattlePetTooltip.Delimiter:SetHeight(1)
		S.ReskinClose(FloatingBattlePetTooltip.CloseButton)
		S.ReskinClose(FloatingPetBattleAbilityTooltip.CloseButton)
		
	end
--[[ 
	if not(IsAddOnLoaded("MetaMap") or IsAddOnLoaded("m_Map") or IsAddOnLoaded("Mapster") or IsAddOnLoaded("SunUI")) then
		WorldMapFrameMiniBorderLeft:SetAlpha(0)
		WorldMapFrameMiniBorderRight:SetAlpha(0)

		local scale = WORLDMAP_WINDOWED_SIZE
		local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
		mapbg:Point("TOPLEFT", -1 / scale, 1 / scale)
		mapbg:Point("BOTTOMRIGHT", 1 / scale, -1 / scale)
		mapbg:SetFrameLevel(0)
		mapbg:SetBackdrop({
			bgFile = media.backdrop,
		})
		mapbg:SetBackdropColor(0, 0, 0)

		local frame = CreateFrame("Frame",nil,WorldMapButton)
		frame:SetFrameStrata("HIGH")

		local function skinmap()
			WorldMapFrameMiniBorderLeft:SetAlpha(0)
			WorldMapFrameMiniBorderRight:SetAlpha(0)
			WorldMapFrameCloseButton:ClearAllPoints()
			WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, 3)
			WorldMapFrameCloseButton:SetFrameStrata("HIGH")
			WorldMapFrameSizeUpButton:ClearAllPoints()
			WorldMapFrameSizeUpButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, -18)
			WorldMapFrameSizeUpButton:SetFrameStrata("HIGH")
			WorldMapFrameTitle:ClearAllPoints()
			WorldMapFrameTitle:Point("BOTTOMLEFT", WorldMapDetailFrame, 9, 5)
			WorldMapFrameTitle:SetParent(frame)
			WorldMapFrameTitle:SetTextColor(1, 1, 1)
			WorldMapQuestShowObjectives:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT")
			WorldMapQuestShowObjectives.SetPoint = function() end
			WorldMapQuestShowObjectives:SetFrameStrata("HIGH")
			WorldMapQuestShowObjectivesText:ClearAllPoints()
			WorldMapQuestShowObjectivesText:Point("RIGHT", WorldMapQuestShowObjectives, "LEFT", -4, 1)
			WorldMapQuestShowObjectivesText:SetTextColor(1, 1, 1)
			WorldMapTrackQuest:SetParent(frame)
			WorldMapTrackQuest:ClearAllPoints()
			WorldMapTrackQuest:Point("TOPLEFT", WorldMapDetailFrame, 9, -5)
			WorldMapTrackQuestText:SetTextColor(1, 1, 1)
			WorldMapShowDigSites:SetFrameStrata("HIGH")
			WorldMapShowDigSites:ClearAllPoints()
			WorldMapShowDigSites:Point("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 19)
			WorldMapShowDigSitesText:ClearAllPoints()
			WorldMapShowDigSitesText:Point("RIGHT", WorldMapShowDigSites, "LEFT", -4, 1)
			WorldMapShowDigSitesText:SetTextColor(1, 1, 1)
			WorldMapFrameTitle:SetFont(DB.Font, 12 / scale, "THINOUTLINE")
			WorldMapFrameTitle:SetShadowOffset(0, 0)
			WorldMapQuestShowObjectivesText:SetFont(DB.Font, 12, "OUTLINE")
			WorldMapQuestShowObjectivesText:SetShadowOffset(0, 0)
			WorldMapTrackQuestText:SetFont(DB.Font, 12 / scale, "OUTLINE")
			WorldMapTrackQuestText:SetShadowOffset(0, 0)
			WorldMapShowDigSitesText:SetFont(DB.Font, 12, "OUTLINE")
			WorldMapShowDigSitesText:SetShadowOffset(0, 0)
		end

		skinmap()
		hooksecurefunc("WorldMap_ToggleSizeDown", skinmap)

		S.ReskinDropDown(WorldMapLevelDropDown)
		S.ReskinCheck(WorldMapShowDigSites)
		S.ReskinCheck(WorldMapQuestShowObjectives)
		S.ReskinCheck(WorldMapTrackQuest)
	end

	if not(IsAddOnLoaded("Baggins") or IsAddOnLoaded("Stuffing") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("famBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("Bagnon")) then
		BackpackTokenFrame:GetRegions():Hide()

		for i = 1, 12 do
			local con = _G["ContainerFrame"..i]

			for j = 1, 7 do
				select(j, con:GetRegions()):SetAlpha(0)
			end

			for k = 1, MAX_CONTAINER_ITEMS do
				local item = "ContainerFrame"..i.."Item"..k
				local button = _G[item]
				local icon = _G[item.."IconTexture"]

				_G[item.."IconQuestTexture"]:SetAlpha(0)

				button:SetNormalTexture("")
				button:SetPushedTexture("")

				icon:Point("TOPLEFT", 1, -1)
				icon:Point("BOTTOMRIGHT", -1, 1)
				icon:SetTexCoord(.08, .92, .08, .92)

				S.CreateBD(button, 0)
			end

			local f = CreateFrame("Frame", nil, con)
			f:Point("TOPLEFT", 8, -4)
			f:Point("BOTTOMRIGHT", -4, 3)
			f:SetFrameLevel(con:GetFrameLevel()-1)
			S.CreateBD(f)

			S.ReskinClose(_G["ContainerFrame"..i.."CloseButton"], "TOPRIGHT", con, "TOPRIGHT", -6, -6)
		end

		for i = 1, 3 do
			local ic = _G["BackpackTokenFrameToken"..i.."Icon"]
			ic:SetDrawLayer("OVERLAY")
			ic:SetTexCoord(.08, .92, .08, .92)
			S.CreateBG(ic)
		end

		if not IsAddOnLoaded("oGlow") then
			hooksecurefunc("ContainerFrame_Update", function(frame)
				local name = frame:GetName()
				local bu
				for i = 1, frame.size do
					bu = _G[name.."Item"..i]
					if _G[name.."Item"..i.."IconQuestTexture"]:IsShown() then
						bu:SetBackdropBorderColor(1, 0, 0)
					else
						bu:SetBackdropBorderColor(0, 0, 0)
					end
				end
			end)

			hooksecurefunc("BankFrameItemButton_Update", function(bu)
				if not bu.isBag then
					if _G[bu:GetName().."IconQuestTexture"]:IsShown() then
						bu:SetBackdropBorderColor(1, 0, 0)
					else
						bu:SetBackdropBorderColor(0, 0, 0)
					end
				end
			end)
		end

		S.SetBD(BankFrame)
		BankFrame:DisableDrawLayer("BACKGROUND")
		BankFrame:DisableDrawLayer("BORDER")
		BankFrame:DisableDrawLayer("OVERLAY")
		BankPortraitTexture:Hide()
		BankFrameMoneyFrameInset:Hide()
		BankFrameMoneyFrameBorder:Hide()


		S.Reskin(BankFramePurchaseButton)
		S.ReskinClose(BankFrameCloseButton)

		for i = 1, 28 do
			local item = "BankFrameItem"..i
			local button = _G[item]
			local icon = _G[item.."IconTexture"]

			_G[item.."IconQuestTexture"]:SetAlpha(0)

			button:SetNormalTexture("")
			button:SetPushedTexture("")

			icon:Point("TOPLEFT", 1, -1)
			icon:Point("BOTTOMRIGHT", -1, 1)
			icon:SetTexCoord(.08, .92, .08, .92)

			S.CreateBD(button, 0)
		end

		for i = 1, 7 do
			local bag = _G["BankFrameBag"..i]
			local ic = _G["BankFrameBag"..i.."IconTexture"]
			_G["BankFrameBag"..i.."HighlightFrameTexture"]:SetTexture(media.checked)

			bag:SetNormalTexture("")
			bag:SetPushedTexture("")

			ic:Point("TOPLEFT", 1, -1)
			ic:Point("BOTTOMRIGHT", -1, 1)
			ic:SetTexCoord(.08, .92, .08, .92)

			S.CreateBD(bag, 0)
		end
	end

	if not(IsAddOnLoaded("Butsu") or IsAddOnLoaded("LovelyLoot") or IsAddOnLoaded("XLoot")) then
		LootFramePortraitOverlay:Hide()

		select(19, LootFrame:GetRegions()):Point("TOP", LootFrame, "TOP", 0, -7)
		hooksecurefunc("LootFrame_UpdateButton", function(index)
			local ic = _G["LootButton"..index.."IconTexture"]

			if not ic.bg then
				local bu = _G["LootButton"..index]

				_G["LootButton"..index.."IconQuestTexture"]:SetAlpha(0)
				_G["LootButton"..index.."NameFrame"]:Hide()

				bu:SetNormalTexture("")
				bu:SetPushedTexture("")

				local bd = CreateFrame("Frame", nil, bu)
				bd:SetPoint("TOPLEFT")
				bd:SetPoint("BOTTOMRIGHT", 114, 0)
				bd:SetFrameLevel(bu:GetFrameLevel()-1)
				S.CreateBD(bd, .25)

				ic:SetTexCoord(.08, .92, .08, .92)
				ic.bg = S.CreateBG(ic)
			end

			if select(6, GetLootSlotInfo(index)) then
				ic.bg:SetVertexColor(1, 0, 0)
			else
				ic.bg:SetVertexColor(0, 0, 0)
			end
		end)

		LootFrameDownButton:ClearAllPoints()
		LootFrameDownButton:SetPoint("BOTTOMRIGHT", -8, 6)
		LootFramePrev:ClearAllPoints()
		LootFramePrev:SetPoint("LEFT", LootFrameUpButton, "RIGHT", 4, 0)
		LootFrameNext:ClearAllPoints()
		LootFrameNext:SetPoint("RIGHT", LootFrameDownButton, "LEFT", -4, 0)

		S.ReskinPortraitFrame(LootFrame, true)
		S.ReskinArrow(LootFrameUpButton, "up")
		S.ReskinArrow(LootFrameDownButton, "down")
	end
	local chatBubbles = false
	if chatBubbles then
		local bubbleHook = CreateFrame("Frame")

		local function styleBubble(frame)
			for i = 1, frame:GetNumRegions() do
				local region = select(i, frame:GetRegions())
				if region:GetObjectType() == "Texture" then
					region:SetTexture(nil)
				end
			end

			frame:SetBackdrop({
				bgFile = media.backdrop,
				edgeFile = media.backdrop,
				edgeSize = UIParent:GetScale(),
			})
			frame:SetBackdropColor(0, 0, 0, .5)
			frame:SetBackdropBorderColor(0, 0, 0)
		end

		local function isChatBubble(frame)
			if frame:GetName() then return end
			if not frame:GetRegions() then return end
			return frame:GetRegions():GetTexture() == ("Interface\\Tooltips\\ChatBubble-Background")
		end

		local last = 0
		local numKids = 0

		bubbleHook:SetScript("OnUpdate", function(self, elapsed)
			last = last + elapsed
			if last > .1 then
				last = 0
				local newNumKids = WorldFrame:GetNumChildren()
				if newNumKids ~= numKids then
					for i=numKids + 1, newNumKids do
						local frame = select(i, WorldFrame:GetChildren())

						if isChatBubble(frame) then
							styleBubble(frame)
						end
					end
					numKids = newNumKids
				end
			end
		end)
	end ]]
end)