mark = {}
makinalar = {
    --{x,y,z,dimens,interior,rz,scale}
    {1969.47980, 1020.00647, 992.168750,0,10,86,0.5},
    {1969.47187, 1020.87292, 992.16875,0,10,86,0.5},
    {1969.47175, 1021.74481, 992.16875,0,10,86,0.5},
    {1969.47211, 1022.63708, 992.16875,0,10,86,0.5},
    {1969.47843, 1023.49652, 992.16875,0,10,86,0.5},

    {1969.47138, 1028.04395, 992.17449,0,10,86,0.5},
    {1969.47804, 1028.93066, 992.17449,0,10,86,0.5},
    {1969.47382, 1029.74341, 992.17449,0,10,86,0.5},
    {1969.47504, 1030.57520, 992.17449,0,10,86,0.5},
    {1969.47025, 1031.46179, 992.17449,0,10,86,0.5},


    {1966.65862, 1020.00647, 993.168750,0,10,274,0.5},
    {1966.65862, 1020.87292, 993.16875,0,10,274,0.5},
    {1966.65862, 1021.74481, 992.16875,0,10,274,0.5},
    {1966.65862, 1022.63708, 992.16875,0,10,274,0.5},
    {1966.65862, 1023.49652, 992.16875,0,10,274,0.5},

    {1966.65862, 1028.04395, 992.17449,0,10,274,0.5},
    {1966.65862, 1028.93066, 992.17449,0,10,274,0.5},
    {1966.65862, 1029.74341, 992.17449,0,10,274,0.5},
    {1966.65862, 1030.57520, 992.17449,0,10,274,0.5},
    {1966.65862, 1031.46179, 992.17449,0,10,274,0.5},



    
}
oyun_kartlari = {}

local function sistem_calisma()
    for k,v in pairs(makinalar) do 
        mark[k] = createMarker(makinalar[k][1],makinalar[k][2],makinalar[k][3],"cylinder",makinalar[k][7],255,0,0,255)
        setElementInterior(mark[k],makinalar[k][5])
        setElementDimension(mark[k],makinalar[k][4])
        addEventHandler("onClientMarkerHit",mark[k],panel_acma)
        setElementData(mark[k],"meta_rot",makinalar[k][6])
    end
end
function panel_acma(hit)
    if hit == localPlayer then 
        if getElementInterior(localPlayer) ~= 10 then return end
        guiSetVisible(panel,true)
        showCursor(true)
        local rz = getElementData(source,"meta_rot")
        setElementRotation(localPlayer,0,0,rz)
    end
end

function kart_ayni_kart_degis(tablo,kart)
    kart = rastgele_kart()
    local kart_durum = kart_kontrol(tablo,kart)
    while (kart_durum == false) do 
        kart = rastgele_kart()
        kart_durum = kart_kontrol(tablo,kart)
    end
    return kart
end
function kart_kontrol(tablo,kart)
    local a = 0 
    for k,v in pairs(tablo) do
        if v == kart then 
            a = a + 1 
        end
    end
    if a >= 5 then 
        return false
    else
        return true
    end
end

