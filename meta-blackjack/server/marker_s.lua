markerler = {
    --{marker_isim,x,y,z,scale,dimens,interior,durum,oyuncu_card_data,rz,cx,cy,lcx,lcy,oyun_baslama_durum,timer_durum,timer_sure,kamera_aci}
    {"masa_arka_sol_1",1958.73840, 1015.64868, 992.46875,0.5,0,10,false,nil,270,1959.76648, 1015.62183, 995.59357,1959.76648, 1015.62183, 992.59357,270,false,false,0,-90},
    {"masa_arka_sol_1_2",1958.99939, 1016.96521, 992.46875,0.5,0,10,false,nil,230,1959.76648, 1015.62183, 995.59357,1959.76648, 1015.62183, 992.59357,270,false,false,0,0},
    {"masa_arka_orta_1",1958.72534, 1020.30743, 992.46875,0.5,0,10,false,nil,270,1959.72217, 1020.08160, 995.59357,1959.72217, 1020.08160, 992.59357,270,false,false,0,-90},
    {"masa_arka_orta_1_2",1958.72534, 1020.30743, 992.46875,0.5,0,10,false,nil,280,1959.72217, 1020.08160, 995.59357,1959.72217, 1020.08160, 992.59357,270,false,false,0,0},
    {"masa_on_sol_1",1963.97339, 1015.60150, 992.46875,0.5,0,10,false,nil,90,1963.76648, 1015.62183, 995.59357,1962.76648, 1015.62183, 992.59357,270,false,false,0,0},
    {"masa_on_sol_1_2",1963.97339, 1015.60150, 992.46875,0.5,0,10,false,nil,230,1959.76648, 1015.62183, 995.59357,1959.76648, 1015.62183, 992.59357,270,false,false,0,0},
    {"masa_on_orta_1",1963.97461, 1020.21985, 992.46875,0.5,0,10,false,nil,90,1963.72217, 1020.08160, 995.59357,1962.72217, 1020.08160, 992.59357,270,false,false,0,0},
    {"masa_on_orta_1_2",1958.72534, 1020.30743, 992.46875,0.5,0,10,false,nil,280,1959.72217, 1020.08160, 995.59357,1959.72217, 1020.08160, 992.59357,270,false,false,0,0},
}

markers = {}
pedler_tablo = {
    --{skin_id,x,y,z,rz,dimension,interior}
    {189,1960.74133, 1015.66376, 992.46875,90,0,10},
    {189,1960.74963, 1020.16168, 992.46875,90,0,10},
    {189,1961.96118, 1020.29474, 992.46875,270,0,10},
    {189,1961.97009, 1015.69513, 992.46875,270,0,10}
} 
function anim_ekle(ped) 
    if (getElementModel(ped)==189) then 
        setPedAnimation(ped,"FOOD", "SHP_Tray_Lift_Loop", -1,true, false, false )
    end
end
function sistem_calisma()
    setTimer(function()
        for k,v in ipairs(markerler) do 
            if t_c_kontrol(k) == "tek" then
                markers[k] = createMarker(markerler[k][2],markerler[k][3],markerler[k][4],"cylinder",markerler[k][5],255,0,0,255,root)
                setElementDimension(markers[k],markerler[k][6])
                setElementInterior(markers[k],markerler[k][7])
                setElementData(markers[k],"marker_isim",markerler[k][1])
                addEventHandler("onMarkerHit",markers[k], markergiris)
                addEventHandler("onMarkerLeave",markers[k], markercikis)
            end
        end
    end,6000,1)
    setTimer(function()
        for k,v in ipairs(pedler_tablo) do
            ped=createPed(pedler_tablo[k][1],pedler_tablo[k][2],pedler_tablo[k][3],pedler_tablo[k][4],pedler_tablo[k][5])
            setElementDimension(ped,pedler_tablo[k][6])
            setElementInterior(ped,pedler_tablo[k][7])
            setElementFrozen(ped,true)
            setElementData(ped,"ped_olumsuzluk_meta",true)
            setTimer(anim_ekle,1000,1,ped)
        end
    end,7000,1)
end
function markergiris(oyuncu)
    if getElementType(oyuncu) ~= "player" then return end
    if getElementInterior(oyuncu) ~= 10 then return  end
    local basilan_marker = getElementData(source,"marker_isim")
    for k,v  in ipairs(markerler) do
        if basilan_marker == markerler[k][1] then
            if markerler[k][8] then 
                exports["meta-info"]:sendServerMessage("Burası şuan dolu!","error",oyuncu)
                sistemden_ayril(oyuncu)
                setElementData(oyuncu,"engel_bj",true)
                break
            end
            markerler[k][8] = true
            markerler[k][9] = oyuncu  
            if markerler[k][19] then 
                local suan = getTickCount()
                local sonuc = suan - markerler[k][20]
                triggerClientEvent("sure_baslat_bj_y",oyuncu,sonuc)
            end

            setElementRotation(oyuncu,0,0,markerler[k][10])
            triggerClientEvent("panel_ac_blackjack",oyuncu,true)
            setPedAnimation(oyuncu,"FOOD", "SHP_Tray_Lift_Loop", -1,true, false, false )
            setElementData(oyuncu,"oyuncu_bj_marker",source)
            setCameraMatrix(oyuncu,markerler[k][11],markerler[k][12],markerler[k][13],markerler[k][14],markerler[k][15],markerler[k][16],markerler[k][21])
            break
        end
    end
end
function markercikis(oyuncu)
    if getElementType(oyuncu) ~= "player" then return end
    if getElementData(oyuncu,"meta_bj_kp") then removeElementData(oyuncu,"meta_bj_kp") end
    if getElementData(oyuncu,"yeni_kartlar_bj") then removeElementData(oyuncu,"yeni_kartlar_bj") end
    if getElementData(oyuncu,"kurpiyer_kartlar_bj") then removeElementData(oyuncu,"kurpiyer_kartlar_bj") end
    if getElementData(oyuncu,"kurpiyer_puan") then removeElementData(oyuncu,"kurpiyer_puan") end
    if getElementData(oyuncu,"engel_bj") then 
        setElementData(oyuncu,"engel_bj",false)
    else
        local basilan_marker = getElementData(source,"marker_isim")
        for k,v  in ipairs(markerler) do
            if basilan_marker == markerler[k][1] then
                markerler[k][8] = false
                markerler[k][9] = nil
                triggerClientEvent("panel_ac_blackjack",oyuncu,false)
                setCameraTarget(oyuncu,oyuncu)
                removeElementData(oyuncu,"oyuncu_bj_marker")
                triggerClientEvent("kapat",oyuncu)
                break
            end
        end
    end
end
function sistemden_ayril(oyuncu)
    local _,_a,aci = getElementRotation(oyuncu)
    if aci >= 0 and aci <=180 then 
        aci = 315
    else
        aci = 180
    end
    setElementRotation(oyuncu,0,0,aci)
    setPedAnimation(oyuncu,"ped","run_player",750)
    setTimer(function() setPedAnimation(oyuncu) end,750,1,oyuncu)
end
function oyundan_cikma()
    for k,v  in ipairs(markerler) do
        if markerler[k][9] == source then 
            markerler[k][8] = false
            markerler[k][9] = nil
        end
    end
end
addEvent("blackjack_ayril",true)
addEventHandler("blackjack_ayril",root,sistemden_ayril)
addEventHandler("onResourceStart",resourceRoot,sistem_calisma)

                                                                                                                            
addEventHandler("onPlayerQuit",root,oyundan_cikma)

