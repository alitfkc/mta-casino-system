gui = {}
mark ={}
mayinlar = {"❁",1,2,3,5,1,"❁",6,"❁",8,2,"❁",6,1,4,"❁",5,7,9,"❁",6,2}
makinalar = {
    --{x,y,z,dimens,interior,rz,scale}
    {1966.59692, 1004.62439, 992.4744,0,10,266,0.5},
    {1966.57617, 1005.49969, 992.47449,0,10,266,0.5},
    {1966.59888, 1006.29425, 992.47449,0,10,266,0.5},
    {1966.59888, 1007.29425, 992.47449,0,10,266,0.5},
    {1966.59888, 1008.0425, 992.47449,0,10,266,0.5},

    {1969.5485, 1004.62439, 992.4744,0,10,86,0.5},
    {1969.5485, 1005.49969, 992.47449,0,10,86,0.5},
    {1969.5485, 1006.29425, 992.47449,0,10,86,0.5},
    {1969.5485, 1007.29425, 992.47449,0,10,86,0.5},
    {1969.5485, 1008.0425, 992.47449,0,10,86,0.5},

    {1969.5485, 1012.38104, 992.4744,0,10,86,0.5},
    {1969.5485, 1013.19969, 992.47449,0,10,86,0.5},
    {1969.5485, 1014.04425, 992.47449,0,10,86,0.5},
    {1969.5485, 1014.87425, 992.47449,0,10,86,0.5},
    {1969.5485, 1015.78425, 992.47449,0,10,86,0.5},

    {1966.59692, 1012.38104, 992.4744,0,10,266,0.5},
    {1966.59692, 1013.19969, 992.47449,0,10,266,0.5},
    {1966.59692, 1014.04425, 992.47449,0,10,266,0.5},
    {1966.59692, 1014.87425, 992.47449,0,10,266,0.5},
    {1966.59692, 1015.78425, 992.47449,0,10,266,0.5},
    
    
}
local kazanc_deger = 0
local function sistem_calisma()
    local ekranh,ekrany = guiGetScreenSize()
    panel = guiCreateWindow((ekranh-805)/2,(ekrany-650)/2,805,650,"Meta Mayın Tarlası",false)
    local px,py = 20,30
    a = 1
    while (a < 141) do
        a = a + 1 
        b = guiCreateButton(px,py,50,50,"",false,panel,"1f1b1a","ff0000",255,255,255)
        gui[b] = b
        if px >= 715 then
            px = 20 
            py = py + 55
        else
            px = px + 55
        end
    end
    aciklama = guiCreateLabel(20,580,300,100,"Her buton 3 Çip Alır. \nHer butondan çıkan rakamlar toplanır.\nMayın'a tıklarsanız tüm kazanç sıfırlanır!\nİstediğiniz zaman çekebilirsiniz.",false,panel)
    guiSetFont(aciklama,"default-bold-small")
    guiLabelSetColor(aciklama,255,0,0)
    aciklama_2 = guiCreateLabel(270,590,250,100,"Kazanç 15'den sonra her değer 2x olur.\nKazanç 30'dan sonra her değer 3x olur.\nKazanç 50'den sonra her değer 4x olur.",false,panel)
    guiSetFont(aciklama_2,"default-bold-small")
    guiLabelSetColor(aciklama_2,0,255,0)
    cek_buton = guiCreateButton(660,590,125,50,"Çipleri Çek",false,panel,"1f1b1a","ff0000",0,255,0)
    guiSetProperty(cek_buton,"NormalTextColour","FF00FF00")
    kazanc_metin = guiCreateLabel(520,605,125,50,"Kazanç = ",false,panel)
    guiSetFont(kazanc_metin,"default-bold-small")
    kazanc = guiCreateLabel(575,605,125,50,"0 Çip",false,panel)
    guiSetFont(kazanc,"default-bold-small")
    guiLabelSetColor(kazanc,0,255,0)
    for k,v in pairs(gui) do 
        addEventHandler("onClientGUIClick",v,buton_basma)
    end
    addEventHandler("onClientGUIClick",cek_buton,odul_cek)
    guiSetVisible(panel,false)
    for k,v in pairs(makinalar) do 
        mark[k] = createMarker(makinalar[k][1],makinalar[k][2],makinalar[k][3],"cylinder",makinalar[k][7],255,0,0,255)
        setElementInterior(mark[k],makinalar[k][5])
        setElementDimension(mark[k],makinalar[k][4])
        addEventHandler("onClientMarkerHit",mark[k],panel_acma)
        setElementData(mark[k],"meta_rot",makinalar[k][6])
    end
