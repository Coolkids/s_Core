--[[

一些说明：

   Sora's AuraWatch对于Buff列表的管理是分组进行的,每一组Buff公用同一个定位点,同样的大小,同样的样式
   
   在组属性中
   {
		Name = 分组的名称
		Direction = 提示的增长方向 ("RIGHT"/"LEFT"/"UP"/"DOWN")
		Interval = 相邻提示的间距
		Mode = 提示模式(图标ICON 或者 计时条BAR)
		IconSize = 图标大小
		BarWidth = 计时条宽度(BAR模式下必须有这个属性)
		Pos = 首图标的定位点
		List = 要监视的Buff/Debuff/CD列表	
   }
   
   其中List =
   {
		AuraID/ItemID/SpellID = 三选一,分别对应监视 Buff/Debuff,物品CD,技能CD 三种情况
		UnitID = 要监视的目标,常用的有 玩家"player"/目标"target" (如果要监视Buff/Debuff的话必须有)
		Caster = 过滤Buff/Debuff的释放者 (可选,如果不需要按照施法者过滤请不要写这一项 ！！！注意,C为大写！！！ )
		Stack = 过滤Buff/Debuff的层数(可选,当Buff/Debuff层数大于等于Stack的值的时候才显示 ！！！注意,S为大写！！！)
	}

	eg. 这是一个示例
	{
		Name = "目标Debuff",
		Direction = "UP",
		Interval = 4,
		Mode = "BAR",
		IconSize = 16,
		BarWidth = 175,
		Pos = {"RIGHT", UIParent, "RIGHT", -200, 0},
		List = {
			-- 血之疫病
			{AuraID = 55078, UnitID = "target", Stack = 1},
			-- 冰霜疫病
			{AuraID = 55095, UnitID = "target", Caster = "player"},
			-- 不灭药水
			{ItemID = 40093},
		},
	},

]]

local _, SR = ...
local cfg = SR.AuraWatchConfig

