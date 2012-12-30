local S, L, G, _, C = unpack(select(2, ...))
local SunUIConfig = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("SunUIConfig", "AceConsole-3.0", "AceEvent-3.0")
local db = {}
local defaults
local DEFAULT_WIDTH = 800
local DEFAULT_HEIGHT = 500
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local aglin = false
local equipment = {}
function SunUIConfig:LoadDefaults()
	local equipmenttotal = GetNumEquipmentSets()
	for i = 1, equipmenttotal do
		equipment[i] = GetEquipmentSetInfo(i)
	end
	--Defaults
	defaults = {
		profile = {
			ActionBarDB = G["ActionBarDB"],
			NameplateDB = G["NameplateDB"],
			TooltipDB = G["TooltipDB"],
			BuffDB = G["BuffDB"],
			ReminderDB = G["ReminderDB"],
			SkinDB = G["SkinDB"],
			UnitFrameDB = G["UnitFrameDB"],
			MiniDB = G["MiniDB"],
			InfoPanelDB = G["InfoPanelDB"],
			MoveHandleDB = G["MoveHandleDB"],
			PowerBarDB = G["PowerBarDB"],
			WarnDB = G["WarnDB"],
			AnnounceDB = G["AnnounceDB"],
			BagDB = G["BagDB"],
			EquipmentDB = G["EquipmentDB"],
			ClassToolsDB = G["ClassToolsDB"],
		},
	}
end	

function SunUIConfig:OnInitialize()	
	self:Load()
	self.OnInitialize = nil
end

function SunUIConfig:ShowConfig() 
	ACD[ACD.OpenFrames.SunUIConfig and "Close" or "Open"](ACD,"SunUIConfig") 
end

