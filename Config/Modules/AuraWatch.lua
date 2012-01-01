-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Core = LibStub("AceAddon-3.0"):GetAddon("Core")

-- Init
DB["Modules"]["AuraWatch"] = {}
local Module = DB["Modules"]["AuraWatch"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
	-- 德鲁伊
	["DRUID"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
			  -- 狂怒
				{AuraID = 5229, UnitID = "player"},
				-- 节能施法
				{AuraID = 16870, UnitID = "player"},
				-- 自然之赐
				{AuraID = 16886, UnitID = "player"},
				-- 日蚀
				{AuraID = 48517, UnitID = "player"},			
				-- 月蚀
				{AuraID = 48518, UnitID = "player"},
				-- 狂暴(猫&熊)
				{AuraID = 50334, UnitID = "player"},
				-- 野蛮咆哮(猫)
				{AuraID = 52610, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 80353, UnitID = "player"},
				-- 粉碎
				{AuraID = 80951, UnitID = "player"},
				-- 月光淋漓
				{AuraID = 81192, UnitID = "player"},
				-- 坠星
				{AuraID = 93400, UnitID = "player"},
				-- 狂暴
				{AuraID = 93622, UnitID = "player"},
			},
		},
		
		{
			Name = "目标Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {	
				-- 挫志咆哮(熊)
				{AuraID =    99, UnitID = "target", Caster = "player"},
				-- 回春术
				{AuraID =   774, UnitID = "target", Caster = "player"},
				-- 割裂(猫)
				{AuraID =  1079, UnitID = "target", Caster = "player"},
				-- 斜掠(猫)
				{AuraID =  1822, UnitID = "target", Caster = "player"},			
				-- 虫群
				{AuraID =  5570, UnitID = "target", Caster = "player"},
				-- 月火术
				{AuraID =  8921, UnitID = "target", Caster = "player"},
				-- 割伤(熊)
				{AuraID = 33745, UnitID = "target", Caster = "player"},
				-- 生命绽放
				{AuraID = 33763, UnitID = "target", Caster = "player"},			
				-- 裂伤(猫)
				{AuraID = 33876, UnitID = "target", Caster = "player"},
				-- 野蛮咆哮(猫)
				{AuraID = 52610, UnitID = "target", Caster = "player"},
				-- 阳炎术
				{AuraID = 93402, UnitID = "target", Caster = "player"},
				-- 割碎
				{AuraID = 33878, UnitID = "target", Caster = "player"},
			},
		},
	},
	
	-- 猎人
	["HUNTER"] = {
		{
			Name = "目标框上方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 毒蛇钉刺
				{AuraID =  1978 ,UnitID = "target", Caster = "player"},
				-- 驱散射击
				{AuraID = 19503 ,UnitID = "target", Caster = "player"},
				-- 穿刺射击
				{AuraID = 63468 ,UnitID = "target", Caster = "player"},
				-- 黑蝕箭
				{AuraID = 3674, UnitID = "target", Caster = "player"},
				-- 爆炸射擊
				{AuraID = 53301, UnitID = "target", Caster = "player"},
				-- 連環火網
				{AuraID = 82921, UnitID = "player", Caster = "player"},			
				-- 强化稳固射击
				{AuraID = 53220, UnitID = "player", Caster = "player"},
				-- 驱散射击
				{AuraID = 19503 ,UnitID = "target", Caster = "player"},
				
			},
		},
		{
			Name = "目標的目标框上方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 急速射击
				{AuraID =  3045, UnitID = "player"},
				-- 治疗宠物
				{AuraID = 136, UnitID = "pet"},
				-- 野兽之心
				{AuraID = 34471, UnitID = "player"},
				-- 误导
				{AuraID = 34477, UnitID = "player"},
				-- 误导
				{AuraID = 35079, UnitID = "player"},				
				-- 眼镜蛇打击
				{AuraID = 53257, UnitID = "player"},
				-- 狂野呼唤
				{AuraID = 53434, UnitID = "player"},
				-- 荷枪实弹
				{AuraID = 56453, UnitID = "player"},
				-- 攻击弱点
				{AuraID = 70728, UnitID = "player"},
				-- 准备,端枪,瞄准... ...
				{AuraID = 82925, UnitID = "player"},
				-- 开火!
				{AuraID = 82926, UnitID = "player"},
				-- 上!
				{AuraID = 89388, UnitID = "player"},
				-- 血性大发
				{AuraID = 94007, UnitID = "player"},
				-- 4T12特效
				{AuraID = 99060, UnitID = "player"},
				-- 阻擊訓練
				{AuraID = 64420, UnitID = "player"},
				-- 狂乱
				{AuraID = 19615, UnitID = "pet"},
				
			},
		},
		{
			Name = "玩家技能CD",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -45, -250},
			List = {
				-- 奇美拉射击
				{SpellID = 53209, UnitID = "player"},
				-- 急速射击
				{SpellID =  3045, UnitID = "player"},
				-- 准备就绪
				{SpellID = 23989, UnitID = "player"},
				-- 爆炸射擊
				{SpellID = 53301, UnitID = "player"},
				-- 黑蝕箭
				{SpellID =  3674, UnitID = "player"},
			},
		},
	},
	
	-- 法师
	["MAGE"] = {
		{
			Name = "目标框上方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 点燃
				{AuraID = 12654 ,UnitID = "target", Caster = "player"},
				-- 临界炽焰
				{AuraID = 22959 ,UnitID = "target", Caster = "player"},
				-- 减速
				{AuraID = 31589 ,UnitID = "target", Caster = "player"},
				-- 活动炸弹
				{AuraID = 44457 ,UnitID = "target", Caster = "player"},
				-- 秘法衝擊
				{AuraID = 36032, UnitID = "player", Caster = "player"},
				-- 燃火
				{AuraID = 83853, UnitID = "target", Caster = "player"},
				-- 深度凍結
				{AuraID = 44572, UnitID = "target", Caster = "player"},
				-- 炎爆!
				{AuraID = 92315, UnitID = "target", Caster = "player"},
				-- 炎爆
				{AuraID = 11366, UnitID = "target", Caster = "player"},
	
			},
		},
	
		{
			Name = "目標的目標上方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 30,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {		
			  -- 奥术强化
				{AuraID = 12042, UnitID = "player"},
				-- 唤醒
				{AuraID = 12051, UnitID = "player"},			
				-- 寒冰指
				{AuraID = 44544, UnitID = "player"},
				-- 法术连击
				{AuraID = 48108, UnitID = "player"},
				-- 冰冷智慧
				{AuraID = 57761, UnitID = "player"},
				-- 冲击(等级1)
				{AuraID = 64343, UnitID = "player"},
				-- 秘法飛彈!
				{AuraID = 79683, UnitID = "player"},
				-- 灸灼
				{AuraID = 87023, UnitID = "player"},	
				-- 魔法凝聚
				{AuraID = 54648, UnitID = "player"},
				-- 强化法力宝石
				{AuraID = 83098, UnitID = "player"},	
				-- 隱形術
				{AuraID = 66, UnitID = "player"},
				-- 隱形術
				{AuraID = 32612, UnitID = "player"},
				-- 咒法移轉
				{AuraID = 44413, UnitID = "player"},				
				-- 幻鏡之像
				{AuraID = 55342, UnitID = "player"},
				-- 節能施法
				{AuraID = 12536, UnitID = "player"},
				-- 龍之吐息
				{AuraID = 31661, UnitID = "player"},
				-- 烈焰風暴
				{AuraID = 2120, UnitID = "player"},
			},
		},
		
		{
			Name = "玩家技能CD",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -45, -250},
			List = {
				-- 唤醒
				{SpellID = 12051, UnitID = "player"},
				-- 秘法强化
				{SpellID = 12042, UnitID = "player"},
				-- 燃火
				{SpellID = 11129, UnitID = "player"},
			},
		},
	},
	
	-- 战士
	["WARRIOR"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 盾墙(防御姿态)
				{AuraID =   871, UnitID = "player"},
				-- 怒火中烧
				{AuraID =  1134, UnitID = "player"},
				-- 盾牌格挡(防御姿态)
				{AuraID =  2565, UnitID = "player"},
				-- 嗜血
				{AuraID =  2825, UnitID = "player"},				
				-- 横扫攻击(战斗,狂暴姿态)
				{AuraID = 12328, UnitID = "player"},
				-- 战斗专注
				{AuraID = 12964, UnitID = "player"},
				-- 破釜沉舟
				{AuraID = 12975, UnitID = "player"},
				-- 血之狂热
				{AuraID = 16491, UnitID = "player"},
				-- 反击风暴(战斗姿态)
				{AuraID = 20230, UnitID = "player"},
				-- 嗜血
				{AuraID = 23885, UnitID = "player"},
				-- 法术发射(战斗,防御姿态)
				{AuraID = 23920, UnitID = "player"},
				-- 复苏之风(等级1)
				{AuraID = 29841, UnitID = "player"},
				-- 英勇气概
				{AuraID = 32182, UnitID = "player"},
				-- 胜利
				{AuraID = 32216, UnitID = "player"},
				-- 血脉喷张
				{AuraID = 46916, UnitID = "player"},
				-- 剑盾猛攻
				{AuraID = 50227, UnitID = "player"},
				-- 猝死
				{AuraID = 55694, UnitID = "player"},
				-- 激怒(等级2)
				{AuraID = 57519, UnitID = "player"},
				-- 血之气息
				{AuraID = 60503, UnitID = "player"},
				-- 主宰
				{AuraID = 65156, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 80353, UnitID = "player"},
				-- 胜利
				{AuraID = 82368, UnitID = "player"},
				-- 屠夫(等级3)
				{AuraID = 84586, UnitID = "player"},
				-- 坚守阵地
				{AuraID = 84620, UnitID = "player"},
				-- 致命平静
				{AuraID = 85730, UnitID = "player"},
				-- 激动
				{AuraID = 86627, UnitID = "player"},
				-- 雷霆余震
				{AuraID = 87096, UnitID = "player"},
				-- 行刑者
				{AuraID = 90806, UnitID = "player"},
			},
		},	

		{
			Name = "目标Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 撕裂(战斗,防御姿态)
				{AuraID = 94009, UnitID = "target", Caster = "player"},
			},
		},
	},
	
	-- 萨满
	["SHAMAN"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 嗜血
				{AuraID =  2825, UnitID = "player"},
				-- 闪电之盾
				{AuraID =   324, UnitID = "player"},
				-- 萨满之怒
				{AuraID = 30823, UnitID = "player"},
				-- 英勇气概
				{AuraID = 32182, UnitID = "player"},
				-- 水之护盾
				{AuraID = 52127, UnitID = "player"},
				-- 潮汐奔涌
				{AuraID = 53390, UnitID = "player"},
				-- 5层漩涡武器
				{AuraID = 53817, UnitID = "player", Stack = 5},
				-- 灵魂行者的恩赐
				{AuraID = 79206, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 80353, UnitID = "player"},
			},
		},
		{
			Name = "目标Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 大地震击
				{AuraID =  8042, UnitID = "target", Caster = "player"},
				-- 烈焰震击
				{AuraID =  8050, UnitID = "target", Caster = "player"},
				-- 冰霜震击
				{AuraID =  8056, UnitID = "target", Caster = "player"},
				-- 风暴打击
				{AuraID = 17364, UnitID = "target", Caster = "player"},
				-- 灼热烈焰
				{AuraID = 77661, UnitID = "target", Caster = "player"},
			},
		},
	},
	
	-- 圣骑士
	["PALADIN"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 圣佑术
				{AuraID =   498, UnitID = "player"},
				-- 圣盾术
				{AuraID =   642, UnitID = "player"},
				-- 嗜血
				{AuraID =  2825, UnitID = "player"},
				-- 神恩术
				{AuraID = 31842, UnitID = "player"},
				-- 神圣之盾
				{AuraID = 20925, UnitID = "player"},
				-- 智者审判
				{AuraID = 31930, UnitID = "player"},		
				-- 复仇之怒
				{AuraID = 31884, UnitID = "player"},
				-- 炙热防御者
				{AuraID = 31850, UnitID = "player"},
				-- 英勇气概
				{AuraID = 32182, UnitID = "player"},
				-- 纯洁审判(等级3)
				{AuraID = 53657, UnitID = "player"},
				-- 圣光灌注(等级2)
				{AuraID = 54149, UnitID = "player"},
				-- 神圣恳求
				{AuraID = 54428, UnitID = "player"},
				-- 战争艺术
				{AuraID = 59578, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 80353, UnitID = "player"},
				-- 异端裁决
				{AuraID = 84963, UnitID = "player"},
				-- 大十字军 (复仇盾)
				{AuraID = 85043, UnitID = "player"},
				-- 神圣使命 (盾击必暴)
				{AuraID = 85433, UnitID = "player"},
				-- 狂热
				{AuraID = 85696, UnitID = "player"},
				-- 远古列王守卫
				{AuraID = 86659, UnitID = "player"},
				-- 破晓
				{AuraID = 88819, UnitID = "player"},
				-- 神圣意志
				{AuraID = 90174, UnitID = "player"},
			},
		},
		{
			Name = "目标Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 制裁之锤
				{AuraID =   853, UnitID = "target", Caster = "player"},
				-- 神圣愤怒
				{AuraID =  2812, UnitID = "target", Caster = "player"},
				-- 超度邪恶
				{AuraID = 10326, UnitID = "target", Caster = "player"},
				-- 忏悔
				{AuraID = 20066, UnitID = "target", Caster = "player"},
				-- 辩护
				{AuraID = 26017, UnitID = "target", Caster = "player"},
				-- 圣光道标
				{AuraID = 53563, UnitID = "target", Caster = "player"},
			},
		},
	},

	-- 牧师
	["PRIEST"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 心靈熔蝕
				{AuraID = 87160, UnitID = "player"},
				-- 黑暗佈道
				{AuraID = 87118, UnitID = "player"},
				-- 大天使
				{AuraID = 87152, UnitID = "player"},
				-- 黑天使
				{AuraID = 87153, UnitID = "player"},  
				-- 消散
				{AuraID = 47585, UnitID = "player"},  
				-- 佈道
				{AuraID = 81661, UnitID = "player"},
				-- 心靈意志
				{AuraID = 73413, UnitID = "player"},
				-- 心靈之火
				{AuraID =   588, UnitID = "player"},
				-- 吸血鬼的擁抱
				{AuraID = 15286, UnitID = "player"},
				-- 守护圣灵
				{AuraID = 47788, UnitID = "target"},
				-- 预支时间
				{AuraID = 59889, UnitID = "player"},
				-- 预支时间
				{AuraID = 59888, UnitID = "player"},
				-- 预支时间
				{AuraID = 59887, UnitID = "player"},
				-- 神禦之盾
				{AuraID = 47753, UnitID = "target"},
				-- 漸隱術
				{AuraID = 586, UnitID = "player"},    
				-- 精神分流
				{AuraID = 81301, UnitID = "player"},
				-- 脈輪運轉
				{AuraID = 14751, UnitID = "player"},
				-- 脈輪運轉:懲擊 
				{AuraID = 81209, UnitID = "player"},
				-- 脈輪運轉:治療禱言
				{AuraID = 81206, UnitID = "player"},
				-- 脈輪運轉:治療術
				{AuraID = 81208, UnitID = "player"},
				-- 神性火焰
				{AuraID = 99132, UnitID = "player"},
			},
		},

		{
			Name = "目标框體上方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 吸血鬼之触
				{AuraID = 34914, UnitID = "target", Caster = "player"},
				-- 暗言术:痛
				{AuraID =   589, UnitID = "target", Caster = "player"},
				-- 噬灵疫病
				{AuraID =  2944, UnitID = "target", Caster = "player"},
				-- 虚弱灵魂
				{AuraID =  6788, UnitID = "target", Caster = "player"},
				-- T12 4件特效
				{AuraID = 99158, UnitID = "player"},
				-- 灵感(等级1)
				{AuraID = 14893, UnitID = "target", Caster = "player"},
				-- 灵感(等级2)
				{AuraID = 15357, UnitID = "target", Caster = "player"},
				-- 守护圣灵
				{AuraID = 47788, UnitID = "target", Caster = "player"},
				--光明回想
				{AuraID = 77489, UnitID = "target", Caster = "player"},
				-- 恢复
				{AuraID = 139, UnitID = "target", Caster = "player"},
				-- 聖言術:寧 
				{AuraID = 88684, UnitID = "target", Caster = "player"},
				-- 聖言術:譴
				{AuraID = 88625, UnitID = "tatget", Caster = "player"},
			},
		},
		
		{
			Name = "玩家框體下方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 45,
			Pos = {"CENTER", "UIParent", "CENTER", -185, -255},
			List = {
			  -- 暗影宝珠
				{AuraID = 77487, UnitID = "player"},
			  -- 强效暗影
				{AuraID = 95799, UnitID = "player"},	
			},
		},
		
		{
			Name = "玩家技能CD",
			Direction = "RIGHT", Interval = 6,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -45, -250},
			List = {
				-- 心靈震爆
				{SpellID =  8092, UnitID = "player"},
				-- 暗影魔
				{SpellID = 34433, UnitID = "player"},
				-- 大天使
				{SpellID = 87151, UnitID = "player"},
			},
		},
	},

	-- 术士
	["WARLOCK"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 嗜血
				{AuraID =  2825, UnitID = "player"},
				-- 暗影冥思
				{AuraID = 17941, UnitID = "player"},
				-- 英勇气概
				{AuraID = 32182, UnitID = "player"},
				-- 反冲(等级3)
				{AuraID = 34939, UnitID = "player"},
				-- 小鬼增效
				{AuraID = 47283, UnitID = "player"},			
				-- 灭杀(等级2)
				{AuraID = 63158, UnitID = "player"},
				-- 灭杀
				{AuraID = 63167, UnitID = "player"},
				-- 熔火之心
				{AuraID = 71165, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 80353, UnitID = "player"},
				-- 强化灵魂之火
				{AuraID = 85383, UnitID = "player"},
				-- 魔能火花
				{AuraID = 89937, UnitID = "player"},
			},
		},

		{
			Name = "目标Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 腐蚀术
				{AuraID =   172, UnitID = "target", Caster = "player"},
				-- 献祭
				{AuraID =   348, UnitID = "target", Caster = "player"},
				-- 末日灾祸
				{AuraID =   603, UnitID = "target", Caster = "player"},
				-- 痛苦灾祸
				{AuraID =   980, UnitID = "target", Caster = "player"},
				-- 元素诅咒
				{AuraID =  1490, UnitID = "target", Caster = "player"},
				-- 暗影烈焰 (强化暗箭)
				{AuraID = 17800, UnitID = "target", Caster = "player"},
				-- 烧尽
				{AuraID = 29722, UnitID = "target", Caster = "player"},
				-- 痛苦无常
				{AuraID = 30108, UnitID = "target", Caster = "player"},
				-- 暗影之拥
				{AuraID = 32389, UnitID = "target", Caster = "player"},
				-- 鬼影缠身
				{AuraID = 48181, UnitID = "target", Caster = "player"},
				-- 混乱之箭
				{AuraID = 50796, UnitID = "target", Caster = "player"},
				-- 浩劫灾祸
				{AuraID = 80240, UnitID = "target", Caster = "player"},
				-- 古尔丹邪咒
				{AuraID = 86000, UnitID = "target", Caster = "player"},
			},
		},	
	},
	
	-- 盗贼
	["ROGUE"] = {
		{
			Name = "目標的目標上方",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 冷血
				{AuraID = 14177, UnitID = "player"},
				-- 毒伤
				{AuraID = 32645, UnitID = "player"},
				-- 嫁祸诀窍
				{AuraID = 57934, UnitID = "player"},			
				-- 灭绝
				{AuraID = 58427, UnitID = "player"},
				-- 嫁祸诀窍
				{AuraID = 59628, UnitID = "player"},
				-- 养精蓄锐
				{AuraID = 73651, UnitID = "player"},
				-- 致命冲动
				{AuraID = 84590, UnitID = "player"},
				-- 劍舞
				{AuraID = 13877, UnitID = "player"},
				-- 能量刺激
				{AuraID = 13750, UnitID = "player"},
				-- 佯攻
				{AuraID =  1966, UnitID = "player"},
			},
		},
		
		{
			Name = "目标框上方",
      Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 肾击
				{AuraID =   408, UnitID = "target", Caster = "player"},
				-- 绞喉
				{AuraID =   703, UnitID = "target", Caster = "player"},
				-- 偷袭
				{AuraID =  1833, UnitID = "target", Caster = "player"},
				-- 割裂
				{AuraID =  1943, UnitID = "target", Caster = "player"},
				-- 破甲
				{AuraID =  8647, UnitID = "target", Caster = "player"},
				-- 缴械
				{AuraID = 51722, UnitID = "target", Caster = "player"},
				-- 要害打击
				{AuraID = 84617, UnitID = "target", Caster = "player"},
				-- 仇杀
				{AuraID = 79140, UnitID = "target", Caster = "player"},
				-- 切割
				{AuraID =  5171, UnitID = "player"},
				-- 淺察
				{AuraID = 84745, UnitID = "player"},
				-- 中度
				{AuraID = 84746, UnitID = "player"},
				-- 深度
				{AuraID = 84747, UnitID = "player"},
			},
		},
		
		{
			Name = "玩家技能CD",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -45, -250},
			List = {
				-- 殺戮盛筵
				{SpellID = 51690, UnitID = "player"},
				-- 冲动
				{SpellID = 13750, UnitID = "player"},
			},
		},	
	},
	
	-- 死亡骑士
	["DEATHKNIGHT"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", "UIParent", "CENTER", -75, -175},
			List = {
				-- 嗜血
				{AuraID =  2825, UnitID = "player"},
				-- 英勇气概
				{AuraID = 32182, UnitID = "player"},
				-- 反魔法护罩
				{AuraID = 48707, UnitID = "player"},
				-- 冰封之韧
				{AuraID = 48792, UnitID = "player"},
				-- 末日突降
				{AuraID = 49018, UnitID = "player"},			
				-- 巫妖之躯
				{AuraID = 49039, UnitID = "player"},
				-- 白骨之盾
				{AuraID = 49222, UnitID = "player"},
				-- 杀戮机器
				{AuraID = 51124, UnitID = "player"},
				-- 灰烬冰川
				{AuraID = 53386, UnitID = "player"},
				-- 吸血鬼之血
				{AuraID = 55233, UnitID = "player"},
				-- 冰冻之雾
				{AuraID = 59052, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 80353, UnitID = "player"},
				-- 赤色天灾
				{AuraID = 81141, UnitID = "player"},
				-- 大墓地的意志
				{AuraID = 81162, UnitID = "player"},
				-- 符文刃舞
				{AuraID = 81256, UnitID = "player"},
				-- 暗影灌注
				{AuraID = 91342, UnitID = "pet"}, 
			},
		},	
		{
			Name = "目标Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", "UIParent", "CENTER", 131, -135},
			List = {
				-- 血之疫病
				{AuraID = 55078, UnitID = "target", Caster = "player"},
				-- 冰霜疫病
				{AuraID = 55095, UnitID = "target", Caster = "player"},
				-- 血红热疫
				{AuraID = 81130, UnitID = "target", Caster = "player"},
			},
		}, 
	},
}
	if not AuraWatchDB then AuraWatchDB = {} end
	for key, value in pairs(Default[select(2, UnitClass("player"))]) do
		if AuraWatchDB[key] == nil then AuraWatchDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(AuraWatchDB)
