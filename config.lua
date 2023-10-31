Config = {}

Config.oxinv = true -- true if you use ox inv
Config.oxtarget = true -- true if you use ox targer
Config.PoliceChance = 99 -- needs to be 1-99 
Config.MaterialBreakdown = vector3(1110.03, -2008.0, 31.06) -- where you break down rusty materials for materials
Config.FishBuyer = vector3(-1808.63, -1176.74, 13.02) -- where you sell your fish
Config.ChumLoc = vector3(1023.8, -3036.87, 8.69) -- where you break down your fish to make chum for illegal fishing bait
Config.ShopLoc = vector3(1314.75, 4281.75, 33.91) -- where the shop is located to buy poles and bait
Config.AutoRecast = false -- if false players will have to reclick their pole for every catch
Config.TreasureChestObject = true -- this will put a chest on the ground people can third eye. if false it will run the event as a usuable item and not put a chest on the ground
Config.TreasureChestchance = 20 -- must be 1-100 chance to get a treasure chest while fishing

Config.FishingZones = { -- these locations will have blips and can do legal and magnet fishing
 vector3(-1849.2, -1230.44, 13.02),
 vector3(-3427.21, 967.53, 8.35),
vector3(1313.22, 4229.9, 33.92),
vector3(40.83, 848.72, 197.73)
}
 
 Config.illegalfishingzones = { -- these will have no blips and will only work with illegal fishing
vector3(1788.64, -3525.29, 0.54),
vector3(3190.5, -974.99, 0.37),
vector3(1235.08, 7926.63, -1.26),
vector3(-3196.07, 2601.24, 1.33)
}
 
 Config.spinnerfishies = { -- loot from spinners bait
 "largemouthbass",
 "panfish",
 "trout",
}
 
Config.softplasticbaitfishies = { -- loot from soft plastic bait
 "catfish",
 "whitebass",
 "salmon",
}
Config.plugbaitfishies = { -- loot from plug bait
 "steelhead",
 "bluefish",
 "halibut",
}
Config.wormsfishies = { -- loot from worms
 "flounder",
 "reddrum",
 "tunafish",
}
 
 
 
 Config.ChumFish = { -- these will be broken down to make illegal fish bait "chum"
  "flounder",
 "reddrum",
 "tunafish",
  "steelhead",
 "bluefish",
 "halibut",
  "catfish",
 "whitebass",
 "salmon",
  "largemouthbass",
 "panfish",
 "trout",
}
 
Config.IllegalFish = { -- the loot pool for illegal fishing using chum uses same pole as reg fishing
 "tigershark",
 "groundshark",
 "goblinshark", 		
 "stripeddolphin", 			
 "chileandolphin", 			
 "atlanticdolphin", 			
 "belugawhale",			
 "bluewhale", 			
 "narwhal", 			
 "spermwhale", 			
 "seaturtle", 	
 "tortoise", 			
 "leatherheadturtle", 			
}
 
Config.MagnetFishing = { -- loot from magnet fishing
 "rustyak",
 "rustypistol",
 "rustyshotgun", 		
 "rustybike", 			
 "rustysafe", 			
 "copperpipe", 			
 "closedsafe",			
 "sheetmetal", 			
 "rustysign", 			
 "rustytire", 			
 "rustywheelchair", 	
 "rustychain", 			
 "rustyantenna", 		
 "rustyelectronickit", 	
 "rustyscanner", 		
 "rustyraspberrypi", 	
 "rustyusb", 			
 "rustyscrapmetal", 	
}
 
 Config.Materials = { -- reward material for magnetfishing
 "metalscrap",
 "iron",
 "copper",
 "steel",
 "aluminum",
}
Config.Materialamount = 5 -- how many materials per item
 
 ---------------------- metadata amounts This is permanent levels 1 per fish catch. recommend setting high 
