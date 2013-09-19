local S, L, DB, _, C = unpack(select(2, ...))
if (GetLocale() == "zhCN") then return end
local Module = LibStub("AceAddon-3.0"):GetAddon("SunUI"):NewModule("ClearFont_zhTW", "AceEvent-3.0", "AceHook-3.0")
local SunUIConfig = LibStub("AceAddon-3.0"):GetAddon("SunUI"):GetModule("SunUIConfig")
local CF_SCALE
-- ָ������������w
local CLEAR_FONT_BASE = "Fonts\\";
-- ���š��ѯB�����I���������w
local CLEAR_FONT_NUMBER = CLEAR_FONT_BASE .. "FRIZQT__.TTF";
-- �����l�����l�ϵ����w
local CLEAR_FONT_EXP = CLEAR_FONT_BASE .. "ARIALN.TTF";
-- �΄��f���͕��š�ʯ�����������w
local CLEAR_FONT_QUEST = CLEAR_FONT_BASE .. "bLEI00D.TTF";
-- ���Y������ֵ��ʾ
local CLEAR_FONT_DAMAGE = CLEAR_FONT_BASE .. "bKAI00M.TTF";
-- �[������е���Ҫ���w
local CLEAR_FONT = CLEAR_FONT_BASE .. "bLEI00D.TTF";
-- ��Ʒ�����ܵ��f�����w
local CLEAR_FONT_ITEM = CLEAR_FONT_BASE .. "bHEI00M.TTF";
-- �������w
local CLEAR_FONT_CHAT = CLEAR_FONT_BASE .. "bHEI01B.TTF";

if GetLocale() ~= "zhTW" then
	CLEAR_FONT_NUMBER = DB.Font
	CLEAR_FONT_EXP = DB.Font
	CLEAR_FONT_QUEST = DB.Font
	CLEAR_FONT_DAMAGE = DB.Font
	CLEAR_FONT = DB.Font
	CLEAR_FONT_ITEM = DB.Font
	CLEAR_FONT_CHAT = DB.Font
end
local CF_SCALE = 1
local function CanSetFont(object) 
   return (type(object)=="table" 
	   and object.SetFont and object.IsObjectType 
		  and not object:IsObjectType("SimpleHTML")); 
end
local function ApplySystemFonts(event, addon)
	if addon ~= "SunUI" then return end
-- ��������
	STANDARD_TEXT_FONT = CLEAR_FONT_CHAT;

-- �^���ϵ����֣�Ư���ı����h̎���ɿ�Ҋ��
	UNIT_NAME_FONT = CLEAR_FONT;

-- �^���ϵ����֣����������ϣ�NamePlate������V���῿��Ŀ�ˣ����F��Ѫ�l��
	NAMEPLATE_FONT = CLEAR_FONT;

-- ������Ŀ���Ϸ������Ă���ָʾ���c���SCT/DCT�o�P��
	DAMAGE_TEXT_FONT = CLEAR_FONT_DAMAGE;

-- ----------------------------------------------------------------------------- 
-- �������ܱ����w��С��Note by Kirkburn��

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12 * CF_SCALE;

-- -----------------------------------------------------------------------------
-- ���[�����w: �S̎��Ҋ����Ҫ�����w
-- -----------------------------------------------------------------------------

-- �����}�����o�����ܘ��}�����ܕ���壩���΄������΄����I��壩�����ѽ�ɫ���֣��罻��壩���s�u�c�����������c����PvP��壩��ϵ�y���ܱ팣��
	if (CanSetFont(GameFontNormal)) then 				GameFontNormal:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��15
   
-- �����}��ϵ�y���ܱ��o���ɾ��c�����ɾ͗lĿ���ɾ���壩��؛�����lĿ�������΄������΄����I��壩���Օ�����
	if (CanSetFont(GameFontHighlight)) then 			GameFontHighlight:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��15

-- ��δ�_�J��
	if (CanSetFont(GameFontNormalMed3)) then 			GameFontNormalMed3:SetFont(CLEAR_FONT, 13 * CF_SCALE); end	-- �A�Oֵ��14
	if (CanSetFont(GameFontNormalMed3)) then 			GameFontNormalMed3:SetTextColor(1.0, 0.82, 0); end	-- �A�Oֵ��(1.0, 0.82, 0)

