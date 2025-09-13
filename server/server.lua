ps.versionCheck('md-fishing', 'https://raw.githubusercontent.com/Mustachedom/md-fishing/01f336f9cbbecb45dfe0d912887f1715663b3213/version.txt', 'https://github.com/Mustachedom/md-fishing/tree/01f336f9cbbecb45dfe0d912887f1715663b3213')

ps.registerCallback('md-fishing:server:getLocations', function(source)
	return locations
end)

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
					ps.notify(src, ps.lang('Shops.sold', itemCount, ps.getItemLabel(k), ps.lang('Info.currency'), total))
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
			ps.notify(src, ps.lang('Shops.sold', itemCount, ps.getItemLabel(fish), ps.lang('Info.currency'), total), 'success')
		end
	else
		ps.notify(src, ps.lang('Shops.noFish', ps.getItemLabel(fish)), 'error')
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
		ps.notify(src, ps.lang('Shops.bought', data.amount, ps.getItemLabel(item), ps.lang('Info.currency'), price), 'success')
	else
		ps.notify(src, ps.lang('Fails.tooPoor',ps.lang('Info.currency'), price, data.type), 'error')
	end
end)

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