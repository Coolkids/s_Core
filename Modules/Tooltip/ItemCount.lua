﻿local S, L, DB, _, C = unpack(select(2, ...))
local _
----------------------------------------------------------------------------------------
--	Item count in tooltip(by Tukz)
----------------------------------------------------------------------------------------
GameTooltip:HookScript("OnTooltipCleared", function(self) self.UIItemTooltip = nil end)
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if UIItemTooltip and not self.UIItemTooltip and UIItemTooltip.count then
		local item, link = self:GetItem()
		local num = GetItemCount(link)
		local item_count = ""

		if UIItemTooltip.count and num > 1 then
			item_count = "|cffffffff"..L_TOOLTIP_ITEM_COUNT.." "..num
		end

		self:AddLine(item_count)
		self.UIItemTooltip = 1
	end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, name)
	if name ~= "ShestakUI" then return end
	f:UnregisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", nil)
	UIItemTooltip = UIItemTooltip or {count = true}
end)