activeFishers = {} -- no touch
inZonePlayers = {} -- no touch
timeouts = {} -- no touch
cacheSQL = {} -- no touch

locations = {
	fishingZones = { -- fishing and magnet fishing allowed here
		{loc = vector3(-1849.2, -1230.44, 13.02), radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
    	{loc = vector3(-3427.21, 967.53, 8.35),   radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
    	{loc = vector3(1313.22, 4229.9, 33.92),   radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
    	{loc = vector3(40.83, 848.72, 197.73),    radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
	},
	illegalFishingZones = { -- only illegal fishing allowed here
		{loc = vector3(1788.64, -3525.29, 0.54), radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = true} },
		{loc = vector3(3190.5, -974.99, 0.37),   radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = false} },
		{loc = vector3(1235.08, 7926.63, -1.26), radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = false} },
		{loc = vector3(-3196.07, 2601.24, 1.33), radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = false} },
	},
	fishBuyers = { -- sell your fish here
		{loc = vector4(-1814.64, -1194.00, 13.02-1, 238.98), ped = 'a_f_m_bevhills_02', enabled = true, blipData = {sprite = 272, scale = 0.8, color = 2, label = ps.lang('Labels.fishBuyerBlip'), enabled = true} },
	},
	chumMaker = {  -- exchange fish for chum here
		{loc = vector4(1026.52, -3037.92, 8.69-1, 350.03), ped = 's_m_y_dealer_01', enabled = true, blipData = {sprite = 272, scale = 0.8, color = 2, label = ps.lang('Labels.chumMakerBlip'), enabled = true} },
	},
	shopLocation = { -- where to buy fishing supplies
		{loc = vector4(1314.10, 4282.58, 33.91-1, 240.26), ped = 's_m_y_dealer_01', enabled = true, blipData = {sprite = 272, scale = 0.8, color = 2, label = ps.lang('Labels.shopLocationBlip'), enabled = true} },
	},
	breakDown = { -- where to break down rusty items
		{loc = vector3(1088.14, -2002.14, 30.88), blipData = {sprite = 365, scale = 0.8, color = 2, label = ps.lang('Labels.breakDownBlip'), enabled = true}}
	}
}

StarIllLvl = 5 -- level required of regular fishing to be allowed to start illegal fishing

LevelUpAmount = 60 -- amount of fish required to level up
levelTime = { -- in seconds how long it takes to catch 1 fish by your level.
    [0] =  {time = 5},
    [1] =  {time = 50},
    [2] =  {time = 45},
    [3] =  {time = 40},
    [4] =  {time = 35},
    [5] =  {time = 30},
    [6] =  {time = 25},
    [7] =  {time = 20},
    [8] =  {time = 15},
    [9] =  {time = 10},
    [10] = {time = 5},
}

stores = {
	fishShop = { -- what the shop sells left is item | right is price
		fishingpole = 1000,
		worms = 25,
		spinnerbait = 25,
        softplasticbait = 25,
		plugbait = 25,
		magnet = 25,
		magnetpole = 1000,
		illegalpole = 10000,
    },
	fishSales = { -- what the fish buyer buys left is item | right is price
        flounder          = 50,
        reddrum           = 50,
        tunafish          = 50,
        bluefish          = 50,
        halibut           = 50,
        steelhead         = 50,
        catfish           = 50,
        whitebass         = 50,
        salmon            = 50,
        panfish           = 50,
        trout             = 50,
        tigershark        = 50,
        groundshark       = 50,
        goblinshark       = 50,
        stripeddolphin    = 50,
        largemouthbass    = 50,
        chileandolphin    = 50,
        atlanticdolphin   = 50,
        belugawhale       = 50,
        bluewhale         = 50,
        narwhal           = 50,
        spermwhale        = 50,
        seaturtle         = 50,
        tortoise          = 50,
        leatherheadturtle = 50,
	}
}


baitTypes = {
	fishingpole = { -- the type of pole can use this bait
		spinnerbait = {-- key value is bait item name, the value array is the fish that bait can catch
			"largemouthbass", "panfish", "trout"
		},
		softplasticbait = {
			"catfish", "whitebass", "salmon"
		},
		plugbait = {
			"steelhead", "bluefish", "halibut"
		},
		worms = {
			"flounder", "reddrum", "tunafish"
		},
	},
	magnetpole = {
		magnet = {
			"rustyak", "rustypistol", "rustyshotgun", "rustybike", "rustysafe", "copperpipe", "closedsafe", "sheetmetal", "rustysign", "rustytire",
			"rustywheelchair", "rustychain", "rustyantenna", "rustyelectronickit", "rustyscanner", "rustyraspberrypi", "rustyusb", "rustyscrapmetal",
		},
	},
	illegalpole = {
		chum = {
			"tigershark", "groundshark", "goblinshark", "stripeddolphin", "chileandolphin", "atlanticdolphin",
			"belugawhale", "bluewhale", "narwhal", "spermwhale", "seaturtle", "tortoise", "leatherheadturtle",
		},
	},
}


breakDown = {
	rustyak            = { -- item to break down
		items = {"metalscrap", "iron","copper", "steel", "aluminum"}, -- array of items to randomly give on breakdown | only chooses 1 item from the array
		amount = {min = 1, max = 3} -- amount of the items above to give
	},
    rustypistol         = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyshotgun	    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustybike		    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustysafe	        = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    copperpipe		    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    closedsafe		    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    sheetmetal		    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustysign			= {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustytire			= {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustywheelchair	    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustychain	        = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyantenna        = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyelectronickit  = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyscanner	    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyraspberrypi    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyusb		    = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
    rustyscrapmetal     = {
		items = {"metalscrap", "iron","copper", "steel", "aluminum"},
		amount = {min = 1, max = 3}
	},
}

chumMake = { -- % of the amount of fish will be turn to chum, example 100 fish = 90
	flounder = 0.8,
	reddrum = 0.8,
	tunafish = 0.8,
	steelhead = 0.8,
	bluefish = 0.8,
	halibut = 0.8,
	catfish = 0.8,
	whitebass = 0.8,
	salmon = 0.8,
	largemouthbass = 0.8,
	panfish = 0.8,
	trout = 0.8,
}