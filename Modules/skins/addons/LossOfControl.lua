local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")
local function LoadSkin()
    local IconBackdrop = CreateFrame("Frame", nil, LossOfControlFrame)
    IconBackdrop:CreateShadow("Background")
    IconBackdrop:SetAllPoints(LossOfControlFrame.Icon)
    LossOfControlFrame.Icon:SetTexCoord(.08, .92, .08, .92)
	LossOfControlFrame:StripTextures()
    hooksecurefunc("LossOfControlFrame_SetUpDisplay", function(self, ...)   
        self.AbilityName:SetFont(S["media"].font, 20, "OUTLINE")
        self.TimeLeft.NumberText:SetFont(S["media"].font, 20, "OUTLINE")
        self.TimeLeft.SecondsText:SetFont(S["media"].font, 20, "OUTLINE")
    end)

    --Test
    --LossOfControlFrame_SetUpDisplay(LossOfControlFrame, true, 1, 408, "HeHe", select(3,GetSpellInfo(408)), time(), 6, 6, lockoutSchool, 1, 1)
end

A:RegisterSkin("SunUI", SkinGUI)