local QBCore = exports['qb-core']:GetCoreObject()
local poles = {'fishingpole', 'magnetpole', 'illegalpole'}

for k, v in pairs (poles) do 
	QBCore.Functions.CreateUseableItem(v, function(source, item)
		local src = source
		if v == 'fishingpole' then 
			TriggerClientEvent('md-fishing:client:fishing', src, 'fishing')
		elseif v == 'magnetpole' then
			TriggerClientEvent('md-fishing:client:magnetfishing', src, 'magnetfishing')
		elseif v == 'illegalpole' then
			TriggerClientEvent('md-fishing:client:illegalfishing', src, 'illegalfishing')
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
	elseif data == 'magnet' then
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

-------------------------------
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
	local bait = {
		{bait = 'spinnerbait', 	    zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = Config.bait.spinnerfishies[math.random(1, #Config.bait.spinnerfishies)]},
		{bait = 'softplasticbait',  zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = Config.bait.softplasticbaitfishies[math.random(1, #Config.bait.softplasticbaitfishies)] },
		{bait = 'plugbait', 		zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = Config.bait.plugbaitfishies[math.random(1, #Config.bait.plugbaitfishies)] },
		{bait = 'worms', 			zone = 'fish',   type = 'fishxp',     level = 'fishing',      fish = Config.bait.wormsfishies[math.random(1, #Config.bait.wormsfishies)] },
		{bait = 'magnet', 			zone = 'magnet', type = 'magxp',      level = 'magnetfish',   fish = Config.bait.MagnetFishing[math.random(1, #Config.bait.MagnetFishing)] },
		{bait = 'chum', 			zone = 'illegal',type = 'illfishxp',  level = 'illegalfish',  fish = Config.bait.IllegalFish[math.random(1, #Config.bait.IllegalFish)] },
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
					if rep.fishing < Config.IllegalFishingRep then Notifys(src, "You Need More Fishing Rep To Fish Here", "error") return end
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
    local chumCount = 0
	local info = Player.PlayerData.charinfo
    for k, v in pairs(Config.ChumFish) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            if RemoveItem(v, item.amount) then
				AddItem("chum", item.amount)
			end
		end
	end
	Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Made Chum!', 'illegalfishing')
end)

QBCore.Functions.CreateUseableItem('mdtreasurechest', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem("mdtreasurechest", 1) then 
	if Config.TreasureChestObject then
		TriggerClientEvent('md-fishing:client:placechest', src)
	else	
		local item = math.random(#Config.TreasureChest)
		local math = math.random(Config.TreasureChest[item]['min'], Config.TreasureChest[item]['max'])
		if Player.Functions.AddItem(Config.TreasureChest[item]['item'], math) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.TreasureChest[item]['item']], "add",  math)
		end	
	end
end
end)

RegisterServerEvent('md-fishing:server:getchestreward', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local item = math.random(#Config.TreasureChest)
	local math = math.random(Config.TreasureChest[item]['min'], Config.TreasureChest[item]['max'])
	local info = Player.PlayerData.charinfo
	if AddItem(Config.TreasureChest[item]['item'], math) then
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Recieved ' .. Config.TreasureChest[item]['item'] .. ' X ' .. math .. ' From A Chest' , 'chests')
	end
end)
