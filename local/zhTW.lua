﻿local S, C, L, DB = unpack(select(2, ...))

if GetLocale() ~= "zhTW" then  return end
-- 控制台
--标语
L["恢复默认标语"] = "|cffDDA0DDSun|r|cff44CCFFUI|r\n|cffFFD700确认恢复默认设置|r\n"
L["欢迎标语"] = "欢迎使用|cffDDA0DDSun|r|cff44CCFFUI|r\n\n请点击确定按钮加载默认配置\n"
L["警告"] = "|cffDDA0DDSun|r|cff44CCFFUI|r\n|cffFFD700開啟此功能會導致戰鬥中內存暴漲,請量力開啟.|r"
--总
L["恢复默认设置"] = "恢復默認設置"
L["解锁框体"] = "解鎖框體"
L["锁定框体"] = "鎖定框體"
L["应用(重载界面)"] = "應用(重載界面)"
-- 动作条
L["动作条"] = "動作條"
L["请选择主动作条布局"] = "請選擇主動作條布局"
L["bar1布局"] = "bar1布局"
L["bar2布局"] = "bar2布局"
L["bar3布局"] = "bar3布局"
L["bar4布局"] = "bar4布局"
L["bar5布局"] = "bar5布局"
L["12x1布局"] = "12x1布局"
L["6x2布局"] = "6x2布局"
L["4方块布局"] = "4方塊布局"
L["不要4方块布局"] = "不要4方塊布局"
L["动作条皮肤风格"] = "動作條皮膚風格"
L["请选择动作条皮肤风格"] = "請選擇動作條皮膚風格"
L["阴影风格"] = "陰影風格"
L["框框风格"] = "框框風格"
L["隐藏快捷键显示"] = "隱藏快捷鍵顯示"
L["隐藏宏名称显示"] = "隱藏宏名稱顯示"
L["冷却闪光"] = "冷卻閃光"
L["动作条按钮大小"] = "動作條按鈕大小"
L["动作条间距大小"] = "動作條間距大小"
L["动作条字体大小"] = "動作條字體大小"
L["宏名字字体大小"] = "宏名字字體大小"
L["主动作条缩放大小"] = "主動作條縮放大小"
L["特殊按钮缩放大小"] = "特殊按鈕縮放大小"
L["宠物条缩放大小"] = "寵物條縮放大小"
L["姿态栏缩放大小"] = "姿態欄縮放大小"
L["图腾栏缩放大小"] = "圖騰欄縮放大小"
--姓名板
L["姓名板"] = "姓名板"
L["姓名板字体大小"] = "姓名板字體大小"
L["姓名板血条高度"] = "姓名板血條高度"
L["姓名板血条宽度"] = "姓名板血條寬度"
L["姓名板施法条图标大小"] = "姓名板施法條圖標大小"
L["姓名板施法条高度"] = "姓名板施法條高度"
L["姓名板施法条宽度"] = "姓名板施法條寬度"
--鼠标提示
L["鼠标提示"] = "鼠標提示"
L["提示框体跟随鼠标"] = "提示框體跟隨鼠標"
L["进入战斗自动隐藏"] = "進入戰鬥自動隱藏"
L["字体大小"] = "字體大小"
L["隐藏头衔"] = "隱藏頭銜"
L["主天赋"] = "主天賦:|cffffffff "
L["副天赋"] = "副天賦:|cffffffff "
L["成就点数"] = "|cFFF1C502成就點數:  |cFFFFFFFF"
L["正在查询成就"] = "正在查詢成就.."
L["释放者"] = "釋放者:"
L["法术ID"] = "法術編號"
--增益效果
L["增益效果"] = "增益效果"
L["图标大小"] = "圖標大小："
L["BUFF增长方向"] = "BUFF增長方向："
L["从右向左"] = "從右向左"
L["从左向右"] = "從左向右"
L["DEBUFF增长方向"] = "DEBUFF增長方向："
--仇恨监视
L["仇恨监视"] = "仇恨監視"
L["仇恨条宽度"] = "仇恨條寬度："
L["仇恨条姓名长度"] = "仇恨條姓名長度："
L["显示仇恨人数"] = "顯示仇恨人數(不包括Tank)："
--reminder
L["缺失提醒"] = "缺失提醒"
L["显示团队增益缺失提醒"] = "顯示團隊增益缺失提醒"
L["只在队伍中显示"] = "只在隊伍中顯示"
L["团队增益图标大小"] = "團隊增益圖標大小："
L["团队增益图标排列方式"] = "團隊增益圖標排列方式："
L["横排"] = "橫排"
L["竖排"] = "豎排"
L["显示职业增益缺失提醒"] = "顯示職業增益缺失提醒"
L["开启声音警报"] = "開啟聲音警報"
L["职业增益图标大小"] = "職業增益圖標大小："
L["职业增益图标间距"] = "職業增益圖標間距："
--界面皮肤
L["界面皮肤"] = "界面皮膚"
L["启用DBM皮肤"] = "啟用DBM皮膚"
--头像
L["头像框体"] = "頭像框體"
L["开启boss框体"] = "開啟boss框體"
L["血条职业颜色"] = "血條職業顏色"
L["蓝条颜色"] = "藍條顏色"
L["蓝条职业颜色"] = "藍條職業顏色"
L["是否开启头像"] = "是否開啟頭像"
L["是否只显示你释放的debuff"] = "是否只顯示妳釋放的debuff"
L["头像字体大小"] = "頭像字體大小："
L["法力条高度"] = "法力條高度："
L["头像缩放大小"] = "頭像縮放大小："
L["玩家施法条宽度"] = "玩家施法條寬度："
L["玩家施法条高度"] = "玩家施法條高度："
L["目标施法条宽度"] = "目標施法條寬度："
L["目标施法条高度"] = "目標施法條高度："
L["焦点施法条宽度"] = "焦點施法條寬度："
L["焦点施法条高度"] = "焦點施法條高度："
L["宠物施法条宽度"] = "寵物施法條寬度："
L["宠物施法条高度"] = "寵物施法條高度："
L["施法条图标大小"] = "施法條圖標大小："
--mini
L["小东西设置"] = "小東西設置"
L["启用出售垃圾"] = "啟用出售垃圾"
L["启用自动修理"] = "啟用自動修理"
L["启用聊天信息过滤"] = "啟用聊天信息過濾"
L["启用系统红字屏蔽"] = "啟用系統紅字屏蔽"
L["启用打断通报"] = "啟用打斷通報"
L["PVP冷却计时"] = "PVP冷卻計時"
L["启用团队工具"] = "啟用團隊工具"
L["需要团长或者助理权限"] = "需要團長或者助理權限"
L["启用自动邀请"] = "啟用自動邀請"
L["自动邀请关键字"] = "自動邀請關鍵字："
L["启用自动离开有进度的随机副本或团队"] = "啟用自動離開有進度的隨機副本或團隊"
L["UI缩放"] = "UI縮放"
L["UI缩放大小"] = "UI縮放大小："
L["应用"] = "應用"
L["启用插件UI缩放设定"] = "啟用插件UI縮放設定"
L["自动设定UI缩放"] = "自動設定UI縮放"
L["需要开启插件UI缩放设定"] = "需要開啟插件UI縮放設定"
L["锁定UI缩放"] = "鎖定UI縮放"
L["内置CD"] = "內置CD"
L["启动内置CD"] = "啟動內置CD"
L["内置CD字体大小"] = "內置CD字體大小："
L["框体宽度"] = "框體寬度："
L["框体高度"] = "框體高度："
L["计时条增长方向"] = "計時條增長方向："
L["向下"] = "向下"
L["向上"] = "向上"
--other
L["内存占用"] = "|cffFFD700內存占用：|r"
L["处理器占用"] = "|cffFFD700處理器占用：|r"
L["插件管理"] = "|cffDDA0DD插件管理|r"
L["SunUI插件管理"] = "|cffDDA0DDSun|r|cff44CCFFUI|r插件管理"
L["第"] = "第 "
L["页/共"] = " 頁 / 共 "
L["页"] = " 頁"
--打斷
L["我已打断: =>"] = "我已斷法: =>"
L["<=的 "] = "<=的 "
--背包
L["背包"] = "背包"
L["搜索"] = "搜索"
L["整理背包"] = "整理背包"
--move
L["玩家施法条"] = "玩家施法條"
L["目标施法条"] = "目標施法條"
L["焦点施法条"] = "焦點施法條"
L["宠物施法条"] = "寵物施法條"
L["内置CD监视"] = "內置CD監視"
L["仇恨监视"] = "仇恨監視"
L["缺少药剂buff提示"] = "缺少藥劑buff提示"
L["连击点"] = "連擊點"
L["暗影魔计时条"] = "暗影魔計時條"
L["小地图"] = "小地圖"
L["鼠标左键拖动我!"] = "鼠標左鍵拖動我!"
L["药水"] = "精煉"
--minimap
L["角色信息"] = "角色信息"
L["法术书"] = "法術書"
L["天赋"] = "天賦"
L["成就"] = "成就"
L["任务日志"] = "任務日誌"
L["社交"] = "社交"
L["公会"] = "公會"
L["地城查找器"] = "地城查找器"
L["团队查找器"] = "團隊查找器"
L["帮助"] = "幫助"
L["行事历"] = "行事歷"
L["地城手册"] = "地城手冊"
L["就位确认"] = "就位確認"
L["角色检查"] = "角色檢查"
L["转化为团队"] = "轉化為團隊"
L["转化为小队"] = "轉化為小隊"
--声望条
L["经验值"] = "經驗值:"
L["剩余"] = '剩餘: %s'
L["休息"] = '|cffb3e1ff休息: %s (%d%%)'
L["阵营"] = '陣營: %s'
L["状态"] = '狀態: |c'
L["声望"] = '聲望: %s/%s (%d%%)'
L["仇恨"] = "仇恨"
L["敌对"] = "敵對"
L["不友好"] = "不友好"
L["中立"] = "中立"
L["友好"] = "友好"
L["尊敬"] = "尊敬"
L["崇敬"] = "崇敬"
L["崇拜"] = "崇拜"












