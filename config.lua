Config = {}

Config.oxtarget = false -- true if you use ox target
Config.PoliceChance = 20 -- needs to be 1-99 
Config.MaterialBreakdown = vector3(1087.63, -2001.71, 30.88) -- where you break down rusty materials for materials
Config.FishBuyer = vector4(-1814.64, -1194.00, 13.02, 238.98) -- where you sell your fish
Config.ChumLoc = vector4(1026.52, -3037.92, 8.69, 350.03) -- where you break down your fish to make chum for illegal fishing bait
Config.ShopLoc = vector4(1314.10, 4282.58, 33.91, 240.26) -- where the shop is located to buy poles and bait
Config.AutoRecast = true -- if false players will have to reclick their pole for every catch
Config.TreasureChestObject = true -- this will put a chest on the ground people can third eye. if false it will run the event as a usuable item and not put a chest on the ground
Config.TreasureChestchance = 20 -- must be 1-100 chance to get a treasure chest while fishing
Config.LevelUpAmount = 60 -- amount of fish required to level up
Config.imagelink = 'qb-inventory/html/images/'
Config.StarIllLvl = 5 -- level required of regular fishing to be allowed to start illegal fishing

---------------------------------- BRIDGE 
Config.Notify = 'ox' -- qb or ox (okok is experimental)
Config.progressbartype = 'qb' -- qb or oxbar or oxcir
Config.minigametype = 'ox' -- qb or ox
Config.Dispatch = 'ps' -- ps or cd or core or aty
Config.FreezePlayerWhileFishing = true -- keeps players from moving while fishing 

Config.FishingZones = { -- these locations will have blips and can do legal and magnet fishing
    {loc = vector3(-1849.2, -1230.44, 13.02), radius = 30, debug = false, enabled = true },
    {loc = vector3(-3427.21, 967.53, 8.35),   radius = 30, debug = false, enabled = true },
    {loc = vector3(1313.22, 4229.9, 33.92),   radius = 30, debug = false, enabled = true },
    {loc = vector3(40.83, 848.72, 197.73),    radius = 30, debug = false, enabled = true },
}
 Config.Blips = {
    {loc =  vector3(-1849.2, -1230.44, 13.02),  sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true},
    {loc =  vector3(-3427.21, 967.53, 8.35),    sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true},
    {loc =  vector3(1313.22, 4229.9, 33.92),    sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true},
    {loc =  vector3(40.83, 848.72, 197.73),     sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true},
    {loc =  vector3(-1808.63, -1176.74, 13.02), sprite = 500, scale = 0.55, color = 2, label = 'Fish Buyer', enabled = true},
    {loc =  vector3(1314.75, 4281.75, 33.91),   sprite = 500, scale = 0.55, color = 2, label = 'Fishing Store', enabled = true},

 }
 Config.illegalfishingzones = { -- these will have no blips and will only work with illegal fishing
    {loc =  vector3(1788.64, -3525.29, 0.54), radius = 250, debug = false, enabled = true },
    {loc =  vector3(3190.5, -974.99, 0.37),   radius = 250, debug = false, enabled = true },
    {loc =  vector3(1235.08, 7926.63, -1.26), radius = 250, debug = false, enabled = true },
    {loc =  vector3(-3196.07, 2601.24, 1.33), radius = 250, debug = false, enabled = true },
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
    {item = "metalscrap",   min = 1, max = 5},
    {item = "iron",         min = 1, max = 5},
    {item = "copper",       min = 1, max = 5},
    {item = "steel",        min = 1, max = 5},
    {item = "aluminum",     min = 1, max = 5},
} 
Config.Materialamount = 5 -- how many materials per item
Config.Levels = { -- in seconds how long it takes to catch 1 fish by your level.
    [0] =  {time = 55},
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

--------------------------- fish shop 
Config.Items = { -- this is what is inside the shops 
    ["fishingpole"]     = { price = 1000, amount = 1},
    ["worms"]           = { price = 25, amount = 50},
	["spinnerbait"]     = { price = 25, amount = 50},
	["softplasticbait"] = { price = 25, amount = 50},
	["plugbait"]        = { price = 25, amount = 50},
	["magnet"]          = { price = 25, amount = 50},
	["magnetpole"]      = { price = 10, amount = 1},
    ["illegalpole"]     = { price = 10000, amount = 1},
}

Config.TreasureChest = { -- random loot you get from treasure chests
     {item = 'lockpick', min = 1, max = 3},
     { item = 'goldbar',min = 1, max = 3},
     { item = 'repairkit', min = 1, max = 3},
}


Config.FishSells = { -- how much each fish will sell for
    ['flounder']          = {price = 50},
    ['reddrum']           = {price = 50},
    ['tunafish']          = {price = 50},
    ['bluefish']          = {price = 50},
    ['halibut']           = {price = 50},
    ['steelhead']         = {price = 50},
    ['catfish']           = {price = 50},
    ['whitebass']         = {price = 50},
    ['salmon']            = {price = 50},
    ['panfish']           = {price = 50},
    ['trout']             = {price = 50},
    ['tigershark']        = {price = 50},
    ['groundshark']       = {price = 50},
    ['goblinshark']       = {price = 50},
    ['stripeddolphin']    = {price = 50},
    ['largemouthbass']    = {price = 50},
    ['chileandolphin']    = {price = 50},
    ['atlanticdolphin']   = {price = 50},
    ['belugawhale']       = {price = 50},
    ['bluewhale']         = {price = 50},
    ['narwhal']           = {price = 50},
    ['spermwhale']        = {price = 50},
    ['seaturtle']         = {price = 50},
    ['tortoise']          = {price = 50},
    ['leatherheadturtle'] = {price = 50},

}
