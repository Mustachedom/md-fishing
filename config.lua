Config = {}
ps = exports.ps_lib:init()
ps.loadLangs("en") -- set your languages folder name here

Config.AutoRecast = true -- if false players will have to reclick their pole for every catch
Config.FreezePlayerWhileFishing = true -- keeps players from moving while fishing 
Config.AlertInZone = true -- alerts players when they enter a fishing zone
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
Config.Levels = { -- in seconds how long it takes to catch 1 fish by your level.
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
