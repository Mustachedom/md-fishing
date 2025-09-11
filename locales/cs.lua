Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'Kupující ryb',
    fishShop = 'Rybářský obchod',
    breakDown = 'Rozklad materiálů',
    yes = 'Ano',
    no = 'Ne',
}

Lang.Fails = {
    tooFar = ' %s byl příliš daleko od %s',
    invalidItem = ' %s se pokusil koupit neplatnou položku | %s | od %s',
    invalidBreakdown = ' %s se pokusil rozebrat neplatnou položku | %s | od %s',
    tooPoor = 'Nemáte %s %s v %s',
    zoneGlitch = '%s aktivoval md-fishing:server:inZone, ale nebyl v souřadnicích zóny',
    leftZone = 'Opustil jste rybářskou zónu během rybaření!',
    onTimeout = 'Rybaříte příliš rychle, ryby se bojí',
    outOfBait = 'Dostal jste se bez nástrah',
    inVehicle = ' V autě nelze rybařit!',
    alreadyFishing = 'Už rybaříte!',
    failedCatch = 'No tak, je víc ryb v moři'
}

Lang.Labels = {
    fishZoneBlip = 'Rybářská zóna',
    illegalFishzoneBlip = 'Nelegální rybářská zóna',
    fishBuyerBlip = 'Kupující ryb',
    chumMakerBlip = 'Výroba přilákadla',
    shopLocationBlip = 'Rybářský obchod',
    breakDownBlip = 'Rozklad materiálů',
}

Lang.Shops = {
    sold = 'Prodali jste %s kusů %s za %s %s',
    noFish = ' Nemáte žádné %s na prodej',
    bought = 'Koupili jste %s kusů %s za %s %s',
}

Lang.Fishing = {
    stopped = 'Přestali jste rybařit',
    notInZone = 'Nejste v rybářské zóně',
    wrongPole = 'Tento prut zde nelze použít',
    noLevel = 'Nemáte žádná rybářská data, prosím, znovu se přihlašte',
    wrongLevel = 'Potřebujete být úrovně %s, abyste zde mohli rybařit',
    found = 'Máte bitevní!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Prodat ryby',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Prodat vše',
            icon = 'fas fa-donate',
            description = 'Prodat všechny ryby najednou!'
        },
        description = 'Prodej za ' .. Lang.Info.currency .. '%s za kus',
        menuTitle = 'Prodat ryby'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Procházet obchod',
        input = {
            title = 'Koupit %s',
            field1title = 'Kolik kusů koupit',
            field2title = 'Typ platby',
            field2option1 = 'Hotovost',
            field2option2 = 'Banka',
        },
        menuTitle = 'Rybářský obchod'
    },
    chumMaker = {
        label = 'Vyrobit přilákadlo',
        icon = 'fas fa-shopping-basket',
        description = 'Vyrobit přilákadlo pro nástrahy',
        input = {
            title = 'Potvrdit výrobu přilákadla',
            field1title = 'Potvrzení',
            description = 'Toto odstraní všechny vaše ryby'
        },
        menuTitle = 'Výroba přilákadla'
    },
    breakDown = {
        label = 'Rozklad materiálů',
        icon = 'fas fa-dumpster-fire',
        description = 'Rozložit předměty na materiály',
        input = {
            description = 'Rozložit %s na materiály',
        },
        menuTitle = 'Rozklad materiálů',
        progressbar = 'Rozkládání %s'
    }
}

Lang.anchor = {
    notInWater = 'Loď není ve vodě!',
    unanchored = 'Zvedli jste kotvu lodi',
    anchored = 'Zakotvili jste loď',
    noBoat = 'Kde je vaše loď?',
}

return Lang