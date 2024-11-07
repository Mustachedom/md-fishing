Config = {}

Config.PoliceChance = 20 -- needs to be 1-99 
Config.MaterialBreakdown = vector3(1087.63, -2001.71, 30.88) -- where you break down rusty materials for materials
Config.FishBuyer = vector4(-1814.64, -1194.00, 13.02, 238.98) -- where you sell your fish
Config.ChumLoc = vector4(1026.52, -3037.92, 8.69, 350.03) -- where you break down your fish to make chum for illegal fishing bait
Config.ShopLoc = vector4(1314.10, 4282.58, 33.91, 240.26) -- where the shop is located to buy poles and bait
Config.AutoRecast = true -- if false players will have to reclick their pole for every catch
Config.TreasureChestObject = true -- this will put a chest on the ground people can third eye. if false it will run the event as a usuable item and not put a chest on the ground
Config.TreasureChestchance = 5 -- must be 1-100 chance to get a treasure chest while fishing
Config.LevelUpAmount = 60 -- amount of fish required to level up
Config.StarIllLvl = 5 -- level required of regular fishing to be allowed to start illegal fishing

---------------------------------- BRIDGE 
Config.Minigames = {
    ps_circle =     {amount = 2,     speed = 8,},
    ps_maze =       {timelimit = 15},
    ps_scrambler =  {type = 'numeric', time = 15, mirrored = 0},
    ps_var =        {numBlocks = 5, time = 10},
    ps_thermite =   {time = 10, gridsize = 5, incorrect = 3},
    ox =            {'easy', 'easy'},   --easy medium or hard each one corresponds to how many skillchecks and the difficulty
    blcirprog =     {amount = 2,     speed = 50},       -- speed = 1-100
    blprog =        {amount = 1,     speed = 50},       -- speed = 1-100
    blkeyspam =     {amount = 1,     difficulty = 50}, -- difficulty = 1-100
    blkeycircle =   {amount = 1,     difficulty = 50, keynumbers = 3},
    blnumberslide = {amount = 1,     difficulty = 50, keynumbers = 3},
    blrapidlines =  {amount = 1,     difficulty = 50, numberofline = 3},
    blcircleshake = {amount = 1,     difficulty = 50, stages = 3},
    glpath =        {gridSize = 19,  lives = 3,     timelimit = 10000},
    glspot =        {gridSize = 6, timeLimit = 999999, charSet = "alphabet", required = 10},
    glmath =        {timeLimit = 300000},
}

Config.minigametype = 'ox' -- look above for options or choose none if you dont want any minigames 
Config.Notify = 'ox' -- qb or ox (okok is experimental)
Config.progressbartype = 'qb' -- qb or oxbar or oxcir
Config.minigametype = 'ox' -- ps or ox
Config.Dispatch = 'ps' -- ps or cd or core or aty
Config.FreezePlayerWhileFishing = true -- keeps players from moving while fishing 
Config.Target = 'ox'

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
    {loc =  Config.FishBuyer,                   sprite = 500, scale = 0.55, color = 2, label = 'Fish Buyer',   enabled = true},
    {loc =  Config.ShopLoc,                     sprite = 500, scale = 0.55, color = 2, label = 'Fishing Store',enabled = true},

 }

 Config.illegalfishingzones = { -- these will have no blips and will only work with illegal fishing
    {loc =  vector3(1788.64, -3525.29, 0.54), radius = 250, debug = false, enabled = true },
    {loc =  vector3(3190.5, -974.99, 0.37),   radius = 250, debug = false, enabled = true },
    {loc =  vector3(1235.08, 7926.63, -1.26), radius = 250, debug = false, enabled = true },
    {loc =  vector3(-3196.07, 2601.24, 1.33), radius = 250, debug = false, enabled = true },
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
