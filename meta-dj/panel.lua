butonlar = {}
ses_seviye_c=nil
local function sistem_calisma()
    local ekranh,ekrany = guiGetScreenSize()
    panel = guiCreateWindow((ekranh-500)/2,(ekrany-250)/2,500,250,"Meta Müzik",false)
    liste = guiCreateGridList(10,30,200,210,false,panel)
    column = guiGridListAddColumn(liste,"Radyolar",0.85)
    for k,v in ipairs(radyolar) do 
        row=guiGridListAddRow(liste,radyolar[k][1])
    end
    butonlar.edit = guiCreateEdit(240,70,250,20,"URL YAZIN",false,panel)
    butonlar.url_ac_buton = guiCreateButton(240,95,250,30,"URL AÇ",false,panel)
    butonlar.ses_arttirma_buton = guiCreateButton(240,140,50,30,"+",false,panel)
    butonlar.ses_azaltma_buton = guiCreateButton(292,140,50,30,"-",false,panel)
    butonlar.kapat = guiCreateButton(240,175,102,30,"Sesi Kapat",false,panel)
    ses_yazi = guiCreateLabel(352,145,130,20,"Ses seviyesi = ",false,panel)
    triggerServerEvent("radyo_kontrol",localPlayer)
    guiSetVisible(panel,false)
    for k,v in pairs(butonlar) do 
        addEventHandler("onClientGUIClick",v,butona_basma)
    end
    addEventHandler("onClientGUIDoubleClick",liste,radyo_secme)
end
function radyo_secme()
    if source == liste then 
        for k,v in ipairs(radyolar) do 
            guiGridListSetItemColor(liste,k-1,column,255,255,255)
        end
        local secilen_row,secilen_column=guiGridListGetSelectedItem(liste) 
        if secilen_row >= 0 then
            local secilen=guiGridListGetItemText(liste,secilen_row,secilen_column)
            for k,v in ipairs(radyolar) do 
                if secilen == radyolar[k][1] then 
                    guiGridListSetItemColor(liste,secilen_row,secilen_column,0,255,0)
                    triggerServerEvent("sarki_degis",localPlayer,radyolar[k][2])
                    break
                end
            end
        end
    end
end
function butona_basma()
    if source ==  butonlar.url_ac_buton then 
        local link = guiGetText(butonlar.edit)
        if link then 
            triggerServerEvent("sarki_degis",localPlayer,link)
            kontrol_timer = setTimer(function () guiSetText(butonlar.edit,"Hatalı URL") exports["meta-info"]:sendClientMessage("Hatalı URL","error") triggerServerEvent("sarki_degis",localPlayer,"http://91.121.59.45:8394/stream") end,1200,1)
        else
            exports["meta-info"]:sendClientMessage("URL ekleyin","error")
        end
    elseif source == butonlar.ses_arttirma_buton then 
        triggerServerEvent("ses_degis",localPlayer,"+")
    elseif source == butonlar.ses_azaltma_buton then 
        triggerServerEvent("ses_degis",localPlayer,"-")
    elseif source == butonlar.edit then 
        guiSetText(butonlar.edit,"")
    elseif source == butonlar.kapat then 
        triggerServerEvent("ses_kapat",localPlayer)
    end
end
function sistem_calisma_devam(link,ses_seviye)
    if link then 
        for k,v in ipairs(radyolar) do 
           if link == radyolar[k][2] then 
            guiGridListSetItemColor(liste,k-1,column,0,255,0)
            break
           end
        end
    end
    ses_seviye_c = ses_seviye
    guiSetText(ses_yazi,"Ses seviyesi = "..ses_seviye_c)
    sarki_cal(link,ses_seviye_c)
end
function panel_acilis()
    guiSetText(butonlar.edit,"URL Yazın")
    guiSetVisible(panel, not guiGetVisible(panel)) 
    showCursor(not isCursorShowing()) 

end
function sarki_cal(link,ses_seviye_e)
    if sarki then 
        stopSound(sarki)
        sarki = nil
    end
    sarki = playSound3D (link,1952.35925, 1019.34912, 992.46875,true) 
    setElementInterior(sarki,10)
    setSoundMaxDistance(sarki,120)
    local ses_level= ses_seviye_e / 100
    setSoundVolume(sarki,ses_level)
end
function ses_degistir(ses_level)
    guiSetText(ses_yazi,"Ses seviyesi = "..ses_level)
    ses_level = ses_level / 100
    setSoundVolume(sarki,ses_level)
end
function ses_calisma_kontrol(suc,length,streamN,error)
    if suc  and isTimer(kontrol_timer) then 
        killTimer(kontrol_timer)
    end
end
function ses_kapat_c()
    if sarki then 
        stopSound(sarki)
        sarki = nil
    end
end


addEventHandler("onClientSoundStream",root,ses_calisma_kontrol)

addEvent("ses_degistir_s",true)
addEventHandler("ses_degistir_s",localPlayer,ses_degistir)

addEvent("ses_kapat_s",true)
addEventHandler("ses_kapat_s",localPlayer,ses_kapat_c)

addEvent("sarki_degistir_s",true)
addEventHandler("sarki_degistir_s",localPlayer,sarki_cal)

addEvent("panelAc" ,true)
addEventHandler("panelAc",localPlayer,panel_acilis)

addEvent("radyo_kontrol_edildi",true)
addEventHandler("radyo_kontrol_edildi",localPlayer,sistem_calisma_devam)

addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)