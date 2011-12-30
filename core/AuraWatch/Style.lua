----------------
--  命名空间  --
----------------

local S, _, _, DB = unpack(select(2, ...))
local class = DB.MyClass
local CLASS_COLORS = DB.MyClassColor



-- BuildICON
function S.BuildICON(IconSize)
	local Frame = CreateFrame("Frame", nil, UIParent)
	Frame:SetSize(IconSize, IconSize)
	
	Frame.Icon = Frame:CreateTexture(nil, "ARTWORK") 
	Frame.Icon:SetAllPoints()
	Frame.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	
	Frame.Count = Frame:CreateFontString(nil, "OVERLAY") 
	Frame.Count:SetFont(DB.Font, 17, "THINOUTLINE") 
	Frame.Count:SetPoint("BOTTOMRIGHT", 6, -1)
	
	Frame.Cooldown = CreateFrame("Cooldown", nil, Frame) 
	Frame.Cooldown:SetAllPoints() 
	Frame.Cooldown:SetReverse(true)
	Frame.Border = S.MakeBorder(Frame, 2)
	Frame.Shadow = S.MakeShadow(Frame, 4)
	--[[Frame.Statusbar = CreateFrame("StatusBar", nil, Frame)
	Frame.Statusbar:SetSize(Frame:GetWidth(), Frame:GetHeight()/10)
	Frame.Statusbar:SetPoint("BOTTOM", Frame, "TOP", 0, 2) 
	Frame.Statusbar:SetStatusBarTexture(DB.Statusbar) 
	Frame.Statusbar:SetStatusBarColor(CLASS_COLORS.r, CLASS_COLORS.g, CLASS_COLORS.b, 0.9)
	Frame.Statusbar:SetMinMaxValues(0, 1) 
	Frame.Statusbar:SetValue(0) 	

	Frame.Statusbar.Shadow = S.MakeShadow(Frame.Statusbar, 2)
	
	Frame.Statusbar.BG = Frame.Statusbar:CreateTexture(nil, "BACKGROUND")
	Frame.Statusbar.BG:SetAllPoints() 
	Frame.Statusbar.BG:SetTexture(DB.Statusbar)
	Frame.Statusbar.BG:SetVertexColor(0.1, 0.1, 0.1, 0.6)  --]]
		
	Frame:Hide()
	return Frame
end

-- BuildBAR
function S.BuildBAR(BarWidth, IconSize)
	local Frame = CreateFrame("Frame", nil, UIParent)
	Frame:SetSize(BarWidth, IconSize)
	
	Frame.Icon = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	Frame.Icon:SetSize(IconSize, IconSize)
	Frame.Icon:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", -5, 0)
	
	Frame.Icon.Shadow = S.MakeShadow(Frame, 3)
	Frame.Icon.Shadow:SetPoint("TOPLEFT", Frame.Icon, -3, 3)
	Frame.Icon.Shadow:SetPoint("BOTTOMRIGHT", Frame.Icon, 3, -3)

	Frame.Statusbar = CreateFrame("StatusBar", nil, Frame)
	Frame.Statusbar:SetSize(Frame:GetWidth(), Frame:GetHeight()/3)
	Frame.Statusbar:SetPoint("BOTTOM") 
	Frame.Statusbar:SetStatusBarTexture(DB.Statusbar) 
	Frame.Statusbar:SetStatusBarColor(CLASS_COLORS.r, CLASS_COLORS.g, CLASS_COLORS.b, 0.9)
	Frame.Statusbar:SetMinMaxValues(0, 1) 
	Frame.Statusbar:SetValue(0) 	

	Frame.Statusbar.Shadow = S.MakeShadow(Frame.Statusbar, 3)

	Frame.Count = Frame:CreateFontString(nil, "OVERLAY") 
	Frame.Count:SetFont(DB.Font, 16, "THINOUTLINE") 
	Frame.Count:SetPoint("BOTTOMRIGHT", Frame.Icon, "BOTTOMRIGHT", 3, -1) 

	Frame.Time = Frame.Statusbar:CreateFontString(nil, "ARTWORK") 
	Frame.Time:SetFont(DB.Font, 11, "THINOUTLINE") 
	Frame.Time:SetPoint("RIGHT", 0, 5) 

	Frame.Spellname = Frame.Statusbar:CreateFontString(nil, "ARTWORK") 
	Frame.Spellname:SetFont(DB.Font, 18, "THINOUTLINE") 
	Frame.Spellname:SetPoint("CENTER", -10, 5)
	
	Frame:Hide()
	return Frame
end