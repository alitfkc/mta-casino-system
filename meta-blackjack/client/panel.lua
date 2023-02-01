gui = {}
bahis = 100
oyuncu_2_bahis = ""
bahis_min = 100
bahis_max = 500
function sistem_calisma()
    panel = guiCreateStaticImage(0,300,242,215,"resimler/panel.png",false)


    gui.pas = guiCreateButton(15,135,210,30,"Dur",false,panel)
    gui.ayril = guiCreateButton(15,170,210,30,"Ayrıl",false,panel)
    gui.kart_iste = guiCreateButton(15,100,210,30,"Kart İste",false,panel)
    gui.bahis_arttir = guiCreateButton(15,10,80,30,"Bahis Arttır",false,panel)
    gui.bahis_azalt = guiCreateButton(15,45,80,30,"Bahis Azalt",false,panel)
    gui.yatir = guiCreateButton(120,45,100,30,"Yatır ",false,panel)
    bahis_yazi = guiCreateLabel(120,18,60,30,"Bahis :",false,panel)
    guiSetFont(bahis_yazi,"default-bold-small")
    bahis_miktar_yazi = guiCreateLabel(160,18,60,30,bahis.." Çip",false,panel)
    guiSetFont(bahis_miktar_yazi,"default-bold-small")
    guiLabelSetColor(bahis_miktar_yazi,0,255,0)
    guiSetVisible(panel,false)
    for k,v in pairs(gui) do
        addEventHandler("onClientGUIClick",v,butonabasma)
    end
end
function butonabasma()
    if source == gui.ayril then 
        triggerServerEvent("blackjack_ayril",localPlayer,localPlayer)
    elseif source == gui.bahis_arttir then 
        if bahis >= bahis_max  or bahis == 1900 then  
            bahis = bahis_max
            guiSetText(bahis_miktar_yazi,bahis.." Çip") 
            exports["meta-info"]:sendClientMessage("Maksimum Bahis Sınırı!","error") 
            return 
        end
        if bahis == 260 then bahis = bahis - 10 end
        if bahis == 550 then bahis = bahis - 50 end
        if bahis >= 250 and bahis <= 499 then 
            bahis = bahis + 40 
        elseif bahis >= 500 and bahis <= 1000 then 
            bahis = bahis + 90 
        elseif bahis >= 1000 and bahis <= bahis_max then
            bahis = bahis + 190 
        end
        bahis = bahis + 10
        guiSetText(bahis_miktar_yazi,bahis.." Çip")
    elseif source == gui.bahis_azalt then 
        if bahis <= bahis_min then 
            bahis = bahis_min
            guiSetText(bahis_miktar_yazi,bahis.." Çip") 
            exports["meta-info"]:sendClientMessage("Minimum Bahis Sınırı!","error") 
            return 
        end 
        if bahis >= 250 and bahis <= 500 then 
            bahis = bahis - 40 
        elseif bahis >= 500 and bahis <= 1000 then 
            bahis = bahis - 90 
        elseif bahis >= 1000 and bahis <= bahis_max then
            bahis = bahis - 190 
        end
        bahis = bahis - 10
        guiSetText(bahis_miktar_yazi,bahis.." Çip")
    elseif source == gui.yatir then
        triggerServerEvent("blackjack_yatir",localPlayer,bahis)
    elseif source == gui.pas then
    elseif source == gui.kart_iste then 
        triggerServerEvent("blackjack_kart_iste",localPlayer)
    end
end
function panel_acma(durum)
    if durum then 
        guiSetVisible(panel,true)
        oyuncu_2_bahis = 0 
        guiSetText(bahis_miktar_yazi,bahis.." Çip")
        showCursor(true)
        guiSetEnabled(gui.kart_iste,false)
        guiSetEnabled(gui.pas,false)
        addEventHandler("onClientKey", root,tus_engel)
    else
        guiSetVisible(panel,false)
        showCursor(false)
        removeEventHandler("onClientKey", root,tus_engel)
    end
end


addEvent("panel_ac_blackjack",true)
addEventHandler("panel_ac_blackjack",localPlayer,panel_acma)
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)