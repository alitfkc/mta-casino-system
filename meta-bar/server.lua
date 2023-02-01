map_objeler_tablo={
    --{obje_id,x,y,z,rx,ry,rz,interior,dimens,scale}

    --dış mekan süsleme
}
barwomen_durum=false

function sistem_calisma_s()
    satin_alma_marker=createMarker(1955.66694, 1018.02585, 991.56875,"cylinder",1,255,0,0,50,root)
    setElementInterior(satin_alma_marker,10)
    addEventHandler("onMarkerHit",satin_alma_marker, satin_alma_markergiris)
    addEventHandler("onMarkerLeave",satin_alma_marker, satin_alma_markercikis)

    for k,v in ipairs(map_objeler_tablo) do 
        obje=createObject(map_objeler_tablo[k][1],map_objeler_tablo[k][2],map_objeler_tablo[k][3],map_objeler_tablo[k][4],map_objeler_tablo[k][5],map_objeler_tablo[k][6],map_objeler_tablo[k][7])
        setElementInterior(obje,map_objeler_tablo[k][8])
        setElementDimension(obje,map_objeler_tablo[k][9])
        setObjectScale(obje,map_objeler_tablo[k][10])
    end
    barwomen=createPed(172,1953.78650, 1018.07526, 992.46875,270)
    setElementInterior(barwomen,10)
    setElementFrozen(barwomen,true)
    setElementData(barwomen,"ped_olumsuzluk_meta",true)
    setTimer(anim_ekle,1000,1,barwomen)
end
function satin_alma_markergiris(oyuncu)
    if not barwomen_durum then 
        if oyuncu then 
            setElementAlpha(satin_alma_marker,0)
            barwomen_durum=true
            setElementRotation(oyuncu,0,0,90)
            triggerClientEvent("bar_panel_ac",oyuncu,true)
            setElementPosition(oyuncu,1955.37915, 1017.99597, 992.50875)
            if getElementData(oyuncu,"oyuncu_meta_icki") then 
                unbindKey(oyuncu,icme_tus,"down","ic")
                unbindKey(oyuncu,birak_tus,"down","birak")
            end
        end
    else
        exports["meta-info"]:sendServerMessage("Bar şuan dolu biraz sonra tekrar deneyiniz.","warning",oyuncu)
    end
end
function satin_alma_markercikis(oyuncu)
    setElementAlpha(satin_alma_marker,50)
    barwomen_durum=false
    triggerClientEvent("bar_panel_ac",oyuncu,false)
    if getElementData(oyuncu,"oyuncu_meta_icki") then 
        bindKey(oyuncu,icme_tus,"down","ic")
        bindKey(oyuncu,birak_tus,"down","birak")
    end
    if isElement(icki) then 
        destroyElement(icki)
        icki=nil
        if isTimer(icki_masaya_koyma) then
            killTimer(icki_masaya_koyma)
            icki_masaya_koyma=nil
        end
    end
end
function anim_ekle(ped) 
    if (getElementModel(ped)==172) then 
        setPedAnimation(ped,"FOOD", "SHP_Tray_Lift_Loop", -1,true, false, false )
        setElementData(ped,"yazi","ped_barwomen")
    end
end
function bardan_ayrilma()
    setElementRotation(source,0,0,270)
    setPedAnimation(source,"ped","run_player",750)
    local oyuncu=source
    setTimer(function() setPedAnimation(oyuncu) end,750,1,oyuncu)
end
function ickiyi_goster(obje_id)
    if isElement(icki) then 
        destroyElement(icki)
        icki=nil
    end
    icki=createObject(obje_id,1953.78650, 1018.07526, 991.46875)
    setElementCollisionsEnabled(icki,false)
    setElementInterior(icki,10)
    setPedAnimation(barwomen,"BAR","Barserve_bottle",-1,false,false, false)
    for k,v in ipairs(icecekler_liste) do 
        if obje_id ==icecekler_liste[k][3]  then 
            exports.bone_attach:attachElementToBone(icki,barwomen,12,
                                                    icecekler_liste[k][5],
                                                    icecekler_liste[k][6],
                                                    icecekler_liste[k][7],
                                                    icecekler_liste[k][8],
                                                    icecekler_liste[k][9],
                                                    icecekler_liste[k][10])
        end
    end
    icki_masaya_koyma=setTimer(function (obje_id) 
        setPedAnimation(barwomen,"FOOD", "SHP_Tray_Lift_Loop" , -1,true, false, false )
        exports.bone_attach:detachElementFromBone(icki)
        for k,v in ipairs(obje_masa_konum) do 
            if obje_masa_konum[k][1] == obje_id then 
                setElementPosition(icki,obje_masa_konum[k][2],obje_masa_konum[k][3],obje_masa_konum[k][4])
                setElementRotation(icki,obje_masa_konum[k][5],obje_masa_konum[k][6],obje_masa_konum[k][7])
                break
            end
        end
    end,2700,1,obje_id)
