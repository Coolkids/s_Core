local S, _, _, _ = unpack(select(2, ...))
function S.CreateShadow(f) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(.05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end