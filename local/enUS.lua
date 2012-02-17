﻿local S, C, L, DB = unpack(select(2, ...))

if (GetLocale() == "zhTW" or GetLocale() == "zhCN") then  return end
-- 控制台
--标语
L["恢复默认标语"] = "|cffDDA0DDSun|r|cff44CCFFUI|r\n|cffFF0000Sure to Default Setting|r\n"
L["欢迎标语"] = "Welcome|cffDDA0DDSun|r|cff44CCFFUI|r\n\nLoading Default Setting\n"
L["警告"] = "|cffFFD700Use this Module need big memory.|r"
--总
L["恢复默认设置"] = "DefaultSet"
L["解锁框体"] = "unLock"
L["锁定框体"] = "Lock"
L["应用(重载界面)"] = "Accpet(Reload)"
-- 动作条
L["动作条"] = "ActionBar"
L["请选择主动作条布局"] = "Main ActionBar Layout"
L["bar1布局"] = "Bar1 Layout"
L["bar2布局"] = "Bar2 Layout"
L["bar3布局"] = "Bar3 Layout"
L["bar4布局"] = "Bar4 Layout"
L["bar5布局"] = "Bar5 Layout"
L["12x1布局"] = "12x1"
L["6x2布局"] = "6x2"
L["4方块布局"] = "Big 4 ActionBar"
L["不要4方块布局"] = "Not Big 4 ActionBar"
L["动作条皮肤风格"] = "ActionBar Slyte"
L["请选择动作条皮肤风格"] = "select ActionBar Slyte"
L["阴影风格"] = "Shadow Slyte"
L["框框风格"] = "Borde"
L["隐藏快捷键显示"] = "Hide Hotkey"
L["隐藏宏名称显示"] = "Hide Macro Name"
L["冷却闪光"] = "Cooldown Flash"
L["动作条按钮大小"] = "ActionBar Button Size"
L["动作条间距大小"] = "ActionBar Button Spacing"
L["动作条字体大小"] = "ActionBar Font Size"
L["宏名字字体大小"] = "Macro Name Font Size"
L["主动作条缩放大小"] = "Main ActionBar Scale"
L["特殊按钮缩放大小"] = "ExtraBar Sacle"
L["宠物条缩放大小"] = "PetBar Sacle"
L["姿态栏缩放大小"] = "StanceBar Sacle"
L["图腾栏缩放大小"] = "TotemBar Sacle"
L["冷却闪光图标大小"] = "CooldownFlash Size"
--姓名板
L["姓名板"] = "Nameplate"
L["姓名板字体大小"] = "Nameplate Font Size"
L["姓名板血条高度"] = "Nameplate HP Height"
L["姓名板血条宽度"] = "Nameplate HP Width"
L["姓名板施法条图标大小"] = "Nameplate Castbar Icon Size"
L["姓名板施法条高度"] = "Nameplate Castbar Height"
L["姓名板施法条宽度"] = "Nameplate Castbar Width"
--鼠标提示
L["鼠标提示"] = "Tooltips"
L["提示框体跟随鼠标"] = "Cursor"
L["进入战斗自动隐藏"] = "Hide In Combat"
L["字体大小"] = "Font Size"
L["隐藏头衔"] = "Hide Titles"
L["主天赋"] = "Main Talent:|cffffffff "
L["副天赋"] = "Second  Talent:|cffffffff "
L["成就点数"] = "|cFFF1C502Achievement Point:  |cFFFFFFFF"
L["正在查询成就"] = "Loading.."
L["释放者"] = "Cast By:"
L["法术ID"] = "Spell ID"
--增益效果
L["增益效果"] = "BUFF"
L["图标大小"] = "Icon Size："
L["BUFF增长方向"] = "Set Buff Direction："
L["从右向左"] = "right to left"
L["从左向右"] = "left to right"
L["DEBUFF增长方向"] = "Set DeBuff Direction："
L["每行图标数"] = "Icon Per Row"
--仇恨监视
L["仇恨监视"] = "Threat"
L["仇恨条宽度"] = "Threat bat Width："
L["仇恨条姓名长度"] = "Name Text Length："
L["显示仇恨人数"] = "ThreatLimited："
--reminder
L["缺失提醒"] = "Reminder"
L["显示团队增益缺失提醒"] = "Show Raid Buff"
L["只在队伍中显示"] = "Show Only In Party"
L["团队增益图标大小"] = "Raid Buff Size："
L["团队增益图标排列方式"] = "Raid Buff Direction："
L["横排"] = "横排"
L["竖排"] = "竖排"
L["显示职业增益缺失提醒"] = "Show Class Buff"
L["开启声音警报"] = "Sound warning"
L["职业增益图标大小"] = "Class Buff Size："
L["职业增益图标间距"] = "Class Buff Space："
--界面皮肤
L["界面皮肤"] = "Skin"
L["启用DBM皮肤"] = "DBM Skin"
--头像
L["头像框体"] = "UnitFrame"
L["开启boss框体"] = "Boss UnitFrame"
L["血条职业颜色"] = "ClassColorbars"
L["蓝条颜色"] = "PowerColor"
L["蓝条职业颜色"] = "PowerClassColor"
L["是否开启头像"] = "Portraits"
L["是否只显示你释放的debuff"] = "only show player debuffs on target"
L["头像字体大小"] = "Font Size："
L["法力条高度"] = "PowerHeight："
L["头像缩放大小"] = "UnitFrame Scale："
L["玩家施法条宽度"] = "Player Castbar Width："
L["玩家施法条高度"] = "Player Castbar Height："
L["目标施法条宽度"] = "Target Castbar Width："
L["目标施法条高度"] = "Target Castbar Height："
L["焦点施法条宽度"] = "Focus Castbar Width："
L["焦点施法条高度"] = "Focus Castbar Height："
L["宠物施法条宽度"] = "Pet Castbar Width："
L["宠物施法条高度"] = "Pet Castbar Height："
L["施法条图标大小"] = "Castbar Icon Size："
--mini
L["小东西设置"] = "Mini"
L["启用出售垃圾"] = "AutoSell"
L["启用自动修理"] = "AutoRepair"
L["启用聊天信息过滤"] = "ChatFilter"
L["启用系统红字屏蔽"] = "Fast System Error"
L["启用打断通报"] = "Interrupt Say"
L["PVP冷却计时"] = "PVP CD Time"
L["启用团队工具"] = "Raid Tools"
L["需要团长或者助理权限"] = "Need RL or Assistant"
L["启用自动邀请"] = "Autoinvite"
L["自动邀请关键字"] = "Invite_Word："
L["启用自动离开有进度的随机副本或团队"] = "Auto leave old LFD or LFR"
L["UI缩放"] = "uiScale"
L["UI缩放大小"] = "uiScale Size："
L["应用"] = "Accpet"
L["启用插件UI缩放设定"] = "Open SunUI uiScale"
L["自动设定UI缩放"] = "Auto set uiScale"
L["需要开启插件UI缩放设定"] = "Need Open SunUI uiScale"
L["锁定UI缩放"] = "Lock uiScale "
L["内置CD"] = "Internal cooldown"
L["启动内置CD"] = "Open Internal cooldown"
L["内置CD字体大小"] = "Internal cooldown font size："
L["框体宽度"] = "bar height："
L["框体高度"] = "bar width："
L["计时条增长方向"] = "bar Direction："
L["向下"] = "Down"
L["向上"] = "Up"
--other
L["内存占用"] = "|cffFFD700Memory：|r"
L["处理器占用"] = "|cffFFD700CPU：|r"
L["插件管理"] = "|cffDDA0DDAddonManager|r"
L["SunUI插件管理"] = "|cffDDA0DDSun|r|cff44CCFFUI|r AddonManager"
L["第"] = "No. "
L["页/共"] = "  /  "
L["页"] = " Page"
--打断
L["我已打断: =>"] = "I Interrupt: =>"
L["<=的 "] = "<= "
--背包
L["背包"] = "Bags"
L["搜索"] = "Search"
L["整理背包"] = "JPack"
--move
L["玩家施法条"] = "Player Castbar"
L["目标施法条"] = "Target Castbar"
L["焦点施法条"] = "Focus Castbar"
L["宠物施法条"] = "Pet Castbar"
L["内置CD监视"] = "Internal cooldown"
L["仇恨监视"] = "Threat"
L["缺少药剂buff提示"] =  "Reminder"
L["连击点"] = "Combat Point"
L["暗影魔计时条"] = "Shadow Pet Time"
L["小地图"] = "MiniMap"
L["鼠标左键拖动我!"] = "Hold down to drag"
L["药水"] = "Reminder"
L["冷却闪光"] = "CooldownFlash"
--minimap
L["角色信息"] = "Character"
L["法术书"] = "SpellBook"
L["天赋"] = "Talent"
L["成就"] = "Achievement"
L["任务日志"] = "QuestLog"
L["社交"] = "Friends"
L["公会"] = "Guild"
L["地城查找器"] = "LFD"
L["团队查找器"] = "LFR"
L["帮助"] = "Help"
L["行事历"] = "Calendar"
L["地城手册"] = "EncounterJournal"
L["就位确认"] = "ReadyCheck"
L["角色检查"] = "InitiateRolePoll"
L["转化为团队"] = "ConvertToRaid"
L["转化为小队"] = "ConvertToParty"
--声望条
L["经验值"] = "Experience:"
L["剩余"] = 'Last: %s'
L["休息"] = '|cffb3e1ffReset: %s (%d%%)'
L["阵营"] = 'Name: %s'
L["状态"] = 'State: |c'
L["声望"] = 'Faction: %s/%s (%d%%)'
L["仇恨"] = "Hated"
L["敌对"] = "Hostile"
L["不友好"] = "Unfriendly"
L["中立"] = "Neutral"
L["友好"] = "Friendly"
L["尊敬"] = "Honored"
L["崇敬"] = "Revered"
L["崇拜"] = "Exalted"
--信息条
L["没有工会"] = "没有工会"
L["免伤分析"] = "免伤分析"
L["免伤"] = "免伤"
L["等级缓和"] = "等级缓和"
L["头部"] = "头部"
L["肩部"] = "肩部"
L["胸部"] = "胸部"
L["腰部"] = "腰部"
L["手腕"] = "手腕"
L["手"] = "手"
L["腿部"] = "腿部"
L["脚"] = "脚"
L["主手"] = "主手"
L["副手"] = "副手"
L["远程"] = "远程"
L["共释放内存"] = "共释放内存"
L["总共内存使用"] = "总共内存使用"
L["延迟"] = "延迟"
L["本地延迟"] = "本地延迟"
L["世界延迟"] = "世界延迟"
L["耐久度"] = "耐久度"
L["信息面板"] = "信息面板"
L["启用顶部信息条"] = "启用顶部信息条"
L["启用底部信息条"] = "启用底部信息条"
L["底部信息条宽度"] = "底部信息条宽度"
L["底部信息条宽度"] = "底部信息条宽度"
L["带宽"] = "带宽"
L["下载"] = "下载"
L["背包"] = "背包"
L["背包剩余"] = "背包剩余"
L["背包总计"] = "背包总计"
L["邮件"] = "邮件"
L["新邮件"] = "新邮件"
L["无邮件"] = "无邮件"
L["地区"] = "地区"
--chat
L["综合"] = "[General]"
L["交易"] = "[Trade]"
L["世界防务"] = "[WorldDefense]"
L["本地防御"] = "[LocalDefense]"
L["寻求组队"] = "[LookingForGroup]"
L["工会招募"] = "[GuildRecruitment]"
L["战场"] = "[Battleground]"
L["战场领袖"] = "[Battleground Leader]"
L["工会"] = "[Guild]"
L["小队"] = "[Party]"
L["小队队长"] = "[Party Leader]"
L["地城领袖"] = "[Party Leader]"
L["官员"] = "[Officer]"
L["团队"] = "[Raid]"
L["团队领袖"] = "[Raid Leader]"
L["团队警告"] = "[Raid Warning]"
--staddonmanage
L["Search"] = "Search"
L["ReloadUI"] = "Reload UI"
L["Profiles"] = "Profiles"
L["New_Profile"] = "New Profile"
L["Enable_All"] = "Enable All"
L["Disable_All"] = "Disable All"
L["Profile_Name"] = "Profile Name"
L["Set_To"] = "Set To.."
L["Add_To"] = "Add To.."
L["Remove_From"] = "Remove From.."
L["Delete_Profile"] = "Delete Profile.."
L["Confirm_Delete"] = "Are you sure you want to delete this profile? Hold down shift and click again if you are."
L["Dependencies"] = "Dependencies"
L["Optional Dependencies"] = "Optional Dependencies"
L["全局字体大小"] = "全局字体大小系数"