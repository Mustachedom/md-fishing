
local poles = {'fishingpole', 'magnetpole', 'illegalpole'}

local locations = {
	fishingZones = {
		{loc = vector3(-1849.2, -1230.44, 13.02), radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true} },
    	{loc = vector3(-3427.21, 967.53, 8.35),   radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true} },
    	{loc = vector3(1313.22, 4229.9, 33.92),   radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true} },
    	{loc = vector3(40.83, 848.72, 197.73),    radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Fishing Zone', enabled = true} },
	},
	illegalFishingZones = {
		{loc = vector3(1788.64, -3525.29, 0.54), radius = 250, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Illegal Fishing Zone', enabled = false} },
		{loc = vector3(3190.5, -974.99, 0.37),   radius = 250, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Illegal Fishing Zone', enabled = false} },
		{loc = vector3(1235.08, 7926.63, -1.26), radius = 250, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Illegal Fishing Zone', enabled = false} },
		{loc = vector3(-3196.07, 2601.24, 1.33), radius = 250, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = 'Illegal Fishing Zone', enabled = false} },
	},
	fishBuyers = {
		{loc = vector4(-1814.64, -1194.00, 13.02, 238.98), ped = 'a_f_m_bevhills_02', enabled = true, blipData = {sprite = 403, scale = 0.55, color = 2, label = 'Fish Buyer', enabled = true} },
	},
	chumMaker = {
		{loc = vector4(1026.52, -3037.92, 8.69, 350.03), ped = 's_m_y_dealer_01', enabled = true, blipData = {sprite = 403, scale = 0.55, color = 2, label = 'Chum Maker', enabled = true} },
	},
	shopLocation = {
		{loc = vector4(1314.10, 4282.58, 33.91, 240.26), ped = 's_m_y_dealer_01', enabled = true, blipData = {sprite = 403, scale = 0.55, color = 2, label = 'Fishing Shop', enabled = true} },
	}
}

ps.registerCallback('md-fishing:server:getLocations', function(source)
	return locations
end)

local stores = {
	fishShop = { -- what the shop sells
        {name = 'fishingpole', price = 1000, amount = 1},
        {name = 'worms', price = 25, amount = 50},
	    {name = 'spinnerbait', price = 25, amount = 50},
	    {name = 'softplasticbait', price = 25, amount = 50},
	    {name = 'plugbait', price = 25, amount = 50},
	    {name = 'magnet', price = 25, amount = 50},
	    {name = 'magnetpole', price = 10, amount = 1},
        {name = 'illegalpole', price = 10000, amount = 1},
    },

	fishSales = { -- what the fish buyer buys
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
ps.registerCallback('md-fishing:server:getStores', function(source, type, location)
	local src = source
	if type == 'fishSales' then
		if not ps.checkDistance(src, locations['fishBuyers'][location].loc, 5.0) then
			ps.notify(src, 'You Are Too Far From The Fish Buyer', 'error')
			return
		end
		return stores.fishSales
	end
	if type == 'fishShop' then
		if not ps.checkDistance(src, locations['shopLocation'][location].loc, 5.0) then
			ps.notify(src, 'You Are Too Far From The Shop', 'error')
			return
		end
		return stores.fishShop
	end
	return nil
end)

RegisterNetEvent('md-fishing:server:sellFish', function(fish, loc)
	local src = source
	if not ps.checkDistance(src, locations['fishBuyers'][loc].loc, 5.0) then
		ps.notify(src, 'You Are Too Far From The Fish Buyer', 'error')
		return
	end
	if fish == 'all' then
		for k, v in pairs (stores.fishSales) do
			local itemCount = ps.getItemCount(src, k)
			if itemCount > 0 then
				local total = itemCount * v
				if ps.removeItem(src, k, itemCount) then
					ps.addMoney(src, 'cash', total, 'sold-fish')
					ps.notify(src, 'You Sold '.. itemCount ..' '.. ps.getLabel(k) ..' For $'.. total)
				end
			end
		end
		return
	end
	if not stores.fishSales[fish] then return end
	local itemCount = ps.getItemCount(src, fish)
	if itemCount > 0 then
		local total = itemCount * stores.fishSales[fish]
		if ps.removeItem(src, fish, itemCount) then
			ps.addMoney(src, 'cash', total, 'sold-fish')
			ps.notify(src, 'You Sold '.. itemCount ..' '.. ps.getLabel(fish) ..' For $'.. total)
		end
	else
		ps.notify(src, 'You Have No '.. ps.getLabel(fish), 'error')
	end
end)

local baitTypes = {
	fishingpole = { -- the type of pole can use this bait
		spinner = {-- key value is bait item name, the value array is the fish that bait can catch
			"largemouthbass", "panfish", "trout"
		},
		softplastic = {
			"catfish", "whitebass", "salmon"
		},
		plug = {
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
		illegal = {
			"tigershark", "groundshark", "goblinshark", "stripeddolphin", "chileandolphin", "atlanticdolphin",
			"belugawhale", "bluewhale", "narwhal", "spermwhale", "seaturtle", "tortoise", "leatherheadturtle",
		},
	},
}


local breakDown = {
		rustyak            = {
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

local activeFishers = {}
local inZonePlayers = {}

RegisterNetEvent('md-fishing:server:inZone', function(locationType, location)
	local src = source
	local distance = #(GetEntityCoords(GetPlayerPed(src)) - locations[locationType][location].loc)
	if distance > locations[locationType][location].radius then
		ps.notify(src, 'You Left The Fishing Zone', 'error')
		return
	end
	inZonePlayers[ps.getIdentifier(src)] = {type = locationType, loc = location}
end)

RegisterNetEvent('md-fishing:server:outZone', function()
	local src = source
	local identifier = ps.getIdentifier(src)
	inZonePlayers[identifier] = nil
	if activeFishers[identifier] then
		ps.notify(src, 'You Left The Fishing Zone', 'error')
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
	end
end)

local function getPoleType(pole)
	if pole == 'fishingpole' then
		return 'fishing'
	elseif pole == 'magnetpole' then
		return 'magnet'
	elseif pole == 'illegalpole' then
		return 'illegal'
	end
	return nil
end

for k, v in pairs (poles) do
	ps.createUseable(v, function(source, item)
		local src = source
		local identifier = ps.getIdentifier(src)
		if activeFishers[identifier] then
			ps.notify(src, 'You Stopped Fishing', 'error')
			activeFishers[identifier] = nil
			TriggerClientEvent('md-fishing:client:stopfishing', src)
			return
		end
		if not inZonePlayers[identifier] then
			ps.notify(src, 'You Are Not In A Fishing Zone', 'error')
			return
		end
		if v == 'fishingpole' or v == 'magnetpole' then
			if inZonePlayers[identifier].type ~= 'fishingZones' then
				ps.notify(src, 'You Are Not In A Fishing Zone', 'error')
				return
			end
			local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations.fishingZones[inZonePlayers[identifier].loc].loc)
			if checkDistance > locations.fishingZones[inZonePlayers[identifier].loc].radius then
				ps.notify(src, 'You Left The Fishing Zone', 'error')
				inZonePlayers[identifier] = nil
				return
			end

			activeFishers[identifier] = {pole = v, location = inZonePlayers[identifier].loc, type = 'fishingZones', fishingType = getPoleType(v)}
			TriggerClientEvent('md-fishing:client:fishing', src, v)
			return
		end

		if v == 'illegalpole' then
			if inZonePlayers[identifier].type ~= 'illegalFishingZones' then
				ps.notify(src, 'You Are Not In An Illegal Fishing Zone', 'error')
				return
			end
			local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations.illegalFishingZones[inZonePlayers[identifier].loc].loc)
			if checkDistance > locations.illegalFishingZones[inZonePlayers[identifier].loc].radius then
				ps.notify(src, 'You Left The Illegal Fishing Zone', 'error')
				inZonePlayers[identifier] = nil
				return
			end
			local levels = MySQL.query.await('SELECT levels FROM mdfishing2 WHERE citizenid = ?', { identifier })
			if not levels[1] then
				ps.notify(src, 'You Have No Fishing Level, Please Re-Log', 'error')
				return
			end
			local lvl = json.decode(levels[1].levels)
			if lvl.illegal.level < Config.StarIllLvl then
				ps.notify(src, 'You Need To Be Level ' .. Config.StarIllLvl .. ' In Fishing To Fish Here', 'error')
				return
			end
			activeFishers[identifier] = {pole = v, location = inZonePlayers[identifier].loc, type = 'illegalFishingZones', fishingType = getPoleType(v)}
			TriggerClientEvent('md-fishing:client:fishing', src, v)
			return
		end
	end)
end

------------------------------- creates a table on players first log in with script
RegisterServerEvent('md-fishing:server:checksql', function()
	local src = source
	local check = MySQL.query.await('SELECT citizenid FROM mdfishing2 WHERE citizenid = ?', { ps.getIdentifier(src) })
	if not check[1] then
		MySQL.insert('INSERT INTO mdfishing2 (citizenid, levels, name) VALUES (?, ?,?)', {
			ps.getIdentifier(src),json.encode({fishing = {level = 0, xp = 0}, illegal = {level = 0, xp = 0}, magnet = {level = 0, xp = 0}}), ps.getPlayerName(src)
    	})
	end
end)

--------------------------------- catch fish logic
local timeouts = {}
local function addRepToPlayer(identifier, poleType)
	local levels = MySQL.query.await('SELECT levels FROM mdfishing2 WHERE citizenid = ?', { identifier })
	if not levels[1] then return end
	local lvl = json.decode(levels[1].levels)
	if not lvl[poleType] then return end
	lvl[poleType].xp = lvl[poleType].xp + 1
	if lvl[poleType].xp >= Config.LevelUpAmount then
		lvl[poleType].level = lvl[poleType].level + 1
		lvl[poleType].xp = 0
	end
	MySQL.update('UPDATE mdfishing2 SET levels = ? WHERE citizenid = ?', {json.encode(lvl), identifier})
	CreateThread(function()
		timeouts[identifier] = true
		Wait(1000 * Config.Levels[lvl[poleType].level].time)
		timeouts[identifier] = nil
	end)
end

RegisterServerEvent('md-fishing:server:givefish', function()
	local src = source
	local identifier = ps.getIdentifier(src)
	if timeouts[identifier] then
		ps.notify(src, 'You Are Fishing Too Fast', 'error')
		return
	end
	if not activeFishers[identifier] then
		ps.notify(src, 'You Are Not Fishing', 'error')
		return
	end
	if not inZonePlayers[identifier] then
		ps.notify(src, 'You Left The Fishing Zone', 'error')
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
	local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations[activeFishers[identifier].type][activeFishers[identifier].location].loc)
	if checkDistance > locations[activeFishers[identifier].type][activeFishers[identifier].location].radius then
		ps.notify(src, 'You Left The Fishing Zone', 'error')
		inZonePlayers[identifier] = nil
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
	local bait = baitTypes[activeFishers[identifier].pole] or nil
	if not bait then return end
	for baitType, v in pairs (bait) do
		if ps.hasItem(src, baitType, 1) then
			if ps.removeItem(src, baitType, 1) then
				ps.addItem(src, v[math.random(1, #v)], 1)
				addRepToPlayer(identifier, activeFishers[identifier].fishingType)
			end
		end
	end
end)


------------------------------------------------------
RegisterNetEvent('md-fishing:server:fishchum', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local info = Player.PlayerData.charinfo
	local chumMake = {
		flounder = 80,
		reddrum = 80,
		tunafish = 80,
		steelhead = 80,
		bluefish = 80,
		halibut = 80,
		catfish = 80,
		whitebass = 80,
		salmon = 80,
		largemouthbass = 80,
		panfish = 80,
		trout = 80,
	}
	local amount = 0
    for k, v in pairs(chumMake) do
        local item = Player.Functions.GetItemByName(k)
        if item and item.amount > 0 then
			local allow = math.random(1,100) 
			if v <= allow then
				amount = amount + item.amount
            	if RemoveItem(src, k, item.amount) then
					AddItem(src,"chum", item.amount)
				end
			else
			end
		end
	end
end)