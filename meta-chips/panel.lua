local butonlar = {}
local sayilar = {1,2,3,4,5,6,7,8,9,0}
local satma_alma_durum = ""
local function sistem_calisma()
    ekranh,ekrany = guiGetScreenSize()
    panel = guiCreateWindow(20,(ekrany-180)/2,400,180,"Meta Çip Alma",false)
    panel_logo = guiCreateStaticImage(10,25,125,145,"resimler/logo.png",false,panel)
    yazi_1 = guiCreateLabel(155,25,80,30,"Meta Çip",false,panel)
    guiSetFont(yazi_1,"default-bold-small")
    para_yazi = guiCreateLabel(210,25,72,30,coin_fiyat.."$",false,panel)
    guiSetFont(para_yazi,"default-bold-small")
    guiLabelSetColor(para_yazi,0,255,0)
    yazi_3 = guiCreateLabel(272,25,80,30,"Vergi Miktarı ",false,panel)
    guiSetFont(yazi_3,"default-bold-small")
    vergi_yazi = guiCreateLabel(348,25,72,30,"%"..vergi,false,panel)
    guiSetFont(vergi_yazi,"default-bold-small")
    guiLabelSetColor(vergi_yazi,0,255,0)
    yazi_2 = guiCreateLabel(145,50,215,20,"Almak/Satmak İstediğiniz Çip Miktarı.",false,panel)
    butonlar.satma__alma_edit = guiCreateEdit(185,70,145,25,"",false,panel)
    butonlar.satin_al_buton = guiCreateButton(185,103,145,25,"Meta Çip Al",false,panel)
    butonlar.sat_buton = guiCreateButton(185,135,145,25,"Meta Çip Sat",false,panel)

    onaylama_panel = guiCreateWindow((ekranh-300)/2,(ekrany-140)/2,300,140,"Meta Çip Alma",false)
    onay_yazi = guiCreateLabel(0,30,300,30,"30 $ 10 Meta Çip Dönüştürülecek.",false,onaylama_panel)
    guiSetFont(onay_yazi,"default-bold-small")
    guiLabelSetColor(onay_yazi,0,255,0)
    guiLabelSetHorizontalAlign(onay_yazi,"center")
    onay_yazi_1 = guiCreateLabel(0,60,300,30,"Bu işlemi onaylıyor musunuz.",false,onaylama_panel)
    guiSetFont(onay_yazi_1,"default-bold-small")
    guiLabelSetColor(onay_yazi_1,255,0,0)
    guiLabelSetHorizontalAlign(onay_yazi_1,"center")
    butonlar.onay_buton = guiCreateButton(70,90,160,30,"Onaylıyorum",false,onaylama_panel)
    guiSetVisible(onaylama_panel,false)
    guiSetVisible(panel,false)
    for k,v in pairs(butonlar) do 
        addEventHandler("onClientGUIClick",v,butona_basma)
    end
end
function butona_basma()
    if source == butonlar.satin_al_buton then
        if guiGetVisible(onaylama_panel) then 
            guiSetVisible(onaylama_panel,false)
        end
        local yazi = guiGetText(butonlar.satma__alma_edit)
        if yazi == "" then 
            exports["meta-info"]:sendClientMessage("Miktar giriniz.","error")
            return
        end
        yazi = tonumber(yazi)
        if yazi < 0 then return  exports["meta-info"]:sendClientMessage("0'ın altında değer girilmez!","error") end
        if type(yazi) == "number" then 
        else
            exports["meta-info"]:sendClientMessage("Hatalı miktar!","error")
            guiSetText(butonlar.satma__alma_edit,"")
            return
        end
        local fiyat = yazi * coin_fiyat 
        vergi_miktar = fiyat * vergi/100
        fiyat = fiyat + vergi_miktar
        fiyat = math.floor(fiyat)
        guiSetText(onay_yazi,fiyat.." $'a "..yazi.." Meta Çip alacaksınız.")
        guiSetVisible(onaylama_panel,true)
        satma_alma_durum  = "al"
    elseif source == butonlar.sat_buton then
        if guiGetVisible(onaylama_panel) then 
            guiSetVisible(onaylama_panel,false)
        end
        local yazi = guiGetText(butonlar.satma__alma_edit)
        if yazi == "" then 
            exports["meta-info"]:sendClientMessage("Miktar giriniz.","error")
            return
        end
        yazi = tonumber(yazi)
        if yazi < 0 then return  exports["meta-info"]:sendClientMessage("0'ın altında değer girilmez!","error") end
        if type(yazi) == "number" then 
        else
            exports["meta-info"]:sendClientMessage("Hatalı miktar!","error")
            guiSetText(butonlar.satma__alma_edit,"")
            return
        end
        local fiyat = yazi * coin_fiyat 
        vergi_miktar = fiyat * vergi/100
        fiyat = fiyat - vergi_miktar
        fiyat = math.floor(fiyat)
        guiSetText(onay_yazi,yazi.." Meta Çip'i "..fiyat.." $'a satacaksınız.")
        guiSetVisible(onaylama_panel,true)
        satma_alma_durum  = "sat"
    elseif source == butonlar.onay_buton then
        local yazi = guiGetText(butonlar.satma__alma_edit)
        triggerServerEvent("cip_alisveris",localPlayer,satma_alma_durum,yazi)
        guiSetVisible(onaylama_panel,false)
    elseif source == butonlar.satma__alma_edit then
        guiSetText(butonlar.satma__alma_edit,"") 
        if guiGetVisible(onaylama_panel) then 
            guiSetVisible(onaylama_panel,false)
        end
    end
end
function panel_ac(durum)
    if guiGetVisible(onaylama_panel) then 
        guiSetVisible(onaylama_panel,false)
    end
    if durum then 
        guiSetVisible(panel,true)
        showCursor(true)
    else
        guiSetVisible(panel,false)
        guiSetVisible(onaylama_panel,false)
        showCursor(false)
    end
end
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)
addEvent("chip_panel_ac",true)
addEventHandler("chip_panel_ac",localPlayer,panel_ac) 

-------------
--ÜST BAR
-------------
function ust_bar()
    if getElementInterior(localPlayer) == 10 then 
        local ox,oy,oz = getElementPosition(localPlayer)
        if ox >= 1926 and ox <= 2027 and oy >= 958  and oy <= 1078 then
            local cip = getElementData(localPlayer,"meta_cip")
            if cip == false then 
                cip = 0 
            end
            if cip  then 
                dxDrawImage((ekranh-32)/2,0,32,32,"resimler/chip_icon.png")
                dxDrawText(tostring(cip),(ekranh-45)/2+45+1,4,95,95,tocolor(0,0,0,255),1.5,"default-bold")
                dxDrawText(tostring(cip),(ekranh-45)/2+45,5,95,95,tocolor(255,0,0,255),1.5,"default-bold")
            end
        end
    end
end
addEventHandler("onClientRender",root,ust_bar)