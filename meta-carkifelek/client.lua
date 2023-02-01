function sistem_calisma()
    --Obje yükleme
    setTimer(function()
        local txd = engineLoadTXD ( 'objeler/object.txd' )
        engineImportTXD ( txd, obje_id )
        local dff = engineLoadDFF ( 'objeler/object.dff', 0 )
        engineReplaceModel ( dff, obje_id )
        local col = engineLoadCOL ( 'objeler/object.col' )
        engineReplaceCOL ( col, obje_id )
    end,5000,1)
    
    --sistem panel
    local ekranw,ekranh=guiGetScreenSize()
    panel_dondur=guiCreateWindow((ekranw-200)/2-60,(ekranh-100)/2-275,200,100,"Çarkıfelek",false)
    dondur_buton=guiCreateButton(10,25,180,65,"Döndür - "..carkifelek_ucret_chip.." Çip",false,panel_dondur)
    guiSetVisible(panel_dondur,false)
    panel_kapat=guiCreateWindow((ekranw-200)/2-60,(ekranh-100)/2+290,200,100,"Çarkıfelek",false)
    kapat_buton=guiCreateButton(10,25,180,65,"Ayrıl",false,panel_kapat)
    guiSetVisible(panel_kapat,false)
    if ped_ust_yazi then 
        addEventHandler("onClientRender", root, renderobjes)
    end
end
function tus_engel(button, press) -- oyuncu herhangi bir tuşa bastığında
    for i,v in pairs(butons) do -- butons tablosunu döndür
       local veri, tus = unpack(v) -- tablodaki verileri dğeişkene koy
       if tus[button] then -- eğer basılan uton tusların içinde varsa ve oyuncunun datası bellirtilen data ise
          cancelEvent() -- iptal et
       end
    end      
 end
 
function panel_acma(durum)
     if durum then 
        guiSetVisible(panel_dondur,true)
        guiSetVisible(panel_kapat,true)
        showCursor(true)
        setCameraMatrix (1951.04919, 999.50696, 992.67334, 1954.00488, 995.29889, 993.25938)
        addEventHandler("onClientGUIClick",dondur_buton,butona_tiklama)
        addEventHandler("onClientGUIClick",kapat_buton,butona_tiklama)
        addEventHandler("onClientKey", root,tus_engel)
     else
        guiSetVisible(panel_dondur,false)
        guiSetVisible(panel_kapat,false)
        showCursor(false)
        setCameraTarget(localPlayer)
        removeEventHandler("onClientGUIClick",dondur_buton,butona_tiklama)
        removeEventHandler("onClientGUIClick",kapat_buton,butona_tiklama)
        removeEventHandler("onClientKey", root,tus_engel)
     end

end
function butona_tiklama()
    if source==kapat_buton then 
        triggerServerEvent("carkifelekten_ayril",localPlayer)
        guiSetVisible(panel_dondur,false)
        guiSetVisible(panel_kapat,false)
        showCursor(false)
        setCameraTarget(localPlayer)
        removeEventHandler("onClientGUIClick",dondur_buton,butona_tiklama)
        removeEventHandler("onClientGUIClick",kapat_buton,butona_tiklama)
    else
        local oyuncu_cip = getElementData(localPlayer,"meta_cip")
        if oyuncu_cip >= carkifelek_ucret_chip then 
            triggerServerEvent("carkifelek_dondur",localPlayer)
        else
            exports["meta-info"]:sendClientMessage("Yetersiz Bakiye!","error")
        end
    end
end
function ses_cal()
    playSound3D("sesler/carkifelek_ses.mp3",1954.78699, 996.43091, 992.85938,false)
end
function renderobjes()
    local cx, cy, cz = getCameraMatrix();
    local screenW,screenH=guiGetScreenSize()
    local text="Çarkıfeleği çevirmek için daire içine gir"
  for  k, v in ipairs(getElementsByType('marker' , getResourceRootElement(getThisResource()), true)) do
      if getElementData(v, "yazi") == "carkifelek_marker" then
          local x, y, z = getElementPosition( v );
          z=z+0.8
          if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
              local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
              if dist <= 8 then
                  local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 );
                  if px then
                      dxDrawText(text, px + 1, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                      dxDrawText(text, px, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                  end
              end
          end
      end
    end
end
addEvent("carkifelek_ses_cal",true)
addEventHandler("carkifelek_ses_cal",localPlayer,ses_cal)
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)
addEvent("panel_ac",true)
addEventHandler("panel_ac",localPlayer,panel_acma)