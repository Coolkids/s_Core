local S, _, _, DB = unpack(select(2, ...))
if DB.SkinBigWigs ~= true then return end
----------------------------------------
local classcolor = false	-- classcolored bars
local drawshadow = true		-- shadows around frames.
local skinrange = true		-- skin distance window
----------------------------------------
local barcolor = classcolor and RAID_CLASS_COLORS[myclass] -- or {["r"]=.1,["g"]=.1,["b"]=1,} -- uncomment the following to use your own color for the bars
local buttonsize = 18

-- init some tables to store backgrounds
local freebg = {}
-- styling functions
local createbg = function()
	local bg=CreateFrame("Frame")
	if drawshadow then
		S.CreateShadow(bg)
	end
	return bg
end
local function freestyle(bar)
	-- reparent and hide bar background
	local bg = bar:Get("bigwigs:bigwigs:bg")
	if bg then
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		freebg[#freebg + 1] = bg
	end
	-- reparent and hide icon background
	local ibg = bar:Get("bigwigs:bigwigs:bg")
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		freebg[#freebg + 1] = ibg
	end
	-- replace dummies with original method functions
	bar.candyBarBar.SetPoint=bar.candyBarBar.OldSetPoint
	bar.candyBarIconFrame.SetWidth=bar.candyBarIconFrame.OldSetWidth
	bar.SetScale=bar.OldSetScale
end
local applystyle = function(bar)
	-- general bar settings
	bar:SetHeight(buttonsize)
	bar:SetScale(1)
	bar.OldSetScale=bar.SetScale
	bar.SetScale= dummy
	-- create or reparent and use bar background
	local bg=nil
	if #freebg > 0 then
		bg = table.remove(freebg)
	else
		bg = createbg()
	end
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:SetPoint("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bg:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:bigwigs:bg", bg)
	-- create or reparent and use icon background
	local ibg=nil
	if bar.candyBarIconFrame:GetTexture() then
		if #freebg > 0 then
			ibg = table.remove(freebg)
		else
			ibg = createbg()
		end
		ibg:SetParent(bar)
		ibg:ClearAllPoints()
		ibg:SetPoint("TOPLEFT", bar.candyBarIconFrame, "TOPLEFT", -2, 2)
		ibg:SetPoint("BOTTOMRIGHT", bar.candyBarIconFrame, "BOTTOMRIGHT", 2, -2)
		ibg:SetFrameStrata("BACKGROUND")
		ibg:Show()
		bar:Set("bigwigs:bigwigs:bg", ibg)
	end
	-- setup timer and bar name fonts and positions
	bar.candyBarLabel:SetFont(DB.Font, 12, "OUTLINE")
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", -2, 4)

	bar.candyBarDuration:SetFont(DB.Font, 12, "OUTLINE")
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("BOTTOMRIGHT", bar, "TOPRIGHT", 2, 4)
	-- setup bar positions and look
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	bar.candyBarBar.OldSetPoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint= dummy
	bar.candyBarBar:SetStatusBarTexture(DB.Statusbar)
	if barcolor and not bar.data["bigwigs:emphasized"]==true then bar.candyBarBar:SetStatusBarColor(barcolor.r, barcolor.g, barcolor.b, 1) end
	bar.candyBarBackground:SetTexture(DB.Statusbar)
	-- setup icon positions and other things
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", -buttonsize - buttonsize/3 , 0)
	bar.candyBarIconFrame:SetSize(buttonsize, buttonsize)
	bar.candyBarIconFrame.OldSetWidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame.SetWidth= dummy
	bar.candyBarIconFrame:SetTexCoord(0.05, 0.95, 0.05, 0.95)
end
local f = CreateFrame("Frame")
local function registerStyle()
	if not BigWigs then return end
	local bars = BigWigs:GetPlugin("Bars", true)
	local prox = BigWigs:GetPlugin("Proximity", true)
	if bars then
		bars:RegisterBarStyle("BigWigs", {
			apiVersion = 1,
			version = 1,
			GetSpacing = function(bar) return buttonsize end,
			ApplyStyle = applystyle,
			BarStopped = freestyle,
			GetStyleName = function() return "BigWigs" end,
		})
	end
	
		hooksecurefunc(BigWigs.pluginCore.modules.Proximity, "RestyleWindow", function()
			if drawshadow then
				S.CreateShadow(BigWigsProximityAnchor)
			end
		end)
	
end
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
		if  msg == "BigWigs_Plugins" then
			registerStyle()
			f:UnregisterEvent("ADDON_LOADED")
		end
	end
end)
local pr = function(msg)
    print("BigWigs", tostring(msg))
end
SLASH_BW1 = "/bigwigstest"
SlashCmdList["BW"] = function(msg)
	if(msg=="apply") then
		SlashCmdList["BigWigs"]()
		HideUIPanel(InterfaceOptionsFrame)
		StaticPopup_Show("BW")        
	elseif(msg=="test") then
		SlashCmdList["BigWigs"]()
		BigWigs.pluginCore.modules.Proximity.Test(BigWigs.pluginCore.modules.Proximity)
		HideUIPanel(InterfaceOptionsFrame)
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		
	else
		pr("use /bigwigstest apply to apply BigWigs settings.")
		pr("use /bigwigstest test to launch BigWigs testmode.")
	end
end
StaticPopupDialogs["BW"] = {
	text = "We need to set some BigWigs options to apply BigWigs skin.\nMost of your settings will remain untouched.",
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		BigWigs.pluginCore.modules.Bars.db.profile.barStyle="BigWigs"
		if InCombatLockdown() then pr(ERR_NOT_IN_COMBAT) pr("Reload your UI to apply skin.") else ReloadUI() end
	end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = true,
}