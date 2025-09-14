Lang = {}

Lang.Info = {
    currency = '💰',
    fishBuyer = 'THE FISH KINGPIN 💵🐠',
    fishShop = 'BAIT & BASS EMPORIUM 🛒🎛️',
    breakDown = 'MATERIAL MELTDOWN STATION 🧨🔧',
    yes = 'HECK YEAH, DROP THAT BEAT 🎶✅',
    no = 'NAH, THAT TRACK’S A SKIP ❌🎧'
}

Lang.Fails = {
    tooFar = ' %s WAS OUTTA RANGE LIKE A BROKEN WI-FI — GET CLOSER, DJ! 📶🚫',
    invalidItem = ' %s TRIED TO BUY A GHOST ITEM | %s | FROM %s — BRO, THAT’S NOT EVEN ON THE MENU 🛒👻',
    invalidBreakdown = ' %s TRIED TO SMASH A PHANTOM ITEM | %s | FROM %s — NAH, THAT AIN’T IN THE CATALOG 🚫📦',
    tooPoor = 'YOU BROKE, HOMIE — NO %s %s IN YA %s POCKET 🤑💔',
    zoneGlitch = '%s PULLED A GLITCH MOVE — md-fishing:server:inZone BUT NOT IN ZONE?! CHEAT CODE ACTIVATED? 🕹️👾',
    leftZone = 'YOU DIPPED OUTTA THE FISH ZONE MID-SET — CROWD BOOING 🐠🎤👎',
    onTimeout = 'TOO FAST, TOO FURIOUS — FISHIES SCARED, TEMPO TOO HIGH ⏱️🐟💨',
    outOfBait = 'BAIT BAR IS DRY — RELOAD THAT CLIP, SOLDIER 🎣🔫',
    inVehicle = ' NO FISHIN’ IN THE WHIP — PARK IT, POP THE TRUNK, THEN CAST 🚗🚫🎣',
    alreadyFishing = 'YOU’RE ALREADY ON THE DECK, SPINNING THAT REEL — ONE TRACK AT A TIME 🎛️✋',
    failedCatch = 'MISSED THE DROP — BUT THE OCEAN’S STILL BUMPIN’! NEXT TRACK, BABY 🌊⏭️'
}

Lang.Labels = {
    fishZoneBlip = 'FISH ZONE — DROP BEAT HERE 🐠📍',
    illegalFishzoneBlip = 'SHADY FISH ZONE — UNDERGROUND BASS ONLY 🕶️🎣',
    fishBuyerBlip = 'THE FISH KINGPIN — CASHOUT SPOT 💰👑',
    chumMakerBlip = 'CHUM LAB — COOKIN’ UP BAIT BEATS 🧪🍖',
    shopLocationBlip = 'BAIT & BASS EMPORIUM — SHOP THE DROP 🎧🛒',
    breakDownBlip = 'MATERIAL MELTDOWN — SMASH IT TO THE BEAT 🔨🔥'
}

Lang.Shops = {
    sold = 'YOU JUST SOLD %s OF %s FOR %s %s — THAT’S A PLATINUM TRACK, BABY 💿💸',
    noFish = ' YOU GOT NO %s — GO CATCH A BANGER, THEN COME BACK 🎣❌',
    bought = 'YOU JUST Copped %s OF %s FOR %s %s — NEW GEAR, NEW VIBES 🛍️🎧'
}

Lang.Fishing = {
    stopped = 'YOU PAUSED THE TRACK — TAKE A BREATH, DJ 🎧⏸️',
    notInZone = 'NOT IN THE FISH ZONE — FIND THE DROP ZONE, STAT 🗺️❗',
    wrongPole = 'WRONG ROD FOR THIS BEAT — SWITCH IT UP, PRO 🎚️🎣',
    noLevel = 'NO FISH DATA? RELOG — SERVER’S WAITIN’ ON YA 💾🔁',
    wrongLevel = 'YOU NEED LEVEL %s TO DROP BEATS HERE — LEVEL UP, ROOKIE 📈🎣',
    found = '🚨 BITE DETECTED — DROP THE HOOK, SPIN THAT REEL! 🎣💥',
    inZone = 'YOU’RE LOCKED IN THE FISH ZONE — LET’S GET THIS PARTY STARTED! 🐟🎉',
    outZone = 'YOU’RE OUTTA THE FISH ZONE — TIME TO RELOCATE, DJ! 🗺️🚫',
}

Lang.Targets = {
    fishBuyer = {
        label = 'CASH OUT YA FISHIES 💰🐠',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'SELL THE WHOLE ALBUM 📀💸',
            icon = 'fas fa-donate',
            description = 'ONE-CLICK SELL — ENTIRE TRACKLIST GONE, BABY!'
        },
        description = 'CASHOUT RATE: ' .. Lang.Info.currency .. '%s PER FISH 🎵',
        menuTitle = 'FISH KINGPIN CHECKOUT 💵🐟'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'SHOP THE DROP 🛒🎧',
        input = {
            title = 'COP %s — LIMITED EDITION 🎁',
            field1title = 'HOW MANY BARS?',
            field2title = 'PAYMENT VIBE',
            field2option1 = 'CASH MONEY 💵',
            field2option2 = 'BANK TRANSFER 🏦',
        },
        menuTitle = 'BAIT & BASS EMPORIUM 🎛️🎣'
    },
    chumMaker = {
        label = 'COOK UP CHUM BEATS 🍖🎛️',
        icon = 'fas fa-shopping-basket',
        description = 'TURN FISH INTO BAIT — PRODUCER MODE ACTIVATED',
        input = {
            title = 'CONFIRM BEAT COOKIN’?',
            field1title = 'DROP THE SAMPLE?',
            description = 'THIS’LL WIPE YA FISH TRACKS — NO UNDO 🚫🐠'
        },
        menuTitle = 'CHUM LAB — STUDIO SESSION 🧪🎧'
    },
    breakDown = {
        label = 'MATERIAL MELTDOWN 🧨🔧',
        icon = 'fas fa-dumpster-fire',
        description = 'SMASH GEAR INTO LOOT — MAKE IT RAIN PARTS',
        input = {
            description = 'BREAKIN’ DOWN %s — FEELS LIKE A REMIX 🎧',
        },
        menuTitle = 'MATERIAL MELTDOWN STATION 🔥📦',
        progressbar = 'BREAKIN’ %s — BEAT IN PROGRESS... 🎶⏳'
    }
}

Lang.anchor = {
    notInWater = 'BOAT’S ON DRY LAND — NO BEATS WITHOUT WATER, DJ 🚤❌💦',
    unanchored = 'ANCHOR’S UP — LET’S CRUISE TO THE NEXT DROP 🚤⚓➡️',
    anchored = 'ANCHOR DOWN — DROP THE BEAT RIGHT HERE 🚤⚓🎶',
    noBoat = 'WHERE’S YA BOAT, CAPTAIN? DID IT GHOST YA? 🚤👻'
}

return Lang