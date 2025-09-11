Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'Fish Buyer',
    fishShop = 'Fishing Store',
    breakDown = 'Material Breakdown',
    yes = 'Yes',
    no = 'No',
}

Lang.Fails = {
    tooFar = ' %s Was Too Far From %s',
    invalidItem = ' %s Tried To Buy An Invalid Item | %s | From %s',
    invalidBreakdown = ' %s Tried To Break Down An Invalid Item | %s | From %s',
    tooPoor = 'You Dont Have %s %s In $s',
    zoneGlitch = '%s Triggered md-fishing:server:inZone But Was Not Within The Zone Coords',
    leftZone = 'You Left The Fishing Zone While Fishing!',
    onTimeout = 'You Are Fishing A Little Too Fast, Fishies Are Scared',
    outOfBait = 'You Ran Out Of Bait',
    inVehicle = ' You Cant Fish In A Vehicle!',
    alreadyFishing = 'You Are Already Fishing!',
    failedCatch = 'Welp, Theres More Fish In The Sea'
}

Lang.Labels = {
    fishZoneBlip = 'Fishing Zone',
    illegalFishzoneBlip = 'Illegal Fishing Zone',
    fishBuyerBlip = 'Fish Buyer',
    chumMakerBlip = 'Chum Maker',
    shopLocationBlip = 'Fishing Shop',
    breakDownBlip = 'Material Breakdown',
}

Lang.Shops = {
    sold = 'You Sold %s Of %s For %s %s',
    noFish = ' You Didnt Have Any %s To Sell',
    bought = 'You Bought %s Of %s For %s %s',
}

Lang.Fishing = {
    stopped = 'You Stopped Fishing',
    notInZone = 'You Are Not In A Fishing Zone',
    wrongPole = 'You Cant Use This Pole Here',
    noLevel = 'You Dont Have Any Fishing Data, Please Re-log',
    wrongLevel = 'You Need To Be Level %s To Fish Here',
    found = 'You Got A Bite!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Sell Your Fish',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Sell All',
            icon = 'fas fa-donate',
            description = 'Sell All Your Fish At Once!'
        },
        description = 'Sell For ' .. Lang.Info.currency .. '%s Each',
        menuTitle = 'Sell Fish'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Browse Shop',
        input = {
            title = 'Purchase %s',
            field1title = 'How Many To Buy',
            field2title = 'Payment Type',
            field2option1 = 'Cash',
            field2option2 = 'Bank',
        },
        menuTitle = 'Fish Shop'
    },
    chumMaker = {
        label = 'Make Chum',
        icon = 'fas fa-shopping-basket',
        description = 'Make Chum For Bait',
        input = {
            title = 'Confirm You Want To Make Chum',
            field1title = 'Confirm',
            description = 'This will remove all your fish'
        },
        menuTitle = 'Make Chum'
    },
    breakDown = {
        label = 'Material Breakdown',
        icon = 'fas fa-dumpster-fire',
        description = 'Break Down Items Into Materials',
        input = {
            description = 'Break Down %s Into Materials',
        },
        menuTitle = 'Material Breakdown',
        progressbar = 'Breaking Down %s'
    }
}

Lang.anchor = {
    notInWater = 'The Boat Is Not In Water!',
    unanchored = 'You Unachored Your Boat',
    anchored = 'You Anchored Your Boat',
    noBoat = 'Where Is Your Boat?',
}
return Lang