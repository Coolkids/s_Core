﻿local _, _, _, DB = unpack(select(2, ...))
--全局设置
local MediaPath = "Interface\\Addons\\s_core\\media\\"
local Media = "Interface\\Addons\\s_core\\media\\"
dummy = function() return end
DB.MyClass = select(2, UnitClass("player"))
DB.PlayerName, _ = UnitName("player")
DB.MyClassColor = RAID_CLASS_COLORS[DB.MyClass]
DB.Font = ChatFrame1:GetFont()
DB.Solid = Media.."solid"
DB.Button = Media.."Button"
DB.GlowTex = Media.."glowTex"
DB.Statusbar = Media.."Statusbar7"
DB.barinset = 10
DB.backdrop = { 
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
    edgeFile = "",
    tile = false,
    tileSize = 0, 
    edgeSize = 0, 
    insets = { 
      left = -DB.barinset, 
      right = -DB.barinset, 
      top = -DB.barinset, 
      bottom = -DB.barinset,
    },
  }
-- Buff设置
 DB.auratex = MediaPath.."iconborder" 
 DB.bfont = MediaPath.."ROADWAY.ttf"
 DB.backdrop_texture = MediaPath.."backdrop"
 DB.backdrop_edge_texture = MediaPath.."backdrop_edge"
 DB.biconsize = 36 									-- 大小
 DB.timefontsize = 17									-- 时间数字大小
 DB.countfontsize = 16								-- 堆叠层数数字大小
-- 聊天设置
DB.AutoApply = false									--聊天设置锁定		
DB.def_position = {"BOTTOMLEFT",UIParent,"BOTTOMLEFT",20,30} -- Chat Frame position
DB.chat_height = 230
DB.chat_width = 510
DB.fontsize = 18                          --other variables
DB.eb_point = {"BOTTOM", -200, 180}		-- Editbox position
DB.eb_width = 400						-- Editbox width
DB.tscol = "64C2F5"						-- Timestamp coloring
DB.TimeStampsCopy = true					-- 时间戳

--Loot 
  DB.bartex =		MediaPath.."statusbar"		
  DB.bordertex =	MediaPath.."icon_clean"	
  DB.closebtex =	MediaPath.."black-close"
  DB.edgetex = 	"Interface\\Tooltips\\UI-Tooltip-Border"
  DB.loottex =		"Interface\\QuestFrame\\UI-QuestLogTitleHighlight"
  DB.iconsize = 28 					-- 图标大小
  DB.roll_iconsize = 33 				-- roll点框体大小
  DB.position = {"TOP", 0, -300}  	-- roll点框体位置
  DB.suppress_loot_spam = false			-- suppress group loot spam in chat window if detailed loot info enabled
  DB.bar_width = 250					-- bar宽度
  DB.bar_height = 25					-- bar高度
 
--仇恨条
DB.OpenThreat = true
DB.ArrowT = Media.."ArrowT"
DB.Arrow = Media.."Arrow"


--背包
DB.bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"
DB.edgeFile = Media.."glowTex5"
--DB.Solid = Media.."Solid"
DB.bagScale = 1.1 		

--AuraWatch
DB.AWStatusbar = Media.."Statusbar7"
--动作条

DB.bars = {
    bar1 = {     
	    uselayout2x6    = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
    },
    bar2 = {
      uselayout2x6    = false,
      showonmouseover = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
    },
    bar3 = {
      uselayout2x6    = false,
      showonmouseover = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
    },
    bar4 = {
      showonmouseover = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
    },
    bar5 = {
      showonmouseover = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
    },

    stancebar = {
      showonmouseover = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
      disable         = false,
    },
    petbar = {
      showonmouseover = false,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
      disable         = false,
    },

    extrabar = {
      userplaced      = true,
      locked          = true,
      testmode        = false,
      disable         = false,
    },
    micromenu = {
      showonmouseover = true,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
      disable         = true,
    },
    bags = {
      showonmouseover = true,
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
      disable         = true,
    },
    totembar = {
      userplaced      = true, --want to place the bar somewhere else?
      locked          = true, --frame locked 
      testmode        = false,
      disable         = false,
    },
    vehicleexit = {
      userplaced      =true, --want to place the bar somewhere else?
      locked          = true, --frame locked
      testmode        = false,
    },
  }
 
 

--头像
DB.UFont, DB.Ufontsize, DB.Ufontflag = ChatFrame1:GetFont(), 15, "THINOUTLINE" 
DB.Uheight, DB.Uwidth = 25, 240
DB.Uscale = 1.0
DB.Uhpheight = .75 -- .70 - .95 
DB.Ubossframes = true
DB.Uportraits = false

	

--施法条
DB.bar_texture = "Interface\\AddOns\\S_core\\media\\sppower"  --bar原材质

--声望条位置
DB.stEAnchor = { "TOP", Minimap, "TOP", 0, 38}


---mini功能
DB.combatpointOpen = true --盗贼连击点显示
DB.combatpoint = {"CENTER",UIParent,"CENTER",226,-297}  --连击点位子
DB.AutoSell = true   --自动出售
DB.AutoRepair = false --自动修理
DB.caelNamePlatesOpen = true  --开启姓名板美化
DB.ChatFilter = true  --开启聊天信息过滤(防刷屏)
DB.FastError = true   --开启系统红字屏蔽
DB.Interrupt = true   --开启打断通告
DB.Icicle = true  --开启敌对技能冷却监视
DB.Ratings = true  --装备属性转换
DB.MiniMapPanels = true  --开启团队工具
DB.UIscale = true  --设置UI缩放
DB.AutoUIscale = false  -- 自动设定UI缩放
DB.LockUIscale = true --锁定UI缩放
DB.Autoinvite = false  --自动邀请
DB.INVITE_WORD = "SunUI"  --自动邀请关键字(请在""里面填写)
--皮肤
DB.SkinDBM = true  --DBM皮肤
DB.SkinOmen = true --Omen皮肤
DB.SkinPallyPower = true  --PallyPower皮肤
DB.SkinBigWigs = true  --BigWigs
DB.SkinQuartz = true --Quartz
DB.SkinRecount = true --Recount
DB.SkinSkada = true --Skada
--內置CD
DB.ClassCDOpen = true
DB.ClassCDDirection = down   --  down or up
--暗影魔計時
DB.ShadowPetOpen = true