function yatirma_kontrol(bahis)
    local oyuncu_marker = getElementData(source,"oyuncu_bj_marker")
    local marker_isim = getElementData(oyuncu_marker,"marker_isim")
    for k,v in ipairs(markerler) do 
        if marker_isim == markerler[k][1] then 
            local durum = t_c_kontrol(k)
            if durum == "çift" then 
                if markerler[k-1][8] then  --2 kişi
                    if markerler[k][18] or markerler[k-1][18] then 
                        exports["meta-info"]:sendServerMessage("Bahisler kapalı sonraki turu bekle!","error",source)
                    else --OYUN BAŞLAMADIYSA
                        if not markerler[k][19] then 
                            if  markerler[k][19] then 
                                markerler[k][19] = true
                                markerler[k-1][19] = true
                                oyun_baslama = setTimer(baslatma_sure,oyun_baslatma_sure_m,1,source,markerler[k-1][9],k,"çift")
                                setElementData(oyuncu_marker,"m_oyun_baslama",oyun_baslama)
                                triggerClientEvent("geri_sayim_bj",source)
                                triggerClientEvent("geri_sayim_bj",markeler[k-1][9])
                                --TİMER gönderilen veriler YATIRAN OYUNCU , 2 OYUNCU , K DEĞERİ 
                            end
                        end
                        local oyuncu_bahis = getElementData(source,"meta_bj_bahis")
                        if oyuncu_bahis then 
                            oyuncu_bahis = oyuncu_bahis + bahis
                        else
                            oyuncu_bahis =  bahis
                        end
                        setElementData(source,"meta_bj_bahis",oyuncu_bahis)
                    end
                else                 --1 kişi
                    if markerler[k][18] then 
                        exports["meta-info"]:sendServerMessage("Bahisler kapalı sonraki turu bekle!","error",source)
                    else --OYUN BAŞLAMADIYSA
                        if not markerler[k][19] then 
                            markerler[k][19] = true
                            markerler[k-1][19] = true
                            oyun_baslama = setTimer(baslatma_sure,oyun_baslatma_sure_m,1,source,false,k,"çift")
                            setElementData(oyuncu_marker,"m_oyun_baslama",oyun_baslama)
                            triggerClientEvent("geri_sayim_bj",source)
                            --TİMER gönderilen veriler YATIRAN OYUNCU , 2 OYUNCU , K DEĞERİ 
                        end
                        local oyuncu_bahis = getElementData(source,"meta_bj_bahis")
                        if oyuncu_bahis then 
                            oyuncu_bahis = oyuncu_bahis + bahis
                        else
                            oyuncu_bahis =  bahis
                        end
                        setElementData(source,"meta_bj_bahis",oyuncu_bahis)
                    end
                end
            elseif durum == "tek" then 
                if markerler[k+1][8] then --2 kişi
                    if markerler[k][18] then 
                        exports["meta-info"]:sendServerMessage("Bahisler kapalı sonraki turu bekle!","error",source)
                    else --OYUN BAŞLAMADIYSA
                        if not markerler[k][19] then 
                            markerler[k][19] = true
                            markerler[k+1][19] = true
                            oyun_baslama = setTimer(baslatma_sure,oyun_baslatma_sure_m,1,source,markerler[k+1][9],k,"tek")
                            setElementData(oyuncu_marker,"m_oyun_baslama",oyun_baslama)
                            triggerClientEvent("geri_sayim_bj",source)
                            triggerClientEvent("geri_sayim_bj",markerler[k+1][9])
                            --TİMER gönderilen veriler YATIRAN OYUNCU , 2 OYUNCU , K DEĞERİ 
                        end
                        local oyuncu_cip = getElementData(source,"meta_cip")
                        if oyuncu_cip >= bahis then 
                            local oyuncu_bahis = getElementData(source,"meta_bj_bahis")
                            if oyuncu_bahis then 
                                oyuncu_bahis = oyuncu_bahis + bahis
                            else
                                oyuncu_bahis =  bahis
                            end
                            setElementData(source,"meta_bj_bahis",oyuncu_bahis)
                            oyuncu_cip = oyuncu_cip - bahis
                            setElementData(source,"meta_cip",oyuncu_cip)
                        end
                    end
                else                       --1kişi
                    if markerler[k][18] then 
                        exports["meta-info"]:sendServerMessage("Bahisler kapalı sonraki turu bekle!","error",source)
                    else -- OYUN BAŞLAMADIYSA
                        local oyuncu_cip = getElementData(source,"meta_cip")
                        if oyuncu_cip >= bahis then 
                            if not markerler[k][19] then 
                                markerler[k][19] = true
                                markerler[k+1][19] = true
                                oyun_baslama = setTimer(baslatma_sure,oyun_baslatma_sure_m,1,source,false,k,"tek")
                                setElementData(oyuncu_marker,"m_oyun_baslama",oyun_baslama)
                                triggerClientEvent("geri_sayim_bj",source)
                                markerler[k][20] = getTickCount()
                                markerler[k+1][20] = getTickCount()
                                --TİMER gönderilen veriler YATIRAN OYUNCU , 2 OYUNCU , K DEĞERİ 
                            end
                            local oyuncu_bahis = getElementData(source,"meta_bj_bahis")
                            if oyuncu_bahis then 
                                oyuncu_bahis = oyuncu_bahis + bahis
                            else
                                oyuncu_bahis =  bahis
                            end
                            setElementData(source,"meta_bj_bahis",oyuncu_bahis)
                            oyuncu_cip = oyuncu_cip - bahis
                            setElementData(source,"meta_cip",oyuncu_cip)
                        else
                            exports["meta-info"]:sendServerMessage("Yetersiz Bakiye!","error",source)
                        end
                    end
                end
            end
        end
    end
