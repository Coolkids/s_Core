local S, L, DB, _, C = unpack(select(2, ...))
local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
local F = S
local C = DB
DB.AuroraModules["Blizzard_BarbershopUI"] = function()
	F.SetBD(BarberShopFrame, 44, -75, -40, 44)
	BarberShopFrameBackground:Hide()
	BarberShopFrameMoneyFrame:GetRegions():Hide()
	F.Reskin(BarberShopFrameOkayButton)
	F.Reskin(BarberShopFrameCancelButton)
	F.Reskin(BarberShopFrameResetButton)
	F.ReskinArrow(BarberShopFrameSelector1Prev, "left")
	F.ReskinArrow(BarberShopFrameSelector1Next, "right")
	F.ReskinArrow(BarberShopFrameSelector2Prev, "left")
	F.ReskinArrow(BarberShopFrameSelector2Next, "right")
	F.ReskinArrow(BarberShopFrameSelector3Prev, "left")
	F.ReskinArrow(BarberShopFrameSelector3Next, "right")
end