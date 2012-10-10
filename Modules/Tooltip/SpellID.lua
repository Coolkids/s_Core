﻿local S, C, L, DB = unpack(select(2, ...))
local _
----------------------------------------------------------------------------------------
--	Spell/Item IDs(idTip by Silverwind)
----------------------------------------------------------------------------------------
local function addLine(self, id, isItem)
	if isItem then
		self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_ID.." "..id)
	else
		self:AddLine("|cff70C0F5"..L_TOOLTIP_SPELL_ID.." "..id)
	end
	self:Show()
end

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
	local id = select(11, UnitBuff(...))
	if id then addLine(self, id) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, ...)
	local id = select(11, UnitDebuff(...))
	if id then addLine(self, id) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
	local id = select(11, UnitAura(...))
	if id then addLine(self, id) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3, self:GetSpell())
	if id then addLine(self, id) end
end)

hooksecurefunc("SetItemRef", function(link, ...)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip, id) end
end)

local function attachItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"))
	if id then addLine(self, id, true) end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip3:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip3:HookScript("OnTooltipSetItem", attachItemTooltip)
--CastBy
local a, b, d = _G.GameTooltip.SetUnitAura, _G.GameTooltip.SetUnitBuff, _G.GameTooltip.SetUnitDebuff
local un, uc, uvsi, ua, uip, upc, sub = _G.UnitName, _G.UnitClass, _G.UnitVehicleSeatInfo, _G.UnitAura, _G.UnitIsPlayer, _G.UnitPlayerControlled, _G.string.sub
local co = setmetatable({}, {__index = function(t, cl)
	local c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[cl] or RAID_CLASS_COLORS[cl]
	if c then
		t[cl] = ("ff%02x%02x%02x"):format(c.r * 255, c.g * 255, c.b * 255)
	else
		t[cl] = "ffffffff"
	end
	return t[cl]
end})

local function h(o, ...)
	o(...)
	local _, uid, id, f = ...
	if o == b then
		f = "HELPFUL " .. (f or "")
	elseif o == d then
		f = "HARMFUL " .. (f or "")
	end
	local _, _, _, _, _, _, _, c = ua(uid, id, f)
	local cl, str
	if c then
		if not uip(c) and upc(c) then
			local n
			_, n = uvsi(c, 1)
			if n then
				_, cl = uc(n)
				str = ("|c%s%s|r"):format(co[cl], n)
				_, n = uvsi(c, 2)
				if n then
					_, cl = uc(n)
					str = str.." & "..("|c%s%s|r"):format(co[cl], n)
				end
			else
				local cl2, n2
				if c == "pet" then
					_, cl=uc(c);_, cl2 = uc("player");n, n2 = un(c), un("player")
				elseif sub(c, 1, 8) == "partypet" then
					id = sub(c, 9)
					_, cl = uc(c);_, cl2 = uc("party"..id);n, n2 = un(c), un("party"..id)
				elseif sub(c, 1, 7) == "raidpet" then
					id = sub(c, 8)
					_, cl = uc(c);_, cl2=uc("raid"..id);n, n2 = un(c), un("raid"..id)
				end
				if cl then
					str = ("|c%s%s|r (|c%s%s|r)"):format(co[cl], n,co[cl2], n2)
				else
					_, cl = uc(c)
					str = ("|c%s%s|r"):format(co[cl], un(c))
				end
			end
		else
			_, cl = uc(c)
			str = ("|c%s%s|r"):format(co[cl], un(c))
		end
	end
	if str then
		GameTooltip:AddDoubleLine(DONE_BY,str)
		GameTooltip:Show()
	end
end

GameTooltip.SetUnitAura = function( ... )
	h( a, ... )
end

GameTooltip.SetUnitBuff = function( ... )
	h( b, ... )
end

GameTooltip.SetUnitDebuff = function( ... )
	h( d, ... )
end