Config.tier1rep = 30 
Config.tier2rep = 60 -- amount to unlock magnet fishing
Config.tier3rep = 90
Config.tier4rep = 120
Config.tier5rep = 150
Config.tier6rep = 180
Config.tier7rep = 210 
Config.tier8rep = 240 
Config.tier9rep = 270
Config.tier10rep = 300 -- amount required to unlock illegal fishing
----------------------- time it takes between catches in ms 1000 = 1 second

Config.tierWaitTimer1 = 50000
Config.tierWaitTimer2 = 45000
Config.tierWaitTimer3 = 40000
Config.tierWaitTimer4 = 35000
Config.tierWaitTimer5 = 30000
Config.tierWaitTimer6 = 25000
Config.tierWaitTimer7 = 20000
Config.tierWaitTimer8 = 15000
Config.tierWaitTimer9 = 10000
Config.tierWaitTimer10 = 5000

--------------------------- fish shop 
Config.Items = { -- this is what is inside the shops for everything besides ox_inv. that is in the readme
    label = "Fishing Shop",
    slots = 7,
    items = {
        [1] = {name = "fishingpole", price = 1000,amount = 10, info = {}, type = "item", slot = 1},
        [2] = {name = "worms", price = 25, amount = 50, info = {}, type = "item", slot = 2},
		[3] = {name = "spinnerbait", price = 25, amount = 50, info = {}, type = "item", slot = 3},
		[4] = {name = "softplasticbait", price = 25, amount = 50, info = {}, slot = 4},
		[5] = {name = "plugbait", price = 25, amount = 50, info = {}, type = "item", slot = 5},
		[6] = {name = "magnet", price = 25, amount = 50, info = {}, type = "item", slot = 6},
		[7] = {name = "magnetpole", price = 1000, amount = 50, info = {}, type = "item", slot = 7},
	}
}

Config.TreasureChest = { -- loot from treasure chest rolls a math.random to see if you get 1 reward, 2 rewards, or 3 if you are really really lucky. the amount is math.random(1,3) for each item. change on line 137 server.lua if you want to give different amounts
"lockpick",
"goldbar",
"repairkit",
}


Config.FishSells = { -- this is the price of all the fish when you sell them. edit to your cities economy
    [1] = {
        label = 'flounder',
        price = 50
    },
    [2] = {
        label = 'reddrum',
        price = 50
    },
    [3] = {
        label = 'tunafish',
        price = 50
    },
    [4] = {
        label = 'tunafish',
        price = 50
    },
    [5] = {
        label = 'bluefish',
        price = 50
    },
    [6] = {
        label = 'halibut',
        price = 50
    },
    [7] = {
        label = 'steelhead',
        price = 50
    },
    [8] = {
        label = 'catfish',
        price = 50
    },
	[9] = {
        label = 'whitebass',
        price = 50
    },
    [10] = {
        label = 'salmon',
        price = 50
    },
    [11] = {
        label = 'largemouthbass',
        price = 50
    },
    [12] = {
        label = 'panfish',
        price = 50
    },
    [13] = {
        label = 'trout',
        price = 50
    },
    [14] = {
        label = 'tigershark',
        price = 50
    },
    [15] = {
        label = 'groundshark',
        price = 50
    },
	[16] = {
        label = 'goblinshark',
        price = 50
    },
    [17] = {
        label = 'stripeddolphin',
        price = 50
    },
    [18] = {
        label = 'largemouthbass',
        price = 50
    },
    [19] = {
        label = 'chileandolphin',
        price = 50
    },
    [20] = {
        label = 'atlanticdolphin',
        price = 50
    },
    [21] = {
        label = 'belugawhale',
        price = 50
    },
    [22] = {
        label = 'bluewhale',
        price = 50
    },
	[23] = {
        label = 'narwhal',
        price = 50
    },
    [24] = {
        label = 'spermwhale',
        price = 50
    },
    [25] = {
        label = 'seaturtle',
        price = 50
    },
    [26] = {
        label = 'tortoise',
        price = 50
    },
    [27] = {
        label = 'leatherheadturtle',
        price = 50
    },

}
