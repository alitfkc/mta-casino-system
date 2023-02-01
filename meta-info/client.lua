function yazi(metin,durum)
    mesaj(metin,durum)
end
addEvent("ust_yazi",true)
addEventHandler("ust_yazi",localPlayer,yazi)
function sendClientMessage(metin,durum)
    mesaj(metin,durum)
end