end
function baslatma_sure(oy_1,oy_2,k,t_c_durum)

    if t_c_durum == "tek" then 
        markerler[k][18] = true
        markerler[k+1][18] = true
        local oyuncu_marker = getElementData(oy_1,"oyuncu_bj_marker")
        local kurpiyer_kart_tablo = getElementData(oyuncu_marker,"marker_kurpiyer_kart")
        if markerler[k+1][8] then 
            local oyuncu_marker_2 = getElementData(markerler[k+1][9],"oyuncu_bj_marker")
            local kurpiyer_kart_2 = getElementData(oyuncu_marker,"marker_kurpiyer_kart")
        end
    else
        markerler[k][18] = true
        markerler[k-1][18] = true
        local oyuncu_marker = getElementData(oy_1,"oyuncu_bj_marker")
        local kurpiyer_kart_tablo = getElementData(oyuncu_marker,"marker_kurpiyer_kart")
        if markerler[k-1][8] then 
            local oyuncu_marker_2 = getElementData(markerler[k-1][9]"oyuncu_bj_marker")
            local kurpiyer_kart_tablo_2 = getElementData(oyuncu_marker_2,"marker_kurpiyer_kart")
        end
    end
    local oyun_kartlari = {}
    kurpiyer_kart_tablo = kurpiyer_kart_tablo_2
    kurpiyer_kart_1 = rastgele_kart()
    kurpiyer_kart_2 = rastgele_kart()
    if kurpiyer_kart_tablo then 
    else
        kurpiyer_kart_tablo = {}
    end
    table.insert(oyun_kartlari,kurpiyer_kart_1)
    table.insert(oyun_kartlari,kurpiyer_kart_2)
    oy_1_kart_1 = rastgele_kart()
    oy_1_kart_2 = rastgele_kart()
    table.insert(oyun_kartlari,oy_1_kart_1)
    table.insert(oyun_kartlari,oy_1_kart_2)
    if t_c_durum == "çift" then --2 OYUNCUYA KART VERMEK İÇİN
        if markerler[k-1][8] then 
            oy_2_kart_1 = rastgele_kart()
            oy_2_kart_2 = rastgele_kart()
            local kart_durum = kart_kontrol(oyun_kartlari,oy_2_kart_1)
            if not kart_durum then
                oy_2_kart_1 =  kart_ayni_kart_degis(oyun_kartlari,oy_2_kart_1)
            end
            local kart_durum = kart_kontrol(oyun_kartlari,oy_2_kart_2)
            if not kart_durum then
                oy_2_kart_1 =  kart_ayni_kart_degis(oyun_kartlari,oy_2_kart_2)
            end
        end
    else
        if  markerler[k+1][8] then 
            oy_2_kart_1 = rastgele_kart()
            oy_2_kart_2 = rastgele_kart()
            local kart_durum = kart_kontrol(oyun_kartlari,oy_2_kart_1)
            if not kart_durum then
                oy_2_kart_1 =  kart_ayni_kart_degis(oyun_kartlari,oy_2_kart_1)
            end
            local kart_durum = kart_kontrol(oyun_kartlari,oy_2_kart_2)
            if not kart_durum then
                oy_2_kart_1 =  kart_ayni_kart_degis(oyun_kartlari,oy_2_kart_2)
            end
        end
    end

    if t_c_durum == "çift" then  --çiftse
        if markerler[k][8] then 
            triggerClientEvent("kart_goster_kurpiyer",oy_1,kurpiyer_kart_1,kurpiyer_kart_2)
            triggerClientEvent("kart_goster_oy_1",oy_1,oy_1_kart_1,oy_1_kart_2,true)
            if markerler[k-1][8] then 
                triggerClientEvent("kart_goster_oy_2",markerler[k-1][9],oy_1_kart_1,oy_1_kart_2,true)
            end
            setElementData(oy_1,"meta_bj_oyun_kartlari",oyun_kartlari)
            triggerClientEvent("ara_sayim_bj",oy_1)
        end
        if markerler[k-1][8] then 
            triggerClientEvent("kart_goster_kurpiyer",markeler[k-1][9],kurpiyer_kart_1,kurpiyer_kart_2)
            triggerClientEvent("kart_goster_oy_1",markerler[k-1][9],oy_2_kart_1,oy_2_kart_2,false)
            triggerClientEvent("kart_goster_oy_2",oy_1,oy_2_kart_1,oy_2_kart_2,false)
            setElementData(markerler[k-1][9],"meta_bj_oyun_kartlari",oyun_kartlari)
            triggerClientEvent("ara_sayim_bj",markerler[k-1][9])
        end
    else -- tekse
        if markerler[k][8] then 
            triggerClientEvent("kart_goster_kurpiyer",oy_1,kurpiyer_kart_1,kurpiyer_kart_2)
            triggerClientEvent("kart_goster_oy_1",oy_1,oy_1_kart_1,oy_1_kart_2,false)
            if markerler[k+1][8] then 
                triggerClientEvent("kart_goster_oy_2",markerler[k+1][9],oy_1_kart_1,oy_1_kart_2,false)
            end
            setElementData(oy_1,"meta_bj_oyun_kartlari",oyun_kartlari)
            triggerClientEvent("ara_sayim_bj",oy_1)
        end
        if markerler[k+1][8] then 
            triggerClientEvent("kart_goster_kurpiyer",markerler[k+1][9],kurpiyer_kart_1,kurpiyer_kart_2)
            triggerClientEvent("kart_goster_oy_1",markerler[k+1][9],oy_2_kart_1,oy_2_kart_2,true)
            triggerClientEvent("kart_goster_oy_2",oy_1,oy_2_kart_1,oy_2_kart_2,true)
            setElementData(markerler[k+1][9],"meta_bj_oyun_kartlari",oyun_kartlari)
            triggerClientEvent("ara_sayim_bj",markerler[k+1][9])
        end
    end
    
    timer_ara_sure = setTimer(ara_sure,oyun_ara_sure_m,1,oy_1,oy_2,k,t_c_durum)
    local oyuncu_marker = getElementData(oy_1,"oyuncu_bj_marker")
    setElementData(oyuncu_marker,"m_ara_sure",timer_ara_sure)