function SunUIConfig:Load()
	self:LoadDefaults()

	-- Create savedvariables
	self.db = LibStub("AceDB-3.0"):New("SunUIConfig", defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	db = self.db.profile

	self:SetupOptions()
end

function SunUIConfig:OnProfileChanged(event, database, newProfileKey)
	StaticPopup_Show("CFG_RELOAD")
end

function SunUIConfig:SetupOptions()
	AC:RegisterOptionsTable("SunUIConfig", self.GenerateOptions)
	ACD:SetDefaultSize("SunUIConfig", DEFAULT_WIDTH, DEFAULT_HEIGHT)

	--Create Profiles Table
	self.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	AC:RegisterOptionsTable("SunUIProfiles", self.profile)
	self.profile.order = -10

	self.SetupOptions = nil
end

function SunUIConfig.GenerateOptions()
	if SunUIConfig.noconfig then assert(false, SunUIConfig.noconfig) end
	if not SunUIConfig.Options then
		SunUIConfig.GenerateOptionsInternal()
		SunUIConfig.GenerateOptionsInternal = nil
	end
	return SunUIConfig.Options
end

function SunUIConfig.GenerateOptionsInternal()
	StaticPopupDialogs["CFG_RELOAD"] = {
		text = L["改变参数需重载应用设置"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function() ReloadUI() end,
		timeout = 0,
		whileDead = 1,
	}

	SunUIConfig.Options = {
		type = "group",
		name = "|cff00d2ffSun|r|cffffffffUI|r",
		args = {
			Header = {
				order = 1,
				type = "header",
				name = L["版本号:"]..GetAddOnMetadata("SunUI", "Version"),
				width = "full",		
			},
			Unlock = {
				order = 2,
				type = "execute",
				name = L["解锁框体"],
				func = function()
					--ACD["Close"](ACD,"SunUIConfig")
					if not UnitAffectingCombat("player") then
						for _, value in pairs(MoveHandle) do value:Show() end
						if not aglin then SlashCmdList.TOGGLEGRID() aglin = true end
					end
					--GameTooltip_Hide()
				end,
			},
			Lock = {
				order = 3,
				type = "execute",
				name = L["锁定框体"],
				func = function()
					if not UnitAffectingCombat("player") then
						for _, value in pairs(MoveHandle) do value:Hide() end
						if aglin then SlashCmdList.TOGGLEGRID() aglin = false end
					end
				end,
			},
			Reload = {
				order = 4,
				type = "execute",
				name = L["应用(重载界面)"],
				func = function()
					if not UnitAffectingCombat("player") then
						ReloadUI()
					end
				end,
			},
			ActionBarDB = {
				order = 5,
				type = "group",
				name = L["动作条"],
				get = function(info) return db.ActionBarDB[ info[#info] ] end,
				set = function(info, value) db.ActionBarDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					group1 = {
					type = "group", order = 1,
					name = " ",guiInline = true,
					args = {
						Bar1Layout = {
							type = "select", order = 1,
							name = L["bar1布局"], desc = L["请选择主动作条布局"],
							values = {[1] = L["12x1布局"], [2] =L["6x2布局"]},
							get = function(info) return db.ActionBarDB.Bar1Layout end,
							set = function(info, value) db.ActionBarDB.Bar1Layout = value
								local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
								Module:UpdateSpace()
							end,
						},
						Bar2Layout = {
							type = "select", order = 2,
							name = L["bar2布局"], desc = L["请选择主动作条布局"],
							values = {[1] = L["12x1布局"], [2] =L["6x2布局"]},
							get = function(info) return db.ActionBarDB.Bar2Layout end,
							set = function(info, value) db.ActionBarDB.Bar2Layout = value
								local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
								Module:UpdateSpace()
							end,
						},
						Bar3Layout = {
							type = "select", order = 3,
							name = L["bar3布局"], desc = L["请选择主动作条布局"],
							values = {[1] = L["12x1布局"], [2] =L["6x2布局"]},
							get = function(info) return db.ActionBarDB.Bar3Layout end,
							set = function(info, value) db.ActionBarDB.Bar3Layout = value
								local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
								Module:UpdateSpace()
							end,
						},	
						Bar4Layout = {
							type = "select", order = 4,
							name = L["bar4布局"], desc = L["请选择主动作条布局"],
							values = {[1] = L["12x1布局"], [2] =L["6x2布局"]},
							get = function(info) return db.ActionBarDB.Bar4Layout end,
							set = function(info, value) db.ActionBarDB.Bar4Layout = value
								local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
								Module:UpdateSpace()
							end,
						},	
						Bar5Layout = {
							type = "select", order = 5,
							name = L["bar5布局"], desc = L["请选择主动作条布局"].."\n need"..L["不要4方块布局"],disabled = function(info) return (db.ActionBarDB.Big4Layout == 1) end,
							values = {[1] = "12x1布局", [2] = "6x2布局"},
							get = function(info) return db.ActionBarDB.Bar5Layout end,
							set = function(info, value) db.ActionBarDB.Bar5Layout = value
								local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
								Module:UpdateSpace()
							end,
						},	
						Big4Layout = {
							type = "select", order = 6,
							name = L["4方块布局"], desc = L["请选择主动作条布局"],
							values = {[1] = L["4方块布局"],  [2] = L["不要4方块布局"] },
						},
					}
				},
					group2 = {
						type = "group", order = 2,
						name = " ",guiInline = true,
						args = {
							HideHotKey = {
								type = "toggle", order = 1,
								name = L["隐藏快捷键显示"],			
							},
							HideMacroName = {
								type = "toggle", order = 2,
								name = L["隐藏宏名称显示"],		
							},
							CooldownFlash = {
								type = "toggle", order = 3,
								name = L["冷却闪光"],	
								get = function(info) return db.ActionBarDB.CooldownFlash end,
								set = function(info, value) db.ActionBarDB.CooldownFlash = value
									local CF = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("CooldownFlash")
									CF:UpdateSet()
								end,
							},
							UnLock = {
								type = "execute",
								name = L["按键绑定"],
								order = 4,
								func = function()
									SlashCmdList.MOUSEOVERBIND()
								end,
							},
						}
					},
					group3 = {
						type = "group", order = 3,
						name = " ",guiInline = true,
						args = {
							ButtonSize = {
								type = "range", order = 1,
								name = L["动作条按钮大小"], desc = L["动作条按钮大小"],
								min = 16, max = 64, step = 1,
								set = function(info, value) 
									db.ActionBarDB.ButtonSize = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateSize(value)
								end,
							},
							ButtonSpacing = {
								type = "range", order = 2,
								name = L["动作条间距大小"], desc = L["动作条间距大小"],
								min = 0, max = 6, step = 1,
								get = function(info) return db.ActionBarDB.ButtonSpacing end,
								set = function(info, value) db.ActionBarDB.ButtonSpacing = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateSpace()
								end,
							},
							FontSize = {
								type = "range", order = 3,
								name = L["动作条字体大小"], desc = L["动作条字体大小"],
								min = 1, max = 36, step = 1,
							},
							MFontSize = {
								type = "range", order = 4,
								name = L["宏名字字体大小"], desc = L["宏名字字体大小"],
								min = 1, max = 36, step = 1,
							},
							MainBarSacle = {
								type = "range", order = 5,
								name = L["主动作条缩放大小"], desc = L["主动作条缩放大小"],
								min = 0, max = 3, step = 0.1,
								get = function(info) return db.ActionBarDB.MainBarSacle end,
								set = function(info, value) db.ActionBarDB.MainBarSacle = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateMainScale()
								end,
							},
							ExtraBarSacle = {
								type = "range", order = 6,
								name = L["特殊按钮缩放大小"], desc = L["特殊按钮缩放大小"],
								min = 0, max = 3, step = 0.1,
								get = function(info) return db.ActionBarDB.ExtraBarSacle end,
								set = function(info, value) db.ActionBarDB.ExtraBarSacle = value
									SunUIExtraActionBar:SetScale(value)
								end,
							},
							PetBarSacle = {
								type = "range", order = 7,
								name = L["宠物条缩放大小"], desc = L["宠物条缩放大小"],
								min = 0, max = 3, step = 0.1,
								get = function(info) return db.ActionBarDB.PetBarSacle end,
								set = function(info, value) db.ActionBarDB.PetBarSacle = value
									SunUIPetBar:SetScale(value)
								end,
							},
							StanceBarSacle = {
								type = "range", order = 8,
								name = L["姿态栏缩放大小"], desc = L["姿态栏缩放大小"],
								min = 0, max = 3, step = 0.1,
								get = function(info) return db.ActionBarDB.StanceBarSacle end,
								set = function(info, value) db.ActionBarDB.StanceBarSacle = value
									SunUIStanceBar:SetScale(value)
								end,
							},
						}
					},
					group4 = {
						type = "group", order = 4,
						name = " ",guiInline = true,
						args = {
							CooldownFlashSize = {
								type = "input",
								name = L["冷却闪光图标大小"],
								desc = L["冷却闪光图标大小"],
								order = 1,
								disabled = function(info) return not db.ActionBarDB.CooldownFlash end,
								get = function() return tostring(db.ActionBarDB.CooldownFlashSize) end,
								set = function(_, value) 
									db.ActionBarDB.CooldownFlashSize = tonumber(value) 
									local CF = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("CooldownFlash")
									CF:UpdateSize()
								end,
							},
							ExpbarWidth= {
								type = "input",
								name = L["经验条宽度"],
								order = 2,
								get = function() return tostring(db.ActionBarDB.ExpbarWidth) end,
								set = function(_, value) 
									db.ActionBarDB.ExpbarWidth = tonumber(value) 
									local EB = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ExpBar")
									EB:UpdateSize()
								end,
							},
							ExpbarHeight= {
								type = "input",
								name = L["经验条高度"],
								order = 3,
								get = function() return tostring(db.ActionBarDB.ExpbarHeight) end,
								set = function(_, value) 
									db.ActionBarDB.ExpbarHeight = tonumber(value) 
									local EB = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ExpBar")
									EB:UpdateSize()
								end,
							},
							ExpbarUp = {
								type = "toggle", order = 4,
								name = L["经验条垂直模式"],
								get = function() return db.ActionBarDB.ExpbarUp end,
								set = function(_, value) 
									db.ActionBarDB.ExpbarUp = value
									local EB = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ExpBar")
									EB:UpdateSize()
								end,
							},
							ExpbarFadeOut = {
								type = "toggle", order = 5,
								name = L["经验条渐隐"],
								get = function() return db.ActionBarDB.ExpbarFadeOut end,
								set = function(_, value) 
									db.ActionBarDB.ExpbarFadeOut = value
									local EB = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ExpBar")
									EB:UpdateFade()
								end,
							},
						}
					},
					group5 = {
						type = "group", order = 1,
						name = " ",guiInline = true,
						args = {		
							AllFade = {
								type = "toggle", order = 2,
								name = L["全部动作条渐隐"],		
							},
							Bar1Fade = {
								type = "toggle", order = 3,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["Bar1渐隐"],		
							},
							Bar2Fade = {
								type = "toggle", order = 4,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["Bar2渐隐"],		
							},
							Bar3Fade = {
								type = "toggle", order = 5,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["Bar3渐隐"],		
							},
							Bar4Fade = {
								type = "toggle", order = 6,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["Bar4渐隐"],		
							},
							Bar5Fade = {
								type = "toggle", order = 7,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["Bar5渐隐"],		
							},
							StanceBarFade = {
								type = "toggle", order = 8,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["姿态栏渐隐"],		
							},

							PetBarFade = {
								type = "toggle", order = 9,
								disabled = function(info) return db.ActionBarDB.AllFade end,
								name = L["宠物渐隐"],		
							},
						}
					},
					group6 = {
						type = "group", order = 6,
						name = " ",guiInline = true, disabled =function(info) return (db.ActionBarDB.Big4Layout ~= 1) end,
						args = {
							BigSize1 = {
								type = "range", order = 1, desc = "大小设置为小于10的时候为关闭按钮",
								name = L["Big1大小"],
								min = 9, max = 80, step = 1,
								set = function(info, value) 
									db.ActionBarDB.BigSize1 = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateBigButtonSize()
								end,
							},
							BigSize2 = {
								type = "range", order = 2, desc = "大小设置为小于10的时候为关闭按钮",
								name = L["Big2大小"],
								min = 9, max = 80, step = 1,
								set = function(info, value) 
									db.ActionBarDB.BigSize2 = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateBigButtonSize()
								end,
							},
							BigSize3 = {
								type = "range", order = 3, desc = "大小设置为小于10的时候为关闭按钮",
								name = L["Big3大小"],
								min = 9, max = 80, step = 1,
								set = function(info, value) 
									db.ActionBarDB.BigSize3 = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateBigButtonSize()
								end,
							},
							BigSize4 = {
								type = "range", order = 4, desc = "大小设置为小于10的时候为关闭按钮",
								name = L["Big4大小"],
								min = 9, max = 80, step = 1,
								set = function(info, value) 
									db.ActionBarDB.BigSize4 = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("actionbar")
									Module:UpdateBigButtonSize()
								end,
							},
						}
					},
				}
			},
			BuffDB = {
				order = 6,
				type = "group",
				name = L["增益效果"],
				get = function(info) return db.BuffDB[ info[#info] ] end,
				set = function(info, value) db.BuffDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					IconSize = {
						type = "input",
						name = L["图标大小"],
						desc = L["图标大小"],
						order = 1,
						get = function() return tostring(db.BuffDB.IconSize) end,
						set = function(_, value) 
							db.BuffDB.IconSize = tonumber(value) 
							local Buff = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Buff")
							Buff:UpdateSet()
						end,
					},
					IconPerRow = {
						type = "input",
						name = L["每行图标数"],
						desc = L["每行图标数"],
						order = 2,
						get = function() return tostring(db.BuffDB.IconPerRow) end,
						set = function(_, value) 
							db.BuffDB.IconPerRow = tonumber(value) 
							local Buff = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Buff")
							Buff:UpdateBuffDirection()
							Buff:UpdateDebuffDirection()
						end,
					},
					BuffDirection = {
						type = "select",
						name = L["BUFF增长方向"],
						desc = L["BUFF增长方向"],
						order = 3,
						values = {[1] = L["从右向左"], [2] = L["从左向右"]},
						get = function() return db.BuffDB.BuffDirection end,
						set = function(_, value) 
							db.BuffDB.BuffDirection = value
							local Buff = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Buff")
							Buff:UpdateBuffDirection()
						end,
					},
					DebuffDirection = {
						type = "select",
						name = L["DEBUFF增长方向"],
						desc = L["DEBUFF增长方向"],
						order = 4,
						values = {[1] = L["从右向左"], [2] = L["从左向右"]},
						get = function() return db.BuffDB.DebuffDirection end,
						set = function(_, value) 
							db.BuffDB.DebuffDirection = value
							local Buff = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Buff")
							Buff:UpdateDebuffDirection()
						end,
					},
					FontSize = {
						type = "input",
						name = L["字体大小"],
						desc = L["字体大小"],
						order = 5,
						get = function() return tostring(db.BuffDB.FontSize) end,
						set = function(_, value) db.BuffDB.FontSize = tonumber(value) end,
					},
				},
			},
			NameplateDB = {
				order = 7,
				type = "group",
				name = L["姓名板"],
				get = function(info) return db.NameplateDB[ info[#info] ] end,
				set = function(info, value) db.NameplateDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
						group1 = {
						type = "group", order = 1,
						name = " ",guiInline = true,
						args = {
							enable = {
								type = "toggle",
								name = L["启用姓名板"],
								order = 1,
								},
							}
						},
						group2 = {
						type = "group", order = 2,
						name = " ",guiInline = true,disabled = function(info) return not db.NameplateDB.enable end,
							args = {
								Fontsize = {
									type = "input",
									name = L["姓名板字体大小"] ,
									desc = L["姓名板字体大小"] ,
									order = 1,
									get = function() return tostring(db.NameplateDB.Fontsize) end,
									set = function(_, value) db.NameplateDB.Fontsize = tonumber(value) end,
								},
								HPHeight = {
									type = "input",
									name = L["姓名板血条高度"],
									desc = L["姓名板血条高度"] ,
									order = 2,
									get = function() return tostring(db.NameplateDB.HPHeight) end,
									set = function(_, value) db.NameplateDB.HPHeight = tonumber(value) end,
								},
								HPWidth = {
									type = "input",
									name = L["姓名板血条宽度"],
									desc = L["姓名板血条宽度"],
									order = 3,
									get = function() return tostring(db.NameplateDB.HPWidth) end,
									set = function(_, value) db.NameplateDB.HPWidth = tonumber(value) end,
								},
								CastBarIconSize = {
									type = "input",
									name = L["姓名板施法条图标大小"],
									desc = L["姓名板施法条图标大小"],
									order = 4,
									get = function() return tostring(db.NameplateDB.CastBarIconSize) end,
									set = function(_, value) db.NameplateDB.CastBarIconSize = tonumber(value) end,
								},
								CastBarHeight = {
									type = "input",
									name = L["姓名板施法条高度"],
									desc = L["姓名板施法条高度"],
									order = 5,
									get = function() return tostring(db.NameplateDB.CastBarHeight) end,
									set = function(_, value) db.NameplateDB.CastBarHeight = tonumber(value) end,
								},
								CastBarWidth = {
									type = "input",
									name = L["姓名板施法条宽度"],
									desc = L["姓名板施法条宽度"],
									order = 6,
									get = function() return tostring(db.NameplateDB.CastBarWidth) end,
									set = function(_, value) db.NameplateDB.CastBarWidth = tonumber(value) end,
								},
								Combat = {
									type = "toggle",
									name = L["启用战斗显示"],
									order = 7,
								},
								NotCombat = {
									type = "toggle",
									name = L["启用脱离战斗隐藏"],
									order = 8,
								},
								Showdebuff = {
									type = "toggle",
									name = L["启用debuff显示"],
									order = 9,
								},
							}
						},
				}
			},
			TooltipDB = {
				order = 8,
				type = "group",
				name = L["鼠标提示"],
				get = function(info) return db.TooltipDB[ info[#info] ] end,
				set = function(info, value) db.TooltipDB[ info[#info] ] = value end,
				args = {
					Cursor = {
						type = "toggle",
						name = L["提示框体跟随鼠标"],
						order = 1,
					},
					HideInCombat = {
						type = "toggle",
						name = L["进入战斗自动隐藏"],
						order = 2,
					},
					FontSize = {
						type = "range", order = 3,
						name = L["字体大小"], desc = L["字体大小"],
						min = 2, max = 22, step = 1,
					},
					HideTitles = {
						type = "toggle",
						name = L["隐藏头衔"],
						order = 4,
					},
				}
			},
			ReminderDB = {
				order = 9,
				type = "group",
				name = L["缺失提醒"],
				get = function(info) return db.ReminderDB[ info[#info] ] end,
				set = function(info, value) db.ReminderDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					ShowRaidBuff = {
						type = "toggle", order = 1,
						name = L["显示团队增益缺失提醒"],
					},
					Gruop_1 = {
						type = "group", order = 2,
						name = " ", guiInline = true, disabled = function(info) return not db.ReminderDB.ShowRaidBuff end,
						args = {
							ShowOnlyInParty = {
								type = "toggle", order = 1,
								name = L["只在队伍中显示"],
							}, 
							RaidBuffSize = {
								type = "input", order = 2,
								name = L["团队增益图标大小"], desc = L["团队增益图标大小"],disabled = function(info) return true end,
								get = function() return tostring(db.ReminderDB.RaidBuffSize) end,
								set = function(_, value) db.ReminderDB.RaidBuffSize = tonumber(value) end,
							},
							RaidBuffDirection = {
								type = "select", order = 3,
								name = L["团队增益图标排列方式"], desc = L["团队增益图标排列方式"],
								values = {[1] = L["横排"], [2] = L["竖排"]},
								get = function() return db.ReminderDB.RaidBuffDirection end,
								set = function(_, value) db.ReminderDB.RaidBuffDirection = value end,
							},
						},
					},
					ShowClassBuff = {
						type = "toggle", order = 3,
						name = L["显示职业增益缺失提醒"],
					},
					Gruop_2 = {
						type = "group", order = 4,
						name = " ", guiInline = true, disabled = function(info) return not db.ReminderDB.ShowClassBuff end,
						args = {
							ClassBuffSize = {
								type = "input", order = 1,
								name = L["职业增益图标大小"], desc = L["职业增益图标大小"],
								get = function() return tostring(db.ReminderDB.ClassBuffSize) end,
								set = function(_, value) db.ReminderDB.ClassBuffSize = tonumber(value) end,
							},
						},
					},
				}
			},
			SkinDB = {
				order = 10,
				type = "group",
				name = L["界面皮肤"],
				get = function(info) return db.SkinDB[ info[#info] ] end,
				set = function(info, value) db.SkinDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {	
					EnableDBMSkin = {
					type = "toggle",
					name = L["启用DBM皮肤"],
					order = 1,
					},
				}
			},
			UnitFrameDB = {
				order = 11,
				type = "group",
				name = L["头像框体"],
				get = function(info) return db.UnitFrameDB[ info[#info] ] end,
				set = function(info, value) db.UnitFrameDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					group1 = {
					type = "group", order = 1,
					name = "大小",guiInline = true,
					args = {
						FontSize = {
							type = "range", order = 1,
							name = L["头像字体大小"],
							min = 2, max = 28, step = 1,
							get = function() return db.UnitFrameDB.FontSize end,
							set = function(_, value) db.UnitFrameDB.FontSize = value end,
						},
						Width = {
							type = "input",
							name = L["玩家与目标框体宽度"],
							desc = L["玩家与目标框体宽度"],
							order = 2,
							get = function() return tostring(db.UnitFrameDB.Width) end,
							set = function(_, value) 
								db.UnitFrameDB.Width = tonumber(value) 
								local player = _G["oUF_SunUIPlayer"]
								local target = _G["oUF_SunUITarget"]
								if player then
									player:SetWidth(db.UnitFrameDB.Width)
									player.Health:SetWidth(db.UnitFrameDB.Width)
									player.Power:SetWidth(db.UnitFrameDB.Width)
									target:SetWidth(db.UnitFrameDB.Width)
									target.Health:SetWidth(db.UnitFrameDB.Width)
									target.Power:SetWidth(db.UnitFrameDB.Width)
								end
								if MoveHandle.SunUIPlayerFrame then
									MoveHandle.SunUIPlayerFrame:SetWidth(db.UnitFrameDB.Width)
									MoveHandle.SunUITargetFrame:SetWidth(db.UnitFrameDB.Width)
								end
							end,
						},
						Height = {
							type = "input",
							name = L["玩家与目标框体高度"],
							desc = L["玩家与目标框体高度"],
							order = 3,
							get = function() return tostring(db.UnitFrameDB.Height) end,
							set = function(_, value) 
								db.UnitFrameDB.Height = tonumber(value) 
								local player = _G["oUF_SunUIPlayer"]
								local target = _G["oUF_SunUITarget"]
								if player then
									player:SetHeight(db.UnitFrameDB.Width)
									player.Health:SetHeight(db.UnitFrameDB.Width)
									player.Power:SetHeight(db.UnitFrameDB.Width)
									target:SetHeight(db.UnitFrameDB.Width)
									target.Health:SetHeight(db.UnitFrameDB.Width)
									target.Power:SetHeight(db.UnitFrameDB.Width)
								end
								if MoveHandle.SunUIPlayerFrame then
									MoveHandle.SunUIPlayerFrame:SetHeight(db.UnitFrameDB.Width)
									MoveHandle.SunUITargetFrame:SetHeight(db.UnitFrameDB.Width)
								end
							end,
						},
						Scale = {
							type = "range", order = 4,
							name = L["头像缩放大小"], desc = L["头像缩放大小"],
							min = 0.2, max = 2, step = 0.1,
							get = function() return db.UnitFrameDB.Scale end,
							set = function(_, value) db.UnitFrameDB.Scale = value end,
						},
						PetWidth = {
							type = "input",
							name = L["宠物ToT焦点框体宽度"],
							order = 5,
							get = function() return tostring(db.UnitFrameDB.PetWidth) end,
							set = function(_, value) db.UnitFrameDB.PetWidth = tonumber(value) end,
						},
						PetHeight = {
							type = "input",
							name = L["宠物ToT焦点框体高度"],
							order = 6,
							get = function() return tostring(db.UnitFrameDB.PetHeight) end,
							set = function(_, value) db.UnitFrameDB.PetHeight = tonumber(value) end,
						},
						PetScale = {
							type = "range", order = 7,
							name = L["宠物ToT焦点缩放大小"],
							min = 0.2, max = 2, step = 0.1,
							get = function() return db.UnitFrameDB.PetScale end,
							set = function(_, value) db.UnitFrameDB.PetScale = value end,
						},
						BossWidth = {
							type = "input",
							name = L["Boss小队竞技场框体宽度"],
							desc = L["Boss小队竞技场框体宽度"],
							order = 8,
							get = function() return tostring(db.UnitFrameDB.BossWidth) end,
							set = function(_, value) db.UnitFrameDB.BossWidth = tonumber(value) end,
						},
						BossHeight = {
							type = "input",
							name = L["Boss小队竞技场框体高度"],
							desc = L["Boss小队竞技场框体高度"],
							order = 9,
							get = function() return tostring(db.UnitFrameDB.BossHeight) end,
							set = function(_, value) db.UnitFrameDB.BossHeight = tonumber(value) end,
						},
						BossScale = {
							type = "range", order = 10,
							name = L["Boss小队竞技场缩放大小"],
							min = 0.2, max = 2, step = 0.1,
							get = function() return db.UnitFrameDB.BossScale end,
							set = function(_, value) db.UnitFrameDB.BossScale = value end,
						},
						Alpha3D = {
							type = "range", order = 11,
							name = L["头像透明度"],
							min = 0, max = 1, step = 0.1,
							get = function() return db.UnitFrameDB.Alpha3D end,
							set = function(_, value) db.UnitFrameDB.Alpha3D = value end,
						},
						BigFocus = {
							type = "toggle", order = 12,
							name = L["焦点放大"],
						},
						CastBar = {
							type = "toggle", order = 13,
							name = L["施法条开关"],
						},
						TargetRange = {
							type = "toggle", order = 14,
							name = L["距离监视"],
							desc = L["超过40码头像渐隐"],
						}, 
						RangeAlpha = {
							type = "range", order = 15,
							name = L["距离监视透明度"],
							desc = L["超出距离头像透明度"],
							min = 0, max = 1, step = 0.1,
							get = function() return db.UnitFrameDB.RangeAlpha end,
							set = function(_, value) db.UnitFrameDB.RangeAlpha = value end,
						}, 
						FocusDebuff = {
							type = "toggle", order = 16,disabled = function(info) return not db.UnitFrameDB.showfocus end,
							name = L["焦点debuff过滤"],
							desc = L["只显示玩家释放的debuff"],
						}, 
						TagFadeIn = {
							type = "toggle", order = 17,
							name = L["头像文字渐隐"],
							desc = L["非战斗非指向时隐藏"],
						}, 
					}
					},
					group2 = {
						type = "group", order = 2,
						name = " ",guiInline = true,
						args = {
							ReverseHPbars = {
								type = "toggle", order = 1,
								name = L["血条非透明模式"],
								desc = L["不打钩为透明模式"],
								get = function() return db.UnitFrameDB.ReverseHPbars end,
								set = function(_, value) db.UnitFrameDB.ReverseHPbars = value end,
							},
							ClassColor = {
								type = "toggle", order = 2,
								name = L["开启头像职业血条颜色"],			
							},
							showtot = {
								type = "toggle", order = 3,
								name = L["开启目标的目标"],			
							},
							showpet = {
								type = "toggle", order = 4,
								name = L["开启宠物框体"],			
							},
							showfocus = {
								type = "toggle", order = 5,
								name = L["开启焦点框体"],			
							},
							showparty = {
								type = "toggle", order = 6,
								name = L["开启小队框体"],			
							},
							Party3D = {
							type = "toggle", order = 7,disabled = function(info) return not db.UnitFrameDB.showparty end,
							name = L["小队头像"],
							},
							showboss = {
								type = "toggle", order = 8,
								name = L["开启boss框体"],			
							},
							showarena = {
								type = "toggle", order = 9,
								name = L["开启竞技场框体"],			
							},
							EnableVengeanceBar = {
								type = "toggle", order = 10,
								name = L["开启复仇监视"],
							},
							EnableThreat = {
								type = "toggle", order = 11,
								name = L["开启仇恨监视"],			
							},
							EnableBarFader = {
								type = "toggle", order = 12,
								name = L["开启头像渐隐"],			
							},
							TargetAura = {
								type = "select", order = 13,
								name = L["目标增减益"],
								values = {[1] = L["显示"], [2] =L["不显示"], [3] = "Only Player"},
							},
							PlayerBuff = {
								type = "select",
								name = L["玩家框体BUFF显示"],
								order = 14,
								values = {[1] = "debuff", [2] = "buff", [3] = "debuff+buff", [4] = "none"},
							},
						}
					},
					group3 = {
						type = "group", order = 3,
						name = " ",guiInline = true,disabled = function(info) return (db.UnitFrameDB.CastBar == false) end,
						args = {
							playerCBuserplaced = {
								type = "toggle", order = 1,
								name = L["锁定玩家施法条到玩家头像"],			
							},
							PlayerCastBarWidth = {
								type = "input",
								name = L["玩家施法条宽度"],
								desc = L["玩家施法条宽度"],
								order = 2,
								get = function() return tostring(db.UnitFrameDB.PlayerCastBarWidth) end,
								set = function(_, value) 
									db.UnitFrameDB.PlayerCastBarWidth = tonumber(value) 
								end,
							},
							PlayerCastBarHeight = {
								type = "input",
								name = L["玩家施法条高度"],
								desc = L["玩家施法条高度"],
								order = 3,
								get = function() return tostring(db.UnitFrameDB.PlayerCastBarHeight) end,
								set = function(_, value) 
									db.UnitFrameDB.PlayerCastBarHeight = tonumber(value) 	
								end,
							},
							NewLine = {
								type = "description", order = 4,
								name = "\n",					
							},
							targetCBuserplaced = {
								type = "toggle", order = 5,
								name = L["锁定目标施法条到目标框体"],			
							},
							TargetCastBarWidth = {
								type = "input",
								name = L["目标施法条宽度"],
								desc = L["目标施法条宽度"],
								order = 6,
								get = function() return tostring(db.UnitFrameDB.TargetCastBarWidth) end,
								set = function(_, value) 
									db.UnitFrameDB.TargetCastBarWidth = tonumber(value) 
								end,
							},
							TargetCastBarHeight = {
								type = "input",
								name = L["目标施法条高度"],
								desc = L["目标施法条高度"],
								order = 7,
								get = function() return tostring(db.UnitFrameDB.TargetCastBarHeight) end,
								set = function(_, value) 
									db.UnitFrameDB.TargetCastBarHeight = tonumber(value) 
								end,
							},
							NewLine = {
								type = "description", order = 8,
								name = "\n",					
							},
							focusCBuserplaced = {
								type = "toggle", order = 9,
								name = L["锁定焦点施法条到焦点框体"],			
							},
							FocusCastBarWidth = {
								type = "input",
								name = L["焦点施法条宽度"],
								desc = L["焦点施法条宽度"],
								order = 10,
								get = function() return tostring(db.UnitFrameDB.FocusCastBarWidth) end,
								set = function(_, value) db.UnitFrameDB.FocusCastBarWidth = tonumber(value) end,
							},
							FocusCastBarHeight = {
								type = "input",
								name = L["焦点施法条高度"],
								desc = L["焦点施法条高度"],
								order = 11,
								get = function() return tostring(db.UnitFrameDB.FocusCastBarHeight) end,
								set = function(_, value) db.UnitFrameDB.FocusCastBarHeight = tonumber(value) end,
							},
						}
					},
				}
			},
			MiniDB = {
				order = 12,
				type = "group",
				name = "Mini",
				get = function(info) return db.MiniDB[ info[#info] ] end,
				set = function(info, value) db.MiniDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					group1 = {
					type = "group", order = 1,
					name = L["小东西设置"],
						args = {
							AutoSell = {
								type = "toggle",
								name = L["启用出售垃圾"],
								order = 1,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local AS = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("AutoSell")
									AS:UpdateSet()
								end,
							},
							AutoRepair = {
								type = "toggle",
								name = L["启用自动修理"],
								order = 2,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local AR = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("AutoRepair")
									AR:UpdateSet()
								end,
							},
							ChatFilter = {
								type = "toggle",
								name = L["启用聊天信息过滤"],
								order = 3,
							},
							FastError = {
								type = "toggle",
								name = L["启用系统红字屏蔽"],
								order = 4,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local FE = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("FastError")
									FE:UpdateSet()
								end,
							},
							Icicle = {
								type = "toggle",
								name = L["PVP冷却计时"],
								order = 6,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local IC = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Icicle")
									IC:UpdateSet()
								end,
							},
							MiniMapPanels = {
								type = "toggle",
								name = L["启用团队工具"], desc = L["需要团长或者助理权限"],
								order = 8,
							},
							Autoinvite = {
								type = "toggle",
								name = L["启用自动邀请"],
								order = 9,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local ST = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Settings")
									ST:UpdateSet()
								end,
							},
							INVITE_WORD = {
								type = "input",
								name = L["自动邀请关键字"],
								desc = L["自动邀请关键字"],
								disabled = function(info) return not db.MiniDB.Autoinvite end,
								order = 10,
								get = function() return tostring(db.MiniDB.INVITE_WORD) end,
								set = function(_, value) db.MiniDB.INVITE_WORD = tostring(value) end,
							},
							HideRaid = {
								type = "toggle",
								name = "Hide Blz RAID Frame",
								desc = L["隐藏暴雪团队框架"],
								order = 12,
							},
							HideRaidWarn = {
								type = "toggle",
								name = L["隐藏团队警告"],
								order = 13,
							},
							Disenchat = {
								type = "toggle",
								name = "Quick Disenchat",
								desc = L["快速分解"],
								order = 14,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local ST = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Settings")
									ST:UpdateSet()
								end,
							},
							Resurrect = {
								type = "toggle",
								name = "Auto AcceptResurrect",
								desc = L["自动接受复活"],
								order = 15,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local ST = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Settings")
									ST:UpdateSet()
								end,
							},
							IPhoneLock = {
								type = "toggle",
								name = "SlideLock",
								desc = L["AFK锁屏"],
								order = 16,
								get = function(info) return db.MiniDB[ info[#info] ] end,
								set = function(info, value) db.MiniDB[ info[#info] ] = value
									local AL = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("AFKLock")
									AL:UpdateSet()
								end,
							},
							AutoQuest = {
								type = "toggle",
								name = "AutoQuest",
								desc = L["自动交接任务"],
								order = 17,
							},
							DNDFilter = {
								type = "toggle",
								name = "DNDFilter",
								desc = L["过滤DND/AFK自动回复消息"],
								order = 18,
							},
							TimeStamps = {
								type = "toggle",
								name = "TimeStamps",
								desc = L["聊天时间戳"],
								order = 19,
							},
							ChatBackground = {
								type = "toggle",
								name = L["聊天框背景"],
								order = 20,
							},
							Combat = {
								type = "toggle",
								name = L["战斗提醒"],
								desc = L["进出战斗提醒"],
								order = 21,
							},
							Aurora = {
								type = "toggle",
								name = L["Aurora主题"],
								desc = L["透明模式"],
								order = 22,
							},
							FogClear = {
								type = "toggle",
								name = L["显示未探索地区"],
								order = 23,
							},
							uistyle= {
								type = "select",
								name = "ui style",
								order = 24,
								values = {
									["plane"] = "plane",
									["stereo"] = "stereo",
								},
							},
						}
					},
					group2 = {
					type = "group", order = 2,
					name = L["UI缩放"],
						args = {
							uiScale = {
								type = "range", order = 1,
								name = L["UI缩放大小"], desc = L["UI缩放大小"],
								min = 0.65, max = 1.4, step = 0.01,
							},
							accept = {
								type = "execute", order = 2,
								name = L["应用"], desc = L["应用"],
								func = function()  SetCVar("useUiScale", 1) SetCVar("uiScale", db.MiniDB.uiScale) ReloadUI() end,
							},	
							NewLine = {
								type = "description", order = 3,
								name = "\n",					
							},
							FontScale = {
								type = "range", order = 4,
								name = L["全局字体大小"], desc = L["全局字体大小"],
								min = 0.20, max = 2.50, step = 0.01,
							},
						}
					},
					group3 = {
					type = "group", order = 3,
					name = L["内置CD"],
						args = {
							ClassCDOpen = {
								type = "toggle",
								name = L["启动内置CD"],
								order = 1,
								get = function() return db.MiniDB.ClassCDOpen end,
								set = function(_, value) 
									db.MiniDB.ClassCDOpen = value
									local CCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassCD")
									CCD:UpdateSet()
								end,
							},
							group = {
								type = "group", order = 2,
								name = " ",guiInline = true,
								disabled = function(info) return not db.MiniDB.ClassCDOpen end,
								args = {
									ClassCDIcon = {
										type = "toggle",
										name = L["启用图标模式"],
										order = 1,
									},
									ClassCDIconSize = {
										type = "input",
										name = L["图标大小"],
										desc = L["图标大小"], disabled = function(info) return not db.MiniDB.ClassCDIcon end,
										order = 2,
										get = function() return tostring(db.MiniDB.ClassCDIconSize) end,
										set = function(_, value) 
											db.MiniDB.ClassCDIconSize = tonumber(value) 
											local CCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassCD")
											CCD:UpdateSize()
										end,
									},
									ClassCDIconDirection = {
										type = "select",
										name = L["BUFF增长方向"],
										desc = L["BUFF增长方向"],
										order = 3, disabled =function(info) return not db.MiniDB.ClassCDIcon end,
										values = {[1] = L["从左向右"], [2] = L["从右向左"]},
										get = function() return db.MiniDB.ClassCDIconDirection end,
										set = function(_, value) 
											db.MiniDB.ClassCDIconDirection = value
											local CCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassCD")
											CCD:UpdatePositions()
										end,
									},
									ClassFontSize = {
										type = "range", order = 4,
										name = L["内置CD字体大小"], desc = L["内置CD字体大小"], disabled = function(info) return db.MiniDB.ClassCDIcon end,
										min = 4, max = 28, step = 1,
										--get = function() return db.MiniDB.ClassFontSize end,
										--set = function(_, value) db.MiniDB.ClassFontSize = value end,
									},
									ClassCDWidth = {
										type = "input",
										name = L["框体宽度"],
										desc = L["框体宽度"], disabled = function(info) return db.MiniDB.ClassCDIcon end,
										order = 5,
										get = function() return tostring(db.MiniDB.ClassCDWidth) end,
										set = function(_, value) 
											db.MiniDB.ClassCDWidth = tonumber(value) 
											local CCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassCD")
											CCD:UpdateSize()
										end,
									},
									ClassCDHeight = {
										type = "input",
										name = L["框体高度"],
										desc = L["框体高度"],
										order = 6, disabled =  function(info) return db.MiniDB.ClassCDIcon end,
										get = function() return tostring(db.MiniDB.ClassCDHeight) end,
										set = function(_, value) 
											db.MiniDB.ClassCDHeight = tonumber(value)
											local CCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassCD")
											CCD:UpdateSize()
										end,
									},
									ClassCDDirection = {
										type = "select",
										name = L["计时条增长方向"],
										desc = L["计时条增长方向"],
										order = 7, disabled = function(info) return db.MiniDB.ClassCDIcon end,
										values = {[1] = L["向下"], [2] = L["向上"]},
										get = function() return db.MiniDB.ClassCDDirection end,
										set = function(_, value) 
											db.MiniDB.ClassCDDirection = value 
											local CCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassCD")
											CCD:UpdatePositions()
										end,
									},
								}		
							},
						}
					},
					group4 = {
					type = "group", order = 4,
					name = "RaidCD",
						args = {
							RaidCD = {
								type = "toggle",
								name = L["打开团队技能CD监视"],
								order = 1,
								get = function() return db.MiniDB.RaidCD end,
								set = function(_, value) 
									db.MiniDB.RaidCD = value 
									local RCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("RaidCD")
									RCD:UpdateSet()
								end,
							},
							group = {
								type = "group", order = 2,
								name = " ",guiInline = true,
								disabled = function(info) return not db.MiniDB.RaidCD end,
								args = {
									RaidCDFontSize = {
										type = "range", order = 1,
										name = L["字体大小"], desc = L["字体大小"],
										min = 4, max = 28, step = 1,
										get = function() return db.MiniDB.RaidCDFontSize end,
										set = function(_, value) db.MiniDB.RaidCDFontSize = value end,
									},
									RaidCDWidth = {
										type = "input",
										name = L["框体宽度"],
										desc = L["框体宽度"],
										order = 2,
										get = function() return tostring(db.MiniDB.RaidCDWidth) end,
										set = function(_, value) 
											db.MiniDB.RaidCDWidth = tonumber(value) 
											local RCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("RaidCD")
											RCD:UpdateSize()
										end,
									},
									RaidCDHeight = {
										type = "input",
										name = L["框体高度"],
										desc = L["框体高度"],
										order = 3,
										get = function() return tostring(db.MiniDB.RaidCDHeight) end,
										set = function(_, value) 
											db.MiniDB.RaidCDHeight = tonumber(value) 
											local RCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("RaidCD")
											RCD:UpdateSize()
										end,
									},
									RaidCDDirection = {
										type = "select",
										name = L["计时条增长方向"],
										desc = L["计时条增长方向"],
										order = 4,
										values = {[1] = L["向下"], [2] = L["向上"]},
										get = function() return db.MiniDB.RaidCDDirection end,
										set = function(_, value) 
											db.MiniDB.RaidCDDirection = value
											local RCD = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("RaidCD")
											RCD:UpdatePositions()
										end,
									},
								}		
							},
						}
					},
				}
			},
			InfoPanelDB = {
				order = 13,
				type = "group",
				name = L["信息面板"],
				get = function(info) return db.InfoPanelDB[ info[#info] ] end,
				set = function(info, value) db.InfoPanelDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					OpenTop = {
					type = "toggle",
					name = L["启用顶部信息条"],
					order = 1,
					},
					OpenBottom = {
						type = "toggle",
						name = L["启用底部信息条"],
						order = 2,
					},
					Friend = {
					type = "toggle",
					name = FRIENDS,
					order = 3,
					},
					Guild = {
						type = "toggle",
						name = GUILD,
						order = 4,
					},
				}
			},	
			PowerBarDB = {
				order = 14,
				type = "group",
				name = L["职业能量条"],
				get = function(info) return db.PowerBarDB[ info[#info] ] end,
				set = function(info, value) db.PowerBarDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					group1 = {
						type = "group", order = 1,
						name = "",guiInline = true,
						args = {
							Open = {
							type = "toggle",
							name = L["启用职业能量条"],
							order = 1,
							},
						}
					},
					group2 = {
						type = "group", order = 2, guiInline = true, disabled = function(info) return not db.PowerBarDB.Open end,
						name = "",
						args = {
							Width = {
								type = "input",
								name = L["框体宽度"],
								order = 1,
								get = function() return tostring(db.PowerBarDB.Width) end,
								set = function(_, value)
									db.PowerBarDB.Width = tonumber(value)
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SunUIPowerBar")
									Module:UpdateSize()
								end,
							},
							Height = {
								type = "input",
								name = L["框体高度"],
								order = 2,
								get = function() return tostring(db.PowerBarDB.Height) end,
								set = function(_, value) 
									db.PowerBarDB.Height = tonumber(value)
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SunUIPowerBar")
									Module:UpdateSize()
								end,
							},
							Scale = {
								type = "range", order = 3,disabled =function(info) return true end,
								name = "框体缩放", desc = "框体缩放",
								min = 0, max = 1, step = 0.01,
							},
							Fade = {
							type = "toggle",
							name = L["渐隐"],
							order = 4,
								get = function() return db.PowerBarDB.Fade end,
								set = function(_, value)
									db.PowerBarDB.Fade = value
									local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SunUIPowerBar")
									Module:UpdateFade()
								end,
							},
							HealthPower = {
							type = "toggle",
							name = L["生命值"],
							order = 5,
							},
						}
					},
				},
			},
			WarnDB = {
				order = 15,
				type = "group",
				name = L["警告提示"],
				get = function(info) return db.WarnDB[ info[#info] ] end,
				set = function(info, value) db.WarnDB[ info[#info] ] = value end,
				args = {
					group1 = {
						type = "group", order = 1,
						name = "",guiInline = true,
						args = {
							Open = {
							type = "toggle",
							name = L["启用警告提示"],
							order = 1,
							get = function() return db.WarnDB.Open end,
							set = function(_, value) 
								db.WarnDB.Open = value
								local W = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Warnning")
								W:UpdateSet()
							end,
							},
						}
					},
					group2 = {
						type = "group", order = 2, guiInline = true, disabled = function(info) return not db.WarnDB.Open end,
						name = "",
						args = {
							-- Width = {
								-- type = "input",
								-- name = L["框体宽度"],
								-- order = 1,
								-- get = function() return tostring(db.WarnDB.Width) end,
								-- set = function(_, value) db.WarnDB.Width = tonumber(value) end,
							-- },
							-- Height = {
								-- type = "input",
								-- name = L["框体高度"],
								-- order = 1,
								-- get = function() return tostring(db.WarnDB.Height) end,
								-- set = function(_, value) db.WarnDB.Height = tonumber(value) end,
							-- },
							-- FontSize = {
								-- type = "range", order = 3,
								-- name = L["字体大小"],
								-- min = 1, max = 28, step = 1,
							-- },
							Health = {
							type = "toggle",
							name = L["低血量"], desc = L["开启低血量报警"],
							order = 4,
							get = function() return db.WarnDB.Health end,
							set = function(_, value) 
								db.WarnDB.Health = value
								local W = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Warnning")
								W:UpdateSet()
							end,
							},
						}
					},
				},
			},
			AnnounceDB = {
				order = 16,
				type = "group",
				name = L["施法通告"],
				get = function(info) return db.AnnounceDB[ info[#info] ] end,
				set = function(info, value) 
					db.AnnounceDB[ info[#info] ] = value
					local A = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Announce")
					A:UpdateSet() 
				end,
				args = {
					group1 = {
						type = "group", order = 1,
						name = "",guiInline = true,
						args = {
							Open = {
							type = "toggle",
							name = L["启用施法通告"],
							desc = L["只是通告自己施放的法术"],
							order = 1,
							},
						}
					},
					group2 = {
						type = "group", order = 2, guiInline = true, disabled = function(info) return not db.AnnounceDB.Open end,
						name = "",
						args = {
							Interrupt = {
							type = "toggle",
							name = L["启用打断通告"],
							order = 1,
							},
							Channel = {
							type = "toggle",
							name = L["启用治疗大招通告"],
							order = 2,
							},
							Mislead = {
							type = "toggle",
							name = L["启用误导通告"],
							order = 3,
							},
							BaoM = {
							type = "toggle",
							name = L["启用保命技能通告"],
							order = 4,
							},
							Give = {
							type = "toggle",
							name = L["启用给出大招通告"],
							desc = L["包含天使,痛苦压制,保护等等"],
							order = 5,
							},
							Resurrect = {
							type = "toggle",
							name = L["启用复活技能通告"],
							order = 6,
							},
							Heal = {
							type = "toggle",
							name = L["启用团队减伤通告"],
							order = 7,
							},
							Flump = {
								type = "toggle",
								name = L["启用队友施法通告"],
								order = 8,
							},
						}
					},
				},
			},
			BagDB = {
				order = 17,
				type = "group",
				name = "背包设置",
				get = function(info) return db.BagDB[ info[#info] ] end,
				set = function(info, value) db.BagDB[ info[#info] ] = value; end,
				args = {
					group1 = {
						type = "group", order = 1, guiInline = true,
						name = "",
						args = {
							BagSize = {
								type = "range", order = 1,
								name = L["背包图标"],
								min = 20, max = 50, step = 1,
								set = function(info, value)
									db.BagDB.BagSize = value
									local B = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Bags")
									B:Layout(false) 
								end,
							},
							BankSize = {
								type = "range", order = 2,
								name = L["银行图标"],
								min = 20, max = 50, step = 1,
								set = function(info, value)
									db.BagDB.BankSize = value
									local B = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Bags")
									B:Layout(true) 
								end,
							},
							Spacing = {
								type = "range", order = 3,
								name = L["图标间距"], desc = L["图标间距"],
								min = 0, max = 10, step = 1,
								set = function(info, value)
									db.BagDB.Spacing = value
									local B = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Bags")
									B:Layout(true)
									B:Layout(false) 
								end,
							},
							BagWidth = {
								type = "input",
								name = L["背包框体宽度"],
								order = 4,
								get = function() return tostring(db.BagDB.BagWidth) end,
								set = function(_, value) 
									db.BagDB.BagWidth = tonumber(value) 
									local B = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Bags")
									B:Layout(false) 
								end,
							},
							BankWidth = {
								type = "input",
								name = L["银行框体宽度"],
								order = 5,
								get = function() return tostring(db.BagDB.BankWidth) end,
								set = function(_, value) 
									db.BagDB.BankWidth = tonumber(value) 
									local B = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("Bags")
									B:Layout(true) 
								end,
							},
						}
					},
				},
			},
			EquipmentDB = {
				order = 18,
				type = "group",
				name = L["自动换装"],
				get = function(info) return db.EquipmentDB[ info[#info] ] end,
				set = function(info, value) db.EquipmentDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					group1 = {
						type = "group", order = 1, guiInline = true,
						name = "",
						args = {
							Enable = {
								type = "toggle",
								name = L["启用自动换装"],
								order = 1,
								get = function()
									return db.EquipmentDB.Enable
								end,
								set = function(info, value)
									db.EquipmentDB.Enable = value
									local Settings = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("AutoEquipment")
									Settings:UpdataSet()
								end,
							},
						}
					},
					group2 = {
						type = "group", order = 2, guiInline = true, disabled = function(info) return not db.EquipmentDB.Enable end,
						name = "",
						args = {
							FirstName = {
								type = "select",
								name = L["选择主天赋装备"],
								order = 1,
								get = function()
									return db.EquipmentDB.FirstName
								end,
								set = function(info, value)
									db.EquipmentDB.FirstName = value
									local SetName = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("AutoEquipment")
									SetName:Equipment()
								end,
								values = equipment,	
							},
							SecondName = {
								type = "select",
								name = L["选择副天赋装备"],
								order = 2,
								get = function()
									return db.EquipmentDB.SecondName
								end,
								set = function(info, value)
									db.EquipmentDB.SecondName = value
									local SetName = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("AutoEquipment")
									SetName:Equipment()
								end,
								values = equipment,	
							},
						}
					},
				},
			},
			ClassToolsDB = {
				order = 19,
				type = "group",
				name = "Class Tools",
				get = function(info) return db.ClassToolsDB[ info[#info] ] end,
				set = function(info, value) db.ClassToolsDB[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {
					group1 = {
						type = "group", order = 1, guiInline = true,
						name = "",
						args = {
							Enable = {
								type = "toggle",
								name = "Enable ClassTools",
								order = 1,
								set = function(info, value) 
									db.ClassToolsDB.Enable = value 
									local CT = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassTools")
									CT:UpdateSet()
								end,
							},
							Size = {
								type = "range", order = 2, disabled = function(info) return not db.ClassToolsDB.Enable end,
								name = "Size",
								min = 20, max = 100, step = 1,
								set = function(info, value) 
									db.ClassToolsDB.Size = value 
									local CT = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassTools")
									CT:UpdateSet()
								end,
							},
							Scale = {
								type = "range", order = 3, disabled = function(info) return not db.ClassToolsDB.Enable end,
								name = "Scale",
								min = 0.1, max = 2, step = 0.1,
								set = function(info, value) 
									db.ClassToolsDB.Scale = value 
									local CT = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("ClassTools")
									CT:UpdateSet()
								end,
							},
						}
					},
					group2 = {
						type = "group", order = 2, guiInline = true,
						name = "",
						args = {
							EnableIgniteWatch = {
								type = "toggle",
								name = "Enable IgniteWatch",
								order = 1,
								set = function(info, value) 
									db.ClassToolsDB.EnableIgniteWatch = value 
									local IW = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("IgniteWatch")
									IW:UpdateSet()
								end,
							},
							IgniteWatchSize = {
								type = "range", order = 2, disabled = function(info) return not db.ClassToolsDB.EnableIgniteWatch end,
								name = "Size",
								min = 20, max = 100, step = 1,
								set = function(info, value) 
									db.ClassToolsDB.IgniteWatchSize = value 
									local IW = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("IgniteWatch")
									IW:UpdateSet()
								end,
							},
						}
					},
					group3 = {
						type = "group", order = 3, guiInline = true,
						name = "",
						args = {
							EnableSpiritShellWatch = {
								type = "toggle",
								name = "Enable SpiritShell Watch",
								order = 1,
								set = function(info, value) 
									db.ClassToolsDB.EnableSpiritShellWatch = value 
									local SSW = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SpiritShell_Watch")
									SSW:UpdateSet()
								end,
							},
							SpiritShellWatchSize = {
								type = "range", order = 2, disabled = function(info) return not db.ClassToolsDB.EnableSpiritShellWatch end,
								name = "Size",
								min = 20, max = 100, step = 1,
								set = function(info, value) 
									db.ClassToolsDB.SpiritShellWatchSize = value 
									local SSW = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SpiritShell_Watch")
									SSW:UpdateSet()
								end,
							},
						}
					},
					group4 = {
						type = "group", order = 4, guiInline = true,
						name = "",
						args = {
							ROPEnable = {
								type = "toggle",
								name = "Enable SpiritShell Watch",
								order = 1,
								set = function(info, value) 
									db.ClassToolsDB.ROPEnable = value 
									local ROP = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("RuneOfPower")
									ROP:UpdateSet()
								end,
							},
							ROPSize = {
								type = "range", order = 2, disabled = function(info) return not db.ClassToolsDB.ROPEnable end,
								name = "Size",
								min = 20, max = 100, step = 1,
								set = function(info, value) 
									db.ClassToolsDB.ROPSize = value 
									local ROP = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("RuneOfPower")
									ROP:UpdateSize()
								end,
							},
						}
					},
				},
			},
			Other = {
				order = 98,
				type = "group",
				name = "Raid and Filger",
				args = {
					UnlockRiad = {
						type = "execute",
						name = L["团队框架"],
						order = 1,
						func = function()
							if not UnitAffectingCombat("player") then
								if IsAddOnLoaded("SunUI_Freebgrid") then 
									LoadAddOn('SunUI_Freebgrid_Config')
									local RF = LibStub and LibStub("AceConfigDialog-3.0", true)
											RF:Open("SunUI_Freebgrid")
											RF:Close("SunUIConfig")
								end
							end
						end
					},
					UnlockFilger = {
					type = "execute",
					name = L["技能监视"] ,
					order = 1,
					func = function()
						local bF = LibStub and LibStub("AceConfigDialog-3.0", true)
						bF:Open("RayWatcherConfig")
						bF:Close("SunUIConfig")
					end
					},
				}
			},
		}
	}
	SunUIConfig.Options.args.profiles = SunUIConfig.profile
end

function SunUIConfig:OnEnable()
	local Button = CreateFrame("Button", "SunUIGameMenuButton", GameMenuFrame, "GameMenuButtonTemplate")
		S.Reskin(Button)
		Button:SetSize(GameMenuButtonHelp:GetWidth(), GameMenuButtonHelp:GetHeight())
		Button:SetText("|cffDDA0DDSun|r|cff44CCFFUI|r")
		Button:SetPoint(GameMenuButtonHelp:GetPoint())
		Button:SetScript("OnClick", function()
			if not UnitAffectingCombat("player") then
				HideUIPanel(GameMenuFrame)
				SunUIConfig:ShowConfig()
			else
				HideUIPanel(GameMenuFrame)
				print(L["战斗中无法打开控制台"])
			end
		end)
	GameMenuButtonHelp:SetPoint("TOP", Button, "BOTTOM", 0, -1)
	GameMenuFrame:SetHeight(GameMenuFrame:GetHeight()+Button:GetHeight())	
	SunUIConfig:RegisterChatCommand("sunui", "ShowConfig")
end