-- ���o�������x��B��
	if (CanSetFont(GameFontDisable)) then 				GameFontDisable:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
	if (CanSetFont(GameFontDisable)) then 				GameFontDisable:SetTextColor(0.5, 0.5, 0.5); end	-- �A�Oֵ��(0.5, 0.5, 0.5)

-- ���Nɫ������
	if (CanSetFont(GameFontGreen)) then 				GameFontGreen:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��15
	if (CanSetFont(GameFontRed)) then 					GameFontRed:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
	if (CanSetFont(GameFontBlack)) then 				GameFontBlack:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
	if (CanSetFont(GameFontWhite)) then 				GameFontWhite:SetFont(CLEAR_FONT, 14 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- С���w��������С���w�ĵط������ɫ������壬BUFF�r�g������}
-- -----------------------------------------------------------------------------

-- �^�������֣�BUFF�r�g��δ�x������˻`������д󲿷��������w�����x�c�Ĕ�λ���^㕪���ɾ���壩����ԃ�������ɆT��ɫ���֣��罻��壩��
-- ������վ�Ԕ����վ꠵ȼ���PvP��壩���Օѻ�ӗlĿ
	if (CanSetFont(GameFontNormalSmall)) then 			GameFontNormalSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end		-- �A�Oֵ��15

-- �������w���������ܱ��x헣����x������˻`����ɫ���ԡ����ܵĔ�λ�����lĿ����ɫ�YӍ��壩�����x�c�������x��壩����ɫ�ȼ����I���YӍ�������YӍ���罻��壩��
-- Ԕ���s�u�c���������ȷ֣�PvP��壩���r�g�YӍ��ϵ�y���ܱ��ӌ���
	if (CanSetFont(GameFontHighlightSmall)) then 		GameFontHighlightSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- �A�Oֵ��15
	if (CanSetFont(GameFontHighlightSmallOutline)) then	GameFontHighlightSmallOutline:SetFont(CLEAR_FONT, 12 * CF_SCALE, "OUTLINE"); end

-- PvP����������F���尴�o��
	if (CanSetFont(GameFontDisableSmall)) then			GameFontDisableSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- �A�Oֵ��15
	if (CanSetFont(GameFontDisableSmall)) then			GameFontDisableSmall:SetTextColor(0.5, 0.5, 0.5); end	-- �A�Oֵ��(0.5, 0.5, 0.5)

-- ��δ�_�J��
	if (CanSetFont(GameFontDarkGraySmall)) then 		GameFontDarkGraySmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- �A�Oֵ��15
	if (CanSetFont(GameFontDarkGraySmall)) then 		GameFontDarkGraySmall:SetTextColor(0.35, 0.35, 0.35); end	-- �A�Oֵ��(0.35, 0.35, 0.35)

-- ��δ�_�J��
	if (CanSetFont(GameFontGreenSmall)) then 			GameFontGreenSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- �A�Oֵ��15
	if (CanSetFont(GameFontRedSmall)) then				GameFontRedSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
	
-- ��С���w
	if (CanSetFont(GameFontHighlightExtraSmall)) then 		GameFontHighlightExtraSmall:SetFont(CLEAR_FONT, 11 * CF_SCALE); end		-- �A�Oֵ��15


-- -----------------------------------------------------------------------------
-- �����w�����}
-- -----------------------------------------------------------------------------

-- �r犣��a�l
	if (CanSetFont(GameFontNormalLarge)) then 			GameFontNormalLarge:SetFont(CLEAR_FONT, 13 * CF_SCALE); end		-- �A�Oֵ��17
	if (CanSetFont(GameFontHighlightLarge)) then 		GameFontHighlightLarge:SetFont(CLEAR_FONT, 13 * CF_SCALE); end

-- ���������
	if (CanSetFont(GameFontDisableLarge)) then			GameFontDisableLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��17
	if (CanSetFont(GameFontDisableLarge)) then			GameFontDisableLarge:SetTextColor(0.5, 0.5, 0.5); end	-- �A�Oֵ��(0.5, 0.5, 0.5)

-- ��δ�_�J��
	if (CanSetFont(GameFontGreenLarge)) then 			GameFontGreenLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��17
	if (CanSetFont(GameFontRedLarge)) then 			GameFontRedLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- �޴����w��Raid����
