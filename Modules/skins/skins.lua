﻿local S, C, L, DB = unpack(select(2, ...))
local Delay = CreateFrame("Frame")
Delay:RegisterEvent("PLAYER_ENTERING_WORLD")
Delay:SetScript("OnEvent", function()
	Delay:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	if FriendsMenuXPSecure then
		FriendsMenuXPSecureMenuBackdrop:StripTextures()
		S.CreateBD(FriendsMenuXPSecure)
	end
	
	if BaudErrorFrame then
		BaudErrorFrame:StripTextures()
		S.Reskin(BaudErrorFrameCloseButton)
		S.Reskin(BaudErrorFrameClearButton)
		S.SetBD(BaudErrorFrame)
	end
	
	if BuyEmAllFrame then
		BuyEmAllFrame:StripTextures()
		S.Reskin(BuyEmAllStackButton)
		S.Reskin(BuyEmAllMaxButton)
		S.Reskin(BuyEmAllOkayButton)
		S.Reskin(BuyEmAllCancelButton)
		S.SetBD(BuyEmAllFrame)
	end
	
	if ItemRefShoppingTooltip1 then 
		ItemRefShoppingTooltip1:StripTextures()
		S.CreateBD(ItemRefShoppingTooltip1)
	end
	if ItemRefShoppingTooltip2 then 
		ItemRefShoppingTooltip2:StripTextures()
		S.CreateBD(ItemRefShoppingTooltip2)
	end
	
	if UnitPopupMenus then
		UnitPopupMenus["PLAYER"] = { "SET_FOCUS", "WHISPER", "INSPECT", "ACHIEVEMENTS", "INVITE", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "MOVE_PLAYER_FRAME", "MOVE_TARGET_FRAME", "CANCEL" };
	end
	--[[ hooksecurefunc("ShowUIPanel", function(frame)
		if frame and frame ~= InspectFrame and frame ~= TaxiFrame and frame ~= FriendsFrame then
			frame:Show()
			UIFrameFadeIn(frame, 0.3, 0, 1)
		end
	end)
	hooksecurefunc("HideUIPanel", function(frame)
		if frame and frame ~= InspectFrame and frame ~= TaxiFrame and frame ~= FriendsFrame and frame ~= MasterLooterFrame then
			S.FadeOutFrameDamage(frame, 0.3)
			frame:SetAlpha(1)
		end
	end) ]]
	DEFAULT_CHAT_FRAME:AddMessage("|cffDDA0DDSun|r|cff44CCFFUI|r已加载，详细设置请输入/sunui")
	DEFAULT_CHAT_FRAME:AddMessage("更新下载请到个人主页:http://url.cn/5YbLQe")
end)