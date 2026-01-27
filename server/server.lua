

local function checkDistance(src, loc, dist, event)
	local pcoords = GetEntityCoords(GetPlayerPed(src))
	local coords = vector3(loc.x, loc.y, loc.z)
	local distance = #(pcoords - coords)
	if distance > dist then
		Bridge.Prints.Warn(Bridge.Language.Locale('Fails.tooFar', Bridge.Framework.GetPlayerIdentifier(src), event, math.floor(distance)))
		return false
	end
	return true
end

Bridge.Callback.Register('md-fishing:server:getLocations', function(source)
	return locations
end)

Bridge.Callback.Register('md-fishing:server:getStores', function(source, type, location)
	local src = source

	if type == 'fishSales' then
		if not checkDistance(src, locations['fishBuyers'][location].loc, 5.0, 'md-fishing:server:getStores') then
			return
		end
		return stores.fishSales
	end

	if type == 'fishShop' then
		if not checkDistance(src, locations['shopLocation'][location].loc, 5.0, 'md-fishing:server:getStores') then
			return
		end
		return stores.fishShop
	end
	return nil
end)

RegisterNetEvent('md-fishing:server:sellFish', function(fish, loc)
	local src = source

	if not checkDistance(src, locations['fishBuyers'][loc].loc, 5.0, 'md-fishing:server:sellFish') then
		return
	end

	if fish == 'all' then
		for k, v in pairs (stores.fishSales) do
			local itemCount = Bridge.Inventory.GetItemCount(src, k)
			if itemCount > 0 then
				local total = itemCount * v
				if Bridge.Inventory.RemoveItem(src, k, itemCount) then
					Bridge.Framework.AddAccountBalance(src, 'cash', total, 'sold-fish')
				end
			end
		end
		return
	end

	if not stores.fishSales[fish] then return end

	local itemCount = Bridge.Inventory.GetItemCount(src, fish)
	if itemCount > 0 then
		local total = itemCount * stores.fishSales[fish]
		if Bridge.Inventory.RemoveItem(src, fish, itemCount) then
			Bridge.Framework.AddAccountBalance(src, 'cash', total, 'sold-fish')
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.shopsSold', itemCount, Bridge.Inventory.GetItemInfo(fish).label, Bridge.Language.Locale('Info.currency'), total), 'success')
		end
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.noFish', Bridge.Inventory.GetItemInfo(fish).label), 'error')
	end
end)

RegisterNetEvent('md-fishing:server:buyFishGear', function(loc, item, data)
	local src = source

	if not checkDistance(src, locations['shopLocation'][loc].loc, 3.5, 'md-fishing:server:buyFishGear') then
		return
	end

	if not stores['fishShop'][item] then
		Bridge.Prints.Warn(Bridge.Language.Locale('Warns.invalidItemFishShop', Bridge.Framework.GetPlayerIdentifier(src), item))
		return
	end

	local price = stores['fishShop'][item] * data.amount
	if Bridge.Framework.RemoveAccountBalance(src, data.type, price) then
		Bridge.Inventory.AddItem(src, item, data.amount)
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.shopsBought', data.amount, Bridge.Inventory.GetItemInfo(item).label, price), 'success')
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.tooPoor', price), 'error')
	end
end)

Bridge.Callback.Register('md-fishing:server:getBreakdown', function(source, location)
	local src = source

	if not checkDistance(src, locations['breakDown'][location].loc, 3.5, 'md-fishing:server:getBreakdown') then
		return
	end

	return breakDown
end)

