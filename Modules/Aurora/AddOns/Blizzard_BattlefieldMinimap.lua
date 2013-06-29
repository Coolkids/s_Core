local S, L, DB, _, C = unpack(select(2, ...))
local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
local F = S
local C = DB
DB.AuroraModules["Blizzard_BattlefieldMinimap"] = function()
		F.SetBD(BattlefieldMinimap, -1, 1, -5, 3)
		BattlefieldMinimapCorner:Hide()
		BattlefieldMinimapBackground:Hide()
		BattlefieldMinimapCloseButton:Hide()
end