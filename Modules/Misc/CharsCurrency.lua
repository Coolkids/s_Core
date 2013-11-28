local S, L, DB, _, C = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Tracks your currency tokens across multiple characters(Exonumist by Phanx)
----------------------------------------------------------------------------------------
local realmDB, charDB
local playerList = {}
local classColor = {}
local myPlayerRealm = GetRealmName();
local myPlayerName  = UnitName("player");		
local faction = UnitFactionGroup("player")
local nameToID = {}
local collapsed = {}

local function UpdateData()
        if TokenFrame:IsVisible() then
                return
        end
        local i, limit = 1, GetCurrencyListSize()
        while i <= limit do
                local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(i)
                if isHeader then
                        if not isExpanded then
                                collapsed[name] = true
                                ExpandCurrencyList(i, 1)
                                limit = GetCurrencyListSize()
                        end
                else
                        local link = GetCurrencyListLink(i)
                        local id = tonumber(strmatch(link, "currency:(%d+)"))
                        nameToID[name] = id
                        if count > 0 then
                                charDB[id] = count
                        else
                                charDB[id] = nil
                        end
                end
                i = i + 1
        end
        while i > 0 do
                local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(i)
                if isHeader and isExpanded and collapsed[name] then
                        ExpandCurrencyList(i, 0)
                end
                i = i - 1
        end
        wipe(collapsed)
end
hooksecurefunc("BackpackTokenFrame_Update", UpdateData)
hooksecurefunc("TokenFrame_Update", UpdateData)

local function AddTooltipInfo(tooltip, currency, includePlayer)
        local spaced
        for i = (includePlayer and 1 or 2), #playerList do
                local name = playerList[i]
                local n = realmDB[name][currency]
                if n then
                        if not spaced then
                                tooltip:AddLine(" ")
                                spaced = true
                        end
                        local r, g, b
                        local class = realmDB[name].class
                        if class then
                                r, g, b = unpack(classColor[class])
                        else
                                r, g, b = 1, 1, 1
                        end
                        tooltip:AddLine(name..": "..n, r, g, b)
                end
        end
        if spaced then
                tooltip:Show()
        end
end

hooksecurefunc(GameTooltip, "SetCurrencyByID", function(tooltip, id)
        AddTooltipInfo(tooltip, id, not MerchantMoneyInset:IsMouseOver())
end)

hooksecurefunc(GameTooltip, "SetCurrencyToken", function(tooltip, i)
        local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(i)
        AddTooltipInfo(GameTooltip, nameToID[name], not TokenFrame:IsMouseOver())
end)

hooksecurefunc(GameTooltip, "SetHyperlink", function(tooltip, link)
        local id = strmatch(link, "currency:(%d+)")
        if id then
                AddTooltipInfo(tooltip, tonumber(id), true)
        end
end)

hooksecurefunc(GameTooltip, "SetMerchantCostItem", function(tooltip, item, currency)
        local icon, _, _, name = GetMerchantItemCostItem(item, currency)
        AddTooltipInfo(tooltip, nameToID[name], true)
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
        if event == "ADDON_LOADED" then
                if addon ~= "SunUI" then return end
				
                if not SunUIConfig then SunUIConfig = {} end
				if not SunUIConfig.SavedCurrency then SunUIConfig.SavedCurrency = {} end
                if not SunUIConfig.SavedCurrency[myPlayerRealm] then SunUIConfig.SavedCurrency[myPlayerRealm] = {} end
				if not SunUIConfig.SavedCurrency[myPlayerRealm][faction] then SunUIConfig.SavedCurrency[myPlayerRealm][faction] = {} end
				if not SunUIConfig.SavedCurrency[myPlayerRealm][faction][myPlayerName] then SunUIConfig.SavedCurrency[myPlayerRealm][faction][myPlayerName] = {} end

                for k, v in pairs(SunUIConfig.SavedCurrency[myPlayerRealm]) do
                        if k ~= "Alliance" and k ~= "Horde" then
                                SunUIConfig.SavedCurrency[myPlayerRealm][k] = nil
                        end
                end

                local now = time()

                realmDB = SunUIConfig.SavedCurrency[myPlayerRealm][faction]
                charDB = realmDB[myPlayerName]

                charDB.class = select(2, UnitClass("player"))
                charDB.lastSeen = now

                local cutoff = now - (60 * 60 * 24 * 30)
                for name, data in pairs(realmDB) do
                        if data.lastSeen and data.lastSeen < cutoff then
                                realmDB[name] = nil
                        elseif name ~= myPlayerName then
                                tinsert(playerList, name)
                        end
                end
                sort(playerList)
                tinsert(playerList, 1, myPlayerName)

                self:UnregisterEvent("ADDON_LOADED")

                if IsLoggedIn() then
                        self:GetScript("OnEvent")(self, "PLAYER_LOGIN")
                else
                        self:RegisterEvent("PLAYER_LOGIN")
                end
        elseif event == "PLAYER_LOGIN" then
                for k, v in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
                        classColor[k] = {v.r, v.g, v.b}
                end
                if CUSTOM_CLASS_COLORS then
                        CUSTOM_CLASS_COLORS:RegisterCallback(function()
                                for k, v in pairs(CUSTOM_CLASS_COLORS) do
                                        classColor[k][1] = v.r
                                        classColor[k][2] = v.g
                                        classColor[k][3] = v.b
                                end
                        end)
                end
                self:UnregisterEvent("PLAYER_LOGIN")
        end
end)


		
		
		