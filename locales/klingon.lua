Lang = {}

Lang.Info = {
    currency = '💰',
    fishBuyer = 'ghIchwI’ — Fish-Buyer (He who acquires prey)',
    fishShop = '‘op SopwI’ — Weapon & Sustenance Emporium',
    breakDown = 'Hergh ‘ap — Material Disassembly',
    yes = 'HISLAH — Correct / Affirmative',
    no = 'ghobe’ — Negative / False',
}

Lang.Fails = {
    tooFar = ' %s DaH %s retlhDaq pagh — %s is far from %s (No honor in distance)',
    invalidItem = ' %s vItlhutlhlaHbe’ ‘op | %s | %svo’ — %s attempted to acquire invalid item from %s',
    invalidBreakdown = ' %s vIHerghlaHbe’ ‘op | %s | %svo’ — %s attempted to disassemble invalid item from %s',
    tooPoor = 'bIghajbe’ %s %s %sDaq — You possess not %s %s in %s (Weakness!)',
    zoneGlitch = '%s md-fishing:server:inZone vIqaw’laHbe’ — triggered but not within zone (Coward’s trick!)',
    leftZone = 'bIqaw’choHta’ ‘op SuvwI’ — You fled the fishing zone mid-hunt!',
    onTimeout = 'bIbachchoHtaH — You fish too fast! Fish fear you (Good... but slow down, fool)',
    outOfBait = 'ngop yIbaH — Bait exhausted! (Prepare more or die hungry)',
    inVehicle = ' ngopDaq bISopbe’ — You cannot fish from vehicle! (Dismount and face the water, warrior!)',
    alreadyFishing = 'bISoptaH — You already fish! (Focus, fool!)',
    failedCatch = 'Qo’ — Failure! But the sea holds more prey. Hunt again!'
}

Lang.Labels = {
    fishZoneBlip = '‘op SuvwI’ retlh — Fishing Zone (Battlefield of Sustenance)',
    illegalFishzoneBlip = 'pagh ‘op SuvwI’ retlh — Illegal Fishing Zone (Dishonorable Waters)',
    fishBuyerBlip = 'ghIchwI’ — Fish-Buyer',
    chumMakerBlip = 'ngop ‘apwI’ — Bait Forger',
    shopLocationBlip = '‘op SopwI’ — Weapon & Sustenance Emporium',
    breakDownBlip = 'Hergh ‘ap — Material Disassembly',
}

Lang.Shops = {
    sold = 'bIghIchta’ %s ‘op %s ‘Iw %s %s — You sold %s of %s for %s %s (Profit is honor)',
    noFish = ' bIghajbe’ %s — You possessed no %s (Weakness! Go hunt!)',
    bought = 'bImuchta’ %s ‘op %s ‘Iw %s %s — You acquired %s of %s for %s %s (Wise investment)',
}

Lang.Fishing = {
    stopped = 'bIbachHa’ — You ceased fishing (Rest is tactical)',
    notInZone = 'bI‘opbe’ retlhDaq — You are not in fishing zone (Find battle ground!)',
    wrongPole = 'bIghajbe’ ‘op ngop — You cannot wield this pole here (Wrong weapon for this hunt)',
    noLevel = 'bIghajbe’ ‘op ‘Iw — You have no fishing data (Re-log — system failure is unacceptable)',
    wrongLevel = 'bIghajtaHvIS %s ‘op ‘Iw — You must be level %s to fish here (Prove your worth, warrior)',
    found = '‘op qaw’! — Prey bites! (Strike now!)',
    inZone = 'bISoptaH retlhDaq — You are now in fishing zone (Prepare for battle!)',
    outZone = 'bI‘optaHbe’ retlhDaq — You are now out of fishing zone (Seek new waters!)',
}

Lang.Targets = {
    fishBuyer = {
        label = '‘op yIghIch — Sell Your Prey',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = '‘op Hoch yIghIch — Sell All',
            icon = 'fas fa-donate',
            description = 'Sell all prey at once — Efficiency is victory!'
        },
        description = 'Sell for ' .. Lang.Info.currency .. '%s each — ‘op ‘Iw %s',
        menuTitle = '‘op yIghIch — Sell Prey'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = '‘op SopwI’ yIlo’ — Browse Emporium',
        input = {
            title = 'Buy %s — %s yImuch',
            field1title = 'How many acquire? — ‘op chenmoH qatlh?',
            field2title = 'Payment Type — ‘Iw ngop',
            field2option1 = 'Cash — ‘Iw',
            field2option2 = 'Bank — ‘Iw Qotlh',
        },
        menuTitle = '‘op SopwI’ — Weapon & Sustenance Emporium'
    },
    chumMaker = {
        label = 'ngop yI‘ap — Forge Bait',
        icon = 'fas fa-shopping-basket',
        description = 'Forge bait for hunt — ngop yI‘ap ‘op SuvwI’',
        input = {
            title = 'ngop yI‘ap lo’laH? — Confirm bait forging?',
            field1title = 'lo’laH? — Confirm?',
            description = 'This removes all prey — ‘op Hoch yIqaw’ (Sacrifice for future victory)'
        },
        menuTitle = 'ngop ‘apwI’ — Bait Forger'
    },
    breakDown = {
        label = 'Hergh ‘ap — Material Disassembly',
        icon = 'fas fa-dumpster-fire',
        description = 'Disassemble items into materials — ‘op yIHergh ‘ap',
        input = {
            description = 'Disassemble %s — %s yIHergh',
        },
        menuTitle = 'Hergh ‘ap — Material Disassembly',
        progressbar = 'Disassembling %s — %s yIHerghpu’'
    }
}

Lang.anchor = {
    notInWater = 'Duj ‘opbe’ Daq — Boat not in water! (Fool! Anchor in sea!)',
    unanchored = 'Duj yIqaw’Ha’ — You unanchored boat (Prepare to sail, warrior)',
    anchored = 'Duj yIqaw’ — You anchored boat (Steady for battle)',
    noBoat = 'nuq Duj? — Where is boat? (Did you lose it in battle?)',
}

return Lang