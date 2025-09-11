Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'The Greedy Fuck Who Buys Your Trash Fish',
    fishShop = 'Dumpster of Desperation (aka “Shop”)',
    breakDown = 'Where You Admit Defeat and Melt Your Failures',
    yes = 'Fine. Whatever.',
    no = 'Hell no, dumbass.'
}

Lang.Fails = {
    tooFar = ' %s was too far from %s — did you forget how to walk, genius?',
    invalidItem = ' %s tried to buy some made-up bullshit | %s | from %s — are you high or just braindead?',
    invalidBreakdown = ' %s tried to break down something that doesn’t exist | %s | from %s — congrats, you broke reality. Still didn’t fix your IQ.',
    tooPoor = 'You’re broke as hell — no %s %s in your sad little %s account. Go cry about it.',
    zoneGlitch = '%s triggered md-fishing:server:inZone but wasn’t actually in the damn zone — either you’re cheating or you’re retarded. Flip a coin.',
    leftZone = 'You wandered out of the fishing zone like a lost toddler. Sit the fuck down and focus.',
    onTimeout = 'You’re spamming like a 12-year-old with ADHD — slow the fuck down, the fish aren’t running from you, they’re laughing at you.',
    outOfBait = 'Ran out of bait? That’s what happens when you don’t plan. Surprise! You’re an idiot.',
    inVehicle = ' You think you’re James Bond? Get your ass out of the car and stand like a real fisherman, you lazy sack of shit.',
    alreadyFishing = 'You’re already fishing, Einstein. Did you forget your own hands are moving? Take a nap.',
    failedCatch = 'Missed it? Shocking. Maybe if you weren’t built like a participation trophy, you’d catch something.'
}

Lang.Labels = {
    fishZoneBlip = 'Where You’re Supposed to Stand (Try Not to Wander Off, Toddler)',
    illegalFishzoneBlip = 'Where Criminals and Idiots Fish (You Belong Here)',
    fishBuyerBlip = 'Guy Who Pities You Enough to Buy Your Garbage',
    chumMakerBlip = 'Where You Sacrifice Your Dignity for Bait (Worth It)',
    shopLocationBlip = 'Where Hope Goes to Die (But You’ll Go Anyway)',
    breakDownBlip = 'Admit You Fucked Up and Salvage the Wreckage',
}

Lang.Shops = {
    sold = 'You sold %s of %s for %s %s — congrats, you made less than a Starbucks barista.',
    noFish = ' You didn’t even have %s? Jesus. Just quit now.',
    bought = 'You bought %s of %s for %s %s — wasting money like it’s your job. Oh wait, it is.',
}

Lang.Fishing = {
    stopped = 'You stopped fishing — finally, a smart decision. Take a break. You’ve earned it (by being terrible).',
    notInZone = 'You’re not even in the goddamn zone. Did you get lost between your chair and the screen?',
    wrongPole = 'Wrong pole, dumbass. Did you think this was IKEA? Read the fucking manual.',
    noLevel = 'No fishing data? Re-log. And maybe re-think your life choices while you’re at it.',
    wrongLevel = 'You need to be level %s to fish here — but your skill level is currently “potato”. Come back when you’re relevant.',
    found = 'Oh wow, a bite! Don’t fuck it up this time, champ.'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Sell Your Pathetic Fish',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Sell All (Because You’re Lazy)',
            icon = 'fas fa-donate',
            description = 'One-click sell because you can’t be bothered to think. Perfect for you.'
        },
        description = 'Sell for ' .. Lang.Info.currency .. '%s each — it’s charity pricing, really.',
        menuTitle = 'Beg for Money (Fish Edition)'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Waste Your Money Here',
        input = {
            title = 'Buy %s (You’ll Regret It)',
            field1title = 'How Many Stupid Purchases?',
            field2title = 'How Are You Paying For This Mistake?',
            field2option1 = 'Cash (Like a Peasant)',
            field2option2 = 'Bank (Still Broke, Just Fancier)',
        },
        menuTitle = 'Store of Broken Dreams'
    },
    chumMaker = {
        label = 'Turn Your Failures Into Bait',
        icon = 'fas fa-shopping-basket',
        description = 'Destroy everything you worked for to make bait. Poetic.',
        input = {
            title = 'Are You Sure You Want To Be This Dumb?',
            field1title = 'Click Yes, You Glutton for Punishment',
            description = 'This deletes all your fish. Like your dignity. Gone. Forever.'
        },
        menuTitle = 'Chum Maker (aka “Hope Crusher”)'
    },
    breakDown = {
        label = 'Admit Defeat',
        icon = 'fas fa-dumpster-fire',
        description = 'Break your shit down because you can’t use it right. Classic you.',
        input = {
            description = 'Breaking down %s because you failed to use it properly.',
        },
        menuTitle = 'Graveyard of Your Mistakes',
        progressbar = 'Slowly Realizing How Bad You Are At This: %s'
    }
}

Lang.anchor = {
    notInWater = 'Your boat’s on dry land, Einstein. Did you forget what water is?',
    unanchored = 'You unanchored your boat — congratulations, you did one thing right today.',
    anchored = 'You anchored your boat. Wow. Should we throw you a parade?',
    noBoat = 'Where’s your boat? Did you sell it for ramen again?',
}

return Lang