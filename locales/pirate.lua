Lang = {}

Lang.Info = {
    currency = '💰',
    fishBuyer = 'The Fishmonger (Cap’n o’ Coin)',
    fishShop = 'The Salty Tackle & Bait',
    breakDown = 'Break Down Yer Booty',
    yes = 'Aye Aye!',
    no = 'Nay, ye scurvy dog!'
}

Lang.Fails = {
    tooFar = ' %s were too far from %s — walk the plank or walk closer, matey!',
    invalidItem = ' %s tried to buy ghost gear | %s | from %s — that ain’t on the manifest, ye mad lubber!',
    invalidBreakdown = ' %s tried to break down cursed loot | %s | from %s — that be forbidden magic, fool!',
    tooPoor = 'Ye be poorer than a barnacle — no %s %s in yer %s chest!',
    zoneGlitch = '%s triggered md-fishing:server:inZone but weren’t in the blasted zone — cheatin’ or clueless? Walk the plank and decide!',
    leftZone = 'Ye abandoned the fishin’ grounds mid-cast — the sea curses ye for it!',
    onTimeout = 'Ye be reelin’ too fast, ye impatient sea dog — slow yer roll or scare off the catch!',
    outOfBait = 'Yer bait’s gone, ye starvin’ deckhand — restock or go hungry!',
    inVehicle = ' Ye can’t fish from the crow’s nest — get yer sea legs on solid deck, fool!',
    alreadyFishing = 'Ye be already fishin’, ye forgetful barnacle — one line at a time!',
    failedCatch = 'Bah! Missed the bite — but the sea be full o’ fools and fish. Try again!'
}

Lang.Labels = {
    fishZoneBlip = 'Fishin’ Grounds (Drop Anchor Here)',
    illegalFishzoneBlip = 'Smuggler’s Cove (Fish at Yer Own Risk)',
    fishBuyerBlip = 'The Fishmonger — Payin’ Top Doubloon',
    chumMakerBlip = 'Chum Cauldron — Brew the Stink',
    shopLocationBlip = 'The Salty Tackle & Bait',
    breakDownBlip = 'Break Down Yer Booty',
}

Lang.Shops = {
    sold = 'Ye sold %s o’ %s for %s %s — fine haul, matey!',
    noFish = ' Ye had not a single %s to sell — shame on ye, lazy sea slug!',
    bought = 'Ye bought %s o’ %s for %s %s — smart investment, or foolish splurgin’? Time’ll tell!',
}

Lang.Fishing = {
    stopped = 'Ye hauled in yer line — rest while ye can, the sea waits for no man.',
    notInZone = 'Ye be fishin’ in Davy Jones’ locker — get to the marked waters, fool!',
    wrongPole = 'That pole? Useless here — switch gear or switch yer luck!',
    noLevel = 'No fishin’ log? Re-log, ye glitch-ridden deck swab!',
    wrongLevel = 'Ye must be level %s to cast here — prove yer salt, greenhorn!',
    found = 'YARRR! A BITE ON THE LINE — REEL IT IN, YE MAD SEA DOG!',
    inZone = 'Ye be in the fishin’ grounds now — time to haul in some treasure!',
    outZone = 'Ye be out o’ the fishin’ grounds — find new waters, or be fish food!',
}

Lang.Targets = {
    fishBuyer = {
        label = 'Sell Yer Catch',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Sell It All, Quick!',
            icon = 'fas fa-donate',
            description = 'Dump the whole haul — doubloons now, regrets later!'
        },
        description = 'Sell for ' .. Lang.Info.currency .. '%s per fish — fair price for fair catch',
        menuTitle = 'Sell to the Fishmonger'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Browse the Tackle Shop',
        input = {
            title = 'Buy %s — Last Chance, Matey!',
            field1title = 'How many barrels?',
            field2title = 'Pay How?',
            field2option1 = 'Pieces o’ Eight (Cash)',
            field2option2 = 'Bank Draft (Fancy Paper)',
        },
        menuTitle = 'The Salty Tackle & Bait'
    },
    chumMaker = {
        label = 'Brew Chum',
        icon = 'fas fa-shopping-basket',
        description = 'Turn yer catch into stinkin’ bait — waste not, want not!',
        input = {
            title = 'Brew the Chum?',
            field1title = 'Confirm, Ye Mad Alchemist',
            description = 'This’ll scrap all yer fish — no turnin’ back, fool!'
        },
        menuTitle = 'Chum Cauldron'
    },
    breakDown = {
        label = 'Break Down Yer Booty',
        icon = 'fas fa-dumpster-fire',
        description = 'Melt yer gear into scraps — salvage before the kraken takes it!',
        input = {
            description = 'Break down %s — useful scraps from useless junk',
        },
        menuTitle = 'Break Down Yer Booty',
        progressbar = 'Breakin’ Down %s — Hold Steady, Matey!'
    }
}

Lang.anchor = {
    notInWater = 'The ship be on dry land, ye landlubber — find the tide or find the plank!',
    unanchored = 'Ye raised anchor — set sail, ye restless sea dog!',
    anchored = 'Dropped anchor — steady as she goes, Cap’n!',
    noBoat = 'Where be yer ship, ye forgetful fool? Did the kraken take it?',
}

Lang.RepCommand = {
    header = 'FISHIN’ REPUTATION, YE SCALLYWAG!',
        fishing = 'YARR! FISHIN’ LEVEL %s — CAST YER LINES, YA BARNACLE!',
        illegal = 'SHIVER ME TIMBERS! ILLEGAL FISHIN’ LEVEL %s — THE ADMIRAL BE COMIN’!',
        magnet = 'AVAST! MAGNET FISHIN’ LEVEL %s — YE BE PULLIN’ UP TREASURE... OR BOOTY!',
        description = 'XP: %s / %s — KEEP SWABBIN’ THE DECK TILL YE EARN IT, YA LANDLUBBER!',
}
return Lang