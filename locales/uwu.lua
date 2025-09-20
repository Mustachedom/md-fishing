Lang = {}

Lang.Info = {
    currency = '🐟',
    fishBuyer = 'Fwish Buyew~',
    fishShop = 'Fwishy Shoppy~',
    breakDown = 'Bweak It Downny~',
    yes = 'Yesh~ 💖',
    no = 'Nooo~ 😿'
}

Lang.Fails = {
    tooFar = ' %s w-was too faw fwom %s... come cwoser~ 🏃‍♀️💨',
    invalidItem = ' %s twied to buy a *bwookey* item | %s | fwom %s... nyaa~? 🐱❓',
    invalidBreakdown = ' %s twied to bweak down a *bwookey* item | %s | fwom %s... dat not wook right~ 🧸🔧',
    tooPoor = 'UwU you no haz %s %s in %s... go save up, sweetie~ 💸🥺',
    zoneGlitch = '%s did a *glitchy-witchy* in md-fishing:server:inZone but not in zone... spooky~ 👻🗺️',
    leftZone = 'You wunned away fwom da fishy zone while fishin’! 🐠🏃‍♂️',
    onTimeout = 'UwU fishies are scawed... you fish too fasty-fast! slow down, snugglebug~ 🐠💤',
    outOfBait = 'Aww... all outta bait! Go get sum mowe, pwease~ 🍖🥺',
    inVehicle = ' Nuuu~! No fishin’ in vehicwes! Get out an’ feel da wata~ 🚗🚫🎣',
    alreadyFishing = 'You awweady fishin’, silly~! One wod at a time~ 🎣💕',
    failedCatch = 'Welp... mowe fishies in da sea! Twy again, cutie~ 🌊💖'
}

Lang.Labels = {
    fishZoneBlip = 'Fwishy Zone~ 🐠',
    illegalFishzoneBlip = 'Naughty Fwishy Zone 😈🎣',
    fishBuyerBlip = 'Fwish Buyew~ 💰🐠',
    chumMakerBlip = 'Chummy Makew~ 🍖✨',
    shopLocationBlip = 'Fwishy Shoppy~ 🛍️🐟',
    breakDownBlip = 'Bweaky Downy Spot~ 🔨🧸'
}

Lang.Shops = {
    sold = 'You sowd %s of %s fow %s %s! Yay~! 🎉💸',
    noFish = ' Aww... no %s to sewll... go catch sum, pwease~ 🐠🥺',
    bought = 'You bought %s of %s fow %s %s! Snuggles & success~ 🛒💖'
}

Lang.Fishing = {
    stopped = 'You stopped fishin’... take a bweak, sweetie~ ☕🎣',
    notInZone = 'You not in a fishy zone... go find da bubbwes~ 🗺️💦',
    wrongPole = 'Dis powe no wook hewe... twy anotha one, pwease~ 🎣❌',
    noLevel = 'No fishy data? Pwease we-wog, snuggles~ 💤🔁',
    wrongLevel = 'You need to be wevew %s to fish hewe... gwow up fiwst~ 🌱🎣',
    found = 'OMG!!! YOU GOT A BITE!!! 🐠💖 REEL IT IN~!!!',
    inZone = 'You are now in a fishy zone~ 🐠💖',
    outZone = 'You are now out of the fishy zone~ 🐠💔'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Sewll Youw Fishies~',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Sewll Aww~',
            icon = 'fas fa-donate',
            description = 'Sewll aww youw fishies at once! Big hugs~ 🤗💸'
        },
        description = 'Sewll fow ' .. Lang.Info.currency .. '%s each~ 💖',
        menuTitle = 'Sewll Fwishies~ 🐠💰'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Bwowsie Shoppy~',
        input = {
            title = 'Buy %s~ 🛍️',
            field1title = 'How manyy?~',
            field2title = 'Paymwent Type~',
            field2option1 = 'Cashy-Cash~ 💵',
            field2option2 = 'Banky-Bank~ 🏦',
        },
        menuTitle = 'Fwishy Shoppy~ 🎣💖'
    },
    chumMaker = {
        label = 'Make Chummy~',
        icon = 'fas fa-shopping-basket',
        description = 'Make chum fow baity-bait~ 🍖✨',
        input = {
            title = 'Confim Make Chummy~?',
            field1title = 'Confim?~',
            description = 'Dis wiww wemove aww youw fishies... 😿🐠'
        },
        menuTitle = 'Make Chummy~ 🍖💕'
    },
    breakDown = {
        label = 'Bweaky Downy~',
        icon = 'fas fa-dumpster-fire',
        description = 'Bweak stuffies into matewials~ 🔨🧸',
        input = {
            description = 'Bweaky down %s into stuffies~ 💖'
        },
        menuTitle = 'Bweaky Downy~ 🧸🔨',
        progressbar = 'Bweakin’ down %s... almost done, cutie~ 💕⏳'
    }
}

Lang.anchor = {
    notInWater = 'Da boaty not in wata! Find bubbwes fiwst~ 🚤💦',
    unanchored = 'You unanchowed youw boaty~ 🚤💨',
    anchored = 'You anchowed youw boaty~ 🚤⚓💖',
    noBoat = 'Whewe is youw boaty? Did it wun away?~ 🚤❓'
}

Lang.RepCommand = {
    header = 'Fwishin’ Wep OwO',
        fishing = 'Fwishin’ wevew: %s UwU',
        illegal = 'Iwwegaw fwishin’ wevew: %s 😿',
        magnet = 'Mag-net fwishin’ wevew: %s 🧲✨',
        description = 'Expewience p-pwoints: %s / %s 🍪',
}
return Lang