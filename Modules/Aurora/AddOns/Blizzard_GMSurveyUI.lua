local S, L, DB, _, C = unpack(select(2, ...))
local r, g, b = DB.MyClassColor.r, DB.MyClassColor.g, DB.MyClassColor.b
local AuroraConfig = DB.AuroraConfig
local F = S
local C = DB
DB.AuroraModules["Blizzard_GMSurveyUI"] = function()
		F.SetBD(GMSurveyFrame, 0, 0, -32, 4)
		F.CreateBD(GMSurveyCommentFrame, .25)
		for i = 1, 11 do
			F.CreateBD(_G["GMSurveyQuestion"..i], .25)
			for j = 0, 5 do
				F.ReskinRadio(_G["GMSurveyQuestion"..i.."RadioButton"..j])
			end
		end

		for i = 1, 12 do
			select(i, GMSurveyFrame:GetRegions()):Hide()
		end
		GMSurveyHeaderLeft:Hide()
		GMSurveyHeaderRight:Hide()
		GMSurveyHeaderCenter:Hide()
		GMSurveyScrollFrameTop:SetAlpha(0)
		GMSurveyScrollFrameMiddle:SetAlpha(0)
		GMSurveyScrollFrameBottom:SetAlpha(0)
		F.Reskin(GMSurveySubmitButton)
		F.Reskin(GMSurveyCancelButton)
		F.ReskinClose(GMSurveyCloseButton, "TOPRIGHT", GMSurveyFrame, "TOPRIGHT", -36, -4)
		F.ReskinScroll(GMSurveyScrollFrameScrollBar)
end