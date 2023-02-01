local kurpiyer_y_kart_2 = "kart_arka"
local diger_kart_puan = 0
local function sistem_calisma_kart_c()
    kurpiyer_w = guiCreateStaticImage(0.39,0.22,0.20,0.25,"resimler/panel.png",true)
    kurpiyer_yazi = guiCreateLabel(0,0,1,0.3,"Kurpiyer",true,kurpiyer_w)
    guiLabelSetColor(kurpiyer_yazi,255,255,0)
    guiSetFont(kurpiyer_yazi,"default-bold-small")
    guiLabelSetHorizontalAlign(kurpiyer_yazi,"center")
    kurpiyer_top_yazi = guiCreateLabel(0,0.068,1,0.3,"0",true,kurpiyer_w)
    guiLabelSetColor(kurpiyer_top_yazi,0,255,0)
    guiSetFont(kurpiyer_top_yazi,"default-bold-small")
    guiLabelSetHorizontalAlign(kurpiyer_top_yazi,"center")

    kurpiyer_kart_1 = guiCreateStaticImage(0.055,0.2,0.35,0.65,"kart/kart_arka.png",true,kurpiyer_w)
    kurpiyer_kart_2 = guiCreateStaticImage(0.58,0.2,0.35,0.65,"kart/kart_arka.png",true,kurpiyer_w)

    sen_w = guiCreateStaticImage(0.55,0.55,0.20,0.25,"resimler/panel.png",true)
    sen_yazi = guiCreateLabel(0,0,1,0.3,"Sen",true,sen_w)
    guiLabelSetColor(sen_yazi,255,255,0)
    guiSetFont(sen_yazi,"default-bold-small")
    guiLabelSetHorizontalAlign(sen_yazi,"center")
    sen_top_yazi = guiCreateLabel(0,0.068,1,0.3,"0",true,sen_w)
    guiLabelSetColor(sen_top_yazi,0,255,0)
    guiSetFont(sen_top_yazi,"default-bold-small")
    guiLabelSetHorizontalAlign(sen_top_yazi,"center")

    sen_kart_1 = guiCreateStaticImage(0.055,0.2,0.35,0.65,"kart/kart_arka.png",true,sen_w)
    sen_kart_2 = guiCreateStaticImage(0.58,0.2,0.35,0.65,"kart/kart_arka.png",true,sen_w)

    diger_oy_w = guiCreateStaticImage(0.22,0.55,0.20,0.25,"resimler/panel.png",true)
    diger_oy_yazi = guiCreateLabel(0,0,1,0.3,"2.Oyuncu",true,diger_oy_w)
    guiLabelSetColor(diger_oy_yazi,255,255,0)
    guiSetFont(diger_oy_yazi,"default-bold-small")
    guiLabelSetHorizontalAlign(diger_oy_yazi,"center")
    diger_oy_top_yazi = guiCreateLabel(0,0.068,1,0.3,"0",true,diger_oy_w)
    guiLabelSetColor(diger_oy_top_yazi,0,255,0)
    guiSetFont(diger_oy_top_yazi,"default-bold-small")
    guiLabelSetHorizontalAlign(diger_oy_top_yazi,"center")

    diger_oy_kart_1 = guiCreateStaticImage(0.055,0.2,0.35,0.65,"kart/kart_arka.png",true,diger_oy_w)
    diger_oy_kart_2 = guiCreateStaticImage(0.58,0.2,0.35,0.65,"kart/kart_arka.png",true,diger_oy_w)

    guiSetVisible(kurpiyer_w,false)
    guiSetVisible(sen_w,false)
    guiSetVisible(diger_oy_w,false)
end
function kurpiyer_kart_goster_c(kart_1,kart_2)
    local  diger_kart_puan = 0 
    guiSetVisible(kurpiyer_w,true)
    guiStaticImageLoadImage(kurpiyer_kart_1,"kart/"..kart_1..".png")
    guiStaticImageLoadImage(kurpiyer_kart_2,"kart/".."kart_arka"..".png")
    guiSetPosition(kurpiyer_kart_1,0.055,0.2,true)
    guiSetPosition(kurpiyer_kart_2,0.58,0.2,true)
    kurpiyer_y_kart_2 = kart_2
    local kar_puan = diger_kart_hesapla_k(kart_1,kurpiyer_top_yazi)
    setElementData(localPlayer,"kurpiyer_puan",kar_puan)