end

-- BuildGUI
local GruopValue, AuraList, GroupSelectValue, AuraSelectValue = {}, {}, 1, 1
local function UpdateAuraList()
	AuraList = {
		AuraSelect = {
			type = "select", order = 1, 
			name = "选择Aura：", desc = "请选择Aura", 
			values = function()
				local Table = {}
				for key, value in pairs(AuraWatchDB[GroupSelectValue]["List"]) do
					if value["AuraID"] then Table[key] = GetSpellInfo(value["AuraID"]) or value["AuraID"] end
					if value["SpellID"] then Table[key] = GetSpellInfo(value["SpellID"]) or value["AuraID"] end
					if value["ItemID"] then Table[key] = GetItemInfo(value["ItemID"]) or value["AuraID"] end
				end
				return Table
			end, 
			get = function() return AuraSelectValue end, 
			set = function(_, value)
				AuraSelectValue = value
				UpdateAuraList()
			end, 
		}, 
		AddNewAura = {
			type = "execute", order = 2, 
			name = "添加Aura", 
			func = function()
				tinsert(AuraWatchDB[GroupSelectValue]["List"], {AuraID = 118, UnitID = "player"})
				AuraSelectValue = #AuraWatchDB[GroupSelectValue]["List"]
				UpdateAuraList()
			end, 
		}, 
		DeleteAura = {
			type = "execute", order = 3, 
			name = "删除Aura", 
			func = function()
				tremove(AuraWatchDB[GroupSelectValue]["List"], AuraSelectValue)
				AuraSelectValue = AuraSelectValue-1 > 0 and AuraSelectValue-1 or 1
				UpdateAuraList()
			end, 
		}, 
		AuraID = {
			type = "input", order = 4, 
			name = "AuraID：", desc = "请输入AuraID", 
			get = function()
				local Aura = AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]
				if Aura["AuraID"] then return tostring(Aura["AuraID"]) end
				if Aura["SpellID"] then return tostring(Aura["SpellID"]) end
				if Aura["ItemID"] then return tostring(Aura["ItemID"]) end			
			end, 
			set = function(_, value)
				local Aura = AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]
				if Aura["AuraID"] and GetSpellInfo(value) then Aura["AuraID"] = tonumber(value) return end
				if Aura["SpellID"] and GetSpellInfo(value) then Aura["SpellID"] = tonumber(value) return end
				if Aura["ItemID"] and GetItemInfo(value) then Aura["ItemID"] = tonumber(value) return end
			end,
		}, 
		Mode = {
			type = "select", order = 5, 
			name = "监视类型：", desc = "请选择监视类型：", 
			values = {["AuraID"] = "Aura", ["SpellID"] = "技能CD", ["ItemID"] = "物品CD"}, 
			get = function()
				local Aura = AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]
				if Aura["AuraID"] then return "AuraID" end
				if Aura["SpellID"] then return "SpellID" end
				if Aura["ItemID"] then return "ItemID" end	
			end, 
			set = function(_, value)
				local Aura = AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]
				if value == "AuraID" then Aura["AuraID"] = 118 Aura["SpellID"] = nil Aura["ItemID"] = nil end
				if value == "SpellID" then Aura["AuraID"] = nil Aura["SpellID"] = 118 Aura["ItemID"] = nil end
				if value == "ItemID" then Aura["AuraID"] = nil Aura["SpellID"] = nil Aura["ItemID"] = 6948 end
				UpdateAuraList()
			end, 
		}, 
		UnitID = {
			type = "select", order = 6, 
			name = "监视对象：", desc = "请选择监视对象：", 
			values = {["player"] = "玩家", ["target"] = "目标", ["pet"] = "宠物", ["focus"] = "焦点"}, 
			get = function() return AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["UnitID"] end, 
			set = function(_, value) AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["UnitID"] = value end,
		}, 
		Caster = {
			type = "select", order = 7, 
			name = "施法者过滤：", desc = "请选择施法者过滤类型：", 
			values = {["player"] = "玩家", ["None"] = "无"}, 
			get = function() return AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["Caster"] or "None" end, 
			set = function(_, value)
				if value == "None" then
					AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["Caster"] = nil
				else
					AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["Caster"] = value
				end
			end,
		}, 
		Stack = {
			type = "select", order = 8, 
			name = "堆叠层数过滤：", desc = "请选择堆叠过滤层数：", 
			values = {[0] = "无", [1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6, [7] = 7, [8] = 8, [9] = 9}, 
			get = function() return AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["Stack"] or 0 end, 
			set = function(_, value)
				if value == 0 then
					AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["Stack"] = nil
				else
					AuraWatchDB[GroupSelectValue]["List"][AuraSelectValue]["Stack"] = value
				end
			end,
		}, 
	}
