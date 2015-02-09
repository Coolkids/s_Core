﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
function S:CreateInstallFrame()
	local A = S:GetModule("Skins")
	local f
	if not f then 
		f = CreateFrame("Frame", "SunUI_InstallFrame", UIParent)
		f:SetSize(400, 400)
		f:SetPoint("CENTER")
		f:SetFrameStrata("HIGH")
		A:CreateBD(f)
		A:CreateSD(f)

		local sb = CreateFrame("StatusBar", nil, f)
		sb:SetPoint("BOTTOM", f, "BOTTOM", 0, 60)
		sb:SetSize(320, 20)
		sb:SetStatusBarTexture(S["media"].normal)
		sb:Hide()
		
		local sbd = CreateFrame("Frame", nil, sb)
		sbd:SetPoint("TOPLEFT", sb, -1, 1)
		sbd:SetPoint("BOTTOMRIGHT", sb, 1, -1)
		sbd:SetFrameLevel(sb:GetFrameLevel()-1)
		A:CreateBD(sbd, .25)

		local header = f:CreateFontString(nil, "OVERLAY")
		header:SetFont(S["media"].font, 16, "THINOUTLINE")
		header:SetPoint("TOP", f, "TOP", 0, -20)

		local body = f:CreateFontString(nil, "OVERLAY")
		body:SetJustifyH("LEFT")
		body:SetFont(S["media"].font, 13, "THINOUTLINE")
		body:SetWidth(f:GetWidth()-40)
		body:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -60)

		local credits = f:CreateFontString(nil, "OVERLAY")
		credits:SetFont(S["media"].font, 9, "THINOUTLINE")
		credits:SetText("SunUI by Coolkid @ 天空之牆 - TW")
		credits:SetPoint("BOTTOM", f, "BOTTOM", 0, 4)

		local sbt = sb:CreateFontString(nil, "OVERLAY")
		sbt:SetFont(S["media"].font, 13, "THINOUTLINE")
		sbt:SetPoint("CENTER", sb)

		local option1 = CreateFrame("Button", "SunUI_Install_Option1", f, "UIPanelButtonTemplate")
		option1:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 20, 20)
		option1:SetSize(128, 25)
		A:Reskin(option1)

		local option2 = CreateFrame("Button", "SunUI_Install_Option2", f, "UIPanelButtonTemplate")
		option2:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -20, 20)
		option2:SetSize(128, 25)
		A:Reskin(option2)
		--SetUpChat
		local function SetChat()
			local channels = {"SAY","EMOTE","YELL","GUILD","OFFICER","GUILD_ACHIEVEMENT","ACHIEVEMENT","WHISPER","PARTY","PARTY_LEADER","RAID","RAID_LEADER","RAID_WARNING","INSTANCE_CHAT","INSTANCE_CHAT_LEADER","CHANNEL1","CHANNEL2","CHANNEL3","CHANNEL4","CHANNEL5","CHANNEL6","CHANNEL7",}
				
			for i, v in ipairs(channels) do
				ToggleChatColorNamesByClassGroup(true, v)
			end
			
			FCF_SetLocked(ChatFrame1, nil)
			FCF_SetChatWindowFontSize(self, ChatFrame1, 15) 
			ChatFrame1:ClearAllPoints()
			ChatFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 33)
			ChatFrame1:SetWidth(327)
			ChatFrame1:SetHeight(122)
			ChatFrame1:SetClampedToScreen(false)
			for i = 1,10 do FCF_SetWindowAlpha(_G["ChatFrame"..i], 0) end
			FCF_SavePositionAndDimensions(ChatFrame1)
			FCF_SetLocked(ChatFrame1, 1)
			
		end
		
		--按钮
		local step4 = function()
			sb:SetValue(4)
			PlaySoundFile("Sound\\interface\\LevelUp.wav")
			header:SetText(L["安装完毕"])
			body:SetText(L["完毕信息"])
			sbt:SetText("4/4")
			option1:Hide()
			option2:SetText(L["结束"])
			option2:SetScript("OnClick", function()
				self.db.installed = true
				ReloadUI()
			end)
		end

		local step3 = function()
			sb:SetValue(3)
			header:SetText(L["安装DBM设置"])
			body:SetText(L["安装DBM设置信息"])
			sbt:SetText("3/4")
			option1:SetScript("OnClick", step4)
			option2:SetScript("OnClick", function()
				step4()
			end)
		end

		local step2 = function()
			sb:SetValue(2)
			header:SetText(L["聊天框设置"])
			body:SetText(L["聊天框设置信息"])
			sbt:SetText("2/4")
			option1:SetScript("OnClick", step3)
			option2:SetScript("OnClick", function()
				SetChat()
				step3()
			end)
		end

		local step1 = function()
			sb:SetMinMaxValues(0, 4)
			sb:Show()
			sb:SetValue(1)
			sb:GetStatusBarTexture():SetGradient("VERTICAL", 0.20, .9, 0.12, 0.36, 1, 0.30)
			header:SetText(L["核心数据"])
			body:SetText(L["核心数据信息"])
			sbt:SetText("1/4")
			option1:Show()
			option1:SetText(L["跳过"])
			option2:SetText(L["下一步"])
			option1:SetScript("OnClick", step2)
			option2:SetScript("OnClick", function()
				step2()
			end)
		end

		local tut6 = function()
			sb:SetValue(6)
			header:SetText(L["教程6名字"])
			body:SetText(L["教程6信息"])
			sbt:SetText("6/6")
			option1:Show()
			option1:SetText(L["结束"])
			option2:SetText(L["安装"])
			option1:SetScript("OnClick", function()
				UIFrameFade(f,{
					mode = "OUT",
					timeToFade = 0.5,
					finishedFunc = function(f) f:Hide() end,
					finishedArg1 = f,
				})
			end)
			option2:SetScript("OnClick", step1)
		end

		local tut5 = function()
			sb:SetValue(5)
			header:SetText(L["教程5名字"])
			body:SetText(L["教程5信息"])
			sbt:SetText("5/6")
			option2:SetScript("OnClick", tut6)
		end

		local tut4 = function()
			sb:SetValue(4)
			header:SetText(L["教程4名字"])
			body:SetText(L["教程4信息"])
			sbt:SetText("4/6")
			option2:SetScript("OnClick", tut5)
		end

		local tut3 = function()
			sb:SetValue(3)
			header:SetText(L["教程3名字"])
			body:SetText(L["教程3信息"])
			sbt:SetText("3/6")
			option2:SetScript("OnClick", tut4)
		end

		local tut2 = function()
			sb:SetValue(2)
			header:SetText(L["教程2名字"])
			body:SetText(L["教程2信息"])
			sbt:SetText("2/6")
			option2:SetScript("OnClick", tut3)
		end

		local tut1 = function()
			sb:SetMinMaxValues(0, 6)
			sb:Show()
			sb:SetValue(1)
			sb:GetStatusBarTexture():SetGradient("VERTICAL", 0, 0.65, .9, .1, .9, 1)
			header:SetText(L["教程1名字"])
			body:SetText(L["教程1信息"])

			sbt:SetText("1/6")
			option1:Hide()
			option2:SetText(L["下一步"])
			option2:SetScript("OnClick", tut2)
		end
		
		header:SetText(L["欢迎"])
		body:SetText(L["欢迎信息"])

		option1:SetText(L["教程"])
		option2:SetText(L["安装SunUI"])

		option1:SetScript("OnClick", tut1)
		option2:SetScript("OnClick", step1)
	else
		f:Show()
	end
end
SlashCmdList["SETSUNUI"] = function()
	if not UnitAffectingCombat("player") then
		CreateInstallFrame()
	end
end
SLASH_SETSUNUI1 = "/setsunui"
