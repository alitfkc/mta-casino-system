function cip_takas(durum,cip)
    cip = tonumber(cip)
    if durum == "sat" then 
        local oyuncu_cip = getElementData(source,"meta_cip")
        if oyuncu_cip >= cip then
            local fiyat = cip * coin_fiyat
            vergi_miktar = fiyat * vergi/100
            fiyat = fiyat - vergi_miktar
            fiyat = math.floor(fiyat)
            local sonuc = oyuncu_cip - cip 
            setElementData(source,"meta_cip",sonuc)
            givePlayerMoney(source,fiyat)
            exports["meta-info"]:sendServerMessage("Başarıyla "..cip.." Meta Çip'i "..fiyat.." $'a sattınız.","success",source)
        else
            exports["meta-info"]:sendServerMessage("Yetersiz bakiye.","error",source)
        end 
    elseif durum == "al" then
        local fiyat = cip * coin_fiyat
        vergi_miktar = fiyat * vergi/100
        fiyat = fiyat + vergi_miktar
        fiyat = math.floor(fiyat)
        if getPlayerMoney(source) >= fiyat then
            takePlayerMoney(source,fiyat)
            local oy_cip = getElementData(source,"meta_cip")
            if oy_cip then
            else
                oy_cip = 0
            end
            oy_cip = cip + oy_cip 
            setElementData(source,"meta_cip",oy_cip)
            exports["meta-info"]:sendServerMessage("Başarıyla "..fiyat.." $ karşılığında "..cip.." Meta Çip aldınız.","success",source)
        else
            exports["meta-info"]:sendServerMessage("Yetersiz bakiye.","error",source)
        end
    else
        exports["meta-info"]:sendServerMessage("Hatalı İşlem.","error",source)
    end
end
function satin_alma_markergiris(oyuncu)
    if oyuncu then 
        setElementRotation(oyuncu,0,0,180)
        triggerClientEvent("chip_panel_ac",oyuncu,true)
    end
end
function satin_alma_markercikis(oyuncu)
    if oyuncu then 
        triggerClientEvent("chip_panel_ac",oyuncu,false)
    end
end

satin_alma_marker=createMarker(1984.00940, 1010.50909, 993.56875,"cylinder",1,255,0,0,50,root)
setElementInterior(satin_alma_marker,10)
addEventHandler("onMarkerHit",satin_alma_marker, satin_alma_markergiris)
addEventHandler("onMarkerLeave",satin_alma_marker, satin_alma_markercikis)


addEvent("cip_alisveris",true)
addEventHandler("cip_alisveris",root,cip_takas)

--------------------
--SAVE SİSTEM
--------------------
function verileriKaydet(oyuncu)
    local cipler = getElementData(oyuncu,"meta_cip") 
    setAccountData(getPlayerAccount(oyuncu),"meta_cip_data",cipler)
end
function verileriYukle(oyuncu)
    local cipler = getAccountData(getPlayerAccount(oyuncu),"meta_cip_data")
    setElementData(oyuncu,"meta_cip",cipler)
end


addEventHandler("onPlayerQuit", root, function()
    verileriKaydet(source)
end)

addEventHandler("onPlayerLogin", root, function(oncekihesap, suankihesap)
    verileriYukle(source)
end)
addEventHandler("onPlayerLogout", root, function(oncekihesap, suankihesap)
    verileriKaydet(source)
end)
