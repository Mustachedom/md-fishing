local QBCore = exports['qb-core']:GetCoreObject()
local poles = {'fishingpole', 'magnetpole', 'illegalpole'}
local chestLocs = {}

for k, v in pairs (poles) do 
	QBCore.Functions.CreateUseableItem(v, function(source, item)
		local src = source
		if v == 'fishingpole' then 
			TriggerClientEvent('md-fishing:client:fishing', src, 'fishing')
		elseif v == 'magnetpole' then
			TriggerClientEvent('md-fishing:client:fishing', src, 'magnetfishing')
		elseif v == 'illegalpole' then
			TriggerClientEvent('md-fishing:client:fishing', src, 'illegal')
		else
		end
	end)
end

lib.callback.register('md-fishing:server:GetLevels', function(source, data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if data == 'fishing' then 
		local fish = MySQL.scalar.await('SELECT fishing FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		return fish
	elseif data == 'illegal' then
		local ill = MySQL.scalar.await('SELECT illegalfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		return ill
	elseif data == 'magnetfishing' then
		local mag = MySQL.scalar.await('SELECT magnetfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		return mag
	end
	return false
end)

lib.callback.register('md-fishing:server:LevelMenu', function(source, cb, args)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local fish = MySQL.query.await('SELECT fishing, illegalfish, magnetfish, fishxp, magxp, illfishxp FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	
	return fish[1]
end)

------------------------------- creates a table on players first log in with script
RegisterServerEvent('md-fishing:server:checksql', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
	local check = MySQL.query.await('SELECT citizenid FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	if not check[1] then 
		MySQL.insert('INSERT INTO mdfishing (citizenid, name) VALUES (?, ?)', {
			Player.PlayerData.citizenid, GetName(src)
    	})
	end	
end)

--------------------------------- catch fish logic

RegisterServerEvent('md-fishing:server:givefish', function(data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chestchance = math.random(1,100)
	local has = 0
	local rep = getRep(source)

	local catch = {
		spinner = {"largemouthbass", "panfish", "trout",},
		softplastic = {"catfish", "whitebass", "salmon",},
		plug = {"steelhead", "bluefish", "halibut",},
		worms = {"flounder", "reddrum", "tunafish",},
		magnet = {"rustyak", "rustypistol", "rustyshotgun", "rustybike", "rustysafe", "copperpipe", 
			"closedsafe", "sheetmetal", "rustysign", "rustytire", "rustywheelchair", "rustychain", "rustyantenna", "rustyelectronickit", "rustyscanner",
			"rustyraspberrypi", "rustyusb", "rustyscrapmetal",
		},
		illegal = {"tigershark", "groundshark", "goblinshark", "stripeddolphin", "chileandolphin", "atlanticdolphin", "belugawhale", "bluewhale", 
			"narwhal", "spermwhale", "seaturtle", "tortoise", "leatherheadturtle",
		},
	}

	local bait = {
		{bait = 'spinnerbait', 	    zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = catch.spinner[math.random(1, #catch.spinner)]},
		{bait = 'softplasticbait',  zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = catch.softplastic[math.random(1, #catch.softplastic)] },
		{bait = 'plugbait', 		zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = catch.plug[math.random(1, #catch.plug)] },
		{bait = 'worms', 			zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = catch.worms[math.random(1, #catch.worms)] },
		{bait = 'magnet', 			zone = 'magnet', type = 'magxp',      level = 'magnetfish',   fish = catch.magnet[math.random(1, #catch.magnet)] },
		{bait = 'chum', 			zone = 'illegal',type = 'illfishxp',  level = 'illegalfish',  fish = catch.illegal[math.random(1, #catch.illegal)] },
	}

	for k, v in pairs (bait) do
		if v.zone == data then 
			if has >= 1 then return end
			local fish = Player.Functions.GetItemByName(v.bait)
			if fish then
				if v.zone == 'fish' or v.zone == 'magnet' then
					if not isInFishingZone(src, 'fish') then return end
				elseif v.zone == 'illegal' then
					if not isInFishingZone(src, 'illegal') then return end
					if rep.fishing < Config.StarIllLvl then Notifys(src, "You Need More Fishing Rep To Fish Here", "error") return end
				end
				if RemoveItem(src, v.bait, 1) then
					has = has + 1
					AddItem(src, v.fish,1)
					addRep(src, v.type)
				end
			end
		end
	end
	if has == 0 then Notifys(src, "You Have No Bait", "error") return end
	if chestchance <= Config.TreasureChestchance then AddItem("mdtreasurechest", 1) Notifys("You Got Lucky And Found A Chest", "success") end
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
	Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Made Chum!', 'illegalfishing')
end)

QBCore.Functions.CreateUseableItem('mdtreasurechest', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if RemoveItem(src, "mdtreasurechest", 1) then 
		TriggerClientEvent('md-fishing:client:placechest', src)
	end
end)

RegisterServerEvent('md-fishing:server:getchestreward', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local num = 0
	for k, v in pairs(chestLocs) do
		if v.player == Player.PlayerData.citizenid then
			num = k
		end
	end
	if num == 0 then return end
	if  dist(src, chestLocs[num].loc) > 5 then Notifys(src, 'You Are To Far To Claim That Loot!', 'error') return end
	table.remove(chestLocs, num)
	local tierChances = {
		tier1 = 70, -- 70 or below gets tier 1
		tier2 = 90, -- 71-90 gets tier 2
		tier3 = 100, -- 91-100 gets tier 3
	}
	local items = {
		{
			{item = 'lockpick',amount = math.random(1, 3)},
		},
		{
			{item = 'goldbar',amount = 1},
		},
		{
			{item = 'repairkit',amount = 1},
		},
	}
	local item
	local tierchance = math.random(1, 100)
	if tierchance <= tierChances.tier1 then
		item = items[1]
	elseif tierchance <= tierChances.tier2 then
		item = items[2]
	elseif tierchance <= tierChances.tier3 then
		item = items[3]
	end
	local itemNum = math.random(1, #item)
	AddItem(src, item[itemNum].item, item[itemNum].amount)
end)

lib.callback.register('md-fishing:server:addLocation', function(source, data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local has = 0
	for k, v in pairs (chestLocs) do
		if v.player == Player.PlayerData.citizenid then
			has = has + 1
		end
	end
	if has >= 1 then return end
	table.insert(chestLocs, {loc = data, player = Player.PlayerData.citizenid})
end)
