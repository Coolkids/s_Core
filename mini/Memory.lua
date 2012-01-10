local eventcount = 0 
local a = CreateFrame("Frame") 
a:RegisterAllEvents() 

a:SetScript("OnEvent", function(self, event) 
   eventcount = eventcount + 1 
   if  GetAddOnMemoryUsage("s_Core") > 3072 then 
		collectgarbage("collect")  
		eventcount = 0 
	end
    if  IsAddOnLoaded("NugRunning") then
		if  GetAddOnMemoryUsage("NugRunning") > 400 then
			collectgarbage("collect") 
			eventcount = 0 
		end
	end
   if InCombatLockdown() then return end 
   if eventcount > 6000 or event == "PLAYER_ENTERING_WORLD" then 
      collectgarbage("collect") 
      eventcount = 0 
   end 
end)
