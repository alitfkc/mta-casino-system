butonlar = {}

local function sistem_calisma()
    local ekranh,ekrany = guiGetScreenSize()
    panel = guiCreateWindow((ekranh-250)/2,(ekrany-150)/2,250,150,"Meta Tombala",false)
    bahis_yazi = guiCreateLabel(50,20,150,20,"Bahisiniz",false,panel)
    guiLabelSetHorizontalAlign(bahis_yazi,"center")
    butonlar.bahis_edit = guiCreateEdit(45,40,150,20,"",false,panel)

    butonlar.sayi1_edit = guiCreateEdit(25,90,40,20,"",false,panel)
    guiEditSetMaxLength(butonlar.sayi1_edit,2)

    butonlar.sayi2_edit = guiCreateEdit(75,90,40,20,"",false,panel)
    guiEditSetMaxLength(butonlar.sayi2_edit,2)

    butonlar.sayi3_edit = guiCreateEdit(125,90,40,20,"",false,panel)
    guiEditSetMaxLength(butonlar.sayi3_edit,2)

    butonlar.sayi4_edit = guiCreateEdit(175,90,40,20,"",false,panel)
    guiEditSetMaxLength(butonlar.sayi4_edit,2)

    sayi_yazi =guiCreateLabel(25,70,210,20,"Sayı 1     Sayı 2     Sayı 3    Sayı 4",false,panel)
    butonlar.play_btn = guiCreateButton(25,120,190,25,"Oyna",false,panel)

    guiSetVisible(panel,false)
end




addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma)