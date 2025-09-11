Lang = {}

Lang.Info = {
    currency = '₺',
    fishBuyer = 'Balık Alıcı',
    fishShop = 'Balıkçı Dükkanı',
    breakDown = 'Malzeme Parçalama',
    yes = 'Evet',
    no = 'Hayır',
}

Lang.Fails = {
    tooFar = ' %s, %s konumundan çok uzaktaydı',
    invalidItem = ' %s, geçersiz bir eşya satın almaya çalıştı | %s | %s kişisinden',
    invalidBreakdown = ' %s, geçersiz bir eşyayı parçalamaya çalıştı | %s | %s kişisinden',
    tooPoor = '%s %s miktarına sahip değilsin, %s içinde',
    zoneGlitch = '%s, md-fishing:server:inZone tetiklendi ama bölge koordinatlarının içinde değildi',
    leftZone = 'Balık tutarken balık bölgesinden çıktın!',
    onTimeout = 'Biraz fazla hızlı balık tutuyorsun, balıklar korktu!',
    outOfBait = 'Yemin bitti',
    inVehicle = ' Araç içinde balık tutamazsın!',
    alreadyFishing = 'Zaten balık tutuyorsun!',
    failedCatch = 'Vay canına, denizde daha çok balık var'
}

Lang.Labels = {
    fishZoneBlip = 'Balık Bölgesi',
    illegalFishzoneBlip = 'Yasa Dışı Balık Bölgesi',
    fishBuyerBlip = 'Balık Alıcı',
    chumMakerBlip = 'Yem Üretici',
    shopLocationBlip = 'Balıkçı Dükkanı',
    breakDownBlip = 'Malzeme Parçalama',
}

Lang.Shops = {
    sold = '%s adet %s, %s %s karşılığında satıldı',
    noFish = ' Satacak %s balığın yoktu',
    bought = '%s adet %s, %s %s karşılığında satın alındı',
}

Lang.Fishing = {
    stopped = 'Balık tutmayı bıraktın',
    notInZone = 'Bir balık bölgesinde değilsin',
    wrongPole = 'Bu oltayı burada kullanamazsın',
    noLevel = 'Hiçbir balık verin yok, lütfen tekrar giriş yap',
    wrongLevel = 'Burada balık tutmak için seviye %s olman lazım',
    found = 'Iskarmoz oldu!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Balıklarını Sat',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Hepsini Sat',
            icon = 'fas fa-donate',
            description = 'Tüm balıklarını tek seferde sat!'
        },
        description = 'Adet başı ' .. Lang.Info.currency .. '%s karşılığında sat',
        menuTitle = 'Balık Sat'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Dükkanı Gez',
        input = {
            title = '%s Satın Al',
            field1title = 'Kaç tane almak istiyorsun?',
            field2title = 'Ödeme Türü',
            field2option1 = 'Nakit',
            field2option2 = 'Banka',
        },
        menuTitle = 'Balıkçı Dükkanı'
    },
    chumMaker = {
        label = 'Yem Yap',
        icon = 'fas fa-shopping-basket',
        description = 'Balık tutmak için yem üret',
        input = {
            title = 'Yem yapmayı onayla',
            field1title = 'Onayla',
            description = 'Bu, tüm balıklarını silecek'
        },
        menuTitle = 'Yem Üret'
    },
    breakDown = {
        label = 'Malzeme Parçalama',
        icon = 'fas fa-dumpster-fire',
        description = 'Eşyaları malzemelere ayır',
        input = {
            description = '%s eşyasını malzemelere ayır',
        },
        menuTitle = 'Malzeme Parçalama',
        progressbar = '%s parçalanıyor'
    }
}

Lang.anchor = {
    notInWater = 'Tekne suda değil!',
    unanchored = 'Teknenin demirini kaldırdın',
    anchored = 'Tekneni demirledin',
    noBoat = 'Teknen nerede?',
}

return Lang