end
function sen_kart_goster_c(kart_1,kart_2,durum)
    if durum then 
        guiSetVisible(sen_w,true)
        guiSetPosition(sen_w,0.39,0.55,true)
        guiStaticImageLoadImage(sen_kart_1,"kart/"..kart_1..".png")
        guiStaticImageLoadImage(sen_kart_2,"kart/"..kart_2..".png")
        guiSetPosition(sen_kart_1,0.055,0.2,true)
        guiSetPosition(sen_kart_2,0.58,0.2,true)
        oyuncu_kart_hesapla(kart_1,sen_top_yazi)
        oyuncu_kart_hesapla(kart_2,sen_top_yazi)
        guiSetEnabled(gui.kart_iste,true)
        guiSetEnabled(gui.pas,true)
    else
        guiSetVisible(sen_w,true)
        guiSetPosition(sen_w,0.39,0.55,true)
        guiStaticImageLoadImage(sen_kart_1,"kart/"..kart_1..".png")
        guiStaticImageLoadImage(sen_kart_2,"kart/"..kart_2..".png")
        guiSetPosition(sen_kart_1,0.055,0.2,true)
        guiSetPosition(sen_kart_2,0.58,0.2,true)
        oyuncu_kart_hesapla(kart_1,sen_top_yazi)
        oyuncu_kart_hesapla(kart_2,sen_top_yazi)
        guiSetEnabled(gui.kart_iste,true)
        guiSetEnabled(gui.pas,true)
    end
end
function diger_kart_goster_c(kart_1,kart_2,durum)
    if durum then 
        guiSetVisible(diger_oy_w,true)
        guiSetText(sen_top_yazi,0)
        guiSetPosition(diger_oy_w,0.22,0.55,true)
        guiStaticImageLoadImage(diger_oy_kart_1,"kart/"..kart_1..".png")
        guiStaticImageLoadImage(diger_oy_kart_2,"kart/"..kart_2..".png")
        guiSetPosition(diger_oy_kart_1,0.055,0.2,true)
        guiSetPosition(diger_oy_kart_2,0.58,0.2,true)
        diger_kart_hesapla(kart_1,diger_top_yazi)
        diger_kart_hesapla(kart_2,diger_top_yazi)
    else
        guiSetVisible(diger_oy_w,true)
        guiSetPosition(diger_oy_w,0.55,0.55,true)
        guiStaticImageLoadImage(diger_oy_kart_1,"kart/"..kart_1..".png")
        guiStaticImageLoadImage(diger_oy_kart_2,"kart/"..kart_2..".png")
        guiSetPosition(diger_oy_kart_1,0.055,0.2,true)
        guiSetPosition(diger_oy_kart_2,0.58,0.2,true)
        diger_kart_hesapla(kart_1,diger_top_yazi)
        diger_kart_hesapla(kart_2,diger_top_yazi)
    end
end

function diger_kart_hesapla(kart,metin,oy_2)
    for k,v in ipairs(kart_puan) do 
        local kart_isim,kart_puan = unpack(v)
        if kart_isim == kart then 
            if string.find(kart_isim,"_a",1,true) then
                local gecici_top = diger_kart_puan + kart_puan 
                if gecici_top >= 22 then 
                    diger_kart_puan = diger_kart_puan + 1
                else
                    diger_kart_puan = diger_kart_puan + kart_puan 
                end
            else
                diger_kart_puan = diger_kart_puan + kart_puan
            end
            guiSetText(metin,diger_kart_puan)
            break
        end
    end
end

function diger_kart_hesapla_k(kart,metin)
    local diger_kart_puan_k = getElementData(localPlayer,"kurpiyer_puan")
    if diger_kart_puan_k then 
    else 
        diger_kart_puan_k  = 0 
    end
    for k,v in ipairs(kart_puan) do 
        local kart_isim,kart_puan = unpack(v)
        if kart_isim == kart then 
            if string.find(kart_isim,"_a",1,true) then
                local gecici_top = diger_kart_puan_k + kart_puan 
                if gecici_top >= 22 then 
                    diger_kart_puan_k = diger_kart_puan_k + 1
                else
                    diger_kart_puan_k = diger_kart_puan_k + kart_puan 
                end
            else
                diger_kart_puan_k = diger_kart_puan_k + kart_puan
            end
            guiSetText(metin,diger_kart_puan_k)
            return diger_kart_puan_k 
        end
    end
end

function oyuncu_kart_hesapla(kart,metin)
    local oyuncu_kart_puan = getElementData(localPlayer,"meta_bj_kp")
    if not oyuncu_kart_puan then oyuncu_kart_puan = 0 end
    for k,v in ipairs(kart_puan) do 
        local kart_isim,kart_puan = unpack(v)
        if kart_isim == kart then 
            if string.find(kart_isim,"_a",1,true) then
                local gecici_top = oyuncu_kart_puan + kart_puan 
                if gecici_top >= 22 then 
                    oyuncu_kart_puan = oyuncu_kart_puan + 1
                else
                    oyuncu_kart_puan = oyuncu_kart_puan + kart_puan 
                end
            else
                oyuncu_kart_puan = oyuncu_kart_puan + kart_puan;
            end
            setElementData(localPlayer,"meta_bj_kp",oyuncu_kart_puan)
            guiSetText(metin,oyuncu_kart_puan)
            if oyuncu_kart_puan > 21 then 
                exports["meta-info"]:sendClientMessage("Battın!","warning")
                guiSetEnabled(gui.kart_iste,false)
                guiSetEnabled(gui.pas,false)
            end
            break
        end
    end
end

function yeni_kart_ver(kart)
    guiSetPosition(sen_kart_2,0.115,0.2,true)
    local gui_tablo = getElementData(localPlayer,"yeni_kartlar_bj")
    if not gui_tablo then gui_tablo= {} end
    local a = 1
    local x = 0.215
    for k,v in pairs(gui_tablo) do 
        a = a + 1
        x = x + 0.1
    end
    gui_tablo[a] = guiCreateStaticImage(x,0.2,0.35,0.65,"kart/"..kart..".png",true,sen_w)
    setElementData(localPlayer,"yeni_kartlar_bj",gui_tablo)
    oyuncu_kart_hesapla(kart,sen_top_yazi)
end

function kurpiyer_2_kart_goster(oy_2)
    guiSetEnabled(gui.kart_iste,false)
    guiSetEnabled(gui.pas,false)
    guiStaticImageLoadImage(kurpiyer_kart_2,"kart/"..kurpiyer_y_kart_2..".png")
    local diger_kart_puan_l = diger_kart_hesapla_k(kurpiyer_y_kart_2,kurpiyer_top_yazi,oy_2)
    setElementData(localPlayer,"kurpiyer_puan",diger_kart_puan_l)
    if oy_2 then 
        setElementData(oy_2,"kurpiyer_puan",diger_kart_puan_l)
    end
end

function oyun_bitti_c(diger_oy)
    setTimer(function()
        local tablo_1 = getElementData(localPlayer,"yeni_kartlar_bj")
        local tablo_3 = getElementData(localPlayer,"kurpiyer_kartlar_bj")
        if diger_oy then 
            local tablo_2 = getElementData(diger_oy,"yeni_kartlar_bj")
        end
        if tablo_1 then 
            for k,v in pairs(tablo_1) do
                destroyElement(v)
            end
        end
        if tablo_2 then 
            for k,v in pairs(tablo_2) do
                destroyElement(v)
            end
        end
        if tablo_3 then 
            for k,v in pairs(tablo_3) do
                destroyElement(v)
            end
        end
        guiSetVisible(sen_w,false)
        guiSetVisible(kurpiyer_w,false)
        guiSetVisible(diger_oy_w,false)
        guiSetText(kurpiyer_top_yazi,"0")
        guiSetText(sen_top_yazi,"0")
        guiSetText(diger_oy_top_yazi,"0")
        diger_kart_puan = 0
        guiSetEnabled(gui.ayril,true)
    end,2000,1)
end

function kurpiyer_yeni_kart(kart)
    guiSetPosition(kurpiyer_kart_2,0.115,0.2,true)
    local gui_tablo = getElementData(localPlayer,"kurpiyer_kartlar_bj")
    if not gui_tablo then gui_tablo= {} end
    local a = 1
    local x = 0.215
    for k,v in pairs(gui_tablo) do 
        a = a + 1
        x = x + 0.1
    end
    gui_tablo[a] = guiCreateStaticImage(x,0.2,0.35,0.65,"kart/"..kart..".png",true,kurpiyer_w)
    setElementData(localPlayer,"kurpiyer_kartlar_bj",gui_tablo)
    local diger_kart_puan_l_1 = diger_kart_hesapla_k(kart,kurpiyer_top_yazi)
    setElementData(localPlayer,"kurpiyer_puan",diger_kart_puan_l_1)
end

addEvent("kurpiyer_yeni_kart",true)
addEventHandler("kurpiyer_yeni_kart",localPlayer,kurpiyer_yeni_kart)

addEvent("oyun_bitti_bj",true)
addEventHandler("oyun_bitti_bj",localPlayer,oyun_bitti_c)


addEvent("kurpiyer_2_kart",true)
addEventHandler("kurpiyer_2_kart",localPlayer,kurpiyer_2_kart_goster)

addEvent("meta_bj_kart_ver",true)
addEventHandler("meta_bj_kart_ver",localPlayer,yeni_kart_ver)


addEvent("kart_goster_oy_2",true)
addEventHandler("kart_goster_oy_2",localPlayer,diger_kart_goster_c)

addEvent("kart_goster_oy_1",true)
addEventHandler("kart_goster_oy_1",localPlayer,sen_kart_goster_c)

addEvent("kart_goster_kurpiyer",true)
addEventHandler("kart_goster_kurpiyer",localPlayer,kurpiyer_kart_goster_c)

addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma_kart_c)
