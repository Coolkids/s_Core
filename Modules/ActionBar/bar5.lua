local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local

local AB = S:GetModule("ActionBar")

function AB:CreateBar5()
	local C = self.db
	if C["Big4Layout"] == 1 then
		local bar51 = CreateFrame("Frame","SunUIMultiBarLeft1",UIParent, "SecureHandlerStateTemplate")
		local bar52 = CreateFrame("Frame","SunUIMultiBarLeft2",UIParent, "SecureHandlerStateTemplate")
		local bar53 = CreateFrame("Frame","SunUIMultiBarLeft3",UIParent, "SecureHandlerStateTemplate")
		local bar54 = CreateFrame("Frame","SunUIMultiBarLeft4",UIParent, "SecureHandlerStateTemplate")
		bar51:SetWidth(C["BigSize1"])
		bar51:SetHeight(C["BigSize1"])
		bar51:SetPoint("BOTTOM", "MultiBarBottomLeftButton4", "TOP", 0, 4)

		bar52:SetWidth(C["BigSize2"])
		bar52:SetHeight(C["BigSize2"])
		bar52:SetPoint("BOTTOM", "MultiBarBottomLeftButton5", "TOP", 0, 4)

		bar53:SetWidth(C["BigSize3"])
		bar53:SetHeight(C["BigSize3"])
		bar53:SetPoint("BOTTOMRIGHT", "MultiBarBottomRightButton3", "BOTTOMLEFT", -4, 0)

		bar54:SetWidth(C["BigSize4"])
		bar54:SetHeight(C["BigSize4"])
		bar54:SetPoint("BOTTOMLEFT", "MultiBarBottomRightButton9","BOTTOMRIGHT",  4,  0)

		MultiBarLeft:SetParent(bar51)
		MultiBarLeft:EnableMouse(false)
		for i=1, 4 do
			local button = _G["MultiBarLeftButton"..i]
			button:ClearAllPoints()
			button:SetSize(C["BigSize"..i], C["BigSize"..i])
			if i == 1 then
				button:SetAllPoints(bar51)
			elseif i == 2 then
				button:SetAllPoints(bar52)
			elseif i == 3 then
				button:SetAllPoints(bar53)
			else
				button:SetAllPoints(bar54)
			end
			if C["BigSize"..i] < 10 then
				button:ClearAllPoints()
				button:Kill()
			end
		end

		for i=5, 12 do
			local button = _G["MultiBarLeftButton"..i]
			button:ClearAllPoints()
			button:Kill()
		end
		if S:IsDeveloper() then 
			_G["MultiBarLeftButton1"]:ClearAllPoints()
			_G["MultiBarLeftButton2"]:ClearAllPoints()
		end
		RegisterStateDriver(bar51, "visibility", AB.visibility)
		RegisterStateDriver(bar52, "visibility", AB.visibility)
		RegisterStateDriver(bar53, "visibility", AB.visibility)
		RegisterStateDriver(bar54, "visibility", AB.visibility)
		S:CreateMover(bar51, "ActionBar5_1Mover", L["大动作条锚点"], true, nil, "ALL,ACTIONBARS")
		S:CreateMover(bar52, "ActionBar5_2Mover", L["大动作条锚点"], true, nil, "ALL,ACTIONBARS")
		S:CreateMover(bar53, "ActionBar5_3Mover", L["大动作条锚点"], true, nil, "ALL,ACTIONBARS")
		S:CreateMover(bar54, "ActionBar5_4Mover", L["大动作条锚点"], true, nil, "ALL,ACTIONBARS")
	elseif C["Big4Layout"] == 2 then
		local bar = CreateFrame("Frame","SunUIActionBar5",UIParent, "SecureHandlerStateTemplate")
		if C["Bar5Layout"] == 2 then
			bar:SetWidth(C["ButtonSize"]*6+C["ButtonSpacing"]*5)
			bar:SetHeight(C["ButtonSize"]*2+C["ButtonSpacing"])
		else  
			bar:SetWidth(C["ButtonSize"])
			bar:SetHeight(C["ButtonSize"]*12+C["ButtonSpacing"]*11)
		end
		bar:SetPoint("RIGHT","UIParent", "RIGHT", -40, 0)

		MultiBarLeft:SetParent(bar)
		MultiBarLeft:EnableMouse(false)
		if C["Bar5Layout"] == 1 then 
			for i=1, 12 do
				local button = _G["MultiBarLeftButton"..i]
				table.insert(AB.buttonList, button)
				button:ClearAllPoints()
				button:SetSize(C["ButtonSize"], C["ButtonSize"])
					if i == 1 then
						button:SetPoint("TOPLEFT", bar, 0,0)
					else
						local previous = _G["MultiBarLeftButton"..i-1]
						button:SetPoint("TOP", previous, "BOTTOM", 0, -C["ButtonSpacing"])
					end
			end
		elseif C["Bar5Layout"] == 2 then 
			for i=1, 12 do
				local button = _G["MultiBarLeftButton"..i]
				table.insert(AB.buttonList, button)
				button:ClearAllPoints()
				button:SetSize(C["ButtonSize"], C["ButtonSize"])
				if i == 1 then
					button:SetPoint("TOPLEFT", bar, 0,0)	
				else
					local previous = _G["MultiBarLeftButton"..i-1]
					if  i == 7 then
						previous = _G["MultiBarLeftButton1"]
						button:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -C["ButtonSpacing"])
					else
						button:SetPoint("LEFT", previous, "RIGHT", C["ButtonSpacing"], 0)
					end
				end
			end
		end
		RegisterStateDriver(bar, "visibility", AB.visibility)
		S:CreateMover(bar, "ActionBar5Mover", L["右1动作条锚点"], true, nil, "ALL,ACTIONBARS")
	end
end