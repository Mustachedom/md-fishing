Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'Fischhändler',
    fishShop = 'Angelladen',
    breakDown = 'Materialzerlegung',
    yes = 'Ja',
    no = 'Nein',
}

Lang.Fails = {
    tooFar = ' %s war zu weit entfernt von %s',
    invalidItem = ' %s hat versucht, einen ungültigen Gegenstand | %s | von %s zu kaufen',
    invalidBreakdown = ' %s hat versucht, einen ungültigen Gegenstand | %s | von %s zu zerlegen',
    tooPoor = 'Du hast nicht genug %s %s in %s',
    zoneGlitch = '%s hat md-fishing:server:inZone ausgelöst, war aber nicht innerhalb der Zonen-Koordinaten',
    leftZone = 'Du hast die Angelzone während des Angelns verlassen!',
    onTimeout = 'Du angelst etwas zu schnell – die Fische haben Angst!',
    outOfBait = 'Dir ist der Köder ausgegangen',
    inVehicle = ' Du kannst nicht in einem Fahrzeug angeln!',
    alreadyFishing = 'Du angelst bereits!',
    failedCatch = 'Nun ja, es gibt noch mehr Fische im Meer'
}

Lang.Labels = {
    fishZoneBlip = 'Angelzone',
    illegalFishzoneBlip = 'Illegale Angelzone',
    fishBuyerBlip = 'Fischhändler',
    chumMakerBlip = 'Köderhersteller',
    shopLocationBlip = 'Angelladen',
    breakDownBlip = 'Materialzerlegung',
}

Lang.Shops = {
    sold = 'Du hast %s von %s für %s %s verkauft',
    noFish = ' Du hattest keine %s zum Verkaufen',
    bought = 'Du hast %s von %s für %s %s gekauft',
}

Lang.Fishing = {
    stopped = 'Du hast das Angeln beendet',
    notInZone = 'Du bist nicht in einer Angelzone',
    wrongPole = 'Du kannst diese Angelrute hier nicht benutzen',
    noLevel = 'Du hast keine Angel-Daten – bitte melde dich erneut an',
    wrongLevel = 'Du musst Level %s sein, um hier zu angeln',
    found = 'Du hast einen Biss!',
    inZone = 'Du bist jetzt in einer Angelzone',
    outZone = 'Du bist jetzt außerhalb der Angelzone',
}

Lang.Targets = {
    fishBuyer = {
        label = 'Verkaufe deine Fische',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Alles verkaufen',
            icon = 'fas fa-donate',
            description = 'Verkaufe alle deine Fische auf einmal!'
        },
        description = 'Verkauf für ' .. Lang.Info.currency .. '%s pro Stück',
        menuTitle = 'Fische verkaufen'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Shop durchsuchen',
        input = {
            title = 'Kaufe %s',
            field1title = 'Wie viele kaufen',
            field2title = 'Zahlungsart',
            field2option1 = 'Bargeld',
            field2option2 = 'Bank',
        },
        menuTitle = 'Angelladen'
    },
    chumMaker = {
        label = 'Köder herstellen',
        icon = 'fas fa-shopping-basket',
        description = 'Stelle Köder für den Fang her',
        input = {
            title = 'Bestätige die Köderherstellung',
            field1title = 'Bestätigung',
            description = 'Dies entfernt alle deine Fische'
        },
        menuTitle = 'Köder herstellen'
    },
    breakDown = {
        label = 'Materialzerlegung',
        icon = 'fas fa-dumpster-fire',
        description = 'Zerlege Gegenstände in Materialien',
        input = {
            description = 'Zerlege %s in Materialien',
        },
        menuTitle = 'Materialzerlegung',
        progressbar = 'Zerlege %s'
    }
}

Lang.anchor = {
    notInWater = 'Das Boot ist nicht im Wasser!',
    unanchored = 'Du hast dein Boot losgemacht',
    anchored = 'Du hast dein Boot verankert',
    noBoat = 'Wo ist dein Boot?',
}

Lang.RepCommand = {
    header = 'Angel-Reputation',
    fishing = 'Angel-Level: %s',
    illegal = 'Illegaler Angel-Level: %s',
    magnet = 'Magnet-Angel-Level: %s',
    description = 'XP: %s / %s',
}
return Lang