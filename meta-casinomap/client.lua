function sistem_calisma()
    setTimer(function() 
        txd = engineLoadTXD ( "objeler/object.txd" )
        engineImportTXD ( txd, tabela_obje_id )
        col = engineLoadCOL ( "objeler/object.col" )
    end,2000,1)
    setTimer(function()
        engineReplaceCOL ( col, tabela_obje_id)
        dff = engineLoadDFF ( "objeler/object.dff" )
        engineReplaceModel ( dff, tabela_obje_id )
        engineSetModelLODDistance(tabela_obje_id, 9000)
    end,4000,1)
    local ekranw,ekranh=guiGetScreenSize()
    panel_giris=guiCreateWindow((ekranw-300)/2,(ekranh-250)/2,300,180,"Meta Casino",false)
    giris_logo=guiCreateStaticImage(10,25,125,145,"resimler/logo.png",false,panel_giris)
    fiyat_metin=guiCreateLabel(165,25,100,50,"Giriş ücreti:",false,panel_giris)
    guiSetFont(fiyat_metin,"default-bold-small")
    fiyat=guiCreateLabel(235,25,100,50,giris_ucret.."$",false,panel_giris)
    guiSetFont(fiyat,"default-bold-small")
    guiLabelSetColor(fiyat,144,238,144)
    giris_buton=guiCreateButton(145,60,135,50,"Giriş ",false,panel_giris)
    kapat_buton=guiCreateButton(145,120,135,50,"Kapat",false,panel_giris)
    guiSetVisible(panel_giris,false)
    if ped_ust_yazi then 
        addEventHandler("onClientRender", root, renderobjes)
    end
end
function renderobjes()
    local cx, cy, cz = getCameraMatrix();
    local screenW,screenH=guiGetScreenSize()
    local text="Hoş geldiniz"
    local text2="İyi eğlenceler"
    local text3="Buradan Çip alabilirsiniz."
  for  k, v in ipairs(getElementsByType('ped' , getResourceRootElement(getThisResource()), true)) do
      if getElementData(v, "yazi") == "ped_koruma" then
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
        elseif getElementData(v, "yazi") == "ped_garson" then
            local x, y, z = getElementPosition( v );
            z=z+0.8
            if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
                local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
                if dist <= 18 then
                    local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 );
                    if px then
                        dxDrawText(text2, px + 1, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                        dxDrawText(text2, px, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                    end
                end
            end
        elseif getElementData(v, "yazi") == "ped_chip" then
         local x, y, z = getElementPosition( v );
         z=z+0.8
            if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
             local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
             if dist <= 18 then
                 local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 );
                    if px then
                      dxDrawText(text3, px + 1, py + screenW/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                     dxDrawText(text3, px, py + screenW/38, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                    end
                end
            end
        end
end
end
function ped_hasar_engelleme()
    if getElementData(source,"ped_olumsuzluk_meta") then 
        cancelEvent()
    end
end
function panel_acma(durum)
    if durum then 
        if not guiGetVisible(panel_giris) then
            showCursor(true)
            guiSetVisible(panel_giris,true)
            addEventHandler("onClientGUIClick",giris_buton,butona_basma)
            addEventHandler("onClientGUIClick",kapat_buton,butona_basma)
        end
    else
        showCursor(false)
        guiSetVisible(panel_giris,false)
        removeEventHandler("onClientGUIClick",giris_buton,butona_basma)
        removeEventHandler("onClientGUIClick",kapat_buton,butona_basma)
    end
end
function butona_basma()
    if source==kapat_buton then 
        showCursor(false)
        guiSetVisible(panel_giris,false)
        removeEventHandler("onClientGUIClick",giris_buton,butona_basma)
        removeEventHandler("onClientGUIClick",kapat_buton,butona_basma)
    else
        triggerServerEvent("giris_yapma",localPlayer)
        addEventHandler("onClientPlayerDamage",localPlayer,hasar_engel)
    end
end

function hasar_engel()
    if getElementInterior(localPlayer) ~= 10 then return removeEventHandler("onClientPlayerDamage",localPlayer,hasar_engel) end
    cancelEvent()
end

function hasar_engel_kapat()
    removeEventHandler("onClientPlayerDamage",localPlayer,hasar_engel)
end
addEvent("hasar_engel_kapat",true)
addEventHandler("hasar_engel_kapat",localPlayer,hasar_engel_kapat)

addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)
addEventHandler ("onClientPedDamage",getRootElement(),ped_hasar_engelleme) 
addEvent("panel_ac_giris",true)
addEventHandler("panel_ac_giris",localPlayer,panel_acma)

