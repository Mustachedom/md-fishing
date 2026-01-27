Lang = {}

Lang.Warns = {
    tooFar = 'Player: %s Tried To Exploit The Event: %s They Were %s Vectors Away From Where They Should Be.',
    invalidItemFishShop = 'Player: %s Tried To Buy An Invalid Item: %s At The Fish Shop.  \n  This Is NOT In The Shop So They Are Most Likely Using A Menu To Try To Exploit',
    invalidBreakDownItem = 'Player: %s Tried To Break Down An Invalid Item: %s At The Breakdown Location.  \n  This Is NOT In The Breakdown List So They Are Most Likely Using A Menu To Try To Exploit',
    zoneGlitch = 'Player: %s Tried To Exploit The Zone Glitch By Triggering Event: %s While They Were %s Vectors Away From The Center',
    onTimeout = 'Player: %s Is On Timeout But Somehow Triggered Event: %s',
    notInZone = 'Player: %s Tried To Fish While Not In A Fishing Zone By Triggering Event: %s',
}

Lang.Notify = {
    shopsSold = "You Sold %s %s For A Total Of $%s",
    noFish = "You Don't Have Any %s To Sell",
    shopsBought = "You Bought %s %s For A Total Of $%s",
    tooPoor = "You Are Broke As Shit. Cant Even Afford %s",
    leftZone = 'You Have Left The Fishing Zone!',
    stoppedFishing = 'You Have Stopped Fishing!',
    notInZone = 'You Cant Fish Here Silly Goose!',
    wrongPole = 'Woah There, This Pole Is A Little To Risky Here!',
    tooWeak = 'You Need To Get A Little Better At Fishing Before Trying To Do This! Come Back At Level %s',
    outOfBait = 'You Are Out Of Bait!',
    gotABite = 'Sweet! You Got A Bite!',
    enteredZone = "You Should Take A Fishing Pole Out!",
    outOfZone = 'You Put Your Fishing Pole Away!',
    inVehicle = 'How You Gonna Fish In A Vehicle?',
    alreadyFishing = 'You Cant Double Fish! Whats Next Double Jumping?',
    failedCatch = 'Damn That Fish Got Away!',
    notInWater = 'You Gonna Anchor Your Boat On Land?',
    unanchored = 'You Unanchored Your Boat!',
    anchored = 'You Anchored Your Boat!',
    noBoat = 'You Dont Have Anything To Anchor!'
}

Lang.Targets = {
    fishBuyer = {
        icon = 'fas fa-fish',
        label = 'Sell Your Fish!',
        Menu = {
            sellAllTitle = 'Sell All Your Fish!',
            sellAllIcon = 'fas fa-coins',
            sellAllDescription = 'Sell All Your Fish At Once!',
            menuTitle = 'Fish Buyer',

        }
    },
    shops = {
        icon = 'fas fa-shopping-basket',
        label = 'Buy Fishing Supplies!',
        input = {
            title = 'How Many %s Would You Like To Buy?',
            fieldOneTitle = 'Amount To Buy',
            fieldTwoTitle = 'Select Payment Method',
            fieldTwoOption1 = 'Cash',
            fieldTwoOption2 = 'Bank',
            menuTitle = 'Fishing Shop',
        }
    },
    chumMaker = {
        icon = 'fas fa-drumstick-bite',
        label = 'Exchange Fish For Chum!',
        input = {
            title = 'Do You Want To Exchange Fish For Chum?',
            field1Title = 'Confirm Exchange',
            field1Description = 'Select Yes To Exchange Your Fish For Chum',
            menuTitle = 'Chum Maker',
            yes = 'Yes',
            no = 'No',
        }
    },
    breakDown = {
        icon = 'fas fa-recycle',
        label = 'Break Down Rusty Items!',
        description = 'Break Down Your %s Into Useful Materials!',
        progressbar = 'Breaking Down %s',
        menuTitle = 'Rusty Item Breakdown',
    }
}

Lang.Command = {
    Rep = '%s : %s',
    RepDescription = '%s / %s',
    id = 'fishing_reputation_menu',
    header = 'Fishing Reputation Levels',
}