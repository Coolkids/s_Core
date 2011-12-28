local S, C, L, DB = unpack(select(2, ...))
local Module = LibStub("AceAddon-3.0"):GetAddon("Core"):NewModule("Bar4", "AceEvent-3.0")
local barDB = DB.bars.bar4  
  local bar = CreateFrame("Frame","rABS_MultiBarRight",UIParent, "SecureHandlerStateTemplate")
  function Module:OnInitialize()
  C = ActionBarDB

  bar:SetHeight(C["ButtonSize"]*12+C["ButtonSpacing"]*11)
  bar:SetWidth(C["ButtonSize"])
  bar:SetPoint(C["bar4"].a1,C["bar4"].af,C["bar4"].a2,C["bar4"].x,C["bar4"].y)
  bar:SetHitRectInsets(-DB.barinset, -DB.barinset, -DB.barinset, -DB.barinset)
  
  if barDB.testmode then
    bar:SetBackdrop(DB.backdrop)
    bar:SetBackdropColor(1,0.8,1,0.6)
  end
  bar:SetScale(C["MainBarSacle"])

  DB.applyDragFunctionality(bar,barDB.userplaced,barDB.locked)

  MultiBarRight:SetParent(bar)

  for i=1, 12 do
    local button = _G["MultiBarRightButton"..i]
    button:ClearAllPoints()
    button:SetSize(C["ButtonSize"], C["ButtonSize"])
    if i == 1 then
      button:SetPoint("TOPLEFT", bar, 0,0)
    else
      local previous = _G["MultiBarRightButton"..i-1]
      button:SetPoint("TOP", previous, "BOTTOM", 0, -C["ButtonSpacing"])
    end
  end
     end 
  if barDB.showonmouseover then    
    local function lighton(alpha)
      if MultiBarRight:IsShown() then
        for i=1, 12 do
          local pb = _G["MultiBarRightButton"..i]
          pb:SetAlpha(alpha)
        end
      end
    end    
    bar:EnableMouse(true)
    bar:SetScript("OnEnter", function(self) lighton(1) end)
    bar:SetScript("OnLeave", function(self) lighton(0) end)  
    for i=1, 12 do
      local pb = _G["MultiBarRightButton"..i]
      pb:SetAlpha(0)
      pb:HookScript("OnEnter", function(self) lighton(1) end)
      pb:HookScript("OnLeave", function(self) lighton(0) end)
    end    
  end
