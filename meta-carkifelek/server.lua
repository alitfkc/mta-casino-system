kaldirilacak_objeler_tablo={14567,14568,14566}
carki_felekx,carki_feleky,carki_felekz=1954.79382, 994.92877, 993.25938
carki_felekrx,carki_felekry,carki_felekrz=90,90,130
markerx,markery,markerz=1955.61487, 996.49512, 991.85938
carki_felek_donme_durum=false
objeler={}
marker_player = nil
local marker_durum=false
local marker_oyuncu_sayisi=0
local kazanma_aci=0
local  carki_felek_aci=nil
oduller_tablo={
    {1,30,"20"},
    {31,60,"PAS"},
    {61,90,"10"},
    {91,120,"PAS"},
    {121,150,"1"},
    {151,180,"PAS"},
    {181,210,"60"},
    {211,240,"PAS"},
    {241,270,"8"},
    {271,300,"PAS"},
    {301,330,"PAS"},
    {331,360,"90"},
}
function sistem_startlanma()
    for k,v in ipairs(kaldirilacak_objeler_tablo) do 
        removeWorldModel(v,10000, 1958.02112, 1008.56561, 992.46875,-1)
    end
    objeler.carki_felek=createObject(1895,carki_felekx,carki_feleky,carki_felekz,carki_felekrx,carki_felekry,carki_felekrz)
    objeler.carki_felek_tutma_obje=createObject(2699,1955.38643, 994.18628, 993.25938,90,90,130)
    objeler.isaret_obje = createObject(1319,1954.69554, 994.98512, 994.48556,0,180,45)
    objeler.isaret_obje1 = createObject(1319,1954.811554, 994.8711512, 994.62556,90,180,45)
    objeler.isaret_obje2 = createObject(1319,1954.92554, 994.751512, 994.472556,0,180,45)
    setObjectScale(objeler.isaret_obje,0.3)
    setObjectScale(objeler.isaret_obje1,0.3)
    setObjectScale(objeler.isaret_obje2,0.3)
    objeler.marker_alt=createObject(2030,markerx,markery, 991.48)
    objeler.marker_isik=createObject(3385,markerx,markery, 991.50938)
    setObjectScale(objeler.carki_felek_tutma_obje,1.5)
    for k,v in pairs(objeler) do 
        setElementInterior(v,10)
    end
    marker=createMarker(markerx,markery,markerz,"cylinder",1.5,0,0,0,0)
    setElementInterior(marker,10)
    setElementData(marker, "yazi","carkifelek_marker")
    addEventHandler("onMarkerHit",marker, carkifelekmarkergiris)
    addEventHandler("onMarkerLeave",marker, carkifelekmarkercikis)

end
function carkifelekmarkergiris(oyuncu)
    if getElementInterior(oyuncu) ~= 10 then return end
    if getElementType(oyuncu) =="player" then 
        if not marker_durum and marker_oyuncu_sayisi<=1 then
            marker_durum=true
            marker_player = oyuncu
            marker_oyuncu_sayisi=marker_oyuncu_sayisi+1
            triggerClientEvent("panel_ac",oyuncu,true)
            setTimer(function()
                setElementPosition(oyuncu,1955.69141, 996.27484, 992.85938)
                setElementRotation(oyuncu,0,0,131.5)
                setPedWeaponSlot(oyuncu,0)
            end,150,1,oyuncu)
        else 
            setElementRotation(oyuncu,0,0,90)
            setPedAnimation(oyuncu,"ped","run_player",750)
            setTimer(function() setPedAnimation(oyuncu) end,750,1,oyuncu)
            marker_oyuncu_sayisi=marker_oyuncu_sayisi+1
            exports["meta-info"]:sendServerMessage("Çarkıfelek şuan oynanıyor, daha sonra tekrar deneyiniz.","warning",oyuncu)
        end
    end
