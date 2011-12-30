local S, C, L, DB = unpack(select(2, ...))
local Module = LibStub("AceAddon-3.0"):GetAddon("Core"):NewModule("castbarmove")

function Module:OnInitialize()
C=MoveHandleDB
L=ThreatDB
M=ReminderDB
local Castbarplay = CreateFrame("Frame", "Castbarplay", UIParent) 
Castbarplay:SetWidth(460) 
Castbarplay:SetHeight(10) 
Castbarplay:SetPoint(unpack(C["PlayerCastbar"]))
local Castbartarget = CreateFrame("Frame", "Castbartarget", UIParent) 
Castbartarget:SetWidth(240) 
Castbartarget:SetHeight(10) 
Castbartarget:SetPoint(unpack(C["TargetCastbar"]))
local Castbarfouce = CreateFrame("Frame", "Castbarfouce", UIParent) 
Castbarfouce:SetWidth(200) 
Castbarfouce:SetHeight(10) 
Castbarfouce:SetPoint(unpack(C["FocusCastbar"]))
local Castbarpet = CreateFrame("Frame", "Castbarpet", UIParent) 
Castbarpet:SetWidth(200) 
Castbarpet:SetHeight(10) 
Castbarpet:SetPoint(unpack(C["PetCastbar"]))
if DB.MyClass == "PRIEST" then
local ShadowPet = CreateFrame("Frame", "ShadowPet", UIParent) 
ShadowPet:SetWidth(140) 
ShadowPet:SetHeight(20) 
ShadowPet:SetPoint(unpack(C["ShadowPet"]))
end
local ClassCD = CreateFrame("Frame", "ClassCD", UIParent) 
ClassCD:SetWidth(140) 
ClassCD:SetHeight(20) 
ClassCD:SetPoint(unpack(C["ClassCD"]))
local Threat = CreateFrame("Frame", "Threat", UIParent) 
Threat:SetWidth(L["ThreatBarWidth"]) 
Threat:SetHeight(6) 
Threat:SetPoint(unpack(C["Threat"]))
local Reminder = CreateFrame("Frame", "Reminder", UIParent) 
Reminder:SetWidth(M["RaidBuffSize"]) 
Reminder:SetHeight(M["RaidBuffSize"]) 
Reminder:SetPoint(unpack(C["Reminder"]))
local Class = CreateFrame("Frame", "Reminder", UIParent) 
Class:SetWidth(M["ClassBuffSize"]) 
Class:SetHeight(M["ClassBuffSize"]) 
Class:SetPoint(unpack(C["Class"]))
if (DB.MyClass == "ROGUE" and DB.MyClass == "DRUID") then  
local Combatpoint = CreateFrame("Frame", "Combatpoint", UIParent) 
Combatpoint:SetWidth(220) 
Combatpoint:SetHeight(25) 
Combatpoint:SetPoint(unpack(C["Combatpoint"]))
end
	MoveHandle.Castbarplay = S.MakeMoveHandle(Castbarplay, "玩家施法条", "PlayerCastbar")
	MoveHandle.Castbartarget = S.MakeMoveHandle(Castbartarget, "目标施法条", "TargetCastbar")
	MoveHandle.Castbarfouce = S.MakeMoveHandle(Castbarfouce, "焦点施法条", "FocusCastbar")
	MoveHandle.Castbarpet = S.MakeMoveHandle(Castbarpet, "宠物施法条", "PetCastbar")
	
	MoveHandle.ClassCD = S.MakeMoveHandle(ClassCD, "内置CD监视", "ClassCD")
	MoveHandle.Threat = S.MakeMoveHandle(Threat, "仇恨监视", "Threat")
	MoveHandle.Reminder = S.MakeMoveHandle(Reminder, "缺少药剂buff提示", "Reminder")
	MoveHandle.Class = S.MakeMoveHandle(Class, "缺少药剂buff提示", "Class")
	
	if (DB.MyClass == "ROGUE" and DB.MyClass == "DRUID") then  
	MoveHandle.Combatpoint = S.MakeMoveHandle(Combatpoint, "连击点", "Combatpoint")
	end
	if DB.MyClass == "PRIEST" then
	MoveHandle.ShadowPet = S.MakeMoveHandle(ShadowPet, "暗影魔计时条", "ShadowPet")
	end
end