end
function satin_alma(ucret,secilen)
    if getPlayerMoney(source) <= ucret then 
        exports["meta-info"]:sendServerMessage("Yetersiz bakiye!","error",source)
        return
    end
    local sahip_icki=getElementData(source,"oyuncu_meta_icki")
    if isElement(sahip_icki) then 
        destroyElement(sahip_icki)
        removeElementData(source,"oyuncu_meta_icki")
        unbindKey(source,icme_tus,"down","ic")
        unbindKey(source,birak_tus,"down","birak")
    end
    for k,v in ipairs(oyuncu_el_obje_konum) do 
        if secilen == oyuncu_el_obje_konum[k][1] then
            setPedAnimation(source,"INT_SHOP","shop_pay",-1,false, false, false)
            local oyuncu=source
            setTimer(function ()
                para = createObject(1212,0,0,0)
                setElementInterior(para,10)
                setElementFrozen(para,true)
                exports.bone_attach:attachElementToBone(para,oyuncu,11,0,0,0.15)
            end,3000,1,oyuncu)
            setTimer(function () 
                setPedAnimation(oyuncu,"BAR","Barserve_give",-1,false, false, false) 
                exports.bone_attach:detachElementFromBone(para)
                exports.bone_attach:attachElementToBone(para,barwomen,12,0.06,0.07,0.08)
                setPedAnimation(barwomen,"BAR","Barserve_bottle",-1,false,false, false)
                setTimer(function () setPedAnimation(barwomen,"FOOD", "SHP_Tray_Lift_Loop" , -1,true, false, false ) end,2700,1)
            end,6000,1,oyuncu,para)
            setTimer(function ()
                destroyElement(para)
                exports.bone_attach:attachElementToBone(icki,oyuncu,12,
                oyuncu_el_obje_konum[k][2],
                oyuncu_el_obje_konum[k][3],
                oyuncu_el_obje_konum[k][4],
                oyuncu_el_obje_konum[k][5],
                oyuncu_el_obje_konum[k][6],
                oyuncu_el_obje_konum[k][7])
                setElementData(oyuncu,"oyuncu_meta_icki",icki)
                bindKey(oyuncu,icme_tus,"down","ic")
                bindKey(oyuncu,birak_tus,"down","birak")
                icki=nil
                setElementRotation(oyuncu,0,0,270)
                setPedAnimation(oyuncu,"ped","run_player",750)
                setTimer(function() setPedAnimation(oyuncu) end,750,1,oyuncu)
                takePlayerMoney(oyuncu,ucret)
                exports["meta-info"]:sendServerMessage(icme_tus.." tuşuna basarak veya /ic yazarak içebilirsiniz. Bırakmak için "..birak_tus.." tuşuna basarak veya /birak yazabilirsiniz.","info",oyuncu)
            end,8000,1,oyuncu,para)
        end
    end

end
function ickiyi_alma(eski)
    if eski == 10 then 
        local sahip_icki=getElementData(source,"oyuncu_meta_icki")
        if isElement(sahip_icki) then 
            destroyElement(sahip_icki)
            removeElementData(source,"oyuncu_meta_icki")
            unbindKey(source,icme_tus,"down","ic")
            unbindKey(source,birak_tus,"down","birak")
        end
    end
end
function icki_icme(oyuncu)
    local sahip_icki=getElementData(oyuncu,"oyuncu_meta_icki")
    if isElement(sahip_icki) then 
        setPedAnimation(oyuncu,"BAR","dnk_stndM_loop",500,false, false, false)
        setTimer(function() setPedAnimation(oyuncu) end,750,1,oyuncu)
		local icki_model = getElementModel(sahip_icki)
        if getElementData(oyuncu,"icki_"..icki_model) == false then 
            setElementData(oyuncu,"icki_"..icki_model,0)
        end
        for k, v in ipairs(icecekler_liste) do 
            if icki_model == icecekler_liste[k][3] then
                if getElementData(oyuncu,"icki_"..icki_model) >= icecekler_liste[k][4]  and getElementData(oyuncu,"icki_"..icki_model) <= icecekler_liste[k][4]+1 then 
                    setPedWalkingStyle(oyuncu, 126)
                    triggerClientEvent(oyuncu, "client:currentEffectDrinks", resourceRoot)
                elseif getElementData(oyuncu,"icki_"..icki_model) <= icecekler_liste[k][4] then 
                    local icme_sayi=getElementData(oyuncu,"icki_"..icki_model)
                    setElementData(oyuncu,"icki_"..icki_model,icme_sayi+1)
                    local timer_kontrol = getElementData(oyuncu,"meta_bar_timer"..icki_model) 
                    if timer_kontrol then 
                        killTimer(timer_kontrol) 
                    end
                    timer = setTimer(function (oyuncu,icki_model) 
                        setElementData(oyuncu,"icki_"..icki_model,0)
                       removeElementData(oyuncu,"meta_bar_timer"..icki_model)
                    end,60000,1,oyuncu,icki_model)
                    setElementData(oyuncu,"meta_bar_timer"..icki_model,timer)
                end
            end
        end
    end
end
function ickiyi_birak(oyuncu)
    local sahip_icki=getElementData(oyuncu,"oyuncu_meta_icki")
    if isElement(sahip_icki) then 
        destroyElement(sahip_icki)
        removeElementData(oyuncu,"oyuncu_meta_icki")
        unbindKey(oyuncu,icme_tus,"down","ic")
        unbindKey(oyuncu,birak_tus,"down","birak")
    end
end



function resetWalkingStyle()
	setPedWalkingStyle(client, 0)
end
addEvent("resetWalkingStyle", true)
addEventHandler("resetWalkingStyle", resourceRoot, resetWalkingStyle)

addCommandHandler("birak",ickiyi_birak)

addCommandHandler("ic",icki_icme)

addEventHandler("onElementInteriorChange",root,ickiyi_alma)

-- satin alma
addEvent("satin_al",true)
addEventHandler("satin_al",root,satin_alma)

addEventHandler("onResourceStart",resourceRoot,sistem_calisma_s)
-- Bardan ayrılma
addEvent("bardan_ayril",true)
addEventHandler("bardan_ayril",root,bardan_ayrilma)

--İçkiyi gösterme
addEvent("ickiyi_goster",true)
addEventHandler("ickiyi_goster",root,ickiyi_goster)