SRAuraList = {
	-- 全职业
	["ALL"] = {
		{
			Name = "玩家Debuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 64,
			Pos = {"CENTER", UIParent, "CENTER", 160, 300},
			List = {
				-- 震懾波
				{AuraID = 46968, UnitID = "player"},
				-- 变羊
				{AuraID =   118, UnitID = "player"},
				-- 制裁之锤
				{AuraID =   853, UnitID = "player"},
				-- 肾击
				{AuraID =   408, UnitID = "player"},
				-- 撕扯
				{AuraID = 47481, UnitID = "player"},
				-- 沉默
				{AuraID = 55021, UnitID = "player"},
				-- 割碎
				{AuraID = 22570, UnitID = "player"},
				-- 断筋
				{AuraID =  1715, UnitID = "player"},
				-- 沉默
				{AuraID = 15487, UnitID = "player"},
				-- 心靈恐慌
				{AuraID = 64058, UnitID = "player"},
				-- 罪與罰
				{AuraID = 87204, UnitID = "player"},
				-- 魔法反制
				{AuraID = 18469, UnitID = "player"},
				-- 魔法反制
				{AuraID = 55021, UnitID = "player"},
				-- 腳踢
				{AuraID = 18425, UnitID = "player"},
				-- 腳踢
				{AuraID = 86759, UnitID = "player"},
				-- 絞殺
				{AuraID = 47476, UnitID = "player"},
				-- 冰鍊術
				{AuraID = 45524, UnitID = "player"},
				-- 心靈尖嘯
				{AuraID =  8122, UnitID = "player"},
				-- 恐懼
				{AuraID =  5782, UnitID = "player"},
				-- 恐懼嚎叫
				{AuraID =  5484, UnitID = "player"},
				--致殘毒藥
				{AuraID =  3775, UnitID = "player"},
				--聚雷針
				{AuraID = 83099, UnitID = "player"},
				--侵蝕魔法
				{AuraID = 86622, UnitID = "player"},
				--暮光隕星
				{AuraID = 88518, UnitID = "player"},
				--爆裂灰燼
				{AuraID = 79339, UnitID = "player"},
				--火焰易傷
				{AuraID = 98492, UnitID = "player"},
				--爆裂種子
				{AuraID = 98450, UnitID = "player"},
				--折磨
				{AuraID = 100230, UnitID = "player"},
				--折磨
				{AuraID = 100231, UnitID = "player"},
				--受到折磨
				{AuraID = 99257, UnitID = "player"},
				--受到折磨
				{AuraID = 99403, UnitID = "player"},
				--凝视
				{AuraID = 99849, UnitID = "player"},
				--燃烧之球
				{AuraID = 100210, UnitID = "player"},
				--折磨
				{AuraID = 99256, UnitID = "player"},
				--冰霜
				{AuraID = 109325, UnitID = "player"},
				---- Dragon Soul
				-- Morchok
				{AuraID = 103687, UnitID = "player"}, -- Crush Armor(擊碎護甲)
				-- Zon'ozz
				{AuraID = 103434, UnitID = "player"}, -- Disrupting Shadows(崩解之影)
				-- Yor'sahj
				{AuraID = 105171, UnitID = "player"},-- Deep Corruption(深度腐化)
				--{AuraID = 103628)] = 7, -- Deep Corruption(深度腐化)
				{AuraID = 104849, UnitID = "player"},  -- Void Bolt(虛無箭)
				-- Hagara
				{AuraID = 104451, UnitID = "player"},  -- Ice Tomb(寒冰之墓)
				-- Ultraxion
				{AuraID = 110073, UnitID = "player"}, -- Fading Light(凋零之光)
				-- Blackhorn
				{AuraID = 109209, UnitID = "player"},  -- Brutal Strike(蠻橫打擊)
				{AuraID = 108043, UnitID = "player"},  -- Sunder Armor(破甲攻擊)
				{AuraID = 108861, UnitID = "player"}, -- Degeneration(衰亡)
				-- Spine
				{AuraID = 105479, UnitID = "player"}, -- 燃燒血漿
				{AuraID = 109379, UnitID = "player"},-- Searing Plasma(燃燒血漿)
				{AuraID = 109457, UnitID = "player"},  -- Fiery Grip(熾熱之握)
				{AuraID = 105490, UnitID = "player"},  -- Fiery Grip(熾熱之握)
				-- Madness 
				{AuraID = 105841, UnitID = "player"},  -- Degenerative Bite(退化咬擊)
				{AuraID = 105445, UnitID = "player"},  -- Blistering Heat(極熾高熱)
				{AuraID = 106444, UnitID = "player"},  -- Impale(刺穿)
			},
		},
		
		{
			Name = "玩家PVPDebuff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 64,
			Pos = {"CENTER", UIParent, "CENTER", 160, 375},
			List = {
				{AuraID = 47481, UnitID = "player"}, 
        {AuraID = 51209, UnitID = "player"}, 
        {AuraID = 47476, UnitID = "player"}, 
        {AuraID = 45524, UnitID = "player"}, 
        {AuraID = 55666, UnitID = "player"},
        {AuraID = 58617, UnitID = "player"}, 
        {AuraID = 50436, UnitID = "player"},
        {AuraID = 5211, UnitID = "player"}, 
        {AuraID = 33786, UnitID = "player"}, 
        {AuraID = 2637, UnitID = "player"}, 
        {AuraID = 22570, UnitID = "player"}, 
        {AuraID = 9005, UnitID = "player"}, 
        {AuraID = 339, UnitID = "player"}, 
        {AuraID = 19675, UnitID = "player"}, 
        {AuraID = 58179, UnitID = "player"}, 
        {AuraID = 61391, UnitID = "player"}, 
        {AuraID = 60210, UnitID = "player"}, 
        {AuraID = 3355, UnitID = "player"}, 
        {AuraID = 24394, UnitID = "player"}, 
        {AuraID = 1513, UnitID = "player"}, 
        {AuraID = 19503, UnitID = "player"}, 
        {AuraID = 19386, UnitID = "player"}, 
        {AuraID = 34490, UnitID = "player"}, 
        {AuraID = 53359, UnitID = "player"}, 
        {AuraID = 19306, UnitID = "player"}, 
        {AuraID = 19185, UnitID = "player"}, 
        {AuraID = 35101, UnitID = "player"}, 
        {AuraID = 5116, UnitID = "player"}, 
        {AuraID = 13810, UnitID = "player"}, 
        {AuraID = 61394, UnitID = "player"}, 
        {AuraID = 2974, UnitID = "player"}, 
        {AuraID = 50519, UnitID = "player"}, 
        {AuraID = 50541, UnitID = "player"}, 
        {AuraID = 54644, UnitID = "player"}, 
        {AuraID = 50245, UnitID = "player"}, 
        {AuraID = 50271, UnitID = "player"}, 
        {AuraID = 50518, UnitID = "player"}, 
        {AuraID = 54706, UnitID = "player"}, 
        {AuraID = 4167, UnitID = "player"}, 
        {AuraID = 44572, UnitID = "player"}, 
        {AuraID = 31661, UnitID = "player"}, 
        {AuraID = 12355, UnitID = "player"}, 
        {AuraID = 118, UnitID = "player"}, 
        {AuraID = 18469, UnitID = "player"},
        {AuraID = 64346, UnitID = "player"},
        {AuraID = 33395, UnitID = "player"}, 
        {AuraID = 122, UnitID = "player"}, 
        {AuraID = 11071, UnitID = "player"}, 
        {AuraID = 55080, UnitID = "player"}, 
        {AuraID = 11113, UnitID = "player"}, 
        {AuraID = 6136, UnitID = "player"}, 
        {AuraID = 120, UnitID = "player"}, 
        {AuraID = 116, UnitID = "player"}, 
        {AuraID = 47610, UnitID = "player"}, 
        {AuraID = 31589, UnitID = "player"}, 
        {AuraID = 853, UnitID = "player"}, 
        {AuraID = 2812, UnitID = "player"}, 
        {AuraID = 20066, UnitID = "player"}, 
        {AuraID = 20170, UnitID = "player"}, 
        {AuraID = 10326, UnitID = "player"}, 
        {AuraID = 63529, UnitID = "player"}, 
        {AuraID = 20184, UnitID = "player"}, 
        {AuraID = 605, UnitID = "player"},
        {AuraID = 64044, UnitID = "player"}, 
        {AuraID = 8122, UnitID = "player"}, 
        {AuraID = 9484, UnitID = "player"}, 
        {AuraID = 15487, UnitID = "player"}, 
        {AuraID = 15407, UnitID = "player"}, 
        {AuraID = 2094, UnitID = "player"}, 
        {AuraID = 1833, UnitID = "player"}, 
        {AuraID = 1776, UnitID = "player"}, 
        {AuraID = 408, UnitID = "player"}, 
        {AuraID = 6770, UnitID = "player"}, 
        {AuraID = 1330, UnitID = "player"}, 
        {AuraID = 18425, UnitID = "player"}, 
        {AuraID = 51722, UnitID = "player"}, 
        {AuraID = 31125, UnitID = "player"}, 
        {AuraID = 3409, UnitID = "player"}, 
        {AuraID = 26679, UnitID = "player"}, 
        {AuraID = 39796, UnitID = "player"}, 
        {AuraID = 51514, UnitID = "player"}, 
        {AuraID = 64695, UnitID = "player"}, 
        {AuraID = 63685, UnitID = "player"}, 
        {AuraID = 3600, UnitID = "player"}, 
        {AuraID = 8056, UnitID = "player"}, 
        {AuraID = 8034, UnitID = "player"}, 
        {AuraID = 710, UnitID = "player"}, 
        {AuraID = 6789, UnitID = "player"}, 
        {AuraID = 5782, UnitID = "player"}, 
        {AuraID = 5484, UnitID = "player"}, 
        {AuraID = 6358, UnitID = "player"},
        {AuraID = 30283, UnitID = "player"}, 
        {AuraID = 24259, UnitID = "player"}, 
        {AuraID = 18118, UnitID = "player"}, 
        {AuraID = 18223, UnitID = "player"}, 
        {AuraID = 7922, UnitID = "player"},
        {AuraID = 12809, UnitID = "player"},
        {AuraID = 20253, UnitID = "player"}, 
        {AuraID = 5246, UnitID = "player"},
        {AuraID = 12798, UnitID = "player"}, 
        {AuraID = 46968, UnitID = "player"}, 
        {AuraID = 18498, UnitID = "player"}, 
        {AuraID = 676, UnitID = "player"}, 
        {AuraID = 58373, UnitID = "player"}, 
        {AuraID = 23694, UnitID = "player"}, 
        {AuraID = 1715, UnitID = "player"}, 
        {AuraID = 12323, UnitID = "player"}, 
        {AuraID = 30217, UnitID = "player"}, 
        {AuraID = 67769, UnitID = "player"}, 
        {AuraID = 30216, UnitID = "player"}, 
        {AuraID = 20549, UnitID = "player"}, 
        {AuraID = 25046, UnitID = "player"}, 
        {AuraID = 39965, UnitID = "player"}, 
        {AuraID = 55536, UnitID = "player"}, 
        {AuraID = 13099, UnitID = "player"}, 
        {AuraID = 29703, UnitID = "player"}, 
        {AuraID = 46924, UnitID = "player"}, 
        {AuraID = 642, UnitID = "player"}, 
        {AuraID = 45438, UnitID = "player"}, 
        {AuraID = 34692, UnitID = "player"},
        {AuraID = 28169, UnitID = "player"},
        {AuraID = 28059, UnitID = "player"},
        {AuraID = 28084, UnitID = "player"}, 
        {AuraID = 27819, UnitID = "player"},
        {AuraID = 63024, UnitID = "player"},
        {AuraID = 63018, UnitID = "player"}, 
        {AuraID = 62589, UnitID = "player"}, 
        {AuraID = 63276, UnitID = "player"}, 
        {AuraID = 66770, UnitID = "player"}, 
			},
		},
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 56,
			Pos = {"CENTER", UIParent, "CENTER", -340, 65},
			List = {
				-- 火山药水
				{AuraID = 79476, UnitID = "player"},
				-- 英勇
				{AuraID = 80353, UnitID = "player"},
				-- 时间扭曲
				{AuraID = 32182, UnitID = "player"},
				-- 上古狂乱
				{AuraID = 90355, UnitID = "player"},
				-- 托维尔药水
				{AuraID = 79633, UnitID = "player"},
				-- 魔像药水
				{AuraID = 79634, UnitID = "player"},
				-- 能量灌注
				{AuraID = 10060, UnitID = "player"},
				-- 痛苦镇压
				{AuraID = 33206, UnitID = "player"},
				-- 真言術壁
				{AuraID = 81782, UnitID = "player"},
				-- 真言術壁
				{AuraID = 81781, UnitID = "player"},
				-- 集结呐喊
				{AuraID = 97463, UnitID = "player"},
				-- 神性犧牲
				{AuraID = 70940, UnitID = "player"},
				-- 反魔法領域
				{AuraID = 50461, UnitID = "player"},
				-- 靈魂連接圖騰
				{AuraID = 98007, UnitID = "player"},
				-- 邪惡狂熱
				{AuraID = 8699, UnitID = "player"},
				-- 寧靜
				{AuraID = 44203, UnitID = "player"},
				-- 神聖禮頌
				{AuraID = 64844, UnitID = "player"},
				-- 神聖禮頌
				{AuraID = 64843, UnitID = "player"},
				-- 希望禮頌
				{AuraID = 64904, UnitID = "player"},
				-- 希望禮頌
				{AuraID = 64901, UnitID = "player"},
				
			},
		},
		
		  {
			Name = "玩家重要Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 48,
			Pos = {"CENTER", UIParent, "CENTER", -345, -5},
			List = {
				-- 急速射击
				{AuraID =  3045, UnitID = "player"},
				-- 4T12特效
				{AuraID = 99060, UnitID = "player"},
				-- 强化法力宝石
				{AuraID = 83098, UnitID = "player"},
				-- 奥术强化
				{AuraID = 12042, UnitID = "player"},
				-- 黑天使
				{AuraID = 87153, UnitID = "player"},  
				-- 消散
				{AuraID = 47585, UnitID = "player"},  
				-- 劍舞
				{AuraID = 13877, UnitID = "player"},
				-- 能量刺激
				{AuraID = 13750, UnitID = "player"},
				-- 佯攻
				{AuraID =  1966, UnitID = "player"},
				-- 荷枪实弹
				{AuraID = 56453, UnitID = "player"},
				-- 开火!
				{AuraID = 82926, UnitID = "player"},
				-- 冰霜之指
				{AuraID = 44544, UnitID = "player"},
				-- 腦部凍結
				{AuraID = 57761, UnitID = "player"},
				--焦炎之痕
				{AuraID =48108, UnitID = "player"},
				-- 機緣回復
				{AuraID = 63735, UnitID = "player"},
				-- 光之澎湃
				{AuraID = 88688, UnitID = "player"},
				
			},
		},
		
		{
			Name = "玩家饰品附魔触发buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", UIParent, "CENTER", -75, -140},
			List = {
				--电容器
				{AuraID = 96890, UnitID = "player"},
				--死灵法师极核
				{AuraID = 97131, UnitID = "player"},
				--神經突觸彈簧
				{AuraID = 96230, UnitID = "player"},
				--炎魔印記
				{AuraID = 97007, UnitID = "player"},
				--織炎精華
				{AuraID = 97008, UnitID = "player"},
				--遠古石化種子
				{AuraID = 97009, UnitID = "player"},
				--吞噬
				{AuraID = 96911, UnitID = "player"},
				--火山毀滅
				{AuraID = 89091, UnitID = "player"},
				--能量洪流
				{AuraID = 74241, UnitID = "player"},
				--災厄魔力
				{AuraID = 92318, UnitID = "player"},
				--光紋
				{AuraID = 75170, UnitID = "player"},
				--崩土流石
				{AuraID = 74245, UnitID = "player"},
				--燧鎖的發射器
				{AuraID = 99621, UnitID = "player"},
				--矩阵加速
				{AuraID = 96977, UnitID = "player"},
				--矩阵暴击
				{AuraID = 96978, UnitID = "player"},
				--矩阵精通
				{AuraID = 96979, UnitID = "player"},
				--贼4T12加速(火上的未來)
				{AuraID = 99186, UnitID = "player"},
				--贼4T12暴击(熾熱破壞)
				{AuraID = 99187, UnitID = "player"},
				--贼4T12精通(火焰大師)
				{AuraID = 96978, UnitID = "player"},
				--H無縛之怒  觸發buff名字:作戰狀態 X
				{AuraID =109719, UnitID = "player"}, 
				--H淨縛之意志  觸發buff名字:鬥心 X
				{AuraID =109795, UnitID = "player"}, 
				--H無命之心 觸發buff名字:開闊思維 X
				{AuraID =109813, UnitID = "player"}, 
				--H壞滅之眼  觸發buff名字:泰坦之力 X
				{AuraID =77997, UnitID = "player"}, 
				--H不朽的決心  觸發buff名字:超自然閃避 X
				{AuraID =109782, UnitID = "player"},
				--H七徵聖印   觸發buff名字:速度
				{AuraID =109804, UnitID = "player"}, 
				--H靈魂轉移者漩渦  觸發buff名字:戰術大師 
				{AuraID =109776, UnitID = "player"}, 
				--H腐敗心靈徽記  觸發buff名字:速度 
				{AuraID =109789, UnitID = "player"},
				--H末代之龍的誕生塑像   觸發buff名字:找尋弱點
				{AuraID =109744, UnitID = "player"}, 
				--H擒星羅盤   觸發buff名字:速度
				{AuraID =109711, UnitID = "player"},
				--H基洛提瑞克符印  觸發buff名字:輕靈
				{AuraID =109715, UnitID = "player"}, 
				--H瓶裝願望   觸發buff名字:究極之力
				{AuraID =109792, UnitID = "player"}, 
				--H聖光倒影   觸發buff名字:究極之力
				{AuraID =109792, UnitID = "player"},
				--H腐爛頭顱  觸發buff名字:泰坦之力
				{AuraID =109747, UnitID = "player"},
				--H深淵之火  觸發buff名字:難以捉摸
				{AuraID =109779, UnitID = "player"},  
				--無縛之怒  觸發buff名字:作戰狀態 X
				{AuraID =107960, UnitID = "player"}, 
				--淨縛之意志  觸發buff名字:鬥心 X
				{AuraID =77198, UnitID = "player"}, 
				--無命之心  觸發buff名字:開闊思維 X
				{AuraID =107962, UnitID = "player"},
				--壞滅之眼  觸發buff名字:泰坦之力 X
				{AuraID =107967, UnitID = "player"}, 
				--不朽的決心  觸發buff名字:超自然閃避 X
				{AuraID =107968, UnitID = "player"},
				--基洛提瑞克符印 觸發buff名字:輕靈
				{AuraID =107947, UnitID = "player"},
				--瓶裝願望  觸發buff名字:究極之力
				{AuraID =107948, UnitID = "player"},
				--聖光倒影  觸發buff名字:究極之力
				{AuraID =107948, UnitID = "player"},
				--腐爛頭顱  觸發buff名字:泰坦之力
				{AuraID =107949, UnitID = "player"},
				--深淵之火  觸發buff名字:難以捉摸
				{AuraID =107951, UnitID = "player"},
				--擒星羅盤  觸發buff名字:速度
				{AuraID =107982, UnitID = "player"},
				--腐敗心靈徽記  觸發buff名字:速度 
				{AuraID =107982, UnitID = "player"},
				--七徵聖印   觸發buff名字:速度
				{AuraID =107982, UnitID = "player"},
				--末代之龍的誕生塑像  觸發buff名字:找尋弱點
				{AuraID =107988, UnitID = "player"},
				--靈魂轉移者漩渦  觸發buff名字:戰術大師
				{AuraID =107986, UnitID = "player"},
				--時間之箭  觸發buff名字:時間之箭
				{AuraID =102659, UnitID = "player"},
				--惡魔領主之賜  觸發buff名字:邪惡之禮 
				{AuraID =102662, UnitID = "player"}, 
				--惡魔領主之賜  觸發buff名字:邪惡之禮 
				{AuraID =109908, UnitID = "player"},
				--L七徵聖印  觸發buff名字:速度
				{AuraID =109802, UnitID = "player"},
				--L腐敗心靈徽記  觸發buff名字:速度
				{AuraID =109802, UnitID = "player"},
				--L擒星羅盤  觸發buff名字:速度
				{AuraID =109802, UnitID = "player"},
				--L無縛之怒 X 觸發buff名字:作戰狀態
				{AuraID =109717, UnitID = "player"},
				--L淨縛之意志  X  觸發buff名字:鬥心
				{AuraID =109793, UnitID = "player"},
				--L無命之心 X  觸發buff名字:開闊思維
				{AuraID =109811, UnitID = "player"},
				--L壞滅之眼  X   觸發buff名字:泰坦之力
				{AuraID =109748, UnitID = "player"},
				--L不朽的決心  X 觸發buff名字:超自然閃避
				{AuraID =109780, UnitID = "player"},
			},
		},
	},

}