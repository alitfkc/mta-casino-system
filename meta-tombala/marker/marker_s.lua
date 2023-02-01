tombala_players = {}

local bigmarker = createMarker(bigmarkerx,bigmarkery,bigmarkerz,"cylinder",15,0,0,0,0)
setElementDimension(bigmarker,bigmarkerdim)
setElementInterior(bigmarker,bigmarkerinterior)

--marker enter


function bigmarker_join(hit)
    tombala_players[hit] = {hit,false} 
    local result = 0
    if start_timestamp  then 
        result = 20000 -(getTickCount() - start_timestamp)
    end
    triggerClientEvent("load_marker_players_tombala",hit,tombala_players,play_ped,result)
end
addEventHandler("onMarkerHit",bigmarker,bigmarker_join)



--marker leave 
function bigmarker_leave(hit)
    tombala_players[hit] = nil
    triggerClientEvent("close_tombala_marker_players",hit)
    local result = 0
    if start_timestamp  then 
        result = 20000 -(getTickCount() - start_timestamp)
    end
    for k,v in pairs(tombala_players) do 
        triggerClientEvent("refresh_marker_players_tombala",v[1],tombala_players,play_ped,result)
    end
end
addEventHandler("onMarkerLeave",bigmarker,bigmarker_leave)


