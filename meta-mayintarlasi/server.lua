local function kaybetme_anim(anim)
	if source ~= client then
		outputDebugString("Possible cheater in casino", 2)
	end
	setPedAnimation(client,"CASINO",anim,300,false, false, false) 
end
addEvent("mayin_anim",true)
addEventHandler("mayin_anim",root,kaybetme_anim)

