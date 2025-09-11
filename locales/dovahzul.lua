Lang = {}

Lang.Info = {
    currency = '💰',
    fishBuyer = 'Zokarhiiv — Gold-Speaker',
    fishShop = 'Strunbahqo — Storm-Shop',
    breakDown = 'Zofaasru — Unmake-Material',
    yes = 'Zu’u los — I am',
    no = 'Nahlot — Silent / No',
}

Lang.Fails = {
    tooFar = ' %s hi fen kos %s — %s is far from %s',
    invalidItem = ' %s fen kos krent dovah — %s tried to buy false thing from %s',
    invalidBreakdown = ' %s fen kos zofaas krent — %s tried to unmake false thing from %s',
    tooPoor = 'Hi lost ahrk %s %s hi fen — You lack and %s %s you have not',
    zoneGlitch = '%s fen kos inZone dovah — md-fishing:server:inZone but not in zone',
    leftZone = 'Hi fen thur — You fled the zone while fishing!',
    onTimeout = 'Hi fen krii los — You fish too fast, fish are scared',
    outOfBait = 'Bait lost — Your bait is gone',
    inVehicle = ' Nust ni hi fen — You cannot fish in vehicle!',
    alreadyFishing = 'Hi fen hi — You are already fishing!',
    failedCatch = 'Zeymah, Strunmah fen — Brother, the sea has more'
}

Lang.Labels = {
    fishZoneBlip = 'Thur Strun — Fishing Zone',
    illegalFishzoneBlip = 'Thur Strun Nahkip — Illegal Fishing Zone',
    fishBuyerBlip = 'Zokarhiiv — Gold-Speaker',
    chumMakerBlip = 'Chum Zii — Chum-Soul (Maker)',
    shopLocationBlip = 'Strunbahqo — Storm-Shop',
    breakDownBlip = 'Zofaasru — Unmake-Material',
}

Lang.Shops = {
    sold = 'Hi fen zokar %s dov %s — You sold %s of %s',
    noFish = ' Hi lost %s — You did not have any %s',
    bought = 'Hi fen mindok %s dov %s — You bought %s of %s',
}

Lang.Fishing = {
    stopped = 'Hi fen thur — You stopped fishing',
    notInZone = 'Hi lost thur — You are not in fishing zone',
    wrongPole = 'Hi fen lost mindok — You cannot use this pole here',
    noLevel = 'Hi lost data — You have no fishing data, re-log',
    wrongLevel = 'Hi need %s — You need to be level %s to fish here',
    found = 'Fen kos mindok! — You got a bite!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Zokar Strun — Sell Fish',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Zokar Alo — Sell All',
            icon = 'fas fa-donate',
            description = 'Zokar alo Strun — Sell all fish at once!'
        },
        description = 'Zokar fen ' .. Lang.Info.currency .. '%s — Sell for %s each',
        menuTitle = 'Zokar Strun — Sell Fish'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Mindok Strunbahqo — Browse Shop',
        input = {
            title = 'Mindok %s — Purchase %s',
            field1title = 'Krosis mindok — How many to buy',
            field2title = 'Zokar Type — Payment Type',
            field2option1 = 'Zokar — Cash',
            field2option2 = 'Bah — Bank',
        },
        menuTitle = 'Strunbahqo — Fish Shop'
    },
    chumMaker = {
        label = 'Zii Chum — Make Chum',
        icon = 'fas fa-shopping-basket',
        description = 'Zii Chum Mindok — Make chum for bait',
        input = {
            title = 'Krosis Zii Chum — Confirm you want to make chum',
            field1title = 'Krosis — Confirm',
            description = 'Dii Strun lost — This will remove all your fish'
        },
        menuTitle = 'Zii Chum — Make Chum'
    },
    breakDown = {
        label = 'Zofaasru — Material Breakdown',
        icon = 'fas fa-dumpster-fire',
        description = 'Zofaas dovah — Break down items into materials',
        input = {
            description = 'Zofaas %s — Break down %s into materials',
        },
        menuTitle = 'Zofaasru — Material Breakdown',
        progressbar = 'Zofaas %s — Breaking down %s'
    }
}

Lang.anchor = {
    notInWater = 'Boat lost Strun — The boat is not in water!',
    unanchored = 'Hi fen thur anchor — You unanchored your boat',
    anchored = 'Hi fen anchor — You anchored your boat',
    noBoat = 'Zu’u lost boat — Where is your boat?',
}

return Lang