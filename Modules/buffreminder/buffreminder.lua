﻿local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local

local BR = S:GetModule("BufferReminder")

local tab

local function OnEvent(self, event, arg1, arg2)
	local group = tab[self.id]
	if not group.spells and not group.weapon then return end
	if not GetActiveSpecGroup() then return end
	if event == "UNIT_AURA" and arg1 ~= "player" then return end 
	if group.level and UnitLevel("player") < group.level then return end
	
	self.icon:SetTexture(nil)
	self:Hide()
	if group.negate_spells then
		for buff, value in pairs(group.negate_spells) do
			if value == true then
				local name = GetSpellInfo(buff)
				if (name and UnitBuff("player", name)) then
					return
				end
			end
		end
	end
	
	local hasOffhandWeapon = OffhandHasWeapon()
	local hasMainHandEnchant, _, _, hasOffHandEnchant, _, _ = GetWeaponEnchantInfo()
	if not group.weapon then
		for buff, value in pairs(group.spells) do
			if value == true then
				local name = GetSpellInfo(buff)
				local usable, nomana = IsUsableSpell(name)
				if (usable or nomana) then
					self.icon:SetTexture(select(3, GetSpellInfo(buff)))
					break
				end		
			end
		end

		if (not self.icon:GetTexture() and event == "PLAYER_LOGIN") then
			self:UnregisterAllEvents()
			self:RegisterEvent("LEARNED_SPELL_IN_TAB")
			return
		elseif (self.icon:GetTexture() and event == "LEARNED_SPELL_IN_TAB") then
			self:UnregisterAllEvents()
			self:RegisterEvent("UNIT_AURA")
			if group.combat and group.combat == true then
				
				self:RegisterEvent("PLAYER_REGEN_ENABLED")
				self:RegisterEvent("PLAYER_REGEN_DISABLED")
			end
			
			if (group.instance and group.instance == true) or (group.pvp and group.pvp == true) then
				self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			end
			
			if group.role and group.role == true then
				self:RegisterEvent("UNIT_INVENTORY_CHANGED")
			end
		end		
	else
		self:UnregisterAllEvents()
		self:RegisterEvent("UNIT_INVENTORY_CHANGED")
		
		if hasOffhandWeapon == nil then
			if hasMainHandEnchant == nil then
				self.icon:SetTexture(GetInventoryItemTexture("player", 16))
			end
		else
			if hasOffHandEnchant == nil then
				self.icon:SetTexture(GetInventoryItemTexture("player", 17))
			end
			
			if hasMainHandEnchant == nil then
				self.icon:SetTexture(GetInventoryItemTexture("player", 16))
			end
		end
		
		if group.combat and group.combat == true then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
		end
		
		if (group.instance and group.instance == true) or (group.pvp and group.pvp == true) then
			self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		end
		
		if group.role and group.role == true then
			self:RegisterEvent("UNIT_INVENTORY_CHANGED")
		end
	end
	
	local role = group.role
	local tree = group.tree
	local combat = group.combat
	local personal = group.personal
	local instance = group.instance
	local pvp = group.pvp	
	local reversecheck = group.reversecheck
	local negate_reversecheck = group.negate_reversecheck
	local sound = false
	local rolepass = false
	local treepass = false
	local combatpass = false
	local instancepass = false
	local pvppass = false
	local inInstance, instanceType = IsInInstance()
	
	if role ~= nil then
		if role == S.Role then
			rolepass = true
		else
			rolepass = false
		end
	else
		rolepass = true
	end
	
	if tree ~= nil then
		if tree == GetSpecialization() then
			treepass = true
		else
			treepass = false	
		end
	else
		treepass = true
	end
	
	if combat then
		if UnitAffectingCombat("player") then
			combatpass = true
		else
			combatpass = false
		end
	else
		combatpass = true
	end	
	
	if instance then
		if (instanceType == "party" or instanceType == "raid") then
			instancepass = true
		else
			instancepass = false
		end
	else
		instancepass = true
	end
	
	if pvp then
		if (instanceType == "arena" or instanceType == "pvp") then
			pvppass = true
		else
			pvppass = false
		end
	else
		pvppass = true
	end
	
	--Prevent user error
	if reversecheck ~= nil and (role == nil and tree == nil) then reversecheck = nil end
	
	--Only time we allow it to play a sound
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_REGEN_DISABLED") then sound = true end
	
	if not group.weapon then
		if (not combat and not instance and not pvp) or ((combat and UnitAffectingCombat("player")) or (instance and (instanceType == "party" or instanceType == "raid")) or (pvp and (instanceType == "arena" or instanceType == "pvp"))) and 
		treepass == true and rolepass == true and combatpass == true and (instancepass == true or pvppass == true) and not (UnitInVehicle("player") and self.icon:GetTexture()) then
			
			for buff, value in pairs(group.spells) do
				if value == true then
					local name
					if GetSpellInfo(buff) == nil then return else name = GetSpellInfo(buff) end
					local _, _, icon, _, _, _, _, unitCaster, _, _, _ = UnitBuff("player", name)
					if personal and personal == true then
						if (name and icon and unitCaster == "player") then
							self:Hide()
							return
						end
					else
						if (name and icon) then
							self:Hide()
							return
						end
					end
				end
			end
			self:Show()
		elseif ((combat and UnitAffectingCombat("player")) or (instance and (instanceType == "party" or instanceType == "raid"))) and 
		reversecheck == true and not (UnitInVehicle("player") and self.icon:GetTexture()) then
			if negate_reversecheck and negate_reversecheck == GetSpecialization() then self:Hide() return end
			for buff, value in pairs(group.spells) do
				if value == true then
					local name = GetSpellInfo(buff)
					local _, _, icon, _, _, _, _, unitCaster, _, _, _ = UnitBuff("player", name)
					if (name and icon and unitCaster == "player") then
						self:Show()
						return
					end	
				end
			end			
		else
			self:Hide()
		end
	else
		if (not combat and not instance and not pvp) or ((combat and UnitAffectingCombat("player")) or (instance and (instanceType == "party" or instanceType == "raid")) or (pvp and (instanceType == "arena" or instanceType == "pvp"))) and 
		treepass == true and rolepass == true and combatpass == true and (instancepass == true or pvppass == true) and not (UnitInVehicle("player") and self.icon:GetTexture()) then
			if hasOffhandWeapon == nil then
				if hasMainHandEnchant == nil then
					self:Show()
					self.icon:SetTexture(GetInventoryItemTexture("player", 16))
					return
				end
			else			
				if hasMainHandEnchant == nil or hasOffHandEnchant == nil then	
					self:Show()
					if hasMainHandEnchant == nil then
						self.icon:SetTexture(GetInventoryItemTexture("player", 16))
					else
						self.icon:SetTexture(GetInventoryItemTexture("player", 17))
					end		
					return
				end
			end
			self:Hide()
			return	
		else
			self:Hide()
			return
		end
	end
