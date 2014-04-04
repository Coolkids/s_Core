local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local AddOnName = ...

S.myclass            = select(2, UnitClass("player"))
if CUSTOM_CLASS_COLORS then
	S.myclasscolor = CUSTOM_CLASS_COLORS[S.myclass]
else
	S.myclasscolor = RAID_CLASS_COLORS[S.myclass]
end
S.myname             = UnitName("player")
S.myrealm            = GetRealmName()
S.version            = GetAddOnMetadata(AddOnName, "Version")
--BINDING_HEADER_RAYUI = GetAddOnMetadata(AddOnName, "Title")
--关于头像的颜色
--[[
RayUF.colors.power["MANA"] = {0, 0.8, 1}

RayUF["colors"].class = {
	["DEATHKNIGHT"] = { 0.77,	0.12,		0.23 },
	["DRUID"]       = { 1,		0.49,		0.04 },
	["HUNTER"]      = { 0.58,	0.86,		0.49 },
	["MAGE"]        = { 0.2,	0.76,		1 },
	["PALADIN"]     = { 1,		0.42,		0.62 },
	["PRIEST"]      = { 1,		1,			1 },
	["ROGUE"]       = { 1,		0.91,		0.3 },
	["SHAMAN"]      = { 0.16,	0.31,		0.61 },
	["WARLOCK"]     = { 0.6,	0.47,		0.85 },
	["WARRIOR"]     = { 0.9,	0.65,		0.45 },
	["MONK"]        = { 0,		1,			0.59 },
}

RayUF["colors"].reaction = {
	[1] = {1, 0.2, 0.2}, -- Hated
	[2] = {1, 0.2, 0.2}, -- Hostile
	[3] = {1, 0.6, 0.2}, -- Unfriendly
	[4] = {1, 1, 0.2}, -- Neutral
	[5] = {0.2, 1, 0.2}, -- Friendly
	[6] = {0.2, 1, 0.2}, -- Honored
	[7] = {0.2, 1, 0.2}, -- Revered
	[8] = {0.2, 1, 0.2}, -- Exalted
}

R.colors = {
	class = {},
}

for class, color in pairs(RayUF.colors.class) do
	R.colors.class[class] = { r = color[1], g = color[2], b = color[3] }
end
--]]