-- -----------------------------------------------------------------------------

	if (CanSetFont(GameFontNormalHuge)) then			GameFontNormalHuge:SetFont(CLEAR_FONT, 20 * CF_SCALE); end	-- �A�Oֵ��20
	if (CanSetFont(GameFontNormalHugeBlack)) then		GameFontNormalHugeBlack:SetFont(CLEAR_FONT, 20 * CF_SCALE); end	-- �A�Oֵ��20


-- -----------------------------------------------------------------------------
-- Boss��������
-- -----------------------------------------------------------------------------

	if (CanSetFont(BossEmoteNormalHuge)) then			BossEmoteNormalHuge:SetFont(CLEAR_FONT, 25 * CF_SCALE); end		-- �A�Oֵ��25

-- -----------------------------------------------------------------------------
-- ��λ���w: ���u�У����ţ����I��������Ʒ�ѯB����
-- -----------------------------------------------------------------------------

-- ���ţ���Ʒ��Buff�ѯB����
	if (CanSetFont(NumberFontNormal)) then				NumberFontNormal:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE, "OUTLINE"); end		-- �A�Oֵ��12
	if (CanSetFont(NumberFontNormalYellow)) then 		NumberFontNormalYellow:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE); end

-- �����l�İ��I����
	if (CanSetFont(NumberFontNormalSmall)) then 		NumberFontNormalSmall:SetFont(CLEAR_FONT_NUMBER, 11 * CF_SCALE, "OUTLINE"); end		-- �A�Oֵ��11
	if (CanSetFont(NumberFontNormalSmallGray)) then 	NumberFontNormalSmallGray:SetFont(CLEAR_FONT_NUMBER, 11 * CF_SCALE, "THICKOUTLINE"); end

-- ��δ�_�J��
	if (CanSetFont(NumberFontNormalLarge)) then 		NumberFontNormalLarge:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end		-- �A�Oֵ��14

-- ����^���ϵı�����ָʾ
	if (CanSetFont(NumberFontNormalHuge)) then			NumberFontNormalHuge:SetFont(CLEAR_FONT_DAMAGE, 20 * CF_SCALE, "THICKOUTLINE"); end	-- �A�Oֵ��20
--	if (CanSetFont(NumberFontNormalHuge)) then			NumberFontNormalHuge:SetAlpha(30); end


-- -----------------------------------------------------------------------------
-- ����ҕ�����w������ݔ������w
-- -----------------------------------------------------------------------------

-- ����ݔ������w
	if (CanSetFont(ChatFontNormal)) then 				ChatFontNormal:SetFont(CLEAR_FONT_CHAT, 14 * CF_SCALE, "THINOUTLINE"); end	-- �A�Oֵ��14

-- ���x��������w
	CHAT_FONT_HEIGHTS = {
		[1] = 7,
		[2] = 8,
		[3] = 9,
		[4] = 10,
		[5] = 11,
		[6] = 12,
		[7] = 13,
		[8] = 14,
		[9] = 15,
		[10] = 16,
		[11] = 17,
		[12] = 18,
		[13] = 19,
		[14] = 20,
		[15] = 21,
		[16] = 22,
		[17] = 23,
		[18] = 24
	};

-- ����ҕ��Ĭ�J���w
	if (CanSetFont(ChatFontSmall)) then 				ChatFontSmall:SetFont(CLEAR_FONT_CHAT, 13 * CF_SCALE); end	-- �A�Oֵ��12


-- -----------------------------------------------------------------------------
-- �΄����I: �΄����I��������
-- -----------------------------------------------------------------------------

-- �΄՘��}
	if (CanSetFont(QuestTitleFont)) then 				QuestTitleFont:SetFont(CLEAR_FONT_QUEST, 15 * CF_SCALE); end	-- �A�Oֵ��17
	if (CanSetFont(QuestTitleFont)) then 				QuestTitleFont:SetShadowColor(1.0, 0.82, 0); end		-- �A�Oֵ��(0, 0, 0)

	if (CanSetFont(QuestTitleFontBlackShadow)) then 	QuestTitleFontBlackShadow:SetFont(CLEAR_FONT_QUEST, 15 * CF_SCALE); end	-- �A�Oֵ��17
	if (CanSetFont(QuestTitleFontBlackShadow)) then 	QuestTitleFontBlackShadow:SetShadowColor(0, 0, 0); end		-- �A�Oֵ��(0, 0, 0)
	if (CanSetFont(QuestTitleFontBlackShadow)) then 	QuestTitleFontBlackShadow:SetTextColor(1.0, 0.82, 0); end			-- �A�Oֵ��(1.0, 0.82, 0)

