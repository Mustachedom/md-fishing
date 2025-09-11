Anglay = {}

Anglay.Info = {
    currency = '$',
    fishBuyer = 'Ishfay Uyerbay',
    fishShop = 'Ishfay Opshay',
    breakDown = 'Eakbray Own-day',
    yes = 'Esyay',
    no = 'Onay',
}

Anglay.Fails = {
    tooFar = ' %say asway ootay arfay omfray %say',
    invalidItem = ' %say iedtray otay uybay Anay invaliday itemay | %say | Omfray %say',
    invalidBreakdown = ' %say iedtray otay eakbray own-day Anay invaliday itemay | %say | Omfray %say',
    tooPoor = 'Ouyay Ontday Avehay %say %say Inay %say',
    zoneGlitch = '%say Iriggeredtay md-fishing:server:inZone Utbay Asway Otnay Ithinway Ethay Oneday Oordscay',
    leftZone = 'Ouyay Eftlay Ethay Ishingfay Oneday Ilewhay Ishingfay!',
    onTimeout = 'Ouyay Areay Ishingfay Aay Ittlelay Ootay Astfay, Ishiesfay Areay Scareday',
    outOfBait = 'Ouyay Anray Outay Ofay Aitbay',
    inVehicle = ' Ouyay Antcay Otay Ishfay Inay Aay Ehiclevay!',
    alreadyFishing = 'Ouyay Areay Alreadyay Ishingfay!',
    failedCatch = 'Elpway, Herestay Oremay Ishfay Inay Ethay Ea-say'
}

Anglay.Labels = {
    fishZoneBlip = 'Ishingfay Oneday',
    illegalFishzoneBlip = 'Illegalay Ishingfay Oneday',
    fishBuyerBlip = 'Ishfay Uyerbay',
    chumMakerBlip = 'Umchay Akermay',
    shopLocationBlip = 'Ishfay Opshay',
    breakDownBlip = 'Eakbray Own-day',
}

Anglay.Shops = {
    sold = 'Ouyay Oldsay %say Ofay %say Orfay %say %say',
    noFish = ' Ouyay Idn’tday Avehay Anyay %say Otay Ellsay',
    bought = 'Ouyay Oughtbay %say Ofay %say Orfay %say %say',
}

Anglay.Fishing = {
    stopped = 'Ouyay Oppedstay Ishingfay',
    notInZone = 'Ouyay Areay Otnay Inay Aay Ishingfay Oneday',
    wrongPole = 'Ouyay Antcay Otay Useay Ishthay Olepay Erehay',
    noLevel = 'Ouyay Ontday Avehay Anyay Ishingfay Ataday, Easeplay E-logray',
    wrongLevel = 'Ouyay Eednay Otay Ebay Evellay %say Otay Ishfay Erehay',
    found = 'Ouyay Otgay Aay Itebay!'
}

Anglay.Targets = {
    fishBuyer = {
        label = 'Ellsay Ouryay Ishfay',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Ellsay Allay',
            icon = 'fas fa-donate',
            description = 'Ellsay Allay Ouryay Ishfay Atay Onceay!'
        },
        description = 'Ellsay Orfay ' .. Anglay.Info.currency .. '%say Eachay',
        menuTitle = 'Ellsay Ishfay'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Rowsebay Opshay',
        input = {
            title = 'Urchasepay %say',
            field1title = 'Owhay Anyay Otay Uybay',
            field2title = 'Aymentpay Ypetay',
            field2option1 = 'Ashcay',
            field2option2 = 'Ankbay',
        },
        menuTitle = 'Ishfay Opshay'
    },
    chumMaker = {
        label = 'Akemay Umchay',
        icon = 'fas fa-shopping-basket',
        description = 'Akemay Umchay Orfay Aitbay',
        input = {
            title = 'Onfirmcay Ouyay Antway Otay Akemay Umchay',
            field1title = 'Onfirmcay',
            description = 'Isthay Illway Emoveray Allay Ouryay Ishfay'
        },
        menuTitle = 'Akemay Umchay'
    },
    breakDown = {
        label = 'Eakbray Own-day',
        icon = 'fas fa-dumpster-fire',
        description = 'Eakbray Own-day Itemsay Intoay Aterialsmay',
        input = {
            description = 'Eakbray Own-day %say Intoay Aterialsmay',
        },
        menuTitle = 'Eakbray Own-day',
        progressbar = 'Eakingbray Own-day %say'
    }
}

Anglay.anchor = {
    notInWater = 'Ethay Oatbay Isay Otnay Inay Aterway!',
    unanchored = 'Ouyay Unachoreday Ouryay Oatbay',
    anchored = 'Ouyay Anchoreday Ouryay Oatbay',
    noBoat = 'Erehway Isay Ouryay Oatbay?',
}

return Anglay