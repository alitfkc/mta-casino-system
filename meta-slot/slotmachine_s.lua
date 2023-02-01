local function takeStake(stake)
	if source ~= client then
		outputDebugString("Possible cheater in casino", 2)
	end
	local coin = getElementData(client,"meta_cip")
	local sonuc = coin - stake
	setElementData(client,"meta_cip",sonuc)
	setPedAnimation(client,"CASINO","Slot_bet_02",-1,false, false, false) 
end

local function givePrize(prize)
	if source ~= client then
		outputDebugString("Possible cheater in casino", 2)
	end
	local coin = getElementData(client,"meta_cip")
	local sonuc = coin + prize
	exports["meta-vipbonus"]:bonus_ver_server(client,prize)
	setElementData(client,"meta_cip",sonuc)
	setPedAnimation(client,"CASINO","Slot_win_out",300,false, false, false) 
end
local function kaybetme_anim()
	if source ~= client then
		outputDebugString("Possible cheater in casino", 2)
	end
	setPedAnimation(client,"CASINO","Slot_lose_out",300,false, false, false) 
end

addEvent("casinoTakePlayerMoney", true)
addEvent("casinoGivePlayerMoney", true)
addEvent("kaybetme_anim",true)
addEventHandler("kaybetme_anim",root,kaybetme_anim)
addEventHandler("casinoTakePlayerMoney", root, takeStake)
addEventHandler("casinoGivePlayerMoney", root, givePrize)

