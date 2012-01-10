local S, C, L, DB = unpack(select(2, ...))

local Delay = CreateFrame("Frame")
Delay:RegisterEvent("PLAYER_ENTERING_WORLD")
Delay:SetScript("OnEvent", function()
	Delay:UnregisterEvent("PLAYER_ENTERING_WORLD")
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
	if FriendsMenuXPSecure then
		StripTextures(FriendsMenuXPSecureMenuBackdrop)
		S.MakeBG(FriendsMenuXPSecure, 3)
	end
end)