end
function oyunu_resle(oy_1,oy_2,k,t_c_durum)
    setTimer(function(oy_1,oy_2,k,t_c_durum)
        if oy_1 then 
            if getElementData(oy_1,"meta_bj_kp") then removeElementData(oy_1,"meta_bj_kp") end
            if getElementData(oy_1,"yeni_kartlar_bj") then removeElementData(oy_1,"yeni_kartlar_bj") end
            if getElementData(oy_1,"kurpiyer_kartlar_bj") then removeElementData(oy_1,"kurpiyer_kartlar_bj") end
            if getElementData(oy_1,"kurpiyer_puan") then removeElementData(oy_1,"kurpiyer_puan") end
        end
        if oy_2 then 
            if getElementData(oy_2,"meta_bj_kp") then removeElementData(oy_2,"meta_bj_kp") end
            if getElementData(oy_2,"yeni_kartlar_bj") then removeElementData(oy_2,"yeni_kartlar_bj") end
            if getElementData(oy_2,"kurpiyer_kartlar_bj") then removeElementData(oy_2,"kurpiyer_kartlar_bj") end
            if getElementData(oy_2,"kurpiyer_puan") then removeElementData(oy_2,"kurpiyer_puan") end
        end
        if t_c_durum == "çift" then 
            markerler[k][18] = false
            markerler[k][19] = false
            markerler[k][20] = 0
            markerler[k-1][18] = false
            markerler[k-1][19] = false
            markerler[k-1][20] = 0
        else
            markerler[k][18] = false
            markerler[k][19] = false
            markerler[k][20] = 0
            markerler[k+1][18] = false
            markerler[k+1][19] = false
            markerler[k+1][20] = 0
        end
    end,2500,1,oy_1,oy_2,k,t_c_durum)
