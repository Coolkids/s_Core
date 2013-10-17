local S, L, DB, _, C = unpack(select(2, ...))

local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
DB.AuroraModules["Blizzard_GuildBankUI"] = function()
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
	for i = 1, 2 do
		select(i, GuildBankTransactionsScrollFrame:GetRegions()):Hide()
		select(i, GuildBankInfoScrollFrame:GetRegions()):Hide()
	end

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
		S.ReskinTab(tab)

		if i ~= 1 then
			tab:SetPoint("LEFT", _G["GuildBankFrameTab"..i-1], "RIGHT", -15, 0)
		end
	end

	local bd = CreateFrame("Frame", nil, GuildBankPopupFrame)
	bd:SetPoint("TOPLEFT")
	bd:SetPoint("BOTTOMRIGHT", -28, 26)
	bd:SetFrameLevel(GuildBankPopupFrame:GetFrameLevel()-1)
	S.CreateBD(bd)
	S.CreateBD(GuildBankPopupEditBox, .25)

	GuildBankPopupFrame:SetPoint("TOPLEFT", GuildBankFrame, "TOPRIGHT", 2, -30)

	GuildBankFrameWithdrawButton:SetPoint("RIGHT", GuildBankFrameDepositButton, "LEFT", -1, 0)

	for i = 1, NUM_GUILDBANK_COLUMNS do
		_G["GuildBankColumn"..i]:GetRegions():Hide()
		for j = 1, NUM_SLOTS_PER_GUILDBANK_GROUP do
			local bu = _G["GuildBankColumn"..i.."Button"..j]
			bu:SetNormalTexture("")
			bu:SetPushedTexture("")

			bu.icon:SetTexCoord(.08, .92, .08, .92)
			bu.bg = S.CreateBG(bu)
		end
	end

	local function updateButtons()
		if GuildBankFrame.mode == "bank" then
			for i = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
				local index = mod(i, NUM_SLOTS_PER_GUILDBANK_GROUP)
				if index == 0 then
					index = NUM_SLOTS_PER_GUILDBANK_GROUP
				end

				local column = ceil((i-0.5)/NUM_SLOTS_PER_GUILDBANK_GROUP)

				local button = _G["GuildBankColumn"..column.."Button"..index]

				if button.icon:IsShown() then
					button.bg:Show()
				else
					button.bg:Hide()
				end
			end
		end
	end

	hooksecurefunc("GuildBankFrame_UpdateFiltered", updateButtons)
	hooksecurefunc("GuildBankFrame_Update", updateButtons)

	for i = 1, 8 do
		local tb = _G["GuildBankTab"..i]
		local bu = _G["GuildBankTab"..i.."Button"]
		local ic = _G["GuildBankTab"..i.."ButtonIconTexture"]
		local nt = _G["GuildBankTab"..i.."ButtonNormalTexture"]

		bu:SetCheckedTexture(DB.media.checked)
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

		bu:SetCheckedTexture(DB.media.checked)
		select(2, bu:GetRegions()):Hide()

		_G["GuildBankPopupButton"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)

		S.CreateBG(_G["GuildBankPopupButton"..i.."Icon"])
	end
end