function panel_open_close()
    if guiGetVisible(panel) then 
        guiSetVisible(panel,false)
        showCursor(false)
    else
        guiSetVisible(panel,true)
        showCursor(true) 
        if not a then 
            addEventHandler("onClientGUIClick",butonlar.play_btn,gui_click)
            a = true 
        end
    end
end
a = false

-----------------------------------
-- buton click 
-----------------------------------
function gui_click()
    local bahis = guiGetText(butonlar.bahis_edit)
    bahis = tonumber(bahis)
    if type(bahis) == "number" then 
    if bahis <= 0 then return end
        if bahis <= bet_limit then 
            local player_chip = getElementData(localPlayer,"meta_cip") or 0
            if player_chip >= bahis then 
                local sayi1 = guiGetText(butonlar.sayi1_edit) 
                local sayi2 = guiGetText(butonlar.sayi2_edit) 
                local sayi3 = guiGetText(butonlar.sayi3_edit) 
                local sayi4 = guiGetText(butonlar.sayi4_edit) 
                sayi1 = tonumber(sayi1) 
                sayi2 = tonumber(sayi2) 
                sayi3 = tonumber(sayi3)
                sayi4 = tonumber(sayi4)
                if type(sayi1) == "number" and type(sayi2) == "number" and type(sayi3) == "number"  and type(sayi4) == "number"  then 
                    if sayi1 <= 0 or sayi2 <= 0 or sayi3 <= 0 or sayi4 <= 0  then return end
                    if (sayi1 ~= sayi2 and sayi1~=sayi3 and sayi1 ~=sayi4 ) and (sayi2~=sayi3 and sayi2 ~=sayi4) and (sayi3 ~=sayi4)   then 
                        if sayi1 <= 19 and sayi2 <= 19 and sayi3 <= 19 and sayi4 <= 19 then 
                            panel_open_close()
                            local chip  = player_chip - bahis
                            setElementData(localPlayer,"bahis_tombala",bahis)
                            triggerServerEvent("send_numbers_tombala",localPlayer,{sayi1,sayi2,sayi3,sayi4},chip)
                        else
                            exports["meta-info"]:sendClientMessage("Sayılar 19'dan büyük olamaz!." ,"error")
                        end
                    else
                        exports["meta-info"]:sendClientMessage("Sayılar birbirini tekrar edemez!." ,"error")
                    end
                else
                    exports["meta-info"]:sendClientMessage("Geçersiz sayı! Sayılarınızı kontrol edin." ,"error")
                end
            else
                exports["meta-info"]:sendClientMessage("Yetersiz Bakiye!","error")
            end
        else
            exports["meta-info"]:sendClientMessage("Bahis sınırı "..bet_limit,"error")
        end
    else
        exports["meta-info"]:sendClientMessage("Geçersiz bahis!","error")
    end
end
