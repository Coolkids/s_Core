local function update()
	local buttons = QuestLogScrollFrame.buttons
	local numButtons = #buttons
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries, numQuests = GetNumQuestLogEntries()
	
	for i = 1, numButtons do
		local questIndex = i + scrollOffset
		local questLogTitle = buttons[i]
		if questIndex <= numEntries then
			local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex)
			if not isHeader then
				questLogTitle:SetText('[' .. level .. '] ' .. title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end

hooksecurefunc('QuestLog_Update', update)
QuestLogScrollFrameScrollBar:HookScript('OnValueChanged', update)