-- �΄�����
	if (CanSetFont(QuestFont)) then 		   			QuestFont:SetFont(CLEAR_FONT_QUEST, 14 * CF_SCALE); end		-- �A�Oֵ��14
	if (CanSetFont(QuestFont)) then 		   			QuestFont:SetTextColor(1.0, 0.82, 0); end			-- �A�Oֵ��(0, 0, 0)

-- �΄�Ŀ��
	if (CanSetFont(QuestFontNormalSmall)) then			QuestFontNormalSmall:SetFont(CLEAR_FONT, 13 * CF_SCALE); end	-- �A�Oֵ��14
	if (CanSetFont(QuestFontNormalSmall)) then			QuestFontNormalSmall:SetShadowColor(0.3, 0.18, 0); end	-- �A�Oֵ��(0.3, 0.18, 0)

-- �΄ո���
	if (CanSetFont(QuestFontHighlight)) then 			QuestFontHighlight:SetFont(CLEAR_FONT_QUEST, 13 * CF_SCALE); end	-- �A�Oֵ��13


-- -----------------------------------------------------------------------------
-- ��Ʒ��Ϣ: ��Щ"�����I��x"����Ʒ���΄���Ʒ�ă������w��������Ԕy���ĕ������ż��ĸ����ȣ�
-- -----------------------------------------------------------------------------

	if (CanSetFont(ItemTextFontNormal)) then 	 	  	ItemTextFontNormal:SetFont(CLEAR_FONT_QUEST, 15 * CF_SCALE); end		-- �A�Oֵ��15
	if (CanSetFont(ItemTextFontNormal)) then			ItemTextFontNormal:SetShadowColor(1, 1, 1); end	-- �A�Oֵ��(0.18, 0.12, 0.06)


-- -----------------------------------------------------------------------------
-- �]��
-- -----------------------------------------------------------------------------

	if (CanSetFont(MailTextFontNormal)) then 	 	  	MailTextFontNormal:SetFont(CLEAR_FONT_QUEST, 15 * CF_SCALE); end	-- �A�Oֵ��15
	if (CanSetFont(MailTextFontNormal)) then 		   	MailTextFontNormal:SetTextColor(1, 1, 1); end		-- �A�Oֵ��(0.18, 0.12, 0.06)
--	if (CanSetFont(MailTextFontNormal)) then 	 	  	MailTextFontNormal:SetShadowColor(0.54, 0.4, 0.1); end
--	if (CanSetFont(MailTextFontNormal)) then 	 	  	MailTextFontNormal:SetShadowOffset(1, -1); end
   
   
-- -----------------------------------------------------------------------------
-- ���ܣ�������ͣ����ӡ��N�����L�ȣ������ܵȼ�
-- -----------------------------------------------------------------------------

	if (CanSetFont(SubSpellFont)) then					SubSpellFont:SetFont(CLEAR_FONT_QUEST, 12 * CF_SCALE); end	-- �A�Oֵ��12
	if (CanSetFont(SubSpellFont)) then 	   			SubSpellFont:SetTextColor(0.35, 0.2, 0); end	-- �A�Oֵ��(0.35, 0.2, 0)


-- -----------------------------------------------------------------------------
-- ��Ԓ���K���o��"ͬ��"���֘�
-- -----------------------------------------------------------------------------

	if (CanSetFont(DialogButtonNormalText)) then 		DialogButtonNormalText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end	-- �A�Oֵ��13
	if (CanSetFont(DialogButtonHighlightText)) then 	DialogButtonHighlightText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- �^���ГQ�@ʾ����ΞĻ����֪ͨ
-- -----------------------------------------------------------------------------

-- ��^����׃�����Q
	if (CanSetFont(ZoneTextFont)) then 	   			ZoneTextFont:SetFont(CLEAR_FONT, 32 * CF_SCALE, "THICKOUTLINE"); end		-- �A�Oֵ��112
	if (CanSetFont(ZoneTextFont)) then 	   			ZoneTextFont:SetShadowColor(1.0, 0.9294, 0.7607); end	-- �A�Oֵ��(1.0, 0.9294, 0.7607)
	if (CanSetFont(ZoneTextFont)) then 	   			ZoneTextFont:SetShadowOffset(1, -1); end

