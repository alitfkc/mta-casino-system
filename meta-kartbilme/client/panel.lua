gui = {}
bahis = 5
bahis_min = 5
bahis_max = 150
gostermelik_kart = {}
local function sistem_calisma()
    local ekranh,ekrany = guiGetScreenSize()
    panel = guiCreateWindow((ekranh-800)/2,(ekrany-360)/2,800,360,"İskambil Tahmin Et",false)
    
    gostermelik_kart[1] = guiCreateStaticImage(10,30,120,156,"kart/kart_arka.png",false,panel)
    gostermelik_kart[2] = guiCreateStaticImage(140,30,120,156,"kart/kart_arka.png",false,panel)
    gostermelik_kart[3] = guiCreateStaticImage(10,196,120,156,"kart/kart_arka.png",false,panel)
    gostermelik_kart[4] = guiCreateStaticImage(140,196,120,156,"kart/kart_arka.png",false,panel)

    gostermelik_kart[5] = guiCreateStaticImage(540,30,120,156,"kart/kart_arka.png",false,panel)
    gostermelik_kart[6] = guiCreateStaticImage(670,30,120,156,"kart/kart_arka.png",false,panel)
    gostermelik_kart[7] = guiCreateStaticImage(540,196,120,156,"kart/kart_arka.png",false,panel)
    gostermelik_kart[8] = guiCreateStaticImage(670,196,120,156,"kart/kart_arka.png",false,panel)


    bahis_kart_1 = guiCreateComboBox(285,80,105,180,"Siyah 2",false,panel)
    bahis_sayisi_1 = guiCreateComboBox(415,80,100,100,"1",false,panel)
    bahis_1_yazi_1 = guiCreateLabel(285,35,230,40,"Bahis 1",false,panel)
    guiSetFont(bahis_1_yazi_1,"default-bold-small")
    guiLabelSetColor(bahis_1_yazi_1,255,255,255)
    guiLabelSetHorizontalAlign(bahis_1_yazi_1,"center")
    bahis_1_yazi_2 = guiCreateLabel(282,63,100,20,"Kart Seçin",false,panel)
    guiSetFont(bahis_1_yazi_2,"default-bold-small")
    guiLabelSetColor(bahis_1_yazi_2,255,0,0)
    guiLabelSetHorizontalAlign(bahis_1_yazi_2,"center")
    bahis_1_yazi_3 = guiCreateLabel(412,63,100,20,"Kart Sayısı Seçin",false,panel)
    guiSetFont(bahis_1_yazi_3,"default-bold-small")
    guiLabelSetColor(bahis_1_yazi_3,255,0,0)
    guiLabelSetHorizontalAlign(bahis_1_yazi_3,"center")



    bahis_kart_2 = guiCreateComboBox(285,150,105,180,"Siyah 2",false,panel)
    bahis_sayisi_2 = guiCreateComboBox(415,150,100,100,"1",false,panel)
    bahis_2_yazi_1 = guiCreateLabel(285,110,230,20,"Bahis 2",false,panel)
    guiSetFont(bahis_2_yazi_1,"default-bold-small")
    guiLabelSetColor(bahis_2_yazi_1,255,255,255)
    guiLabelSetHorizontalAlign(bahis_2_yazi_1,"center")
    bahis_2_yazi_2 = guiCreateLabel(282,135,100,20,"Kart Seçin",false,panel)
    guiSetFont(bahis_2_yazi_2,"default-bold-small")
    guiLabelSetColor(bahis_2_yazi_2,255,0,0)
    guiLabelSetHorizontalAlign(bahis_2_yazi_2,"center")
    bahis_2_yazi_3 = guiCreateLabel(412,135,100,20,"Kart Sayısı Seçin",false,panel)
    guiSetFont(bahis_2_yazi_3,"default-bold-small")
    guiLabelSetColor(bahis_2_yazi_3,255,0,0)
    guiLabelSetHorizontalAlign(bahis_2_yazi_3,"center")


    for k,v in ipairs(kart_tanimlar) do 
        if k > 26 then break end
        guiComboBoxAddItem( bahis_kart_1,kart_tanimlar[k][2])
        guiComboBoxAddItem( bahis_kart_2,kart_tanimlar[k][2])
    end
    for i=1,4 do 
        guiComboBoxAddItem( bahis_sayisi_1,i)
        guiComboBoxAddItem( bahis_sayisi_2,i)
    end

    gui.ayril = guiCreateButton(270,320,260,30,"Ayrıl",false,panel)
    gui.bahis_arttir = guiCreateButton(270,200,130,30,"Bahis Arttır",false,panel)
    gui.bahis_azalt = guiCreateButton(270,240,130,30,"Bahis Azalt",false,panel)
    gui.yatir = guiCreateButton(270,280,260,30,"Yatır ",false,panel)
    bahis_yazi = guiCreateLabel(420,200,60,30,"Bahis :",false,panel)
    guiSetFont(bahis_yazi,"default-bold-small")
    bahis_miktar_yazi = guiCreateLabel(460,200,60,30,bahis.." Çip",false,panel)
    guiSetFont(bahis_miktar_yazi,"default-bold-small")
    guiLabelSetColor(bahis_miktar_yazi,0,255,0)
    for k,v in pairs(gui) do 
        addEventHandler("onClientGUIClick",v,buton_basma)
    end
   guiSetVisible(panel,false)
end


function buton_basma()
    if source == gui.ayril then 
        guiSetVisible(panel,false)
        showCursor(false)
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
       local oyuncu_bahis = getElementData(localPlayer,"meta_cip")
       if oyuncu_bahis < bahis then return exports["meta-info"]:sendClientMessage("Yetersiz bakiye!","error") end
       guiSetEnabled(gui.yatir,false)
       guiSetEnabled(gui.ayril,false)
       guiSetEnabled(gui.bahis_arttir,false)
       guiSetEnabled(gui.bahis_azalt,false)
       guiSetEnabled(bahis_kart_1,false)
       guiSetEnabled(bahis_sayisi_1,false)
       guiSetEnabled(bahis_kart_2,false)
       guiSetEnabled(bahis_sayisi_2,false)
       oyuncu_bahis = oyuncu_bahis - bahis
       setElementData(localPlayer,"meta_cip",oyuncu_bahis)
       kartlari_goster()
    end
end

addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)