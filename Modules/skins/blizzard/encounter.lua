﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")

local function LoadSkin()
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
	EncounterJournalEncounterFrameInfoModelFrameShadow:Hide()
	EncounterJournalEncounterFrameInfoModelFrame.dungeonBG:Hide()
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

	A:SetBD(EncounterJournal)
	A:CreateBD(EncounterJournalSearchResults, .75)

	EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
	EncounterJournalEncounterFrameInfoBossTab:SetPoint("TOPRIGHT", EncounterJournalEncounterFrame, "TOPRIGHT", 75, 20)
	EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
	EncounterJournalEncounterFrameInfoLootTab:SetPoint("TOP", EncounterJournalEncounterFrameInfoBossTab, "BOTTOM", 0, -4)
	EncounterJournalEncounterFrameInfoModelTab:ClearAllPoints()
	EncounterJournalEncounterFrameInfoModelTab:SetPoint("TOP", EncounterJournalEncounterFrameInfoLootTab, "BOTTOM", 0, -4)

	local tabs = {EncounterJournalEncounterFrameInfoBossTab, EncounterJournalEncounterFrameInfoLootTab, EncounterJournalEncounterFrameInfoModelTab}
	for _, tab in pairs(tabs) do
		tab:SetScale(.75)

		tab:SetBackdrop({
			bgFile = A["media"].backdrop,
			edgeFile = A["media"].backdrop,
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
	bg:SetPoint("TOPLEFT", 4, -4)
	bg:SetPoint("BOTTOMRIGHT", -5, 3)
	A:CreateBD(bg, 0)

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
			A:CreateBD(bg, 0)

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

	A:CreateBDFrame(EncounterJournalEncounterFrameInfoModelFrame, .25)

	hooksecurefunc("EncounterJournal_DisplayInstance", function()
		local bossIndex = 1;
		local name, description, bossID, _, link = EJ_GetEncounterInfoByIndex(bossIndex)
		while bossID do
			local bossButton = _G["EncounterJournalBossButton"..bossIndex]

			if not bossButton.reskinned then
				bossButton.reskinned = true

				A:Reskin(bossButton, true)
				bossButton.text:SetTextColor(1, 1, 1)
				bossButton.text.SetTextColor = S.dummy
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

				header.flashAnim.Play = S.dummy

				header.description:SetTextColor(1, 1, 1)
				header.description:SetShadowOffset(1, -1)
				header.button.title:SetTextColor(1, 1, 1)
				header.button.title.SetTextColor = S.dummy
				header.button.expandedIcon:SetTextColor(1, 1, 1)
				header.button.expandedIcon.SetTextColor = S.dummy
				header.descriptionBG:SetAlpha(0)
				header.descriptionBGBottom:SetAlpha(0)

				A:Reskin(header.button, true)

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
				header.button.bg:SetTexture(A["media"].backdrop)
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
		A:CreateBG(item.icon)

		local bg = CreateFrame("Frame", nil, item)
		bg:SetPoint("TOPLEFT")
		bg:Point("BOTTOMRIGHT", 0, 1)
		bg:SetFrameStrata("BACKGROUND")
		A:CreateBD(bg, 0)

		local tex = item:CreateTexture(nil, "BACKGROUND")
		tex:SetPoint("TOPLEFT")
		tex:Point("BOTTOMRIGHT", -1, 2)
		tex:SetTexture(A["media"].backdrop)
		tex:SetVertexColor(0, 0, 0, .25)
	end

	hooksecurefunc("EncounterJournal_SearchUpdate", function()
		local results = EncounterJournal.searchResults.scrollFrame.buttons
		local result

		for i = 1, #results do
			results[i]:SetNormalTexture("")
		end
	end)

	A:Reskin(EncounterJournalNavBarHomeButton)
	A:Reskin(EncounterJournalInstanceSelectDungeonTab)
	A:Reskin(EncounterJournalInstanceSelectRaidTab)
	A:Reskin(EncounterJournalEncounterFrameInfoDifficulty)
	A:Reskin(EncounterJournalEncounterFrameInfoResetButton)
	A:Reskin(EncounterJournalEncounterFrameInfoLootScrollFrameFilterToggle)
	A:ReskinClose(EncounterJournalCloseButton)
	A:ReskinClose(EncounterJournalSearchResultsCloseButton)
	A:ReskinInput(EncounterJournalSearchBox)
	A:ReskinScroll(EncounterJournalInstanceSelectScrollFrameScrollBar)
	A:ReskinScroll(EncounterJournalEncounterFrameInstanceFrameLoreScrollFrameScrollBar)
	A:ReskinScroll(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar)
	A:ReskinScroll(EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar)
	A:ReskinScroll(EncounterJournalEncounterFrameInfoBossesScrollFrameScrollBar)
	A:ReskinScroll(EncounterJournalSearchResultsScrollFrameScrollBar)
end

A:RegisterSkin("Blizzard_EncounterJournal", LoadSkin)