-- �΅^����׃�����Q
	if (CanSetFont(SubZoneTextFont)) then				SubZoneTextFont:SetFont(CLEAR_FONT, 26 * CF_SCALE, "THICKOUTLINE"); end		-- �A�Oֵ��26


-- -----------------------------------------------------------------------------
-- PvP��Ϣ���硰���Z�е��I�����������I�ء���
-- -----------------------------------------------------------------------------

	if (CanSetFont(PVPInfoTextFont)) then				PVPInfoTextFont:SetFont(CLEAR_FONT, 20 * CF_SCALE, "THICKOUTLINE"); end		-- �A�Oֵ��22


-- -----------------------------------------------------------------------------
-- �e�`���w��"��һ�����������M����"���֘�
-- -----------------------------------------------------------------------------

	if (CanSetFont(ErrorFont)) then					ErrorFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��17
	if (CanSetFont(ErrorFont)) then					ErrorFont:SetShadowOffset(1, -1); end	-- �A�Oֵ��(1, -1)


-- -----------------------------------------------------------------------------
-- ��B�ڣ��^�����еĔ��֣�����ֵ������ֵ/ŭ��ֵ/����ֵ�ȣ������l����򞡢���ȣ�
-- -----------------------------------------------------------------------------

	if (CanSetFont(TextStatusBarText)) then			TextStatusBarText:SetFont(CLEAR_FONT_EXP, 12 * CF_SCALE, "OUTLINE"); end	-- �A�Oֵ��12
	if (CanSetFont(TextStatusBarTextLarge)) then		TextStatusBarTextLarge:SetFont(CLEAR_FONT_EXP, 14 * CF_SCALE, "OUTLINE"); end	-- �A�Oֵ��15
	

-- -----------------------------------------------------------------------------
-- ���Y�o�����
-- -----------------------------------------------------------------------------

	if (CanSetFont(CombatLogFont)) then				CombatLogFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- �A�Oֵ��16


-- -----------------------------------------------------------------------------
-- ��ʾ��ToolTip��
-- -----------------------------------------------------------------------------

-- ��ʾ������
	if (CanSetFont(GameTooltipText)) then				GameTooltipText:SetFont(CLEAR_FONT_ITEM, 13 * CF_SCALE); end		-- �A�Oֵ��13
   
-- �b����^��С�ֲ���
	if (CanSetFont(GameTooltipTextSmall)) then			GameTooltipTextSmall:SetFont(CLEAR_FONT_ITEM, 12 * CF_SCALE); end	-- �A�Oֵ��12
   
-- ��ʾ����}
	if (CanSetFont(GameTooltipHeaderText)) then		GameTooltipHeaderText:SetFont(CLEAR_FONT, 15 * CF_SCALE, "OUTLINE"); end	-- �A�Oֵ��16


-- -----------------------------------------------------------------------------
-- ����؈D��λ�Ø��}
-- -----------------------------------------------------------------------------

	if (CanSetFont(WorldMapTextFont)) then				WorldMapTextFont:SetFont(CLEAR_FONT, 102 * CF_SCALE, "THICKOUTLINE"); end	-- �A�Oֵ��102
	if (CanSetFont(WorldMapTextFont)) then				WorldMapTextFont:SetShadowColor(1.0, 0.9294, 0.7607); end	-- �A�Oֵ��(1.0, 0.9294, 0.7607)
	--if (CanSetFont(WorldMapTextFont)) then				WorldMapTextFont:SetShadowOffset(1, -1); end
--	if (CanSetFont(WorldMapTextFont)) then				WorldMapTextFont:SetAlpha(0.4); end


-- -----------------------------------------------------------------------------
-- �l؛�Σ����u���]�ā�İl؛��
-- -----------------------------------------------------------------------------

	if (CanSetFont(InvoiceTextFontNormal)) then 	   	InvoiceTextFontNormal:SetFont(CLEAR_FONT_QUEST, 13 * CF_SCALE); end	-- �A�Oֵ��12
	if (CanSetFont(InvoiceTextFontNormal)) then 	   	InvoiceTextFontNormal:SetTextColor(0.18, 0.12, 0.06); end	-- �A�Oֵ��(0.18, 0.12, 0.06)

	if (CanSetFont(InvoiceTextFontSmall)) then			InvoiceTextFontSmall:SetFont(CLEAR_FONT_QUEST, 11 * CF_SCALE); end	-- �A�Oֵ��10
	if (CanSetFont(InvoiceTextFontSmall)) then			InvoiceTextFontSmall:SetTextColor(0.18, 0.12, 0.06); end	-- �A�Oֵ��(0.18, 0.12, 0.06)


-- -----------------------------------------------------------------------------
-- ���Y����: ��ѩ���Ñ��Yָʾ��
-- -----------------------------------------------------------------------------

	if (CanSetFont(CombatTextFont)) then				CombatTextFont:SetFont(CLEAR_FONT_DAMAGE, 25 * CF_SCALE); end		-- �A�Oֵ��25


-- -----------------------------------------------------------------------------
-- ӰƬ��Ļ���֣�New in WotLK/3.x��
-- -----------------------------------------------------------------------------

	if (CanSetFont(MovieSubtitleFont)) then			MovieSubtitleFont:SetFont(CLEAR_FONT, 25 * CF_SCALE); end		-- �A�Oֵ��25
	if (CanSetFont(MovieSubtitleFont)) then			MovieSubtitleFont:SetTextColor(1.0, 0.78, 0); end	-- �A�Oֵ��(1.0, 0.78, 0)


-- -----------------------------------------------------------------------------
-- �ɾ�ϵ�y��New in WotLK/3.x��
-- -----------------------------------------------------------------------------

-- �ɾ�ϵ�y��������ϵĳɾͷ֔�
	if (CanSetFont(AchievementPointsFont)) then		AchievementPointsFont:SetFont(CLEAR_FONT, 13 * CF_SCALE); end		-- �A�Oֵ��13

-- �ɾ�ϵ�y���R���ĳɾͷ֔�
	if (CanSetFont(AchievementPointsFontSmall)) then	AchievementPointsFontSmall:SetFont(CLEAR_FONT, 13 * CF_SCALE); end		-- �A�Oֵ��13

-- �ɾ�ϵ�y�����ă���
	if (CanSetFont(AchievementDescriptionFont)) then	AchievementDescriptionFont:SetFont(CLEAR_FONT, 13 * CF_SCALE); end		-- �A�Oֵ��13

-- �ɾ�ϵ�y�����ĸ����}
	if (CanSetFont(AchievementCriteriaFont)) then		AchievementCriteriaFont:SetFont(CLEAR_FONT, 13 * CF_SCALE); end		-- �A�Oֵ��13
   
-- �ɾ�ϵ�yӛ䛵�����
	if (CanSetFont(AchievementDateFont)) then			AchievementDateFont:SetFont(CLEAR_FONT, 11 * CF_SCALE); end		-- �A�Oֵ��13

-- -----------------------------------------------------------------------------
-- ���T�ˡ�܇�vϵ�y���P�����_�J��New in WotLK/3.2+��
-- -----------------------------------------------------------------------------

	if (CanSetFont(VehicleMenuBarStatusBarText)) then		VehicleMenuBarStatusBarText:SetFont(CLEAR_FONT, 15 * CF_SCALE); end		-- �A�Oֵ��15
	if (CanSetFont(VehicleMenuBarStatusBarText)) then		VehicleMenuBarStatusBarText:SetTextColor(1.0, 1.0, 1.0); end	-- �A�Oֵ��(1.0, 1.0, 1.0)

-- -----------------------------------------------------------------------------
-- ���c������w�����_�J��New in CTM/4.0+��
-- -----------------------------------------------------------------------------

	if (CanSetFont(FocusFontSmall)) then				FocusFontSmall:SetFont(CLEAR_FONT, 15 * CF_SCALE); end		-- �A�Oֵ��16
end


function Module:WorldStateAlwaysUpFrame_Update()   
   for i = 1, NUM_ALWAYS_UP_UI_FRAMES do   
      _G["AlwaysUpFrame"..i.."Text"]:SetFont(DB.Font, DB.FontSize, "THINOUTLINE")
   end
end
function Module:OnInitialize()
	CF_SCALE = SunUIConfig.db.profile.MiniDB.FontScale
	self:RegisterEvent("ADDON_LOADED", ApplySystemFonts);
	self:SecureHook("WorldStateAlwaysUpFrame_Update", "WorldStateAlwaysUpFrame_Update")
end