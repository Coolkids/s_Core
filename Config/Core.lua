-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")
local Module = Core:NewModule("Congig", "AceConsole-3.0")
local Version = 1204
function Module:SetDefault()
	CoreVersion = Version
	-- 聊天频道职业染色
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "GUILD_OFFICER")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")   
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
end

MoveHandle = {}
DB["Modules"] = {}
DB["Config"] = {
	ResetToDefault = {
		type = "execute",
		name = "恢复默认设置",
		order = 1,
		func = function()
			for _, value in pairs(DB["Modules"]) do value.ResetToDefault() end
			Module:SetDefault()
			ReloadUI()
		end
	},
	UnLock = {
		type = "execute",
		name = "解锁框体",
		order = 2,
		func = function()
			if not UnitAffectingCombat("player") then
				SlashCmdList.rabs("unlock")
				SlashCmdList.SRAuraWatch("test")
				SlashCmdList.OUF_MOVABLEFRAMES()
				for _, value in pairs(MoveHandle) do value:Show() end
			end		
		end,
	},
	Lock = {
		type = "execute",
		name = "锁定框体",
		order = 3,
		func = function()
			if not UnitAffectingCombat("player") then
				SlashCmdList.rabs("lock")
				SlashCmdList.SRAuraWatch("test")
				SlashCmdList.OUF_MOVABLEFRAMES()
				for _, value in pairs(MoveHandle) do value:Hide() end
			end
		end,
	},
	Reload = {
		type = "execute",
		name = "应用(重载界面)",
		order = 4,
		func = function() ReloadUI() end
	},
}

function Module:ShowConfig()
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("SunUI Config", 780, 550)
	LibStub("AceConfigDialog-3.0"):Open("SunUI Config")
end

function Module:BuildGameMenuButton()
	local Button = CreateFrame("Button", "SoraGameMenuButton", GameMenuFrame, "GameMenuButtonTemplate")
	S.Reskin(Button)
	Button:SetSize(GameMenuButtonHelp:GetWidth(), GameMenuButtonHelp:GetHeight())
	Button:SetText("|cff70C0F5SunUI|r")
	Button:SetPoint(GameMenuButtonHelp:GetPoint())
	Button:SetScript("OnClick", function()
		HideUIPanel(GameMenuFrame)
		Module:ShowConfig()
	end)
	GameMenuButtonHelp:SetPoint("TOP", Button, "BOTTOM", 0, -1)
	GameMenuFrame:SetHeight(GameMenuFrame:GetHeight()+Button:GetHeight())	
end

function Module:OnInitialize()
	for _, value in pairs(DB["Modules"]) do
		value.LoadSettings()
		value.BuildGUI()
	end
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("SunUI Config", {
		type = "group",
		name = "|cff70C0F5SunUI",
		args = DB["Config"],
	})
	Module:RegisterChatCommand("SunUI", "ShowConfig")
end

function Module:OnEnable()
	Module:BuildGameMenuButton()
	if not CoreVersion or (CoreVersion < Version) then
		StaticPopupDialogs["SunUI"] = {
			text = "欢迎使用|cff70C0F5SunUI\n\n请点击确定按钮加载默认配置\n",
			button1 = OKAY,
			OnAccept = function()
				Module:SetDefault()
				ReloadUI()
			end,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = 0,
		}
		StaticPopup_Show("SunUI")
	end
end

