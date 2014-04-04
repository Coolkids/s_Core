local S, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local A = S:GetModule("Skins")

local function LoadSkin()
	ChallengesFrameInset:DisableDrawLayer("BORDER")
	ChallengesFrameInsetBg:Hide()
	ChallengesFrameDetails.bg:Hide()
	select(2, ChallengesFrameDetails:GetRegions()):Hide()
	select(9, ChallengesFrameDetails:GetRegions()):Hide()
	select(10, ChallengesFrameDetails:GetRegions()):Hide()
	select(11, ChallengesFrameDetails:GetRegions()):Hide()
	ChallengesFrameLeaderboard:GetRegions():Hide()
	
	A:Reskin(ChallengesFrameLeaderboard)
	
	local bg = CreateFrame("Frame", nil, ChallengesFrameDetails)
	bg:SetPoint("TOPLEFT", 1, -73)
	bg:SetSize(332, 49)
	bg:SetFrameLevel(ChallengesFrameDetails:GetFrameLevel())
	A:CreateBD(bg, .25)
	
	ChallengesFrameDungeonButton1:SetPoint("TOPLEFT", ChallengesFrame, "TOPLEFT", 8, -83)
	
	for i = 1, 9 do
		local bu = ChallengesFrame["button"..i]
		A:CreateBD(bu, .25)
		bu:SetHighlightTexture("")
		bu.selectedTex:SetTexture(A["media"].backdrop)
		bu.selectedTex:SetAlpha(.2)
		bu.selectedTex:SetPoint("TOPLEFT", 1, -1)
		bu.selectedTex:SetPoint("BOTTOMRIGHT", -1, 1)
	end
	
	for i = 1, 3 do
		local rewardsRow = ChallengesFrame["RewardRow"..i]
		for j = 1, 2 do
			local bu = rewardsRow["Reward"..j]
			
			bu.Icon:SetTexCoord(.08, .92, .08, .92)
			A:CreateBG(bu.Icon)
		end
	end
end

A:RegisterSkin("Blizzard_ChallengesUI", LoadSkin)
