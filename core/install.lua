local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local hooked = false

local function ShowFinish(text, subtext)
    local levelUpTexCoords = {
        gLine = { 0.00195313, 0.81835938, 0.00195313, 0.01562500 },
        tint = {1, 0.996, 0.745},
        gLineDelay = 0,
    }

    local script = LevelUpDisplay:GetScript("OnShow")
    LevelUpDisplay.type = LEVEL_UP_TYPE_SCENARIO
    LevelUpDisplay:SetScript("OnShow", nil)
    LevelUpDisplay:Show()

    LevelUpDisplay.scenarioFrame.level:SetText(text)
    LevelUpDisplay.scenarioFrame.name:SetText(subtext)
    LevelUpDisplay.scenarioFrame.description:SetText("")
    LevelUpDisplay:SetPoint("TOP", 0, -250)

    LevelUpDisplay.gLine:SetTexCoord(unpack(levelUpTexCoords.gLine))
    LevelUpDisplay.gLine2:SetTexCoord(unpack(levelUpTexCoords.gLine))
    LevelUpDisplay.gLine:SetVertexColor(unpack(levelUpTexCoords.tint))
    LevelUpDisplay.gLine2:SetVertexColor(unpack(levelUpTexCoords.tint))
    LevelUpDisplay.levelFrame.levelText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
    LevelUpDisplay.gLine.grow.anim1:SetStartDelay(levelUpTexCoords.gLineDelay)
    LevelUpDisplay.gLine2.grow.anim1:SetStartDelay(levelUpTexCoords.gLineDelay)
    LevelUpDisplay.blackBg.grow.anim1:SetStartDelay(levelUpTexCoords.gLineDelay)

    LevelUpDisplay.scenarioFrame.newStage:Play()
    PlaySoundKitID(31749)

    LevelUpDisplay:SetScript("OnShow", script)

	--if not hooked then
		--hooksecurefunc("LevelUpDisplay_BuildPetBattleWinnerList", function(self)
			--if self.hooked then
				--self.winnerSoundKitID = 31749
				--self.hooked=nil
			--end
		--end)
		--hooked = true
	--end
	--LevelUpDisplay.hooked=true
	--LevelUpDisplay.type=TOAST_PET_BATTLE_WINNER
	--LevelUpDisplay:Show()
	--LevelUpDisplay.levelFrame.singleline:SetText(text)
end
--设置布局
function S:SetLayout(layout)
	S.db.layout = layout
	if layout == "healer" then
		S:ResetMovers()
		S.db.movers = {}
		--[[S.db.movers.RayUF_playerMover = "BOTTOMRIGHTUIParentBOTTOM-190390"
		S.db.movers.RayUF_targetMover = "BOTTOMLEFTUIParentBOTTOM190390"
		S.db.movers.RayUF_petMover = "TOPLEFTRayUF_playerMoverBOTTOMLEFT0-60"
		S.db.movers.RayUFRaid15_1Mover = "BOTTOMUIParentBOTTOM0180"
		S.db.movers.RayUFRaid15_2Mover = "BOTTOMRayUFRaid15_1MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid15_3Mover = "BOTTOMRayUFRaid15_2MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid25_1Mover = "BOTTOMUIParentBOTTOM0150"
		S.db.movers.RayUFRaid25_2Mover = "BOTTOMRayUFRaid25_1MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid25_3Mover = "BOTTOMRayUFRaid25_2MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid25_4Mover = "BOTTOMRayUFRaid25_3MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid25_5Mover = "BOTTOMRayUFRaid25_4MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid40_6Mover = "BOTTOMRayUFRaid25_5MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid40_7Mover = "BOTTOMRayUFRaid40_6MoverTOP0"..S.db.Raid.spacing
		S.db.movers.RayUFRaid40_8Mover = "BOTTOMRayUFRaid40_7MoverTOP0"..S.db.Raid.spacing
		S.db.movers.PlayerCastBarMover = "BOTTOMUIParentBOTTOM0130"
		S.db.movers.VengeanceBarMover = "BOTTOMUIParentBOTTOM0140"
		S.db.movers.ActionBar1Mover = "BOTTOMUIParentBOTTOM"..(-3*S.db.ActionBar.buttonsize-3*S.db.ActionBar.buttonspacing).."50"
		S.db.movers.ActionBar5Mover = "TOPRIGHTActionBar4MoverTOPLEFT"..-S.db.ActionBar.buttonspacing.."0"
		S.db.movers.PetBarMover = "BOTTOMLEFTActionBar2MoverBOTTOMRIGHT"..S.db.ActionBar.buttonspacing.."0"
		S.db.movers.AltPowerBarMover = "BOTTOMRIGHTUIParentBOTTOMRIGHT-36085"
		S.db.Raid.horizontal = true
		S.db.Raid.growth = "UP"
		--]]
		
	elseif layout == "dps" then
		S:ResetMovers()
		S.db.movers = {}
		--[[
		S.db.movers.ArenaHeaderMover = "TOPLEFTUIParentBOTTOM450460"
		S.db.movers.BossHeaderMover = "TOPLEFTUIParentBOTTOM450460"
		S.db.movers.RayUF_focusMover = "BOTTOMRIGHTRayUF_playerTOPLEFT-2050"
		S.db.movers.RayUFRaid15_1Mover = "BOTTOMLEFTUIParentBOTTOMLEFT15235"
		S.db.movers.RayUFRaid25_1Mover = "BOTTOMLEFTUIParentBOTTOMLEFT15235"
		S.db.movers.RayUFRaid40_6Mover = "BOTTOMLEFTRayUFRaid25_1MoverTOPLEFT0"..S.db.Raid.spacing
		S.db.movers.ActionBar5Mover = "TOPRIGHTActionBar4MoverTOPLEFT"..-S.db.ActionBar.buttonspacing.."0"
		S.db.Raid.horizontal = false
		S.db.Raid.growth = "RIGHT"
		--]]
	elseif layout == "default" then
		S:ResetMovers()
		S.db.Raid.horizontal = false
		S.db.Raid.growth = "RIGHT"
	end
	StaticPopup_Show("CFG_RELOAD")
	S:SetMoversPositions()
    --for i = 1, 5 do
        --S:GetModule("ActionBar"):UpdatePositionAndSize("bar"..i)
    --end
