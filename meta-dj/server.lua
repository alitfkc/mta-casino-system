secilen_radyo = "http://91.121.59.45:8394/stream"
ses_seviye=40
function secilen_radyo_kontrol()
    if secilen_radyo == "" then 
        triggerClientEvent("radyo_kontrol_edildi",source,false,ses_seviye)
    else
        triggerClientEvent("radyo_kontrol_edildi",source,secilen_radyo,ses_seviye)
    end
end

function panel(thePlayer)
    local hesap = getAccountName ( getPlayerAccount ( thePlayer ) ) -- Oyuncunun hesabını çektik,
        if isObjectInACLGroup ("user."..hesap, aclGetGroup ( meta_muzik_acma_yetki ) ) then -- Eğer oyuncunun hesabı PanelYetki grubunda ise
          triggerClientEvent(thePlayer, "panelAc" ,thePlayer) -- Clientteki işlemleri yap
       else -- Değilse
          outputChatBox("Bu paneli açmaya yetkiniz yok.", thePlayer,255,0,0,true) -- Sohbete "Bu paneli açmaya yetkiniz yok.." yazısını at.
       end
    end
addCommandHandler ( meta_muzik_acma_komut, panel ) -- Panel açma komutu

function sarki_degis(link)
    secilen_radyo = link
    triggerClientEvent("sarki_degistir_s",root,link,ses_seviye)
end

function ses_degistir(durum)
    if durum == "+" then 
        ses_seviye = ses_seviye + 1
        if ses_seviye >= 101 then 
            ses_seviye = 100
        end
        triggerClientEvent("ses_degistir_s",root,ses_seviye)
    else
        ses_seviye = ses_seviye - 1
        if ses_seviye <= -1 then 
            ses_seviye = 0
        end
        triggerClientEvent("ses_degistir_s",root,ses_seviye)
    end 
end
function ses_kapat()
    triggerClientEvent("ses_kapat_s",root)
end

addEvent("sarki_degis",true)
addEventHandler("sarki_degis",root,sarki_degis)

addEvent("ses_degis",true)
addEventHandler("ses_degis",root,ses_degistir)


addEvent("ses_kapat",true)
addEventHandler("ses_kapat",root,ses_kapat)

addEvent("radyo_kontrol",true)
addEventHandler("radyo_kontrol",root,secilen_radyo_kontrol)

