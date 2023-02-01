start_timestamp = false
game_status = false
numbers = {}
function set_player_bet_numbers(t,chip)
    if game_status then exports["meta-info"]:sendServerMessage("Oyun başladı.","error",source) return end
    setElementData(source,"meta_cip",chip)
    tombala_players[source] = {source,t}
    if not start_timestamp  then
        start_game_timer() 
    end
    local result = 0
    if start_timestamp  then 
        result = 20000 -(getTickCount() - start_timestamp)
    end
    for k,v in pairs(tombala_players) do 
        triggerClientEvent("refresh_marker_players_tombala",v[1],tombala_players,play_ped,result)
    end
end
addEvent("send_numbers_tombala",true) 
addEventHandler("send_numbers_tombala",root,set_player_bet_numbers)

----------------------------
function start_game_timer()
    start_timestamp = getTickCount()
    setTimer(start_game,20000,1)
end

function start_game() 
    game_status = true
    start_timestamp = false
    setTimer(function()
        local random = math.random(1,19)
        if numbers[tostring(random)] then 
            local state = false  
            while( not state) do 
                random = math.random(1,19) 
                if numbers[tostring(random)] then  
                else 
                    state = true
                end
            end
        end
        numbers[tostring(random)] = true
        for k,v in pairs(tombala_players) do 
            triggerClientEvent("random_tombala_number",v[1],random)
        end
    end,4000,4)
    setTimer(function()
        game_status = false
        start_timestamp = false
        for k,v in pairs(tombala_players) do 
            if v[2] then 
                local n1,n2,n3,n4 = unpack(v[2])
                local player_prediction = 0
                for k,v in pairs(numbers) do 
                    k = tonumber(k)
                    if n1 == k or n2 == k or n3 == k or n4 == k then 
                        player_prediction  = player_prediction  + 1
                    end
                end
                if player_prediction == 4 then 
                    local bet = getElementData(v[1],"bahis_tombala")
                    removeElementData(v[1],"bahis_tombala")
                    local result = bet *prize_4x
                    exports["meta-info"]:sendServerMessage(result.." Çip kazandınız.","success",v[1])
                    exports["meta-vipbonus"]:bonus_ver_server(v[1],result)
                    local player_chip = getElementData(v[1],"meta_cip")
                    setElementData(v[1],"meta_cip",player_chip + math.floor(result))
                elseif player_prediction  == 3 then 
                    local bet = getElementData(v[1],"bahis_tombala")
                    removeElementData(v[1],"bahis_tombala")
                    local result = bet *prize_3x
                    exports["meta-info"]:sendServerMessage(result.." Çip kazandınız.","success",v[1])
                    exports["meta-vipbonus"]:bonus_ver_server(v[1],result)
                    local player_chip = getElementData(v[1],"meta_cip")
                    setElementData(v[1],"meta_cip",player_chip + math.floor(result))
                elseif player_prediction  == 2 then 
                    local bet = getElementData(v[1],"bahis_tombala")
                    removeElementData(v[1],"bahis_tombala")
                    local result = bet *prize_2x
                    exports["meta-info"]:sendServerMessage(result.." Çip kazandınız.","success",v[1])
                    exports["meta-vipbonus"]:bonus_ver_server(v[1],result)
                    local player_chip = getElementData(v[1],"meta_cip")
                    setElementData(v[1],"meta_cip",player_chip + math.floor(result))
                elseif player_prediction  == 1 then 
                    local bet = getElementData(v[1],"bahis_tombala")
                    removeElementData(v[1],"bahis_tombala")
                    local result = bet
                    exports["meta-info"]:sendServerMessage(result.." Çip kazandınız.","success",v[1])
                    exports["meta-vipbonus"]:bonus_ver_server(v[1],result)
                    local player_chip = getElementData(v[1],"meta_cip")
                    setElementData(v[1],"meta_cip",player_chip + math.floor(result))
                end
                v[2] = false
            end
        end
        local result = 0
        if start_timestamp  then 
            result = 20000 -(getTickCount() - start_timestamp)
        end
        for k,v in pairs(tombala_players) do 
            triggerClientEvent("finish_marker_players_tombala",v[1],tombala_players)
        end
        numbers = {}
    end,18000,1)
end
