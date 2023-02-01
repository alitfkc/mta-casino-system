guiler_tablo={}
onceki_secilen=""
function sistem_calisma_panel()
    local ekranw,ekranh=guiGetScreenSize()
    panel_bar=guiCreateWindow(10,(ekranh-380)/2,200,260,"Meta Bar",false)
    --butonlar
    guiler_tablo.panel_kapat=guiCreateButton(10,230,85,25,"Kapat",false,panel_bar)
    guiler_tablo.panel_satin_al=guiCreateButton(105,230,85,25,"Satın Al",false,panel_bar)
    guiSetEnabled(guiler_tablo.panel_satin_al,false)
    --içecekler 
    guiler_tablo.ickiler_liste=guiCreateGridList(10,25,180,200,false,panel_bar)
    icecek=guiGridListAddColumn(guiler_tablo.ickiler_liste,"İçecek",0.5)
    fiyat=guiGridListAddColumn(guiler_tablo.ickiler_liste,"Fiyat",0.4)
    for k,v in ipairs(icecekler_liste) do 
        row=guiGridListAddRow(guiler_tablo.ickiler_liste,icecekler_liste[k][1],icecekler_liste[k][2].." $")
        guiGridListSetItemColor(guiler_tablo.ickiler_liste,row,fiyat,0,255,0)
    end
    guiSetVisible(panel_bar,false)
end
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma_panel)
function panel_ac(durum)
    if durum then 
        guiSetVisible(panel_bar,true)
        showCursor(true)
        setCameraMatrix(1955.47854, 1017.99182, 993.46875,1953.78650, 1018.07526, 992.56875)
        guiSetEnabled(guiler_tablo.panel_satin_al,false);
        guiGridListSetSelectedItem( guiler_tablo.ickiler_liste,-1,-1)
        guiSetEnabled(guiler_tablo.panel_kapat,true)
        onceki_secilen=""
        for k,v in pairs(guiler_tablo) do 
            addEventHandler("onClientGUIClick",v,butona_basma)
        end
    else
        guiSetVisible(panel_bar,false)
        showCursor(false)
        setCameraTarget(localPlayer)
        for k,v in pairs(guiler_tablo) do 
            removeEventHandler("onClientGUIClick",v,butona_basma)
        end
    end 
end
function butona_basma()
    if source ==  guiler_tablo.panel_kapat then 
        triggerServerEvent("bardan_ayril",localPlayer)
    elseif source == guiler_tablo.ickiler_liste then 
        local secilen_row,secilen_column=guiGridListGetSelectedItem(guiler_tablo.ickiler_liste) 
        if secilen_row >= 0 then
            local secilen=guiGridListGetItemText(guiler_tablo.ickiler_liste,secilen_row,secilen_column)
            if onceki_secilen == secilen then return end
            guiSetEnabled(guiler_tablo.panel_satin_al,false)
            for k,v in ipairs(icecekler_liste) do 
                if secilen == icecekler_liste[k][1] then 
                    if isTimer(buton_acma) then 
                        killTimer(buton_acma) 
                        guiSetEnabled(guiler_tablo.panel_satin_al,false)
                    end
                    triggerServerEvent("ickiyi_goster",localPlayer,icecekler_liste[k][3])
                    onceki_secilen=icecekler_liste[k][1]
                    buton_acma=setTimer(function ()
                        guiSetEnabled(guiler_tablo.panel_satin_al,true) 
                        buton_acma=nil
                    end,2800,1 )
                end
            end
        else
            guiSetEnabled(guiler_tablo.panel_satin_al,false)
        end
    elseif source == guiler_tablo.panel_satin_al then
        local secilen_row,secilen_column=guiGridListGetSelectedItem(guiler_tablo.ickiler_liste) 
        if secilen_row >= 0 then
            local secilen=guiGridListGetItemText(guiler_tablo.ickiler_liste,secilen_row,secilen_column)
            for k,v in ipairs(icecekler_liste) do 
                if secilen == icecekler_liste[k][1] then 
                    if getPlayerMoney(localPlayer) >= icecekler_liste[k][2] then 
                        triggerServerEvent("satin_al",localPlayer,icecekler_liste[k][2],icecekler_liste[k][3])
                        guiSetEnabled(guiler_tablo.panel_satin_al,false)
                        guiSetEnabled(guiler_tablo.panel_kapat,false)
                        break
                    else
                        exports["meta-info"]:sendClientMessage("Yetersiz bakiye.","error")
                    end
                end
            end
        else
            exports["meta-info"]:sendClientMessage("Öncelikle ne almak istediğinizi seçiniz.","error")
        end
    end
end
addEvent("bar_panel_ac",true)
addEventHandler("bar_panel_ac",localPlayer,panel_ac) 