end
function odul_cek()
    if source == cek_buton then
        if kazanc_deger >= 1 then
            exports["meta-info"]:sendClientMessage(kazanc_deger.." Çip kazandınız.","success")
            exports["meta-vipbonus"]:bonus_ver_client(localPlayer,kazanc_deger)
            local coin = getElementData(localPlayer,"meta_cip")
            local coin = coin + kazanc_deger
            setElementData(localPlayer,"meta_cip",coin)
            kazanc_deger = 0
            guiSetText(kazanc,kazanc_deger.." Çip")
            triggerServerEvent("mayin_anim",localPlayer,"Slot_win_out")
            playSound("sesler/kazanma.ogg")
            for k,v in pairs(gui) do 
                local sonuc = math.random(1,22)
                sonuc = mayinlar[sonuc]
                local yazi_1 = guiGetText(v)
                if yazi_1 == "" then
                    guiSetText(v,sonuc)
                end
                guiSetEnabled(v,false)
            end
            setTimer(function ()
                for k,v in pairs(gui) do 
                    guiSetText(v,"")
                    guiSetEnabled(v,true)
                    kazanc_deger = 0
                    guiSetText(kazanc,kazanc_deger.." Çip")
                end
            end,1500,1)
        end
    end
end
local tick_buton = 0
function buton_basma()
    if ((getTickCount() - tick_buton) <= 500 ) then return end 
    if source == panel then return end
    if not gui[source] then return end
    if guiGetText(source) ~= "" then return end
    local coin = getElementData(localPlayer,"meta_cip")
    if coin < 3 then  exports["meta-info"]:sendClientMessage("Yetersiz Bakiye!","error") return end 
	local coin = coin - 3
    setElementData(localPlayer,"meta_cip",coin)
    local sonuc = math.random(1,20)
    sonuc = mayinlar[sonuc]
    guiSetText(source,sonuc)
    guiSetEnabled(source,false) 
    triggerServerEvent("mayin_anim",localPlayer,"Slot_bet_02")
    buton_ses = playSound("sesler/basma.mp3")
    if sonuc == "❁" then
        exports["meta-info"]:sendClientMessage("BOMMM!!!","info")
        kazanc_deger = 0
        guiSetText(kazanc,kazanc_deger.." Çip") 
        tick_buton = getTickCount()
        triggerServerEvent("mayin_anim",localPlayer,"Slot_lose_out")
        if buton_ses then
            stopSound(buton_ses)
            buton_ses = nil
        end
        playSound("sesler/patlama.mp3")
        for k,v in pairs(gui) do 
            local sonuc = math.random(1,20)
            sonuc = mayinlar[sonuc]
            local yazi_1 = guiGetText(v)
            if yazi_1 == "" then
                guiSetText(v,sonuc)
            end
            guiSetEnabled(v,false)
        end
        setTimer(function ()
            for k,v in pairs(gui) do 
                guiSetText(v,"")
                guiSetEnabled(v,true)
            end
        end,1500,1)
        return
    end
    if kazanc_deger >= 50 then
        sonuc = sonuc * 4
    elseif kazanc_deger >= 30 then
        sonuc = sonuc * 3
    elseif kazanc_deger >= 15 then
        sonuc = sonuc * 2
    end
    kazanc_deger = kazanc_deger + sonuc
    guiSetText(kazanc,kazanc_deger.." Çip")
    tick_buton = getTickCount()
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
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)