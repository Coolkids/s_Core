local S, _, _, DB = unpack(select(2, ...))

if not IsAddOnLoaded("Quartz") then return end
if not SkinDB.EnableQuartzSkin then return end
local Q3 = LibStub("AceAddon-3.0"):GetAddon("Quartz3")
if not Q3 then return end
Mod_AddonSkins = CreateFrame("Frame")
local Mod_AddonSkins = Mod_AddonSkins
function frame1px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetBackdropColor(.05,.05,.05,0)
	f:SetBackdropBorderColor(.15,.15,.15,0)	
end
function Mod_AddonSkins:SkinFrame(frame)
	frame1px(frame)
	S.CreateShadow(frame)
end



Mod_AddonSkins:RegisterSkin("Quartz",function(Skin, skin, Layout, layout, config)
	-- Skin and Layout overrides
	Skin.SkinQuartzBar = function(self, bar)
		self:SkinFrame(bar)
		-- Skin Icon
		if not bar.IconBorder then
			-- Can't skin a texture, so we create a frame for this
			bar.IconBorder = CreateFrame("Frame",nil,bar)
			self:SkinBackgroundFrame(bar.IconBorder)
			bar.IconBorder:SetPoint("TOPLEFT",bar.Icon,"TOPLEFT",-config.borderWidth,config.borderWidth)
			bar.IconBorder:SetPoint("BOTTOMRIGHT",bar.Icon,"BOTTOMRIGHT",config.borderWidth,-config.borderWidth)
			bar.IconBorder:SetFrameStrata("LOW")
		end
		if bar.config.hideicon then
			bar.IconBorder:Hide()
		else
			bar.IconBorder:Show()
		end
		-- Fonts
		bar.Text:SetFont(DB.Font,bar.config.fontsize)
		bar.TimeText:SetFont(DB.Font,bar.config.timefontsize)
		-- Bar Texture
		bar.Bar:SetStatusBarTexture(DB.Statusbar)
	end
	
	Layout.PositionQuartzBar = dummy
	
	-- Hook Bar Template
	local template = Q3.CastBarTemplate.template
	
	template.ApplySettings_ = template.ApplySettings
	template.ApplySettings = function (self)
		self:ApplySettings_()
		self:SetWidth(self.config.w + config.borderWidth * 2)
		self:SetHeight(self.config.h + config.borderWidth * 2)
		
		skin:SkinQuartzBar(self)
		
		self.Bar:SetFrameStrata("HIGH")
		self:SetFrameStrata("HIGH")
	end
	
	-- Hook spellcasts to reskin after the shield disrupts it.
	template.UNIT_SPELLCAST_NOT_INTERRUPTIBLE_ = template.UNIT_SPELLCAST_NOT_INTERRUPTIBLE
	template.UNIT_SPELLCAST_NOT_INTERRUPTIBLE = function(self, event, unit)
		self:UNIT_SPELLCAST_NOT_INTERRUPTIBLE_(event, unit)
		skin:SkinQuartzBar(self)
	end
	template.UNIT_SPELLCAST_START_ = template.UNIT_SPELLCAST_START
	template.UNIT_SPELLCAST_START = function(self, event, unit)
		self:UNIT_SPELLCAST_START_(event, unit)
		skin:SkinQuartzBar(self)
	end
	
	template.UNIT_SPELLCAST_CHANNEL_START_ = template.UNIT_SPELLCAST_CHANNEL_START
	template.UNIT_SPELLCAST_CHANNEL_START = function(self, event, unit)
		self:UNIT_SPELLCAST_CHANNEL_START_(event, unit)
		skin:SkinQuartzBar(self)
	end
	-- Force updates
	Q3:ApplySettings()
end)