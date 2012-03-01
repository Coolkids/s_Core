﻿local S, C, L, DB = unpack(select(2, ...))
if DB.Nuke == true then return end
local Module = LibStub("AceAddon-3.0"):GetAddon("Core"):NewModule("Bar1", "AceEvent-3.0")
local barDB = DB.bars.bar1
local bar = CreateFrame("Frame","SunUIActionBar1",UIParent, "SecureHandlerStateTemplate")
function Module:OnInitialize()
	C = ActionBarDB
	local a1, af, a2, x, y = unpack(MoveHandleDB["bar1"]) 
  if C["Bar1Layout"] == 2 then
    bar:SetWidth(C["ButtonSize"]*6+C["ButtonSpacing"]*5)
    bar:SetHeight(C["ButtonSize"]*2+C["ButtonSpacing"])
  else
    bar:SetWidth(C["ButtonSize"]*12+C["ButtonSpacing"]*11)
    bar:SetHeight(C["ButtonSize"])
  end
  bar:SetScale(C["MainBarSacle"])
  if C["Bar1Layout"] == 2 then
    --bar:Point(a1,af,a2,x-((C["ButtonSize"]*6+C["ButtonSpacing"]*6)/2),y)
	 MoveHandle.SunUIActionBar1 = S.MakeMove(SunUIActionBar1, "SunUIActionBar1", "bar1", C["MainBarSacle"])

  else
    MoveHandle.SunUIActionBar1 = S.MakeMove(SunUIActionBar1, "SunUIActionBar1", "bar1", C["MainBarSacle"])
  end
  bar:SetHitRectInsets(-DB.barinset, -DB.barinset, -DB.barinset, -DB.barinset)

  local Page = {
    ["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
    ["WARRIOR"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
    ["PRIEST"] = "[bonusbar:1] 7;",
    ["ROGUE"] = "[bonusbar:1] 7; [form:3] 10;",
    ["DEFAULT"] = "[bonusbar:5] 11; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
  }

  local function GetBar()
    local condition = Page["DEFAULT"]
    local class = DB.MyClass
    local page = Page[class]
    if page then
      condition = condition.." "..page
    end
    condition = condition.." 1"
    return condition
  end

  bar:RegisterEvent("PLAYER_LOGIN")
  bar:RegisterEvent("PLAYER_ENTERING_WORLD")
  bar:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
  bar:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
  bar:RegisterEvent("BAG_UPDATE")
  bar:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
      local button, buttons
      for i = 1, NUM_ACTIONBAR_BUTTONS do
        button = _G["ActionButton"..i]
        self:SetFrameRef("ActionButton"..i, button)
      end

      self:Execute([[
        buttons = table.new()
        for i = 1, 12 do
          table.insert(buttons, self:GetFrameRef("ActionButton"..i))
        end
      ]])

      self:SetAttribute("_onstate-page", [[
        for i, button in ipairs(buttons) do
          button:SetAttribute("actionpage", tonumber(newstate))
        end
      ]])

      RegisterStateDriver(self, "page", GetBar())
    elseif event == "PLAYER_ENTERING_WORLD" then
      local button
      for i = 1, 12 do
        button = _G["ActionButton"..i]
        button:Size(C["ButtonSize"], C["ButtonSize"])
        button:ClearAllPoints()
        button:SetParent(self)
        if i == 1 then
          button:Point("BOTTOMLEFT", bar, 0,0)
        else
          local previous = _G["ActionButton"..i-1]
          if C["Bar1Layout"] == 2 and i == 7 then
            previous = _G["ActionButton1"]
            button:Point("BOTTOMLEFT", previous, "TOPLEFT", 0, C["ButtonSpacing"])
          else
            button:Point("LEFT", previous, "RIGHT", C["ButtonSpacing"], 0)
          end
        end
      end
    else
       MainMenuBar_OnEvent(self, event, ...)
    end

  end)
 end