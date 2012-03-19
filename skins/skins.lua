local S, C, L, DB = unpack(select(2, ...))
if DB.Nuke == true then return end
local Delay = CreateFrame("Frame")
Delay:RegisterEvent("PLAYER_ENTERING_WORLD")
Delay:SetScript("OnEvent", function()
	Delay:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	if FriendsMenuXPSecure then
		S.StripTextures(FriendsMenuXPSecureMenuBackdrop)
		FriendsMenuXPSecure:CreateShadow("Background")
	end
	
	if BaudErrorFrame then
		S.StripTextures(BaudErrorFrame)
		S.Reskin(BaudErrorFrameCloseButton)
		S.Reskin(BaudErrorFrameClearButton)
		--BaudErrorFrame:CreateShadow("Background") 
		S.SetBD(BaudErrorFrame)
	end
	
	if BuyEmAllFrame then
		S.StripTextures(BuyEmAllFrame)
		S.Reskin(BuyEmAllStackButton)
		S.Reskin(BuyEmAllMaxButton)
		S.Reskin(BuyEmAllOkayButton)
		S.Reskin(BuyEmAllCancelButton)
		S.SetBD(BuyEmAllFrame)
		--BuyEmAllFrame:CreateShadow("Background") 
	end
	
	if WorldMapFrame then
		S.StripTextures(WorldMapFrame, Kill)
		S.SetBD(WorldMapFrame,-S.mult,S.mult,S.mult,-S.mult)
	end
	
	if ChatBarFrameBackground then
		S.StripTextures(ChatBarFrame, Kill)
		S.StripTextures(ChatBarFrameBackground, Kill)
		ChatBarFrameBackground:CreateShadow("Background")
	end
	
	if DB.Nuke == true then
		for i = 1,20 do
			print("|cffFFD700SunUI��ʾ��: ��⵽������ʹ��|r|cff308014���|r|cffFFD700����|r|cff308014ħ��|r,|cffFFD700����|r|cffFF0000Nuke����|r,|cffFFD700Ϊ�������õ��������Բ��|r|cffFF0000���ҹر�|r.|cffFFD700����ʹ�ñ������|r|cffFF0000��ȫɾ��|r|cff308014���|r|cffFFD700����|r|cff308014ħ��|r")
		end
	end
	
end)