end

local i = 0
local prv
function BR:initBuffReminder()
	tab = self.ReminderBuffs[S.myclass]
	
	if not self.db.ShowClassBuff then return end
	if tab == nil then return end
	for groupName, _ in pairs(tab) do
		i = i + 1
		local frame = CreateFrame("Frame", "ReminderFrame"..i, UIParent)
		frame:SetSize(self.db.ClassBuffSize,self.db.ClassBuffSize)
		if i == 1 then
			frame:SetPoint("CENTER", "UIParent", "CENTER", -150, 150)
			S:CreateMover(frame, "ClassBuffMover", L["缺失Buff"], true, nil, "ALL,GENERAL")
		else
			frame:SetPoint("LEFT", prv, "RIGHT", 3, 0)
		end
		frame:SetFrameLevel(1)
		frame.id = groupName
		frame.icon = frame:CreateTexture(nil, "OVERLAY")
		frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.icon:SetAllPoints()
		frame:Hide()
		frame:CreateShadow()

		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("PLAYER_LOGIN")
		frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		frame:RegisterEvent("UNIT_ENTERING_VEHICLE")
		frame:RegisterEvent("UNIT_ENTERED_VEHICLE")
		frame:RegisterEvent("UNIT_EXITING_VEHICLE")
		frame:RegisterEvent("UNIT_EXITED_VEHICLE")
		frame:SetScript("OnEvent", OnEvent)
		frame:SetScript("OnUpdate", function(self, elapsed)
			if not self.icon:GetTexture() then
				self:Hide()
			end
		end)
		frame:SetScript("OnShow", function(self)
			if not self.icon:GetTexture() then
				self:Hide()
			end	
		end)
		prv = frame
	end
end