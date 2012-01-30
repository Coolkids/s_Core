local S, C, L, DB = unpack(select(2, ...))

local Map = CreateFrame("Frame")
Map:RegisterEvent("PLAYER_ENTERING_WORLD")
Map:SetScript("OnEvent", function()
Map:UnregisterEvent("PLAYER_ENTERING_WORLD")
local function StripTextures(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Kill()
			else
				region:SetTexture(nil)
			end
		end
	end		
end
		StripTextures(WorldMapButton)
		S.MakeShadow(WorldMapFrame, 3)
		S.MakeBG(WorldMapFrame, 0)
end)