end

function S:ChooseLayout()
	if not SunUILayoutChooser then
		local A = S:GetModule("Skins")
		local f = CreateFrame("Frame", "SunUILayoutChooser", UIParent)
		f:SetFrameStrata("TOOLTIP")
		f:Size(500, 250)
		f:Point("CENTER")
		A:SetBD(f)

		f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
		f.CloseButton:SetScript("OnClick", function()
			S.db.layoutchosen = true
			f:Hide()
		end)
		A:ReskinClose(f.CloseButton)

		f.Title = f:CreateFontString(nil, "OVERLAY")
		f.Title:FontTemplate(nil, 17, nil)
		f.Title:Point("TOP", 0, -15)
		f.Title:SetText(L["布局选择"])

		f.Desc = f:CreateFontString(nil, "OVERLAY")
		f.Desc:FontTemplate()
		f.Desc:Point("TOPLEFT", 20, -80)
		f.Desc:Width(f:GetWidth() - 40)
		f.Desc:SetText(L["请选择一个布局开始使用"])

		f.Option1 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
		f.Option1:Size(120, 30)
		f.Option1:Point("BOTTOM", 0, 30)
		f.Option1:SetText(L["默认"])
		f.Option1:SetScript("OnClick", function(self)
			S.db.layoutchosen = true
			S:SetLayout("default")
			ShowFinish(L["设置完成"], self:GetText())
			f:Hide()
		end)
		A:Reskin(f.Option1)

		f.Option2 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
		f.Option2:StripTextures()
		f.Option2:Size(120, 30)
		f.Option2:Point("RIGHT", f.Option1, "LEFT", -30, 0)
		f.Option2:SetText(L["伤害输出"])
		f.Option2:SetScript("OnClick", function(self)
			S.db.layoutchosen = true
			S:SetLayout("dps")
			ShowFinish(L["设置完成"], self:GetText())
			f:Hide()
		end)
		A:Reskin(f.Option2)

		f.Option3 = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
		f.Option3:StripTextures()
		f.Option3:Size(120, 30)
		f.Option3:Point("LEFT", f.Option1, "RIGHT", 30, 0)
		f.Option3:SetText(L["治疗"])
		f.Option3:SetScript("OnClick", function(self)
			S.db.layoutchosen = true
			S:SetLayout("healer")
			ShowFinish(L["设置完成"], self:GetText())
			f:Hide()
		end)
		A:Reskin(f.Option3)
	end
	SunUILayoutChooser:Show()
end
