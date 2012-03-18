local addon, ns = ...
local _, settings = ...
local S, _, _, DB = unpack(select(2, ...))

local _DEFAULTS = { 
   width = 252, 
   height = 18, 
   texture = DB.Statusbar, 
 

 
   position = { 
      ["BREATH"] = 'TOP#UIParent#TOP#0#-96'; 
      ["EXHAUSTION"] = 'TOP#UIParent#TOP#0#-119'; 
      ["FEIGNDEATH"] = 'TOP#UIParent#TOP#0#-142'; 
   }; 

   colors = { 
      EXHAUSTION = {1, .9, 0}; 
      BREATH = {0.31, 0.45, 0.63}; 
      DEATH = {1, .7, 0}; 
      FEIGNDEATH = {1, .7, 0}; 
   }; 
} 

do 
   settings = setmetatable(settings, {__index = _DEFAULTS}) 
   for k,v in next, settings do 
      if(type(v) == 'table') then 
         settings[k] = setmetatable(settings[k], {__index = _DEFAULTS[k]}) 
      end 
   end 
end 




local function SkinIt(bar)    
   local _, originalPoint, _, _, _ = bar:GetPoint() 
    
   bar:ClearAllPoints() 
   bar:SetPoint("TOPLEFT", originalPoint, "TOPLEFT", 2, -2) 
   bar:SetPoint("BOTTOMRIGHT", originalPoint, "BOTTOMRIGHT", -2, 2) 
       
   for i=1, bar:GetNumRegions() do 
      local region = select(i, bar:GetRegions()) 
      if region:GetObjectType() == "Texture" then 
         region:SetTexture(nil) 
      elseif region:GetObjectType() == "FontString" then 
         region:SetFont(DB.Font, 12, "THINOUTLINE") 
         region:SetShadowColor(0,0,0,0) 
      end 
   end 
   bar:CreateShadow("Background")
   bar:SetStatusBarTexture(DB.Statusbar) 
   bar:SetStatusBarColor(170/255, 10/255, 10/255) 
    
end 


local function SkinBlizzTimer(self, event) 
   for _, b in pairs(TimerTracker.timerList) do 
      if not b["bar"].skinned then 
         SkinIt(b["bar"]) 
         b["bar"].skinned = true 
      end 
   end 
end

local Spawn, PauseAll 
do 
   local barPool = {} 

   local loadPosition = function(self) 
      local pos = settings.position[self.type] 
      local p1, frame, p2, x, y = strsplit("#", pos) 

      return self:SetPoint(p1, frame, p2, x, y) 
   end 

   local OnUpdate = function(self, elapsed) 
      if(self.paused) then return end 

      self:SetValue(GetMirrorTimerProgress(self.type) / 1e3) 
   end 

   local Start = function(self, value, maxvalue, scale, paused, text) 
      if(paused > 0) then 
         self.paused = 1 
      elseif(self.paused) then 
         self.paused = nil 
      end 

      self.text:SetText(text) 

      self:SetMinMaxValues(0, maxvalue / 1e3) 
      self:SetValue(value / 1e3) 

      if(not self:IsShown()) then self:Show() end 
   end 

   function Spawn(type) 
      if(barPool[type]) then return barPool[type] end 
      local frame = CreateFrame('StatusBar', nil, UIParent) 

      frame:SetScript("OnUpdate", OnUpdate) 

      local r, g, b = unpack(settings.colors[type]) 
	  frame:CreateShadow("Background")
     
--[[       local border = CreateFrame("Frame", nil, frame) 
      border:SetPoint("TOPLEFT", frame, -2, 0) 
      border:SetPoint("BOTTOMRIGHT", frame, 0, 2) 

      border:SetFrameLevel(0)  ]]
      local text = frame:CreateFontString(nil, 'OVERLAY') 
      text:SetFont(GameFontNormalSmall:GetFont(), 14, "THINOUTLINE") 
      text:SetShadowOffset(1, -1) 
      text:SetShadowColor(0, 0, 0, 1) 

      text:SetJustifyH'CENTER' 
      text:SetTextColor(1, 1, 1) 

      text:SetPoint('LEFT', frame) 
      text:SetPoint('RIGHT', frame) 
      text:SetPoint('TOP', frame, 0, 2) 
      text:SetPoint('BOTTOM', frame) 

      frame:SetSize(settings.width, settings.height) 

      frame:SetStatusBarTexture(settings.texture) 
      frame:SetStatusBarColor(r, g, b) 

      frame.type = type 
      frame.text = text 

      frame.Start = Start 
      frame.Stop = Stop 

      loadPosition(frame) 

      barPool[type] = frame 
      return frame 
   end 

   function PauseAll(val) 
      for _, bar in next, barPool do 
         bar.paused = val 
      end 
   end 
end 

local frame = CreateFrame'Frame' 
frame:SetScript('OnEvent', function(self, event, ...) 
   return self[event](self, ...) 
end) 

function frame:ADDON_LOADED(addon) 
      UIParent:UnregisterEvent'MIRROR_TIMER_START' 

      self:UnregisterEvent'ADDON_LOADED' 
      self.ADDON_LOADED = nil 
end 
frame:RegisterEvent'ADDON_LOADED' 

function frame:PLAYER_ENTERING_WORLD() 
   for i=1, MIRRORTIMER_NUMTIMERS do 
      local type, value, maxvalue, scale, paused, text = GetMirrorTimerInfo(i) 
      if(type ~= 'UNKNOWN') then 
         Spawn(type):Start(value, maxvalue, scale, paused, text) 
      end 
   end 
end 
frame:RegisterEvent'PLAYER_ENTERING_WORLD' 

function frame:MIRROR_TIMER_START(type, value, maxvalue, scale, paused, text) 
   return Spawn(type):Start(value, maxvalue, scale, paused, text) 
end 
frame:RegisterEvent'MIRROR_TIMER_START' 

function frame:MIRROR_TIMER_STOP(type) 
   return Spawn(type):Hide() 
end 
frame:RegisterEvent'MIRROR_TIMER_STOP' 

function frame:MIRROR_TIMER_PAUSE(duration) 
   return PauseAll((duration > 0 and duration) or nil) 
end 
frame:RegisterEvent'MIRROR_TIMER_PAUSE'