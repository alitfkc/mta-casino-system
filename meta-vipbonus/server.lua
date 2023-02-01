function bonus_ver_server(oyuncu,kazanc)
    if not oyuncu then return end
    if not kazanc then return end
    local hesap = getAccountName ( getPlayerAccount ( oyuncu ) ) 
    local timer = 1500
    for k,v in ipairs(vipler) do 
        if isObjectInACLGroup ("user."..hesap, aclGetGroup ( vipler[k][1]) ) then
            if kazanc >= vipler[k][2] then 
                setTimer(function(oyuncu,yetki,kazanc,carpan)
                    local sonuc = kazanc * carpan
                    local oyuncu_cip = getElementData(oyuncu,"meta_cip")
                    oyuncu_cip = oyuncu_cip + sonuc
                    oyuncu_cip = math.floor(oyuncu_cip) - 1
                    setElementData(oyuncu,"meta_cip",oyuncu_cip)
                    print(oyuncu_cip)
                    exports["meta-info"]:sendServerMessage(yetki.." olduğunuz için "..math.floor(sonuc).." miktarında bonus çip aldınız.","success",oyuncu) 
                end,timer,1,oyuncu,vipler[k][1],kazanc,vipler[k][3])
                timer = timer + 1000
            end
        end
    end
end
addEvent("bonus_ver_meta",true)
addEventHandler("bonus_ver_meta",root,bonus_ver_server)

