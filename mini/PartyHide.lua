local i
for i = 1, 4 do
  local frame = getglobal("PartyMemberFrame"..i)
 frame:SetScript("OnShow", nil);
 frame:SetScript("OnEvent", nil);
 frame:Hide();
end

SLASH_PARTYHIDE1, SLASH_PARTYHIDE2 = '/partyhide', '/ph';
function SlashCmdList.PARTYHIDE(msg, editbox)
 print("PartyHide is active, to deactivate please disable the addon.");
end