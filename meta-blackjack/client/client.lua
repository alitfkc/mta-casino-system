local geri_sayim_sure = oyun_baslatma_sure_m /1000
local r_r,r_b,r_g = 0,255,0
local ses = 101 
local ekrang,ekrany = guiGetScreenSize()
function tus_engel(button, press) -- oyuncu herhangi bir tuşa bastığında
    for i,v in pairs(butons) do -- butons tablosunu döndür
       local veri, tus = unpack(v) -- tablodaki verileri dğeişkene koy
       if tus[button] then -- eğer basılan uton tusların içinde varsa ve oyuncunun datası bellirtilen data ise
          cancelEvent() -- iptal et
       end
    end      
end

function sureKontrol(sure)
    local sure = tonumber(sure)
    if sure <= 0 then
        return false
    else
        local gun = math.floor(sure/86400)
        local saat = string.format("%01.f", math.floor(sure/3600 - (gun*24)))
        local dakika = string.format("%01.f", math.floor(sure/60 - (gun*24 + saat)*60))
        local saniye = string.format("%01.f", math.floor(sure %60 ))
        if tonumber(gun) >= 1 then
            return gun.." Gün "..saat.." Saat "..dakika.." Dakika "..saniye.." Saniye"
        elseif tonumber(saat) >= 1 then
            return saat.." Saat "..dakika.." Dakika "..saniye.." Saniye"
        elseif tonumber(dakika) >= 1 then
            return dakika.." Dakika "..saniye.." Saniye"
        elseif tonumber(saniye) >= 0 then
            return saniye
        end
    end
end
function geri_sayim()
    if geri_sayim_sure > 0 then
        if geri_sayim_sure < 11  and geri_sayim_sure > 6 then 
            r_r,r_b,r_g = 255,255,0
            ses = 14
        elseif geri_sayim_sure < 6  and geri_sayim_sure > 4 then 
            r_r,r_b,r_g = 155,00,0
            ses = 9
        elseif geri_sayim_sure < 4  and geri_sayim_sure > 0 then 
            r_r,r_b,r_g = 255,00,0
            ses = 9
        end
        playSoundFrontEnd(ses)
        geri_sayim_sure = geri_sayim_sure -1 
    else
        if isTimer(geri_sayim_timer) then 
            killTimer(geri_sayim_timer)
        end
        --geri_sayim_sure = 15
        r_r,r_b,r_g = 0,255,0
        ses = 101
        removeEventHandler("onClientRender",root,render_geri_sayim)
    end
end
function geri_sayim_c()
    geri_sayim_sure = oyun_baslatma_sure_m/1000
    guiSetEnabled(gui.ayril,false)
    geri_sayim_timer = setTimer(geri_sayim,1000,0)
    playSoundFrontEnd(ses)
    addEventHandler("onClientRender",root,render_geri_sayim)
end
function geri_sayim_y(sonuc)
    sonuc = sonuc/1000
    geri_sayim_sure = geri_sayim_sure - sonuc
    if geri_sayim_sure < 0 then 
    else
        geri_sayim_timer = setTimer(geri_sayim,1000,0)
        playSoundFrontEnd(ses)
        addEventHandler("onClientRender",root,render_geri_sayim)
    end
end
function ara_sayim_c()
    setTimer(function()
        geri_sayim_sure = oyun_ara_sure_m/1000
        geri_sayim_timer = setTimer(geri_sayim,1000,0)
        playSoundFrontEnd(ses)
        addEventHandler("onClientRender",root,render_geri_sayim)
    end,1000,1)
end
function render_geri_sayim()
    geri_sayim_sure_n = sureKontrol(geri_sayim_sure)
    if geri_sayim_sure_n == false then 
        removeEventHandler("onClientRender", root, render_geri_sayim)
        if isTimer(geri_sayim_timer) then 
            killTimer(geri_sayim_timer)
        end
    end
    dxDrawImage((ekrang-50)/2-7,40-2,65,60,"resimler/panel.png")
    dxDrawText(geri_sayim_sure_n or 0,ekrang,40,0,0,tocolor(r_r,r_b,r_g),4,4,"default-bold","center")
end
function kapat()
    if isTimer(geri_sayim_timer) then 
        killTimer(geri_sayim_timer)
    end
    geri_sayim_sure = 15
    r_r,r_b,r_g = 0,255,0
    ses = 101
    removeEventHandler("onClientRender",root,render_geri_sayim)
end

addEvent("kapat",true)
addEventHandler("kapat",localPlayer,kapat)
addEvent("sure_baslat_bj_y",true)
addEventHandler("sure_baslat_bj_y",localPlayer,geri_sayim_y)
addEvent("geri_sayim_bj",true)
addEventHandler("geri_sayim_bj",localPlayer,geri_sayim_c)

addEvent("ara_sayim_bj",true)
addEventHandler("ara_sayim_bj",localPlayer,ara_sayim_c)