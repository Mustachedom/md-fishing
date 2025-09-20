Lang = {}

Lang.Info = {
    currency = '€',
    fishBuyer = 'Viskoper',
    fishShop = 'Visserswinkel',
    breakDown = 'Materiaal Opsplitsen',
    yes = 'Ja',
    no = 'Nee',
}

Lang.Fails = {
    tooFar = ' %s was te ver van %s',
    invalidItem = ' %s probeerde een ongeldig item te kopen | %s | van %s',
    invalidBreakdown = ' %s probeerde een ongeldig item te splitsen | %s | van %s',
    tooPoor = 'Je hebt niet genoeg %s %s in %s',
    zoneGlitch = '%s activeerde md-fishing:server:inZone maar was niet binnen de zone-coördinaten',
    leftZone = 'Je hebt de viszone verlaten tijdens het vissen!',
    onTimeout = 'Je vist iets te snel, de vissen schrikken ervan',
    outOfBait = 'Je bent je aas kwijt',
    inVehicle = ' Je kunt niet vissen in een voertuig!',
    alreadyFishing = 'Je bent al aan het vissen!',
    failedCatch = 'Jammer, er zijn meer vissen in de zee'
}

Lang.Labels = {
    fishZoneBlip = 'Viszone',
    illegalFishzoneBlip = 'Illegale Viszone',
    fishBuyerBlip = 'Viskoper',
    chumMakerBlip = 'Aasmaker',
    shopLocationBlip = 'Visserswinkel',
    breakDownBlip = 'Materiaal Opsplitsen',
}

Lang.Shops = {
    sold = 'Je hebt %s van %s verkocht voor %s %s',
    noFish = ' Je had geen %s om te verkopen',
    bought = 'Je hebt %s van %s gekocht voor %s %s',
}

Lang.Fishing = {
    stopped = 'Je bent gestopt met vissen',
    notInZone = 'Je bent niet in een viszone',
    wrongPole = 'Je kunt deze hengel hier niet gebruiken',
    noLevel = 'Je hebt geen visgegevens, log opnieuw in',
    wrongLevel = 'Je moet niveau %s zijn om hier te vissen',
    found = 'Je hebt een beet!',
    inZone = 'Je bent nu in een viszone',
    outZone = 'Je bent nu buiten de viszone',
}

Lang.Targets = {
    fishBuyer = {
        label = 'Verkoop je vissen',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Alles verkopen',
            icon = 'fas fa-donate',
            description = 'Verkoop al je vissen in één keer!'
        },
        description = 'Verkoop voor ' .. Lang.Info.currency .. '%s per stuk',
        menuTitle = 'Vissen Verkopen'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Winkel doorzoeken',
        input = {
            title = '%s kopen',
            field1title = 'Hoeveel kopen',
            field2title = 'Betalingsmethode',
            field2option1 = 'Contant',
            field2option2 = 'Bank',
        },
        menuTitle = 'Visserswinkel'
    },
    chumMaker = {
        label = 'Aas maken',
        icon = 'fas fa-shopping-basket',
        description = 'Maak aas voor het vissen',
        input = {
            title = 'Bevestig aasmaking',
            field1title = 'Bevestigen',
            description = 'Dit verwijdert al je vissen'
        },
        menuTitle = 'Aas Maken'
    },
    breakDown = {
        label = 'Materiaal Opsplitsen',
        icon = 'fas fa-dumpster-fire',
        description = 'Split items op in materialen',
        input = {
            description = '%s opsplitsen in materialen',
        },
        menuTitle = 'Materiaal Opsplitsen',
        progressbar = '%s wordt opgesplitst'
    }
}

Lang.anchor = {
    notInWater = 'De boot is niet in het water!',
    unanchored = 'Je hebt je boot losgemaakt',
    anchored = 'Je hebt je boot aangelegd',
    noBoat = 'Waar is je boot?',
}

Lang.RepCommand = {
    header = 'Visreputatie',
        fishing = 'Verniveau: %s',
        illegal = 'Illegaal verniveau: %s',
        magnet = 'Magneetvissen niveau: %s',
        description = 'XP: %s / %s',
}
return Lang