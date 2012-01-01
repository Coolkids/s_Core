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

	-- 德鲁伊
	["DRUID"] = {
		{
			Name = "玩家Buff",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", -45, -250},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
			List = {		
			  -- 奥术强化
				{AuraID = 12042, UnitID = "player"},
				-- 唤醒
				{AuraID = 12051, UnitID = "player"},
				-- 奥术冲击
				{AuraID = 36032, UnitID = "player"},				
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
				-- 暗月卡片:海啸
				{AuraID = 89182, UnitID = "player"},
			},
		},
		
		{
			Name = "玩家技能CD",
			Direction = "RIGHT", Interval = 8,
			Mode = "ICON", IconSize = 28,
			Pos = {"CENTER", UIParent, "CENTER", -45, -250},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -185, -255},
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
			Pos = {"CENTER", UIParent, "CENTER", -45, -250},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
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
			Pos = {"CENTER", UIParent, "CENTER", -45, -250},
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
			Pos = {"CENTER", UIParent, "CENTER", -75, -175},
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
			Pos = {"CENTER", UIParent, "CENTER", 131, -135},
			List = {
				-- 血之疫病
				{AuraID = 55078, UnitID = "target", Caster = "player"},
				-- 冰霜疫病
				{AuraID = 55095, UnitID = "target", Caster = "player"},
				-- 血红热疫
				{AuraID = 81130, UnitID = "target", Caster = "player"},
			},
		},	
		--[[{
			Name = "CD",
			Direction = "DOWN",
			Interval = 4,
			Mode = "ICON",
			IconSize = 48,
			BarWidth = 175,
			Pos = {"CENTER", UIParent, "CENTER", 0, 100},
			List = {
				-- 随身邮箱
				{ItemID = 40768},
				-- 冰封之韧
				{SpellID = 48792},
				-- 反魔法护罩
				{SpellID = 48707},
			},
		},]]
	},
}