function rastgele_kart()
    kart = kartlar_tablo[math.random ( #kartlar_tablo )]
    return kart
end

function odullendir()
    local kazanc = 0
    local kart_sayisi_1 = 0
    local kart_sayisi_2 = 0
    local bahis_1_kart = guiComboBoxGetItemText(bahis_kart_1,guiComboBoxGetSelected(bahis_kart_1))
    local bahis_2_kart = guiComboBoxGetItemText(bahis_kart_2,guiComboBoxGetSelected(bahis_kart_2))

    local bahis_1_sayisi = guiComboBoxGetItemText(bahis_sayisi_1,guiComboBoxGetSelected(bahis_sayisi_1))
    local bahis_2_sayisi = guiComboBoxGetItemText(bahis_sayisi_2,guiComboBoxGetSelected(bahis_sayisi_2))
    bahis_1_sayisi = tonumber(bahis_1_sayisi)
    bahis_2_sayisi = tonumber(bahis_2_sayisi)

    for k,v in ipairs(oyun_kartlari) do 
        for l,s in ipairs(kart_tanimlar) do 
            local kart_tanim,isim = unpack(s)
            if isim == bahis_1_kart then 
                if v == kart_tanim then 
                    kart_sayisi_1 = kart_sayisi_1 + 1 
                end 
            end
            if isim == bahis_2_kart then 
                if v == kart_tanim then 
                    kart_sayisi_2 = kart_sayisi_2 + 1 
                end 
            end
        end
    end
    if kart_sayisi_1 >= bahis_1_sayisi or kart_sayisi_2 >= bahis_2_sayisi then 
        kazanc = bahis 
    else
        exports["meta-info"]:sendClientMessage("Kaybettin!","warning")
    end
    if kart_sayisi_1 >= bahis_1_sayisi then 
        guiLabelSetColor(bahis_1_yazi_1,0,255,0)
        if bahis_1_sayisi == 1 then 
            local gecici_e = (bahis * 35/100)
            gecici_e = math.floor(gecici_e)
            kazanc = kazanc + gecici_e 
        elseif bahis_1_sayisi == 2 then 
            local gecici_e = (bahis * 70/100)
            gecici_e = math.floor(gecici_e)
            kazanc = kazanc + gecici_e 
        elseif bahis_1_sayisi == 3 then 
            local gecici_e = bahis
            kazanc = kazanc + gecici_e 
        else
            local gecici_e = bahis * 2
            gecici_e = math.floor(gecici_e)
            kazanc = kazanc + gecici_e 
        end
    end
    if kart_sayisi_2 >= bahis_2_sayisi then 
        guiLabelSetColor(bahis_2_yazi_1,0,255,0)
        if bahis_2_sayisi == 1 then 
            local gecici_e = (bahis * 35/100)
            gecici_e = math.floor(gecici_e)
            kazanc = kazanc + gecici_e 
        elseif bahis_2_sayisi == 2 then 
            local gecici_e = (bahis * 70/100)
            gecici_e = math.floor(gecici_e)
            kazanc = kazanc + gecici_e 
        elseif bahis_2_sayisi == 3 then 
            local gecici_e = bahis
            kazanc = kazanc + gecici_e 
        else
            local gecici_e = bahis * 2
            gecici_e = math.floor(gecici_e)
            kazanc = kazanc + gecici_e 
        end
    end
    if kazanc > 0 then 
        local oyuncu_cip = getElementData(localPlayer,"meta_cip")
        oyuncu_cip = oyuncu_cip + kazanc
        exports["meta-vipbonus"]:bonus_ver_client(localPlayer,kazanc)
        setElementData(localPlayer,"meta_cip",oyuncu_cip)
        exports["meta-info"]:sendClientMessage(kazanc.." çip kazandınız.","success")
    end
    setTimer(function()
        guiLabelSetColor(bahis_1_yazi_1,255,255,255)
        guiLabelSetColor(bahis_2_yazi_1,255,255,255)
        guiSetEnabled(gui.yatir,true)
        guiSetEnabled(gui.ayril,true)
        guiSetEnabled(gui.bahis_arttir,true)
        guiSetEnabled(gui.bahis_azalt,true)
        guiSetEnabled(bahis_kart_1,true)
        guiSetEnabled(bahis_sayisi_1,true)
        guiSetEnabled(bahis_kart_2,true)
        guiSetEnabled(bahis_sayisi_2,true)
        for k,v in ipairs(oyun_kartlari) do 
            guiStaticImageLoadImage(gostermelik_kart[k],"kart/kart_arka.png")
        end
        local y_tablo = {}
        oyun_kartlari = y_tablo
    end,1500,1)
end


function kartlari_goster()
    local oyun_kart_1 = rastgele_kart()
    local oyun_kart_2 = rastgele_kart()
    local oyun_kart_3 = rastgele_kart()
    local oyun_kart_4 = rastgele_kart()
    table.insert(oyun_kartlari,oyun_kart_1)
    table.insert(oyun_kartlari,oyun_kart_2)
    table.insert(oyun_kartlari,oyun_kart_3)
    table.insert(oyun_kartlari,oyun_kart_4)
    -- KART 5 
    local oyun_kart_5 = rastgele_kart()
    local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_5)
    while (not kart_durum) do 
        local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_5)
        if not kart_durum then
            oyun_kart_5 =  kart_ayni_kart_degis(oyun_kartlari,oyun_kart_5)
        end
        break
    end
    table.insert(oyun_kartlari,oyun_kart_5)

    --KART 6
    local oyun_kart_6 = rastgele_kart()
    local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_6)
    while (not kart_durum) do 
        local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_6)
        if not kart_durum then
            oyun_kart_6 =  kart_ayni_kart_degis(oyun_kartlari,oyun_kart_6)
        end
        break
    end
    table.insert(oyun_kartlari,oyun_kart_6)

    --KART 7
    local oyun_kart_7 = rastgele_kart()
    local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_7)
    while (not kart_durum) do 
        local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_7)
        if not kart_durum then
            oyun_kart_7 =  kart_ayni_kart_degis(oyun_kartlari,oyun_kart_7)
        end
        break
    end
    table.insert(oyun_kartlari,oyun_kart_7)

    
    --KART 8
    local oyun_kart_8 = rastgele_kart()
    local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_8)
    while (not kart_durum) do 
        local kart_durum = kart_kontrol(oyun_kartlari,oyun_kart_8)
        if not kart_durum then
            oyun_kart_8 =  kart_ayni_kart_degis(oyun_kartlari,oyun_kart_8)
        end
        break
    end
    table.insert(oyun_kartlari,oyun_kart_8)
    local a = 500
    for k,v in ipairs(oyun_kartlari) do 
        setTimer(function(k,v)
            guiStaticImageLoadImage(gostermelik_kart[k],"kart/"..v..".png")
        end,a,1,k,v)
        a = a + 500
    end
    setTimer(odullendir,4500,1)
end


addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)

