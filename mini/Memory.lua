local eventcount = 0 
local a = CreateFrame("Frame") 
a:RegisterAllEvents() 

mem = GetAddOnMemoryUsage("s_Core")
a:SetScript("OnEvent", function(self, event) 
   eventcount = eventcount + 1 
   if  mem > 3072  then collectgarbage("collect")  eventcount = 0  end
   if InCombatLockdown() then return end 
   if eventcount > 6000 or event == "PLAYER_ENTERING_WORLD" then 
      collectgarbage("collect") 
      eventcount = 0 
   end 
end)
