ps.versionCheck('md-fishing', 'https://raw.githubusercontent.com/Mustachedom/md-fishing/01f336f9cbbecb45dfe0d912887f1715663b3213/version.txt', 'https://github.com/Mustachedom/md-fishing/tree/01f336f9cbbecb45dfe0d912887f1715663b3213')
local activeFishers = {} -- no touch
local inZonePlayers = {} -- no touch
local LevelUpAmount = 60 -- amount of fish required to level up
local StarIllLvl = 5 -- level required of regular fishing to be allowed to start illegal fishing

local locations = { 
	fishingZones = {
		{loc = vector3(-1849.2, -1230.44, 13.02), radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
    	{loc = vector3(-3427.21, 967.53, 8.35),   radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
    	{loc = vector3(1313.22, 4229.9, 33.92),   radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
    	{loc = vector3(40.83, 848.72, 197.73),    radius = 30, debug = false, enabled = true, blipData = {sprite = 88, scale = 0.55, color = 2, label = ps.lang('Labels.fishZoneBlip'), enabled = true} },
	},
	illegalFishingZones = {
		{loc = vector3(1788.64, -3525.29, 0.54), radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = true} },
		{loc = vector3(3190.5, -974.99, 0.37),   radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = false} },
		{loc = vector3(1235.08, 7926.63, -1.26), radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = false} },
		{loc = vector3(-3196.07, 2601.24, 1.33), radius = 250, debug = false, enabled = true, blipData = {sprite = 404, scale = 0.8, color = 2, label = ps.lang('Labels.illegalFishzoneBlip'), enabled = false} },
	},
	fishBuyers = {
		{loc = vector4(-1814.64, -1194.00, 13.02, 238.98), ped = 'a_f_m_bevhills_02', enabled = true, blipData = {sprite = 272, scale = 0.8, color = 2, label = ps.lang('Labels.fishBuyerBlip'), enabled = true} },
	},
	chumMaker = {
		{loc = vector4(1026.52, -3037.92, 8.69, 350.03), ped = 's_m_y_dealer_01', enabled = true, blipData = {sprite = 272, scale = 0.8, color = 2, label = ps.lang('Labels.chumMakerBlip'), enabled = true} },
	},
	shopLocation = {
		{loc = vector4(1314.10, 4282.58, 33.91, 240.26), ped = 's_m_y_dealer_01', enabled = true, blipData = {sprite = 272, scale = 0.8, color = 2, label = ps.lang('Labels.shopLocationBlip'), enabled = true} },
	},
	breakDown = {
		{loc = vector3(1088.14, -2002.14, 30.88), blipData = {sprite = 365, scale = 0.8, color = 2, label = ps.lang('Labels.breakDownBlip'), enabled = true}}
	}
}

ps.registerCallback('md-fishing:server:getLocations', function(source)
	return locations
end)