end
function carkifelekmarkercikis(oyuncu)
    if getElementType(oyuncu) =="player" then 
        if marker_durum and marker_oyuncu_sayisi==1 then 
            marker_durum=false
            marker_player = nil
            marker_oyuncu_sayisi=marker_oyuncu_sayisi-1
            triggerClientEvent("panel_ac",oyuncu,false)
        else
            marker_oyuncu_sayisi=marker_oyuncu_sayisi-1
        end
    end
end
function sistemden_ayril()
    setElementRotation(source,0,0,90)
    setPedAnimation(source,"ped","run_player",750)
    local oyuncu=source
    setTimer(function() setPedAnimation(oyuncu) end,750,1,oyuncu)
end

function quit_or_death()
    if marker_durum then 
        if source == marker_player then 
            marker_durum=false
            marker_player = nil
            marker_oyuncu_sayisi=marker_oyuncu_sayisi-1
            triggerClientEvent("panel_ac",oyuncu,false)
        end
    end
end

addEventHandler("onPlayerWasted",root,quit_or_death)
function sistem_dondur()
    if not carki_felek_donme_durum then 
        kazanma_aci=math.random(0,360)
        setPedAnimation(source,"ped","walk_doorpartial",100,false)
        oyuncu_cip = getElementData(source,"meta_cip")
        local sonuc = oyuncu_cip - carkifelek_ucret_chip
        setElementData(source,"meta_cip",sonuc)
        moveObject( objeler.carki_felek,400,carki_felekx,carki_feleky,carki_felekz,360,0,0)
        setTimer(function ()
            moveObject( objeler.carki_felek,450,carki_felekx,carki_feleky,carki_felekz,360,0,0)
        end,450,9)
        moveObject( objeler.carki_felek,800,carki_felekx,carki_feleky,carki_felekz,360,0,0)
        setTimer(function ()
            moveObject( objeler.carki_felek,1000,carki_felekx,carki_feleky,carki_felekz,360,0,0)
            setTimer(function ()
                moveObject( objeler.carki_felek,1000,carki_felekx,carki_feleky,carki_felekz,360,0,0)
            end,1000,2)
        end,4650,1)
        setTimer(function ()
            moveObject( objeler.carki_felek,1050,carki_felekx,carki_feleky,carki_felekz,360,0,0)
            setTimer(function ()
                moveObject( objeler.carki_felek,1800,carki_felekx,carki_feleky,carki_felekz,kazanma_aci,0,0)
            end,1050,1)
        end,7650,1)
        local oy_1= source
        triggerClientEvent("carkifelek_ses_cal",root)
        carki_felek_donme_durum=true
        carki_felek_donme_bitis=setTimer(function ()  
            carki_felek_donme_durum=false 
            stopObject( objeler.carki_felek)
            carki_felek_aci=nil
            carki_felek_aci,y,z=getElementRotation( objeler.carki_felek)
            carki_felek_aci=math.floor(carki_felek_aci + 0.5)
            for k,v in ipairs(oduller_tablo) do
                if carki_felek_aci >= oduller_tablo[k][1] and carki_felek_aci <= oduller_tablo[k][2] then 
                    if oduller_tablo[k][3] == "PAS" then 
                        odul = "0"
                    else
                        odul = oduller_tablo[k][3]
                    end
                    local oyuncu_cip = getElementData(oy_1,"meta_cip")
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,tonumber(odul))
                    local sonuc = oyuncu_cip + tonumber(odul)
                    setElementData(oy_1,"meta_cip",sonuc)
                    break
                end 
             end  
        end,13500,1,oy_1)
    else
        exports["meta-info"]:sendServerMessage("Çarkıfelek şuan dönüyor.","error",source)
    end
end

addEventHandler("onResourceStart",resourceRoot,sistem_startlanma)
addEvent("carkifelekten_ayril",true)
addEventHandler("carkifelekten_ayril",root,sistemden_ayril)
addEvent("carkifelek_dondur",true)
addEventHandler("carkifelek_dondur",root,sistem_dondur)
