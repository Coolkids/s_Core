local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")

local function LoadSkin()
	local r, g, b = RAID_CLASS_COLORS[S.myclass].r, RAID_CLASS_COLORS[S.myclass].g, RAID_CLASS_COLORS[S.myclass].b
	A:SetBD(AuctionFrame, 2, -10, 0, 10)
	A:CreateBD(AuctionProgressFrame)

	AuctionProgressBar:SetStatusBarTexture(A["media"].backdrop)
	local ABBD = CreateFrame("Frame", nil, AuctionProgressBar)
	ABBD:Point("TOPLEFT", -1, 1)
	ABBD:Point("BOTTOMRIGHT", 1, -1)
	ABBD:SetFrameLevel(AuctionProgressBar:GetFrameLevel()-1)
	A:CreateBD(ABBD, .25)

	AuctionProgressBarIcon:SetTexCoord(.08, .92, .08, .92)
	A:CreateBG(AuctionProgressBarIcon)

	AuctionProgressBarText:SetPoint("CENTER", 0, 1)

	A:ReskinClose(AuctionProgressFrameCancelButton, "LEFT", AuctionProgressBar, "RIGHT", 4, 0)
	select(14, AuctionProgressFrameCancelButton:GetRegions()):SetPoint("CENTER", 0, 2)

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
		A:CreateTab(_G["AuctionFrameTab"..i])
	end

	local abuttons = {
		"BrowseBidButton",
		"BrowseBuyoutButton",
		"BrowseCloseButton",
		"BrowseSearchButton",
		"BrowseResetButton",
		"BidBidButton",
		"BidBuyoutButton",
		"BidCloseButton",
		"AuctionsCloseButton",
		"AuctionsCancelAuctionButton",
		"AuctionsCreateAuctionButton",
		"AuctionsNumStacksMaxButton",
		"AuctionsStackSizeMaxButton"
	}
	for i = 1, #abuttons do
		local reskinbutton = _G[abuttons[i]]
		if reskinbutton then
			A:Reskin(reskinbutton)
		end
	end

	BrowseCloseButton:ClearAllPoints()
	BrowseCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameBrowse, "BOTTOMRIGHT", 66, 13)
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
	BrowseSearchButton:ClearAllPoints()
	BrowseSearchButton:SetPoint("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 25, -30)

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
			ic:SetTexCoord(.08, .92, .08, .92)

			A:CreateBG(it)

			_G["BrowseButton"..i.."Left"]:Hide()
			select(5, _G["BrowseButton"..i]:GetRegions()):Hide()
			_G["BrowseButton"..i.."Right"]:Hide()

			local bd = CreateFrame("Frame", nil, bu)
			bd:SetPoint("TOPLEFT")
			bd:Point("BOTTOMRIGHT", 0, 5)
			bd:SetFrameLevel(bu:GetFrameLevel()-1)
			A:CreateBD(bd, .25)

			bu:SetHighlightTexture(A["media"].backdrop)
			local hl = bu:GetHighlightTexture()
			hl:SetVertexColor(r, g, b, .2)
			hl:ClearAllPoints()
			hl:Point("TOPLEFT", 0, -1)
			hl:Point("BOTTOMRIGHT", -1, 6)

			it:StyleButton(true)
		end
	end

	for i = 1, NUM_BIDS_TO_DISPLAY do
		local bu = _G["BidButton"..i]
		local it = _G["BidButton"..i.."Item"]
		local ic = _G["BidButton"..i.."ItemIconTexture"]

		it:SetNormalTexture("")
		ic:SetTexCoord(.08, .92, .08, .92)

		A:CreateBG(it)

		_G["BidButton"..i.."Left"]:Hide()
		select(6, _G["BidButton"..i]:GetRegions()):Hide()
		_G["BidButton"..i.."Right"]:Hide()

		local bd = CreateFrame("Frame", nil, bu)
		bd:SetPoint("TOPLEFT")
		bd:Point("BOTTOMRIGHT", 0, 5)
		bd:SetFrameLevel(bu:GetFrameLevel()-1)
		A:CreateBD(bd, .25)

		bu:SetHighlightTexture(A["media"].backdrop)
		local hl = bu:GetHighlightTexture()
		hl:SetVertexColor(r, g, b, .2)
		hl:ClearAllPoints()
		hl:Point("TOPLEFT", 0, -1)
		hl:Point("BOTTOMRIGHT", -1, 6)

		it:StyleButton(true)
	end

	for i = 1, NUM_AUCTIONS_TO_DISPLAY do
		local bu = _G["AuctionsButton"..i]
		local it = _G["AuctionsButton"..i.."Item"]
		local ic = _G["AuctionsButton"..i.."ItemIconTexture"]

		it:SetNormalTexture("")
		ic:SetTexCoord(.08, .92, .08, .92)

		A:CreateBG(it)

		_G["AuctionsButton"..i.."Left"]:Hide()
		select(4, _G["AuctionsButton"..i]:GetRegions()):Hide()
		_G["AuctionsButton"..i.."Right"]:Hide()

		local bd = CreateFrame("Frame", nil, bu)
		bd:SetPoint("TOPLEFT")
		bd:Point("BOTTOMRIGHT", 0, 5)
		bd:SetFrameLevel(bu:GetFrameLevel()-1)
		A:CreateBD(bd, .25)

		bu:SetHighlightTexture(A["media"].backdrop)
		local hl = bu:GetHighlightTexture()
		hl:SetVertexColor(r, g, b, .2)
		hl:ClearAllPoints()
		hl:Point("TOPLEFT", 0, -1)
		hl:Point("BOTTOMRIGHT", -1, 6)

		it:StyleButton(true)
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

	A:CreateBD(AuctionsItemButton, .25)
	local _, AuctionsItemButtonNameFrame = AuctionsItemButton:GetRegions()
	AuctionsItemButtonNameFrame:Hide()

	A:ReskinClose(AuctionFrameCloseButton, "TOPRIGHT", AuctionFrame, "TOPRIGHT", -4, -14)
	A:ReskinScroll(BrowseScrollFrameScrollBar)
	A:ReskinScroll(AuctionsScrollFrameScrollBar)
	A:ReskinScroll(BrowseFilterScrollFrameScrollBar)
	A:ReskinDropDown(PriceDropDown)
	A:ReskinDropDown(DurationDropDown)
	A:ReskinInput(BrowseName)
	A:ReskinArrow(BrowsePrevPageButton, "left")
	A:ReskinArrow(BrowseNextPageButton, "right")
	A:ReskinCheck(IsUsableCheckButton)
	A:ReskinCheck(ShowOnPlayerCheckButton)

	BrowsePrevPageButton:GetRegions():SetPoint("LEFT", BrowsePrevPageButton, "RIGHT", 2, 0)

	-- seriously, consistency
	BrowseDropDownLeft:SetAlpha(0)
	BrowseDropDownMiddle:SetAlpha(0)
	BrowseDropDownRight:SetAlpha(0)

	local a1, p, a2, x, y = BrowseDropDownButton:GetPoint()
	BrowseDropDownButton:SetPoint(a1, p, a2, x, y-4)
	BrowseDropDownButton:SetSize(16, 16)
	A:Reskin(BrowseDropDownButton)

	local downtex = BrowseDropDownButton:CreateTexture(nil, "OVERLAY")
	downtex:SetTexture("Interface\\AddOns\\SunUI\\media\\arrow-down-active")
	downtex:SetSize(8, 8)
	downtex:SetPoint("CENTER")
	downtex:SetVertexColor(1, 1, 1)

	local bg = CreateFrame("Frame", nil, BrowseDropDown)
	bg:SetPoint("TOPLEFT", 16, -5)
	bg:SetPoint("BOTTOMRIGHT", 109, 11)
	bg:SetFrameLevel(BrowseDropDown:GetFrameLevel(-1))
	A:CreateBD(bg, 0)
	A:CreateBackdropTexture(bg)

	local inputs = {
		"BrowseMinLevel",
		"BrowseMaxLevel",
		"BrowseBidPriceGold",
		"BrowseBidPriceSilver",
		"BrowseBidPriceCopper",
		"BidBidPriceGold",
		"BidBidPriceSilver",
		"BidBidPriceCopper",
		"StartPriceGold",
		"StartPriceSilver",
		"StartPriceCopper",
		"BuyoutPriceGold",
		"BuyoutPriceSilver",
		"BuyoutPriceCopper",
		"AuctionsStackSizeEntry",
		"AuctionsNumStacksEntry"
	}
	for i = 1, #inputs do
		A:ReskinInput(_G[inputs[i]])
	end

	BrowseMinLevel:SetPoint("TOPLEFT", BrowseLevelText, "BOTTOMLEFT", -7, -1)
	BrowseDropDown:SetPoint("TOPLEFT", BrowseLevelText, "BOTTOMRIGHT", 2, 4)
	BrowseNameText:ClearAllPoints()
	BrowseNameText:SetPoint("TOPLEFT", AuctionFrameBrowse, "TOPLEFT", 75, -44)
end

A:RegisterSkin("Blizzard_AuctionUI", LoadSkin)
