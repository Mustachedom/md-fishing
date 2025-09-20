Config = {}
ps = exports.ps_lib:init()
ps.loadLangs("en") -- set your languages folder name here
Config.OldData = false -- if you used the old version of the script set this to true to convert your data
Config.AutoRecast = true -- if false players will have to reclick their pole for every catch
Config.FreezePlayerWhileFishing = true -- keeps players from moving while fishing 
Config.AlertInZone = true -- alerts players when they enter/leave a fishing zone

---------------------------------- BRIDGE 
Config.Minigames = {
    ps_circle =     {amount = 2,     speed = 8,},
    ox =            {'easy', 'easy'},   --easy medium or hard each one corresponds to how many skillchecks and the difficulty
    blcirprog =     {amount = 2,     speed = 50},       -- speed = 1-100
    blprog =        {amount = 1,     speed = 50},       -- speed = 1-100
    blkeyspam =     {amount = 1,     difficulty = 50}, -- difficulty = 1-100
    blkeycircle =   {amount = 1,     difficulty = 50, keynumbers = 3},
    blnumberslide = {amount = 1,     difficulty = 50, keynumbers = 3},
    blrapidlines =  {amount = 1,     difficulty = 50, numberofline = 3},
    blcircleshake = {amount = 1,     difficulty = 50, stages = 3},
}

Config.minigametype = 'ox' -- look above for options or choose none if you dont want any minigames