end
function odullendir(oy_1,oy_2,k,t_c_durum)
    
    local oy_1_puan = -1
    local oy_2_puan = -1
    if t_c_durum == "çift" then 
        if markerler[k][8] then 
            oy_1_puan = getElementData(oy_1,"meta_bj_kp")
        end
        if markerler[k-1][8] then 
            oy_2_puan = getElementData(markerler[k-1][9] ,"meta_bj_kp")
        end
        if oy_1_puan > 21 then 
            oy_1_puan = 0
        end 
        if oy_2_puan > 21 then 
            oy_2_puan = 0
        end 
    else
        if markerler[k][8] then 
            oy_1_puan = getElementData(oy_1,"meta_bj_kp")
        end
        if markerler[k+1][8] then 
            oy_2_puan = getElementData(markerler[k+1][9],"meta_bj_kp")
        end
        if oy_1_puan > 21 then 
            oy_1_puan = 0
        end 
        if oy_2_puan > 21 then 
            oy_2_puan = 0
        end 
    end
    local kurpiyer_puan = getElementData(oy_1,"kurpiyer_puan")
    kurpiyer_puan = tonumber(kurpiyer_puan)
    if  kurpiyer_puan > oy_1_puan and kurpiyer_puan > oy_2_puan and kurpiyer_puan <= 21 then 
        if t_c_durum == "çift" then 
            if markerler[k][8] then 
                exports["meta-info"]:sendServerMessage("Kaybettiniz.","warning",oy_1)
                removeElementData(oy_1,"meta_bj_bahis")
                if markerler[k-1][8] then
                    triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k-1][9])
                    oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                else
                    triggerClientEvent("oyun_bitti_bj",oy_1,false)
                    oyunu_resle(oy_1,false,k,t_c_durum)
                end
            end
            if markerler[k-1][8] then 
                exports["meta-info"]:sendServerMessage("Kaybettiniz.","warning",markerler[k-1][9])
                removeElementData(markerler[k-1][9],"meta_bj_bahis")
                if markerler[k][8] then
                    triggerClientEvent("oyun_bitti_bj",markerler[k-1][9],oy_1)
                    oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                else
                    triggerClientEvent("oyun_bitti_bj",markerler[k-1][9],false)
                    oyunu_resle(false,markerler[k-1][9],k,t_c_durum)
                end
            end
        else
            if markerler[k][8] then 
                exports["meta-info"]:sendServerMessage("Kaybettiniz.","warning",oy_1)
                removeElementData(oy_1,"meta_bj_bahis")
                if markerler[k+1][8] then
                    triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k+1][9])
                    oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                else
                    triggerClientEvent("oyun_bitti_bj",oy_1,false)
                    oyunu_resle(oy_1,false,k,t_c_durum)
                end
            end
            if markerler[k+1][8] then 
                exports["meta-info"]:sendServerMessage("Kaybettiniz.","warning",markerler[k+1][9])
                removeElementData(markerler[k+1][9],"meta_bj_bahis")
                if markerler[k][8] then
                    triggerClientEvent("oyun_bitti_bj",markerler[k+1][9],oy_1)
                    oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                else
                    triggerClientEvent("oyun_bitti_bj",markerler[k+1][9],false)
                    oyunu_resle(false,markerler[k+1][9],k,t_c_durum)
                end
            end
        end
        return
    end
    if kurpiyer_puan < oy_1_puan and (oy_2_puan == -1 or kurpiyer_puan < oy_2_puan) then
        local y_kart = rastgele_kart()
        local oyun_kartlari = getElementData(oy_1,"meta_bj_oyun_kartlari")
        local kart_durum = kart_kontrol(oyun_kartlari,y_kart)
        if not kart_durum then
            kart =  kart_ayni_kart_degis(oyun_kartlari,y_kart)
        end
        triggerClientEvent("kurpiyer_yeni_kart",oy_1,kart)
        if t_c_durum == "çift" then 
            if markerler[k-1][8] then 
                triggerClientEvent("kurpiyer_yeni_kart",markerler[k-1][9],kart)
            end
        else
            if markerler[k+1][8] then 
                triggerClientEvent("kurpiyer_yeni_kart",markerler[k+1][9],kart)
            end
        end
    end
        setTimer(kart_al,500,1,oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
end
function kart_al(oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
    local kurpiyer_puan = getElementData(oy_1,"kurpiyer_puan")
    if kurpiyer_puan <= oy_1_puan then 
        setTimer(sanal_dongu,500,1,oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
    else
        setTimer(odullendir_2,500,1,oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
    end
end
function sanal_dongu(oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
    local kurpiyer_puan = getElementData(oy_1,"kurpiyer_puan")
    if kurpiyer_puan >= oy_1_puan then 
        setTimer(odullendir_2,500,1,oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
    else
        local y_kart = rastgele_kart()
        local oyun_kartlari = getElementData(oy_1,"meta_bj_oyun_kartlari")
        local kart_durum = kart_kontrol(oyun_kartlari,y_kart)
        while (not kart_durum) do 
            local kart_durum = kart_kontrol(oyun_kartlari,y_kart)
            if not kart_durum then
                y_kart =  kart_ayni_kart_degis(oyun_kartlari,y_kart)
            end
            break
        end
        triggerClientEvent("kurpiyer_yeni_kart",oy_1,y_kart)
        if t_c_durum == "çift" then 
            if markerler[k-1][8] then 
                triggerClientEvent("kurpiyer_yeni_kart",markerler[k-1][9],y_kart)
            end
        else
            if markerler[k+1][8] then 
                triggerClientEvent("kurpiyer_yeni_kart",markerler[k+1][9],y_kart)
            end
        end
        kurpiyer_puan = getElementData(oy_1,"kurpiyer_puan")
        setTimer(kart_al,500,1,oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan)
    end

end
function odullendir_2(oy_1,oy_2,k,t_c_durum,oy_1_puan,oy_2_puan) --1 FONKSİYONDA 2 KEZ DATAYI ÇEKTİĞİMİZDE ESKİ VERİ GELİYORDU SİSTEM HIZI YAVAŞ OLDUĞUNDAN SANIRIM. 
    local kurpiyer_puan = getElementData(oy_1,"kurpiyer_puan") -- BU YÜZDEN ARAYA TİMER ATIP DÜZELTTİM DAHA KOLAY YOLUNU BULAMADIM.
    kurpiyer_puan = tonumber(kurpiyer_puan)
    if kurpiyer_puan >= 22 then
        if oy_1_puan <= 21 then 
            if t_c_durum == "çift" then 
                if markerler[k][8] then 
                    local oyuncu_bahis = getElementData(oy_1,"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(oy_1,"meta_cip")
                    oy_cip = oy_cip + sonuc
                    setElementData(oy_1,"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",oy_1)
                    removeElementData(oy_1,"meta_bj_bahis")
                    if markerler[k-1][8] then
                        triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k-1][9])
                        oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                    else
                        triggerClientEvent("oyun_bitti_bj",oy_1,false)
                        oyunu_resle(oy_1,false,k,t_c_durum)
                    end
                end
            else
                if markerler[k][8] then 
                    local oyuncu_bahis = getElementData(oy_1,"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(oy_1,"meta_cip")
                    oy_cip = oy_cip + sonuc
                    if oy_1_puan == 21 then 
                        sonuc_2 = oyuncu_bahis/2 
                        oy_cip = oy_cip + sonuc_2
                        sonuc = sonuc + sonuc_2
                    end
                    setElementData(oy_1,"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",oy_1)
                    removeElementData(oy_1,"meta_bj_bahis")
                    if markerler[k+1][8] then
                        triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k+1][9])
                        oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                    else
                        triggerClientEvent("oyun_bitti_bj",oy_1,false)
                        oyunu_resle(oy_1,false,k,t_c_durum)
                    end
                end
            end
        end
        if oy_2_puan <= 21 then 
            if t_c_durum == "çift" then 
                if oy_2 then 
                    local oyuncu_bahis = getElementData(markerler[k][9],"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(markerler[k][9],"meta_cip")
                    oy_cip = oy_cip + sonuc
                    setElementData(markerler[k-1][9],"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",markerler[k-1][9])
                    removeElementData(markerler[k][9],"meta_bj_bahis")
                end
                if markerler[k-1][8] then
                    triggerClientEvent("oyun_bitti_bj",markerler[k-1][9],oy_1)
                    oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                else
                    if oy_2 then 
                        triggerClientEvent("oyun_bitti_bj",markerler[k-1][9],false)
                    end
                    oyunu_resle(false,markerler[k-1][9],k,t_c_durum)
                end
            else
                if markerler[k+1][8] then 
                    local oyuncu_bahis = getElementData(markerler[k+1][9],"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(markerler[k+1][9],"meta_cip")
                    oy_cip = oy_cip + sonuc
                    setElementData(markerler[k+1][9],"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",markerler[k+1][9])
                    removeElementData(markerler[k+1][9],"meta_bj_bahis")
                    if markerler[k][8] then
                        triggerClientEvent("oyun_bitti_bj",markerler[k+1][9],oy_1)
                        oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                    else
                        triggerClientEvent("oyun_bitti_bj",markerler[k+1][9],false)
                        oyunu_resle(false,markerler[k-1][9],k,t_c_durum)
                    end
                end
            end
 
        end
        return
    end
    if  kurpiyer_puan > oy_1_puan or kurpiyer_puan > oy_2_puan and kurpiyer_puan <= 21 then
        if oy_1_puan <= 21 and kurpiyer_puan < oy_1_puan then
            if t_c_durum == "çift" then 
                if markerler[k][8] then 
                    local oyuncu_bahis = getElementData(oy_1,"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(oy_1,"meta_cip")
                    oy_cip = oy_cip + sonuc
                    if oy_1_puan == 21 then 
                        sonuc_2 = oyuncu_bahis/2 
                        oy_cip = oy_cip + sonuc_2
                        sonuc = sonuc + sonuc_2
                    end
                    setElementData(oy_1,"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",oy_1)
                    removeElementData(oy_1,"meta_bj_bahis")
                    if markerler[k-1][8] then
                        triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k-1][9])
                        oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                    else
                        triggerClientEvent("oyun_bitti_bj",oy_1,false)
                        oyunu_resle(oy_1,false,k,t_c_durum)
                    end
                end
            else
                if markerler[k][8] then 
                    local oyuncu_bahis = getElementData(oy_1,"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(oy_1,"meta_cip")
                    oy_cip = oy_cip + sonuc
                    if oy_1_puan == 21 then 
                        sonuc_2 = oyuncu_bahis/2 
                        oy_cip = oy_cip + sonuc_2
                        sonuc = sonuc + sonuc_2
                    end
                    setElementData(oy_1,"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",oy_1)
                    removeElementData(oy_1,"meta_bj_bahis")
                    if markerler[k+1][8] then
                        triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k+1][9])
                        oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                    else
                        triggerClientEvent("oyun_bitti_bj",oy_1,false)
                        oyunu_resle(oy_1,false,k,t_c_durum)
                    end
                end
            end
        elseif oy_2_puan < 21 and kurpiyer_puan < oy_2_puan then
            if t_c_durum == "çift" then 
                local oyuncu_bahis = getElementData(markerler[k-1][9],"meta_bj_bahis")
                local sonuc = oyuncu_bahis*2
                local oy_cip = getElementData(markerler[k-1][9],"meta_cip")
                oy_cip = oy_cip + sonuc
                setElementData(markerler[k-1][9],"meta_cip",oy_cip)
                exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",markerler[k-1][9])
                removeElementData(markerler[k-1][9],"meta_bj_bahis")
                if markerler[k][8] then
                    triggerClientEvent("oyun_bitti_bj",markerler[k-1][9],oy_1)
                    oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                else
                    triggerClientEvent("oyun_bitti_bj",markerler[k-1][9],false)
                    oyunu_resle(false,markerler[k-1][9],k,t_c_durum)
                end
            else
                if markerler[k+1][8] then 
                    local oyuncu_bahis = getElementData(markerler[k+1][9],"meta_bj_bahis")
                    local sonuc = oyuncu_bahis*2
                    local oy_cip = getElementData(markerler[k+1][9],"meta_cip")
                    oy_cip = oy_cip + sonuc
                    if oy_1_puan == 21 then 
                        sonuc_2 = oyuncu_bahis/2 
                        oy_cip = oy_cip + sonuc_2
                        sonuc = sonuc + sonuc_2
                    end
                    setElementData(markerler[k+1][9],"meta_cip",oy_cip)
                    exports["meta-vipbonus"]:bonus_ver_server(oy_1,sonuc)
                    exports["meta-info"]:sendServerMessage(sonuc.." çip kazandınız.","success",markerler[k+1][9])
                    removeElementData(markerler[k+1][9],"meta_bj_bahis")
                    if markerler[k][8] then
                        triggerClientEvent("oyun_bitti_bj",markerler[k+1][9],oy_1)
                        oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                    else
                        triggerClientEvent("oyun_bitti_bj",markerler[k+1][9],false)
                        oyunu_resle(false,markerler[k-1][9],k,t_c_durum)
                    end
                end
            end
        elseif oy_1_puan == kurpiyer_puan then 
            exports["meta-info"]:sendServerMessage("Kimse kazanamadı.","info",oy_1)
            local bahis = getElementData(oy_1,"meta_bj_bahis")
            local oyuncu_cip = getElementData(oy_1,"meta_cip")
            local oyuncu_cip = oyuncu_cip + bahis
            setElementData(oy_1,"meta_cip",oyuncu_cip)
            triggerClientEvent("oyun_bitti_bj",oy_1,false)
            oyunu_resle(oy_1,false,k,t_c_durum)
            removeElementData(oy_1,"meta_bj_bahis")
        else
            if t_c_durum == "çift" then
                if markerler[k-1][8] then
                    exports["meta-info"]:sendServerMessage("Kaybettiniz.",oy_1)
                    triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k-1][9])
                    oyunu_resle(oy_1,markerler[k-1][9],k,t_c_durum)
                    removeElementData(oy_1,"meta_bj_bahis")
                else
                    exports["meta-info"]:sendServerMessage("Kaybettiniz.","warning",oy_1)
                    triggerClientEvent("oyun_bitti_bj",oy_1,false)
                    oyunu_resle(oy_1,false,k,t_c_durum)
                    removeElementData(oy_1,"meta_bj_bahis")
                end

            else
                if markerler[k+1][8] then
                    exports["meta-info"]:sendServerMessage("Kaybettiniz.",oy_1)
                    triggerClientEvent("oyun_bitti_bj",oy_1,markerler[k+1][9])
                    oyunu_resle(oy_1,markerler[k+1][9],k,t_c_durum)
                    removeElementData(oy_1,"meta_bj_bahis")
                else
                    exports["meta-info"]:sendServerMessage("Kaybettiniz.","warning",oy_1)
                    triggerClientEvent("oyun_bitti_bj",oy_1,false)
                    oyunu_resle(oy_1,false,k,t_c_durum)
                    removeElementData(oy_1,"meta_bj_bahis")
                end
            end
        end   
    end

end
function ara_sure(oy_1,oy_2,k,t_c_durum)
    if t_c_durum == "çift" then 
        if markerler[k][8] then 
            triggerClientEvent("kurpiyer_2_kart",oy_1,markerler[k-1][9])
        end
        if markerler[k-1][8] then 
            triggerClientEvent("kurpiyer_2_kart",markerler[k-1][9],oy_1)
        end
    else
        if markerler[k][8] then 
            triggerClientEvent("kurpiyer_2_kart",oy_1,markerler[k+1][9])
        end
        if markerler[k+1][8] then 
            triggerClientEvent("kurpiyer_2_kart",markerler[k+1][9],oy_1)
        end
    end

    setTimer(odullendir,1000,1,oy_1,oy_2,k,t_c_durum)
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
function kart_iste_s()
    local kart = rastgele_kart()
    local oyun_kartlari = getElementData(source,"meta_bj_oyun_kartlari")
    local kart_durum = kart_kontrol(oyun_kartlari,kart)
    if not kart_durum then
        kart =  kart_ayni_kart_degis(oyun_kartlari,kart)
    end
    triggerClientEvent("meta_bj_kart_ver",source,kart)
end




function t_c_kontrol(sayi) --TEK Mİ ÇİFT Mİ DİYE KONTROL ETMEK İÇİN
    if (sayi % 2 == 0) then
      return "çift"
    else
      return "tek"
    end
end

addEvent("blackjack_kart_iste",true)
addEventHandler("blackjack_kart_iste",root,kart_iste_s)


addEvent("blackjack_yatir",true)
addEventHandler("blackjack_yatir",root,yatirma_kontrol)