local stores = {
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

ps.registerCallback('md-fishing:server:getStores', function(source, type, location)
	local src = source
	if type == 'fishSales' then
		if not ps.checkDistance(src, locations['fishBuyers'][location].loc, 5.0) then
			ps.warn(ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.fishBuyer')))
			return
		end
		return stores.fishSales
	end
	if type == 'fishShop' then
		if not ps.checkDistance(src, locations['shopLocation'][location].loc, 5.0) then
			ps.warn(ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.fishShop')))
			return
		end
		return stores.fishShop
	end
	return nil
end)

RegisterNetEvent('md-fishing:server:sellFish', function(fish, loc)
	local src = source
	if not ps.checkDistance(src, locations['fishBuyers'][loc].loc, 5.0) then
		ps.warn(ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.fishBuyer')))
		return
	end
	if fish == 'all' then
		for k, v in pairs (stores.fishSales) do
			local itemCount = ps.getItemCount(src, k)
			if itemCount > 0 then
				local total = itemCount * v
				if ps.removeItem(src, k, itemCount) then
					ps.addMoney(src, 'cash', total, 'sold-fish')
					ps.notify(src, ps.lang('Shops.sold', itemCount, ps.getLabel(k), ps.lang('Info.currency'), total))
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
			ps.notify(src, ps.lang('Shops.sold', itemCount, ps.getLabel(fish), ps.lang('Info.currency'), total), 'success')
		end
	else
		ps.notify(src, ps.lang('Shops.noFish', ps.getLabel(fish)), 'error')
	end
end)

RegisterNetEvent('md-fishing:server:buyFishGear', function(loc, item, data)
	local src = source
	if not ps.checkDistance(src, locations['shopLocation'][loc].loc, 3.5) then
		ps.warn(ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.fishShop')))
		return
	end
	if not stores['fishShop'][item] then
		ps.warn(ps.lang('Fails.invalidItem', ps.getPlayerName(src), item, ps.lang('Info.fishShop')))
		return
	end
	local price = stores['fishShop'][item] * data.amount
	if ps.removeMoney(src, data.type, price) then
		ps.addItem(src, item, data.amount)
		ps.notify(src, ps.lang('Shops.bought', data.amount, ps.getLabel(item), ps.lang('Info.currency'), price), 'success')
	else
		ps.notify(src, ps.lang('Fails.tooPoor',ps.lang('Info.currency'), price, data.type), 'error')
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

ps.registerCallback('md-fishing:server:getBreakdown', function(source, location)
	local src = source
	if not ps.checkDistance(src, locations['breakDown'][location].loc, 3.5) then
		ps.warn(ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.breakDown')))
		return
	end
	return breakDown
end)

RegisterNetEvent('md-fishing:server:breakDownRustys', function(loc, item)
	local src = source
	if not ps.checkDistance(src, locations['breakDown'][loc].loc, 3.0) then
		ps.warn(ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.breakDown')))
		return
	end
	if not breakDown[item] then
		ps.warn(ps.lang('Fails.invalidBreakdown', ps.getPlayerName(src), item, ps.lang('Info.breakDown')))
		return
	end
	if ps.removeItem(src, item, 1) then
		local itemReward = breakDown[item]['items'][math.random(1, #breakDown[item]['items'])]
		local itemAmount = math.random(breakDown[item]['amount'].min, breakDown[item]['amount'].max)
		ps.addItem(src, itemReward, itemAmount)
	end
end)


RegisterNetEvent('md-fishing:server:inZone', function(locationType, location)
	local src = source
	local distance = #(GetEntityCoords(GetPlayerPed(src)) - locations[locationType][location].loc)
	if distance > locations[locationType][location].radius then
		ps.warn(src, ps.lang('Fails.zoneGlitch', ps.getPlayerName(src)))
		return
	end
	inZonePlayers[ps.getIdentifier(src)] = {type = locationType, loc = location}
end)

RegisterNetEvent('md-fishing:server:outZone', function()
	local src = source
	local identifier = ps.getIdentifier(src)
	inZonePlayers[identifier] = nil
	if activeFishers[identifier] then
		ps.notify(src, ps.lang('Fails.leftZone'), 'error')
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

local function getWaitTimer(identifier, poleType)
	local levels = MySQL.query.await('SELECT levels FROM md_fishing WHERE citizenid = ?', { identifier })
	if not levels[1] then return Config.Levels[0].time end
	local lvl = json.decode(levels[1].levels)
	if not lvl[poleType] then return Config.Levels[0].time end
	return Config.Levels[lvl[poleType].level].time or Config.Levels[0].time
end

local poles = {'fishingpole', 'magnetpole', 'illegalpole'}
for k, v in pairs (poles) do
	ps.createUseable(v, function(source, item)
		local src = source
		local identifier = ps.getIdentifier(src)

		if activeFishers[identifier] then
			ps.notify(src, ps.lang('Fishing.stopped'), 'success')
			activeFishers[identifier] = nil
			TriggerClientEvent('md-fishing:client:stopfishing', src)
			return
		end
		if not inZonePlayers[identifier] then
			ps.notify(src, ps.lang('Fishing.notInZone'), 'error')
			TriggerClientEvent('md-fishing:client:stopfishing', src)
			return
		end

		if v == 'fishingpole' or v == 'magnetpole' then
			if inZonePlayers[identifier].type ~= 'fishingZones' then
				ps.notify(src, ps.lang('Fishing.wrongPole'), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end
			local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations.fishingZones[inZonePlayers[identifier].loc].loc)
			if checkDistance > locations.fishingZones[inZonePlayers[identifier].loc].radius then
				ps.notify(src, ps.lang('Fails.leftZone'), 'error')
				inZonePlayers[identifier] = nil
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end
			activeFishers[identifier] = {pole = v, location = inZonePlayers[identifier].loc, type = 'fishingZones', fishingType = getPoleType(v)}
			TriggerClientEvent('md-fishing:client:fishing', src, getWaitTimer(identifier, getPoleType(v)))
			return
		end
		if v == 'magnetpole' then
			if inZonePlayers[identifier].type ~= 'fishingZones' then
				ps.notify(src, ps.lang('Fishing.wrongPole'), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end
			local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations.illegalFishingZones[inZonePlayers[identifier].loc].loc)
			if checkDistance > locations.illegalFishingZones[inZonePlayers[identifier].loc].radius then
				ps.notify(src, ps.lang('Fails.leftZone'), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				inZonePlayers[identifier] = nil
				return
			end
			local levels = MySQL.query.await('SELECT levels FROM md_fishing WHERE citizenid = ?', { identifier })
			if not levels[1] then
				ps.notify(src, ps.lang('Fishing.noLevel'), 'error')
				return
			end
			local lvl = json.decode(levels[1].levels)
			if lvl.illegal.level < StarIllLvl then
				ps.notify(src, ps.lang('Fishing.wrongLevel', StarIllLvl), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end
			activeFishers[identifier] = {pole = v, location = inZonePlayers[identifier].loc, type = 'illegalFishingZones', fishingType = getPoleType(v)}
			TriggerClientEvent('md-fishing:client:fishing', src,  getWaitTimer(identifier, getPoleType(v)))
			return
		end
	end)
end

------------------------------- creates a table on players first log in with script
RegisterServerEvent('md-fishing:server:checksql', function()
	local src = source
	local check = MySQL.query.await('SELECT citizenid FROM md_fishing WHERE citizenid = ?', { ps.getIdentifier(src) })
	if not check[1] then
		MySQL.insert('INSERT INTO md_fishing (citizenid, levels, name) VALUES (?, ?,?)', {
			ps.getIdentifier(src),json.encode({fishing = {level = 0, xp = 0}, illegal = {level = 0, xp = 0}, magnet = {level = 0, xp = 0}}), ps.getPlayerName(src)
    	})
	end
end)

--------------------------------- catch fish logic
local timeouts = {}
local function addRepToPlayer(identifier, poleType)
	local levels = MySQL.query.await('SELECT levels FROM md_fishing WHERE citizenid = ?', { identifier })
	if not levels[1] then return end
	local lvl = json.decode(levels[1].levels)
	if not lvl[poleType] then return end
	lvl[poleType].xp = lvl[poleType].xp + 1
	if lvl[poleType].xp >= LevelUpAmount then
		lvl[poleType].level = lvl[poleType].level + 1
		lvl[poleType].xp = 0
	end
	MySQL.update('UPDATE md_fishing SET levels = ? WHERE citizenid = ?', {json.encode(lvl), identifier})
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
		ps.notify(src, ps.lang('Fails.onTimeout'), 'error')
		return
	end
	if not activeFishers[identifier] then
		ps.notify(src, ps.lang('Fishing.notInZone'), 'error')
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
	if not inZonePlayers[identifier] then
		ps.notify(src, ps.lang('Fails.leftZone'), 'error')
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
	local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations[activeFishers[identifier].type][activeFishers[identifier].location].loc)
	if checkDistance > locations[activeFishers[identifier].type][activeFishers[identifier].location].radius then
		ps.notify(src, ps.lang('Fails.leftZone'), 'error')
		inZonePlayers[identifier] = nil
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
	local bait = baitTypes[activeFishers[identifier].pole] or nil
	if not bait then return end
	local completed = false
	for baitType, v in pairs (bait) do
		if ps.hasItem(src, baitType, 1) then
			if ps.removeItem(src, baitType, 1) then
				ps.addItem(src, v[math.random(1, #v)], 1)
				addRepToPlayer(identifier, activeFishers[identifier].fishingType)
				completed = true
				break
			end
		end
	end
	if not completed then
		ps.notify(src, ps.lang('Fails.outOfBait'), 'error')
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
end)

RegisterServerEvent('md-fishing:server:stopFishing', function()
	local src = source
	local identifier = ps.getIdentifier(src)
	if activeFishers[identifier] then
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		ps.notify(src, ps.lang('Fishing.stopped'), 'error')
	end
end)

RegisterServerEvent('md-fishing:server:stopFishingNoAlert', function()
	local src = source
	local identifier = ps.getIdentifier(src)
	if activeFishers[identifier] then
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
	end
end)

RegisterNetEvent('md-fishing:server:fishchum', function(location)
    local src = source
	if not ps.checkDistance(src, locations['chumMaker'][location].loc, 3.5) then
		ps.notify(src, ps.lang('Fails.tooFar', ps.getPlayerName(src), ps.lang('Info.breakDown')), 'error')
		return
	end
	local chumMake = { -- % of the amount of fish will be turn to chum, example 100 fish = 90
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
	local amount = 0
    for k, v in pairs(chumMake) do
        local count = ps.getItemCount(src, k)
		if count > 0 then
			if ps.removeItem(src, k, count) then
				amount = math.floor(amount + (count * v))
			end
		end
	end
	ps.addItem(src, 'chum', amount)
end)
 --- RUN THIS COMMAND BEFORE ANYONE JOINS THE SERVER. READ THE README FOR GODS SAKE THEN DELETE THIS COMMAND 
ps.registerCommand('FishingReFormater', {
	admin = true,
}, function()
	local allData = MySQL.query.await('SELECT * FROM mdfishing', {})
	for k, v in pairs (allData) do
		local levels = {
			fishing = {level = v.fishing, xp = v.fishxp},
			illegal = {level = v.illegalfish, xp = v.illfishxp},
			magnet = {level = v.magnetfish, xp = v.magxp},
		}
		MySQL.update('INSERT INTO md_fishing (citizenid, levels, name) VALUES (?, ?, ?)', {v.citizenid, json.encode(levels), v.name})
		MySQL.query.await('DELETE FROM mdfishing WHERE citizenid = ?', {v.citizenid})
	end
end)