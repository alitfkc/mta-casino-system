local rName = getResourceName ( getThisResource ( ) )
function sendServerMessage ( msg,tur,who )
	if ( msg and who ) then
		if ( isElement ( who ) ) then
			triggerClientEvent ("ust_yazi",who,msg,tur )
			return true
		else return false end
	else return false end
end