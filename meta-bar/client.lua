function sistem_calisma_c()
    --içki objeleri
    txd_1 = engineLoadTXD ( "objeler/jackdaniels.txd" )
    engineImportTXD ( txd_1, 1512 )
    dff_1 = engineLoadDFF ( "objeler/jackdaniels.dff" )
    engineReplaceModel ( dff_1, 1512)
    
    txd_2 = engineLoadTXD ( "objeler/icki_1.txd" )
    engineImportTXD ( txd_2, 1669 )
    dff_2 = engineLoadDFF ( "objeler/icki_1.dff" )
    engineReplaceModel ( dff_2, 1669)
    
    txd_3 = engineLoadTXD ( "objeler/icki_2.txd" )
    engineImportTXD ( txd_3, 1509)
    dff_3 = engineLoadDFF ( "objeler/icki_2.dff" )
    engineReplaceModel ( dff_3,1509)
    
    txd_4 = engineLoadTXD ( "objeler/icki_3.txd" )
    engineImportTXD ( txd_4, 1517 )
    dff_4 = engineLoadDFF ( "objeler/icki_3.dff" )
    engineReplaceModel ( dff_4, 1517)

    txd_5 = engineLoadTXD ( "objeler/icki_4.txd" )
    engineImportTXD ( txd_5, 1666 )
    dff_5 = engineLoadDFF ( "objeler/icki_4.dff" )
    engineReplaceModel ( dff_5, 1666)
    if ped_ust_yazi then 
        addEventHandler("onClientRender", root, renderobjes)
    end
end
function renderobjes()
    local cx, cy, cz = getCameraMatrix();
    local screenW,screenH=guiGetScreenSize()
    local text="Ne içersiniz?"
    local text2="İyi eğlenceler"
  for  k, v in ipairs(getElementsByType('ped' , getResourceRootElement(getThisResource()), true)) do
      if getElementData(v, "yazi") == "ped_barwomen" then
          local x, y, z = getElementPosition( v );
          z=z+0.8
          if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
              local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
              if dist <= 8 then
                  local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 );
                  if px then
                      dxDrawText(text, px + 1, py + screenW/38, px + 1, py + 1, tocolor( 255, 255,255, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                      dxDrawText(text, px, py + screenW/38, px, py, tocolor(255, 0, 0, 255 ), 1.25, 'default-bold', 'center', 'center', false, false );
                  end
              end
          end
        end
    end
end
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma_c)



--------------------------
--İÇME ANİMİ
--------------------------
function currentEffectDrinks()
	----------------------------------------------------------
	timerControlDrinks = setTimer(function()
	setPedControlState(localPlayer, "walk", true)
	end, 100, 0)
	setWindVelocity(100, 100, 0)
	setCameraShakeLevel(255)
	----------------------------------------------------------

	timerExpireDrinks = setTimer(function()
	----------------------------------------------------------
	resetWindVelocity()
	setCameraShakeLevel(1)
	if isTimer(timerControlDrinks) then killTimer(timerControlDrinks) end
	setPedControlState(localPlayer, "walk", false)
	--outputChatBox("O efeito da bebida acabou.", 0, 255, 0)
	triggerServerEvent("resetWalkingStyle",resourceRoot)
	----------------------------------------------------------
	end, math.random(40000, 60000), 1)
	
end
addEvent("client:currentEffectDrinks", true)
addEventHandler("client:currentEffectDrinks", resourceRoot, currentEffectDrinks)