RegisterNetEvent('md-fishing:server:breakDownRustys', function(loc, item)
	local src = source

	if not checkDistance(src, locations['breakDown'][loc].loc, 3.0, 'md-fishing:server:breakDownRustys') then
		return
	end

	if not breakDown[item] then
		Bridge.Prints.Warn(Bridge.Language.Locale('Warns.invalidBreakDownItem', Bridge.Framework.GetPlayerIdentifier(src), item))
		return
	end

	if Bridge.Inventory.RemoveItem(src, item, 1) then
		local itemReward = breakDown[item]['items'][math.random(1, #breakDown[item]['items'])]
		local itemAmount = math.random(breakDown[item]['amount'].min, breakDown[item]['amount'].max)
		Bridge.Inventory.AddItem(src, itemReward, itemAmount)
	end
end)


RegisterNetEvent('md-fishing:server:inZone', function(locationType, location)
	local src = source
	local distance = #(GetEntityCoords(GetPlayerPed(src)) - locations[locationType][location].loc)
	if distance > locations[locationType][location].radius then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Warns.zoneGlitch', Bridge.Framework.GetPlayerIdentifier(src), 'md-fishing:server:inZone', distance))
		return
	end
	inZonePlayers[Bridge.Framework.GetPlayerIdentifier(src)] = {type = locationType, loc = location}
end)

RegisterNetEvent('md-fishing:server:outZone', function()
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	inZonePlayers[identifier] = nil

	if activeFishers[identifier] then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.leftZone'), 'info')
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

local poles = {'fishingpole', 'magnetpole', 'illegalpole'}
local spamProtection = {}

local function checkSpam(license)
	if spamProtection[license] then
		return true
	end
	spamProtection[license] = true
	CreateThread(function()
		Wait(2000)
		spamProtection[license] = nil
	end)
	return false
end

local function checkSQL(src)
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if cacheSQL[identifier] then
		return true
	end
	local check = MySQL.query.await('SELECT * FROM md_fishing WHERE citizenid = ?', { identifier })
	if not check[1] then
		local levels = {
			fishing = {level = 0, xp = 0},
			illegal = {level = 0, xp = 0},
			magnet = {level = 0, xp = 0},
		}
		local first, last = Bridge.Framework.GetPlayerName(src)
		MySQL.insert('INSERT INTO md_fishing (citizenid, levels, name) VALUES (?, ?,?)', {
			identifier,json.encode(levels), first .. " " .. last
    	})
		cacheSQL[identifier] = levels
	end
	if not cacheSQL[identifier] then
		cacheSQL[identifier] = json.decode(check[1].levels)
	end
	return true
end

Bridge.Callback.Register('md-fishing:server:getLevels', function(source)
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	checkSQL(src)
	return {level = cacheSQL[identifier], maxXP = LevelUpAmount}
end)

local function getWaitTimer(identifier, poleType)
	local lvl = cacheSQL[identifier]

	if not lvl then
		return levelTime[0].time
	end

	if not lvl[poleType] then
		return levelTime[0].time
	end

	return levelTime[lvl[poleType].level].time or levelTime[0].time
end

for k, v in pairs (poles) do
	Bridge.Framework.RegisterUsableItem(v, function(source, item)
		local src = source
		local identifier = Bridge.Framework.GetPlayerIdentifier(src)

		if activeFishers[identifier] then
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.stoppedFishing'), 'success')
			activeFishers[identifier] = nil
			TriggerClientEvent('md-fishing:client:stopfishing', src)
			return
		end

		if checkSpam(identifier) then
			return
		end

		checkSQL(src)

		if not inZonePlayers[identifier] then
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.notInZone'), 'error')
			TriggerClientEvent('md-fishing:client:stopfishing', src)
			return
		end

		if v == 'fishingpole' or v == 'magnetpole' then
			if inZonePlayers[identifier].type ~= 'fishingZones' then
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.wrongPole'), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end

			local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations.fishingZones[inZonePlayers[identifier].loc].loc)
			if checkDistance > locations.fishingZones[inZonePlayers[identifier].loc].radius then
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.leftZone'), 'error')
				inZonePlayers[identifier] = nil
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end

			activeFishers[identifier] = {pole = v, location = inZonePlayers[identifier].loc, type = 'fishingZones', fishingType = getPoleType(v)}

			timeouts[identifier] = getWaitTimer(identifier, getPoleType(v))
			CreateThread(function()
				Wait(1000 * timeouts[identifier])
				timeouts[identifier] = nil
			end)
			TriggerClientEvent('md-fishing:client:fishing', src, timeouts[identifier])
			return
		end

		if v == 'illegalpole' then
			if inZonePlayers[identifier].type == 'fishingZones' then
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.wrongPole'), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end

			local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations.illegalFishingZones[inZonePlayers[identifier].loc].loc)
			if checkDistance > locations.illegalFishingZones[inZonePlayers[identifier].loc].radius then
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.leftZone'), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				inZonePlayers[identifier] = nil
				return
			end

			local lvl = cacheSQL[identifier]
			if lvl.fishing.level < StarIllLvl then
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.tooWeak', StarIllLvl), 'error')
				TriggerClientEvent('md-fishing:client:stopfishing', src)
				return
			end

			activeFishers[identifier] = {pole = v, location = inZonePlayers[identifier].loc, type = 'illegalFishingZones', fishingType = getPoleType(v)}

			timeouts[identifier] = getWaitTimer(identifier, getPoleType(v))
			CreateThread(function()
				Wait(1000 * timeouts[identifier])
				timeouts[identifier] = nil
			end)
			TriggerClientEvent('md-fishing:client:fishing', src, timeouts[identifier])
			return
		end
	end)
end


--------------------------------- catch fish logic

local function addRepToPlayer(identifier, poleType)
	local lvl = cacheSQL[identifier]
	if not lvl then return end
	if not lvl[poleType] then return end

	lvl[poleType].xp = lvl[poleType].xp + 1
	if lvl[poleType].xp >= LevelUpAmount then
		if lvl[poleType].level + 1 <= 10 then
			lvl[poleType].level = lvl[poleType].level + 1
			lvl[poleType].xp = 0
		end
	end

	MySQL.update('UPDATE md_fishing SET levels = ? WHERE citizenid = ?', {json.encode(lvl), identifier})
	CreateThread(function()
		timeouts[identifier] = true
		Wait(1000 * levelTime[lvl[poleType].level].time)
		timeouts[identifier] = nil
	end)
end

RegisterServerEvent('md-fishing:server:givefish', function()
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)

	if timeouts[identifier] then
		Bridge.Prints.Warn(Bridge.Language.Locale('Warns.onTimeout', identifier, 'md-fishing:server:givefish'), 'error')
		return
	end

	if not activeFishers[identifier] then
		Bridge.Prints.Warn(Bridge.Language.Locale('Warns.notInZone', identifier, 'md-fishing:server:givefish'), 'error')
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end

	if not inZonePlayers[identifier] then
		Bridge.Prints.Warn(Bridge.Language.Locale('Warns.leftZone', identifier, 'md-fishing:server:givefish'), 'error')
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end

	local checkDistance = #(GetEntityCoords(GetPlayerPed(src)) - locations[activeFishers[identifier].type][activeFishers[identifier].location].loc)
	if checkDistance > locations[activeFishers[identifier].type][activeFishers[identifier].location].radius then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Fails.leftZone'), 'error')
		inZonePlayers[identifier] = nil
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end

	local bait = baitTypes[activeFishers[identifier].pole] or nil
	if not bait then return end
	local completed = false
	for baitType, v in pairs (bait) do
		if Bridge.Inventory.HasItem(src, baitType, 1) then
			if Bridge.Inventory.RemoveItem(src, baitType, 1) then
				Bridge.Inventory.AddItem(src, v[math.random(1, #v)], 1)
				addRepToPlayer(identifier, activeFishers[identifier].fishingType)
				completed = true
				break
			end
		end
	end

	if not completed then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.outOfBait'), 'error')
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		return
	end
end)

RegisterServerEvent('md-fishing:server:stopFishing', function()
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if activeFishers[identifier] then
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.stoppedFishing'), 'error')
	end
end)

RegisterServerEvent('md-fishing:server:stopFishingNoAlert', function()
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if activeFishers[identifier] then
		activeFishers[identifier] = nil
		TriggerClientEvent('md-fishing:client:stopfishing', src)
	end
end)

RegisterNetEvent('md-fishing:server:fishchum', function(location)
    local src = source

	if not checkDistance(src, locations['chumMaker'][location].loc, 3.5, 'md-fishing:server:fishchum') then
		return
	end

	local amount = 0
    for k, v in pairs(chumMake) do
        local count = Bridge.Inventory.GetItemCount(src, k)
		if count > 0 then
			if Bridge.Inventory.RemoveItem(src, k, count) then
				amount = math.floor(amount + (count * v))
			end
		end
	end

	if amount <= 0 then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Notify.noFish', 'fish'), 'error')
		return
	end
	Bridge.Inventory.AddItem(src, 'chum', amount)
end)

 --- RUN THIS COMMAND BEFORE ANYONE JOINS THE SERVER. READ THE README FOR GODS SAKE THEN DELETE THIS COMMAND 

if Config.OldData then
	RegisterCommand('FishingReFormater', function(source, args, rawCommand)
		local src = source
		if not IsPlayerAceAllowed(src, 'command') then return end

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
	end, true)
end