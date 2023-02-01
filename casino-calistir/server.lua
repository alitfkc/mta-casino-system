addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),function()
	a = 150
	for _,v in ipairs(getResources())do
		local name = getResourceName(v)
		if string.find(name,"meta-",1,true)then
			local script = v
			setTimer(function(script)
				startResource(script)
			end,a,1,script)
			a = a + 1000
		end
	end
end)

addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),function()
	for _,v in ipairs(getResources())do
		local name = getResourceName(v)
		if string.find(name,"meta-",1,true)then
			stopResource(v)
		end
	end
end)



