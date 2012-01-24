local S, C, L, DB = unpack(select(2, ...))
if DB.Traditionalize == nil then return end
if GetLocale() ~= "zhTW" then   
SlashCmdList.TRADITIONALIZE()
end