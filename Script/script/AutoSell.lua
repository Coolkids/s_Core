﻿local S, C, L, DB = unpack(select(2, ...))
local _
local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("AutoSell")

function Module:OnInitialize()
	C = C["MiniDB"]
	if C["AutoSell"] ~= true then return end
local Event = CreateFrame("Frame")
Event:RegisterEvent("MERCHANT_SHOW")
Event:SetScript("OnEvent", function(self)
local c = 0
	for b=0,4 do
		for s=1,GetContainerNumSlots(b) do
			local l = GetContainerItemLink(b, s)
			if l then
				local p = select(11, GetItemInfo(l))*select(2, GetContainerItemInfo(b, s))
				if select(3, GetItemInfo(l))==0 and p>0 then
					UseContainerItem(b, s)
					PickupMerchantItem()
					c = c+p
				end
			end
		end
	end
	if c>0 then
		local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
		DEFAULT_CHAT_FRAME:AddMessage("共售出："..format(GOLD_AMOUNT_TEXTURE, g, 0, 0).." "..format(SILVER_AMOUNT_TEXTURE, s, 0, 0).." "..format(COPPER_AMOUNT_TEXTURE, c, 0, 0),255,255,255)
	end
end)
end