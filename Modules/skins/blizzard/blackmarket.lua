﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")

local function LoadSkin()
	BlackMarketFrame:DisableDrawLayer("BACKGROUND")
	BlackMarketFrame:DisableDrawLayer("BORDER")
	BlackMarketFrame:DisableDrawLayer("OVERLAY")
	BlackMarketFrame.Inset:DisableDrawLayer("BORDER")
	select(9, BlackMarketFrame.Inset:GetRegions()):Hide()
	BlackMarketFrame.MoneyFrameBorder:Hide()
	BlackMarketFrame.HotDeal.Left:Hide()
	BlackMarketFrame.HotDeal.Right:Hide()
	select(4, BlackMarketFrame.HotDeal:GetRegions()):Hide()

	A:CreateBG(BlackMarketFrame.HotDeal.Item)
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
		A:CreateBD(bg, .25)
	end

	A:SetBD(BlackMarketFrame)
	A:CreateBD(BlackMarketFrame.HotDeal, .25)
	A:Reskin(BlackMarketFrame.BidButton)
	A:Reskin(BlackMarketFrame.HotDeal.BidButton)
	A:ReskinClose(BlackMarketFrame.CloseButton)
	A:ReskinInput(BlackMarketBidPriceGold)
	A:ReskinInput(BlackMarketHotItemBidPriceGold)
	A:ReskinScroll(BlackMarketScrollFrameScrollBar)

    local function UpdateBlackMarketList()
        local scrollFrame = BlackMarketScrollFrame
        local offset = HybridScrollFrame_GetOffset(scrollFrame)
		local buttons = scrollFrame.buttons
        local numButtons = #buttons

		for i = 1, numButtons do
            local index = i + offset
			local bu = buttons[i]

            bu.Item.IconTexture:SetTexCoord(.08, .92, .08, .92)
            if not bu.reskinned then
                bu.Left:Hide()
                bu.Right:Hide()
                select(3, bu:GetRegions()):Hide()

                bu.Item:SetNormalTexture("")
                A:CreateBG(bu.Item)

                local bg = CreateFrame("Frame", nil, bu)
                bg:SetPoint("TOPLEFT")
                bg:SetPoint("BOTTOMRIGHT", 0, 5)
                bg:SetFrameLevel(bu:GetFrameLevel()-1)
                A:CreateBD(bg, 0)

                local tex = bu:CreateTexture(nil, "BACKGROUND")
                tex:SetPoint("TOPLEFT")
                tex:SetPoint("BOTTOMRIGHT", 0, 5)
                tex:SetTexture(0, 0, 0, .25)

                bu:SetHighlightTexture(A["media"].backdrop)
                local hl = bu:GetHighlightTexture()
                hl:SetVertexColor(r, g, b, .2)
                hl.SetAlpha = S.dummy
                hl:ClearAllPoints()
                hl:Point("TOPLEFT", 0, -1)
                hl:Point("BOTTOMRIGHT", -1, 6)

                bu.Item:StyleButton(true)

                bu.reskinned = true
            end

            local link = select(15, C_BlackMarket.GetItemInfoByIndex(index))
            if link then
                local _, _, quality = GetItemInfo(link)
                local r, g, b = GetItemQualityColor(quality)
                bu.Name:SetTextColor(r, g, b)
            end
		end
    end
	hooksecurefunc(BlackMarketScrollFrame, "update", UpdateBlackMarketList)
	hooksecurefunc("BlackMarketScrollFrame_Update", UpdateBlackMarketList)

	hooksecurefunc("BlackMarketFrame_UpdateHotItem", function()
		local link = select(15, C_BlackMarket.GetHotItem())
		if link then
			local _, _, quality = GetItemInfo(link)
			local r, g, b = GetItemQualityColor(quality)
			BlackMarketFrame.HotDeal.Name:SetTextColor(r, g, b)
		end
	end)
end

A:RegisterSkin("Blizzard_BlackMarketUI", LoadSkin)