end
local function UpdateGruopValue()
	GruopValue = {
		GroupSelect = {
			type = "select", order = 1, 
			name = "选择分组：", desc = "请选择分组", 
			values = function()
				local Table = {}
				for key, value in pairs(AuraWatchDB) do Table[key] = value["Name"] end
				return Table
			end, 
			get = function() return GroupSelectValue end, 
			set = function(_, value)
				GroupSelectValue = value
				UpdateGruopValue()
				UpdateAuraList()
				AuraSelectValue = 1
			end, 
		}, 
		AddNewGroup = {
			type = "execute", order = 2, 
			name = "添加分组", 	
			func = function()
				tinsert(AuraWatchDB, {
					Name = "新分组", 
					Direction = "RIGHT", Interval = 8, 
					Mode = "ICON", IconSize = 48, 
					Pos = {"CENTER", "UIParent", "CENTER", 0, 0},
					List = {{AuraID = 118, UnitID = "player"}}
				})
				GroupSelectValue = #AuraWatchDB
				UpdateGruopValue()
			end, 
		}, 
		DeleteGroup = {
			type = "execute", order = 3, 
			name = "删除分组", 
			func = function()
				tremove(AuraWatchDB, GroupSelectValue)
				GroupSelectValue = GroupSelectValue-1 > 0 and GroupSelectValue-1 or 1
				UpdateGruopValue()
			end, 
		}, 
		GroupName = {
			type = "input", order = 4, 
			name = "分组名称：", desc = "请输入分组名称", 
			get = function() return AuraWatchDB[GroupSelectValue]["Name"] end, 
			set = function(_, value) AuraWatchDB[GroupSelectValue]["Name"] = value end,
		}, 
		Mode = {
			type = "select", order = 4, 
			name = "显示模式：", desc = "请选择显示模式", 
			values = {["ICON"] = "图标模式", ["BAR"] = "计时条"}, 
			get = function() return AuraWatchDB[GroupSelectValue]["Mode"] end, 
			set = function(_, value)
				AuraWatchDB[GroupSelectValue]["Mode"] = value
				if not AuraWatchDB[GroupSelectValue]["BarWidth"] then AuraWatchDB[GroupSelectValue]["BarWidth"] = 200 end
			end, 
		}, 
		Direction = {
			type = "select", order = 5, 
			name = "增长方向：", desc = "请选择增长方向", 
			values = {["LEFT"] = "左", ["RIGHT"] = "右", ["UP"] = "上", ["DOWN"] = "下"}, 
			get = function() return AuraWatchDB[GroupSelectValue].Direction end, 
			set = function(_, value) AuraWatchDB[GroupSelectValue].Direction = value end, 
		}, 
		Interval = {
			type = "range", order = 6, 
			name = "间距：", desc = "请输入间距", 
			min = 0, max = 30, step = 1, 
			get = function() return AuraWatchDB[GroupSelectValue].Interval end, 
			set = function(_, value) AuraWatchDB[GroupSelectValue].Interval = value end, 
		}, 
		IconSize = {
			type = "range", order = 7, 
			name = "图标大小：", desc = "图标大小", 
			min = 8, max = 64, step = 1, 
			get = function() return AuraWatchDB[GroupSelectValue].IconSize end, 
			set = function(_, value) AuraWatchDB[GroupSelectValue].IconSize = value end, 
		}, 
		BarWidth = {
			type = "range", order = 8, 
			name = "计时条宽度：", desc = "请输入计时条宽度", 
			min = 20, max = 300, step = 5, 
			get = function() return AuraWatchDB[GroupSelectValue]["BarWidth"] end, 
			set = function(_, value) AuraWatchDB[GroupSelectValue]["BarWidth"] = value end, 
		}, 		
	}
end
function Module.BuildGUI()
	UpdateGruopValue()
	UpdateAuraList()
	if DB["Config"] then
		DB["Config"]["AuraWatch"] =  {
			type = "group", order = 6,
			name = "技能监视", 
			args = {
				GruopValue= {
					type = "group", order = 2, 
					name = " ", guiInline = true, 
					args = GruopValue, 
				}, 
				AuraList = {
					type = "group", order = 3, 
					name = " ", guiInline = true, 
					args = AuraList, 
				}
			}
		}
	end
end