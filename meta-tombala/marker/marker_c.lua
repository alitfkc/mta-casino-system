tombala_players = {}
play_ped = false
number1 = 99999
number2 = 99999
number3 = 99999
number4 = 99999
number = ""
n_state = false
text_state = false
timer = false
local handler_status = false
local screenW,screenH=guiGetScreenSize()
function renderobjes()
    local cx, cy, cz = getCameraMatrix()
    for  k, v in pairs(tombala_players) do
         if v[2] then
            local x, y, z = getElementPosition( v[1])
            z=z+0.8
            if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v[1] ) then
                local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
                if dist <= 15 then
                    local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 );
                    if px then
                        if v[2][1] == number1 or v[2][1] == number2 or v[2][1] == number3  or v[2][1] == number4 then 
                            dxDrawText(v[2][1], (px + 1)-75, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][1], px-60, py + screenW/38, px, py, tocolor( 0, 255, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        else
                            dxDrawText(v[2][1], (px + 1)-75, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][1], px-75, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        end
                        if v[2][2] == number1 or v[2][2] == number2 or v[2][2] == number3  or v[2][2] == number4 then 
                            dxDrawText(v[2][2], (px + 1)-30, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][2], px-30, py + screenW/38, px, py, tocolor( 0, 255, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
    
                        else
                            dxDrawText(v[2][2], (px + 1)-30, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][2], px-30, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        end 

                        if v[2][3] == number1 or v[2][3] == number2 or v[2][3] == number3  or v[2][3] == number4 then 
                            dxDrawText(v[2][3], (px + 1)+30, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][3], px+30, py + screenW/38, px, py, tocolor( 0, 255, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );    
                        else
                            dxDrawText(v[2][3], (px + 1)+30, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][3], px+30, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        end
                        if v[2][4] == number1 or v[2][4] == number2 or v[2][4] == number3  or v[2][4] == number4 then 
                            dxDrawText(v[2][4], (px + 1)+75, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][4], px+75, py + screenW/38, px, py, tocolor( 0, 255, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        else
                            dxDrawText(v[2][4], (px + 1)+75, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            dxDrawText(v[2][4], px+75, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        end
                    end
                end
            end
        end
    end
    if play_ped then 
        local x, y, z = getElementPosition( play_ped);
        z=z+0.8
        if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, play_ped ) then
            local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
            if dist <= 18 then
                    local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 );
                    if px then
                        dxDrawText(ped_text, px + 1, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        dxDrawText(ped_text, px, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        if text_state then 
                            if n_state then 
                                dxDrawText("Gelen Sayı "..number, px + 1,(py + screenW/38)-150, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                                dxDrawText("Gelen Sayı "..number, px,(py + screenW/38)-150, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            else 
                                dxDrawText("Başlama Süresi "..number.." saniye", px + 1, (py + screenW/38)-50, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                                dxDrawText("Başlama Süresi "..number.." saniye", px, (py + screenW/38)-50, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                            end 
                        end
                    end
            end
        end
    end
end



------------------------------
--open close handler 
------------------------------
function open_close_handler()
    if handler_status then 
        removeEventHandler("onClientRender",root,renderobjes)
        handler_status = false
        if isTimer(timer) then 
            killTimer(timer)
            number = ""
            timer = false
            text_state = false
        end
    else
        addEventHandler("onClientRender",root,renderobjes)
        handler_status = true
    end
end


-------------------
-- open marker 
function load_tombala_players(t,ped,n)
    tombala_players = t
    play_ped = ped
    if n then     
        number = math.floor(n/1000) 
    end
    if type(number) == "number" and n_state == false and number >0 then 
        if not isTimer(timer ) then 
            text_state = true
            timer = setTimer(function ()
                number = number - 1
                if number <= 0 then 
                    killTimer(timer)
                    number = ""
                    timer = false 
                    text_state = false
                end
            end,1000,0)  
        end
    end
    open_close_handler()
end

addEvent("load_marker_players_tombala",true)
addEventHandler("load_marker_players_tombala",localPlayer,load_tombala_players)

-------------------
-- open marker 
function refresh_tombala_players(t,ped,n)
    tombala_players = t
    play_ped = ped
    if n then     
        number = math.floor(n/1000)
    end

    if type(number) == "number" and n_state == false and number >0 then 
        if not isTimer(timer ) then 
            text_state = true
            timer = setTimer(function ()
                number = number - 1
                if number <= 0 then 
                    killTimer(timer)
                    number = ""
                    timer = false 
                    text_state = false
                end
            end,1000,0)  
        end
    end
end

addEvent("refresh_marker_players_tombala",true)
addEventHandler("refresh_marker_players_tombala",localPlayer,refresh_tombala_players)


--------
--close markers
----
function close_tombala_players()
    tombala_players = {}
    number1 = 99999
    number2 = 99999
    number3 = 99999
    number4 = 99999
    number = ""
    n_state = false
    open_close_handler()
end

addEvent("close_tombala_marker_players",true)
addEventHandler("close_tombala_marker_players",localPlayer,close_tombala_players)



--------
--close markers
----
function close_tombala_players(t)
    tombala_players = t
    number1 = 99999
    number2 = 99999
    number3 = 99999
    number4 = 99999
    number = ""
    n_state = false
    text_state = false
end

addEvent("finish_marker_players_tombala",true)
addEventHandler("finish_marker_players_tombala",localPlayer,close_tombala_players)



-----------------------
--panel open 
marker = createMarker(playmarkerx,playmarkery,playmarkerz,"cylinder",playmarkerscale,255,0,0)
setElementDimension(marker,playmarkerdim)
setElementInterior(marker,playmarkerinterior)

function marker_join(hit)
    if hit == localPlayer then 
        panel_open_close()
    end
end
addEventHandler("onClientMarkerHit",marker,marker_join)


function random_number(n) 
    number = n
    n_state = true
    text_state = true
    setTimer(function()
        text_state = false
    end,3000,1)
    if number1 > 100 then
        number1 = number
    elseif  number2 > 100 then
        number2 = number
    elseif  number3 > 100 then
        number3 = number
    elseif  number4 > 100 then
        number4 = number
    end
end
addEvent("random_tombala_number",true)
addEventHandler("random_tombala_number",localPlayer,random_number)