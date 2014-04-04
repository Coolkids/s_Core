local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local

local AB = S:GetModule("ActionBar")

function AB:CreateBar4()
	local C = self.db
	local bar = CreateFrame("Frame","SunUIActionBar4",UIParent, "SecureHandlerStateTemplate")
	if C["Bar4Layout"] == 2 then
		bar:SetWidth(C["ButtonSize"]*6+C["ButtonSpacing"]*5)
		bar:SetHeight(C["ButtonSize"]*2+C["ButtonSpacing"])
	else  
		bar:SetWidth(C["ButtonSize"])
		bar:SetHeight(C["ButtonSize"]*12+C["ButtonSpacing"]*11)
	end
	bar:SetPoint("RIGHT", "UIParent", "RIGHT", -10, 0)

	MultiBarRight:SetParent(bar)
	MultiBarRight:EnableMouse(false)

	if C["Bar4Layout"] == 1 then
		for i=1, 12 do
			local button = _G["MultiBarRightButton"..i]
			table.insert(AB.buttonList, button)
			button:ClearAllPoints()
			button:SetSize(C["ButtonSize"], C["ButtonSize"])
				if i == 1 then
					button:SetPoint("TOPLEFT", bar, 0,0)
				else
					local previous = _G["MultiBarRightButton"..i-1]
					button:SetPoint("TOP", previous, "BOTTOM", 0, -C["ButtonSpacing"])
				end
		end
	elseif C["Bar4Layout"] == 2 then 
		for i=1, 12 do
			local button = _G["MultiBarRightButton"..i]
			table.insert(AB.buttonList, button)
			button:ClearAllPoints()
			button:SetSize(C["ButtonSize"], C["ButtonSize"])
				if i == 1 then
					button:SetPoint("TOPLEFT", bar, 0,0)	
				else
					local previous = _G["MultiBarRightButton"..i-1]
					if  i == 7 then
					previous = _G["MultiBarRightButton1"]
					button:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -C["ButtonSpacing"])
					else
					button:SetPoint("LEFT", previous, "RIGHT", C["ButtonSpacing"], 0)
					end
				end
		end
	end
	RegisterStateDriver(bar, "visibility", AB.visibility)
	S:CreateMover(bar, "ActionBar4Mover", L["右2动作条锚点"], true, nil, "ALL,ACTIONBARS")
end