--[[ Element: Leader Icon

 Toggles visibility based on the units leader status.

 Widget

 Leader - Any UI widget.

 Notes

 The default leader icon will be applied if the UI widget is a texture and
 doesn't have a texture or color defined.

 Examples

   -- Position and size
   local Leader = self:CreateTexture(nil, "OVERLAY")
   Leader:SetSize(16, 16)
   Leader:SetPoint("BOTTOM", self, "TOP")
   
   -- Register it with oUF
   self.Leader = Leadera

 Hooks

 Override(self) - Used to completely override the internal update function.
                  Removing the table key entry will make the element fall-back
                  to its internal function again.
]]

local WoW5 = select(4, GetBuildInfo()) == 50001
local parent, ns = ...
local oUF = ns.oUF

local Update = function(self, event)
	local leader = self.Leader
	if(leader.PreUpdate) then
		leader:PreUpdate()
	end

	local unit = self.unit
	local isLeader = UnitIsGroupLeader(unit)
	if(isLeader) then
		leader:Show()
	else
		leader:Hide()
	end

	if(leader.PostUpdate) then
		return leader:PostUpdate(isLeader)
	end
end

local Path = function(self, ...)
	return (self.Leader.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate')
end

local Enable = function(self)
	local leader = self.Leader
	if(leader) then
		leader.__owner = self
		leader.ForceUpdate = ForceUpdate

		self:RegisterEvent("PARTY_LEADER_CHANGED", Path, true)
		if(WoW5) then
			self:RegisterEvent("GROUP_ROSTER_UPDATE", Path, true)
		else
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", Path, true)
		end

		if(leader:IsObjectType"Texture" and not leader:GetTexture()) then
			leader:SetTexture[[Interface\GroupFrame\UI-Group-LeaderIcon]]
		end

		return true
	end
end

local Disable = function(self)
	local leader = self.Leader
	if(leader) then
		self:UnregisterEvent("PARTY_LEADER_CHANGED", Path)
		if(WoW5) then
			self:UnregisterEvent("GROUP_ROSTER_UPDATE", Path)
		else
			self:UnregisterEvent("PARTY_MEMBERS_CHANGED", Path)
		end

	end
end

oUF:AddElement('Leader', Path, Enable, Disable)
