Lang = {}

Lang.Info = {
    currency = '💰',
    fishBuyer = 'GRRR-WHUFF',
    fishShop = 'RWAAA-WOOO',
    breakDown = 'WHRRR-GRRR',
    yes = 'WHUFF-WOOO!',
    no = 'MWWAAA!',
}

Lang.Fails = {
    tooFar = ' %s GRRR-AAA %s',
    invalidItem = ' %s RWWAA-GRRR | %s | %s',
    invalidBreakdown = ' %s WHUFF-GRRR | %s | %s',
    tooPoor = 'RWWAAA! %s %s NO GRRR IN %s',
    zoneGlitch = '%s GRRR-WOOO md-fishing:server:inZone BUT NOT IN ZONE',
    leftZone = 'WHAAA-RRR!',
    onTimeout = 'GRRR-AAA-TOO-FAST!',
    outOfBait = 'MWWWHUFF!',
    inVehicle = ' RWWAA-NO-GRRR!',
    alreadyFishing = 'GRRR-WOOO!',
    failedCatch = 'WHUFF… MWWA.'
}

Lang.Labels = {
    fishZoneBlip = 'RWAAA-GRRR',
    illegalFishzoneBlip = 'GRRR-MWWA',
    fishBuyerBlip = 'GRRR-WHUFF',
    chumMakerBlip = 'WHUFF-RRR',
    shopLocationBlip = 'RWAAA-WOOO',
    breakDownBlip = 'WHRRR-GRRR',
}

Lang.Shops = {
    sold = 'WHUFF! %s OF %s FOR %s %s',
    noFish = ' MWWAAA!',
    bought = 'RWAAA! %s OF %s FOR %s %s',
}

Lang.Fishing = {
    stopped = 'WHUFF-AAA',
    notInZone = 'GRRR-NO!',
    wrongPole = 'MWWAAA-GRRR!',
    noLevel = 'WHUFF-RRR?',
    wrongLevel = 'GRRR-LEVEL %s!',
    found = 'ROOOAAARRR!!!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'WHUFF-GRRR',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'RWAAA-ALL!',
            icon = 'fas fa-donate',
            description = 'RWAAA-WHUFF-WHOOOO!'
        },
        description = 'WHUFF ' .. Lang.Info.currency .. '%s GRRR',
        menuTitle = 'GRRR-WHUFF'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'RWAAA-LOOK',
        input = {
            title = 'GRRR %s',
            field1title = 'WHUFF-QTY?',
            field2title = 'MWWAAA-PAY?',
            field2option1 = 'GRRR-CASH',
            field2option2 = 'WHUFF-BANK',
        },
        menuTitle = 'RWAAA-WOOO'
    },
    chumMaker = {
        label = 'WHUFF-RRR',
        icon = 'fas fa-shopping-basket',
        description = 'MWWAAA-WHUFF-GRRR',
        input = {
            title = 'GRRR-SURE?',
            field1title = 'WHUFF?',
            description = 'GRRR-WIPE-ALL-FISH'
        },
        menuTitle = 'WHUFF-RRR'
    },
    breakDown = {
        label = 'WHRRR-GRRR',
        icon = 'fas fa-dumpster-fire',
        description = 'GRRR-WHUFF-MATERIALS',
        input = {
            description = 'WHRRR %s GRRR',
        },
        menuTitle = 'WHRRR-GRRR',
        progressbar = 'WHRRR-GRRR %s'
    }
}

Lang.anchor = {
    notInWater = 'GRRR-DRY-LAND!',
    unanchored = 'WHUFF-UP!',
    anchored = 'GRRR-DOWN!',
    noBoat = 'MWWAAA-BOAT?',
}
return Lang