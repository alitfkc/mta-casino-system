map_objeler_tablo={
--    {obje_id,x,y,z,rx,ry,rz,interior,dimens,scale}
    {tabela_obje_id,2161.55,2162.1099,23.6,90,315,0,0,0,3.6},-- dış büyük
    {tabela_obje_id,2173.86821,2162.83433,12.32031,90,0,0,0,0,0.5}, --sol küçük sağ  
    {tabela_obje_id,2162.39057, 2174.14424, 12.32031,90,270,0,0,0,0.5}, --dış küçük sol
    {tabela_obje_id,2019.6178, 1018.110533, 1010.45149331,90,270,0,10,0,4}, -- iç çıkış
    {tabela_obje_id,1982.82998, 1017.64583, 1007.91183,90,90,0,10,0,4}, --iç giriş
    -- alt ışıklar
    {3385,2161.69057, 2174.14424, 9.82031,0,0,0,0,0,1},
    {3385,2173.86821,2162.13433, 9.82031,0,0,0,0,0,1},
    --çitler
    {2773,2168.5, 2163.5, 10.35,0,0,330,0,0,1},
    {2773,2170.1999511719, 2162.6000976562, 10.35,0,0,330,0,0,1},
    {2773,2169.2299804688,2160.9389648438, 10.35,0,0,330,0,0,1},
    {2773,2167.939023438,2160.61, 10.35,0,0,240,0,0,1},
    {2773,2166.2700195312,2161.5700683594, 10.35,0,0,240,0,0,1},
    {2773,2167.1999511719,2163.1701660156, 10.35,0,0,240,0,0,1},
    --dış mekan süsleme

    -- meta chip alma
    {2008,1983.95361, 1009.36371, 993.48075,0,0,0,10,0,1.3}
}
pedler_tablo={
    --{skin_id,x,y,z,rz,dimension,interior}
    {163,2168.06592, 2164.12280, 10.82031,150,0,0},
    {224,1999.71423, 1022.83026, 994.6875,220,0,10},
    {263,1984.12427, 1008.45785, 994.46875,0,0,10},
} 
function sistem_calisma()
    interior_isinlanma_marker=createMarker(2169.72217, 2163.29614, 11.42031,"arrow",1,255,0,0,255,root)
    interior_cikma_marker=createMarker(2019.07031, 1017.89117, 997.57500,"arrow",1,255,0,0,255,root)
    setElementInterior(interior_cikma_marker,10)
    addEventHandler("onMarkerHit",interior_isinlanma_marker, interior_giris_markergiris)
    addEventHandler("onMarkerHit",interior_cikma_marker, interior_giris_markercikis)
    setTimer(function()
        for k,v in ipairs(map_objeler_tablo) do 
            obje=createObject(map_objeler_tablo[k][1],map_objeler_tablo[k][2],map_objeler_tablo[k][3],map_objeler_tablo[k][4],map_objeler_tablo[k][5],map_objeler_tablo[k][6],map_objeler_tablo[k][7])
            setElementInterior(obje,map_objeler_tablo[k][8])
            setElementDimension(obje,map_objeler_tablo[k][9])
            setObjectScale(obje,map_objeler_tablo[k][10])
        end
    end,2000,1)
    setTimer(function()
        for k,v in ipairs(pedler_tablo) do
            ped=createPed(pedler_tablo[k][1],pedler_tablo[k][2],pedler_tablo[k][3],pedler_tablo[k][4],pedler_tablo[k][5])
            setElementDimension(ped,pedler_tablo[k][6])
            setElementInterior(ped,pedler_tablo[k][7])
            setElementFrozen(ped,true)
            setElementData(ped,"ped_olumsuzluk_meta",true)
            setTimer(anim_ekle,4000,1,ped)
        end
    end,4000,1)
    createBlip(2163.58081, 2163.80762, 10.82031,25,5)
end
function anim_ekle(ped) 
    if (getElementModel(ped)==163) then 
        setPedAnimation(ped,"DEALER", "DEALER_IDLE", -1,true, false, false )
        setElementData(ped,"yazi","ped_koruma")
    elseif (getElementModel(ped)==224) then 
        setPedAnimation(ped,"DEALER", "DEALER_IDLE", -1,true, false, false )
        setElementData(ped,"yazi","ped_garson")
    elseif (getElementModel(ped)==263) then 
        setPedAnimation(ped,"FOOD", "SHP_Tray_Lift_Loop", -1,true, false, false )
        setElementData(ped,"yazi","ped_chip")
    end
end
function interior_giris_markergiris(oyuncu)
    triggerClientEvent("panel_ac_giris",oyuncu,true)
end
function interior_giris_markercikis(oyuncu)
    setElementInterior(oyuncu,0,2164.09131, 2161.78418, 10.82031)
    toggleControl (oyuncu, 'fire', true )
    toggleControl ( oyuncu, 'next_weapon',true )
    toggleControl ( oyuncu, 'previous_weapon',true )
    triggerClientEvent("hasar_engel_kapat",oyuncu)
end



function giris_istek()
    if (getPlayerMoney(source)>=giris_ucret) then 
        takePlayerMoney(source,giris_ucret)
        setElementInterior(source,10,2016.09546, 1017.78442, 996.87500)
        triggerClientEvent("panel_ac_giris",source,false)
        toggleControl ( source, 'fire', false )
        toggleControl ( source, 'next_weapon', false )
        toggleControl ( source, 'previous_weapon', false )
        setPedWeaponSlot(source,0)
    else
        exports["meta-info"]:sendServerMessage("Yeterli paranız bulunmamaktadır.","error",source)
    end
end
addEvent("giris_yapma",true)
addEventHandler("giris_yapma",root,giris_istek)
addEventHandler("onResourceStart",resourceRoot,sistem_calisma)

