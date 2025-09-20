Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'Fishen Buyen Gungan',
    fishShop = 'Fishen Stopen',
    breakDown = 'Smashen-Maken Stuffen',
    yes = 'Yousa betten!',
    no = 'Nah-nah, mesa say nope-en!'
}

Lang.Fails = {
    tooFar = ' %s wassa toooo faw-fwom %s — getta closen, yoo silly gungan!',
    invalidItem = ' %s twiedda buyen bwokee t’ing | %s | fwom %s — dat notta inna catalog, oopsen!',
    invalidBreakdown = ' %s twiedda smashen bwokee t’ing | %s | fwom %s — no-no, dat notta smashable, mesa warnen yoo!',
    tooPoor = 'Yousa no gotsa %s %s inna %s — go scavenge mo money, lil’ guppa!',
    zoneGlitch = '%s didda glitchy-witchy — md-fishing:server:inZone butta notta inna zone! Spooky-wooky!',
    leftZone = 'Yousa runnen outta fishen zone while fishen — fishies cry now!',
    onTimeout = 'Yousa fishen too fasty-fast — fishies getten scaaared! Slow-en down, mesa beggen yoo!',
    outOfBait = 'Uh-oh — bait all gone-en! Go findden mo!',
    inVehicle = ' Nuh-uh! No fishen inna vehic’en! Getten out, feel da wata!',
    alreadyFishing = 'Yousa ALREADY fishen — one rod at a time, patien-patien!',
    failedCatch = 'Mesa sowwy — mo fishies inna sea! Twy again, yoo big oaf!'
}

Lang.Labels = {
    fishZoneBlip = 'Fishen Zone — splashy splashy!',
    illegalFishzoneBlip = 'Naughty Fishen Zone — shhh, quieten like!',
    fishBuyerBlip = 'Fishen Buyen Gungan — givva cashy!',
    chumMakerBlip = 'Chum-Maken Machine — stinken good!',
    shopLocationBlip = 'Fishen Stopen — buyen gear!',
    breakDownBlip = 'Smashen-Maken Spot — bwap bwap!',
}

Lang.Shops = {
    sold = 'Yousa solden %s of %s fow %s %s — big moneys, yeehaw!',
    noFish = ' Uh-oh — no %s to sellen! Go catchen sum, yoo lazy guppa!',
    bought = 'Yousa boughten %s of %s fow %s %s — new gear, big flexen!',
}

Lang.Fishing = {
    stopped = 'Yousa stoppen fishen — takee nap, mesa tiya!',
    notInZone = 'Yousa notta inna fishen zone — findden da bubbly wata!',
    wrongPole = 'Dis powa? Nuh-uh — notta worky hewe! Twy anotha, yoo silly gungan!',
    noLevel = 'Mesa no sees ya fishen data — re-loggen, yoo glitchy oaf!',
    wrongLevel = 'Yousa needen level %s to fishen hewe — graw up fawst, lil’ tadpolen!',
    found = 'WOWEE!!! BIG BITE-EN!!! REEL-EN IT IN, QUICK-QUICK!!!',
    inZone = 'Yousa now inna fishen zone — splashy time, woohoo!',
    outZone = 'Yousa now outta fishen zone — time to findden mo wata!',
}

Lang.Targets = {
    fishBuyer = {
        label = 'Sell-en Yousa Fishies',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Sell-en All!',
            icon = 'fas fa-donate',
            description = 'Sell-en evvy fishy at once — big payout, yeehaw!'
        },
        description = 'Sell-en fow ' .. Lang.Info.currency .. '%s eachen',
        menuTitle = 'Sell-en Fishies — Cha-ching!'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Looky-Looky Shoppen',
        input = {
            title = 'Buy-en %s',
            field1title = 'How manyy buyen?',
            field2title = 'Paymen Type-en',
            field2option1 = 'Cashy-Cash',
            field2option2 = 'Banky-Bank',
        },
        menuTitle = 'Fishen Stopen — Gear Up!'
    },
    chumMaker = {
        label = 'Maken Chumen',
        icon = 'fas fa-shopping-basket',
        description = 'Maken stinken chum fow baiten — fishies love stink!',
        input = {
            title = 'Suren ’bout maken chum?',
            field1title = 'Suren?',
            description = 'Dis gonna wipeen all ya fishies — yoo suuuure?'
        },
        menuTitle = 'Chum-Maken Lab — Stink Central!'
    },
    breakDown = {
        label = 'Smashen-Maken',
        icon = 'fas fa-dumpster-fire',
        description = 'Smashen t’ings into stuffen — bwap bwap!',
        input = {
            description = 'Smashen down %s into stuffen — pow pow!',
        },
        menuTitle = 'Smashen-Maken Spot — Kaboom!',
        progressbar = 'Smashen %s... almosty-done, holden tight!'
    }
}

Lang.anchor = {
    notInWater = 'Boaten notta in wata! Findden da splashy!',
    unanchored = 'Yousa un-anchor-en ya boaten — vroom vroom!',
    anchored = 'Yousa anchor-en ya boaten — plop plop, stayen put!',
    noBoat = 'Wheren ya boaten? Did it runnen ’way? Ooopsen!',
}

Lang.RepCommand = {
    header = 'Fishin Repesa',
        fishing = 'Mesa got fishin level %s — yippee!',
        illegal = 'Uh-oh! Mesa doin’ bad fishin — level %s!',
        magnet = 'Magnet-fishin? Level %s — clank-clank, dingers!',
        description = 'Expee? %s outsa %s — keepa goin’, mesa proud!',
}
return Lang