local QBCore = exports['qb-core']:GetCoreObject()
local poles = {'fishingpole', 'magnetpole', 'illegalpole'}

for k, v in pairs (poles) do 
	QBCore.Functions.CreateUseableItem(v, function(source, item)
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		local info = Player.PlayerData.charinfo
		if v == 'fishingpole' then 
			TriggerClientEvent('md-fishing:client:fishing', src, item.name)
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Used A Regular Fishing Rod', 'fishing')
		elseif v == 'magnetpole' then
			TriggerClientEvent('md-fishing:client:magnetfishing', src, item.name)
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Used A Magnet Rod', 'fishing')
		elseif v == 'illegalpole' then
			TriggerClientEvent('md-fishing:client:illegalfishing', src, item.name)
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Used An Illegal Fishing Rod', 'fishing')
		else
		end
	end)
end
---------------------------------- Callbacks
--QBCore.Functions.CreateCallback('md-fishing:server:GetLevels', function(source, cb, args)
--	local src = source
--    local Player = QBCore.Functions.GetPlayer(src)
--	local fish = MySQL.scalar.await('SELECT fishing FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
--	local ill = MySQL.scalar.await('SELECT illegalfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
--	local mag = MySQL.scalar.await('SELECT magnetfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
--	cb(fish, ill, mag)
--end)
lib.callback.register('md-fishing:server:GetLevels', function(source, cb, args)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local fish = MySQL.scalar.await('SELECT fishing FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	local ill = MySQL.scalar.await('SELECT illegalfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	local mag = MySQL.scalar.await('SELECT magnetfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	return fish, ill, mag
end)

lib.callback.register('md-fishing:server:LevelMenu', function(source, cb, args)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local fish = MySQL.query.await('SELECT fishing, illegalfish, magnetfish, fishxp, magxp, illfishxp FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	
	return fish[1]
end)
--QBCore.Functions.CreateCallback('md-fishing:server:LevelMenu', function(source, cb, args)
--	local src = source
--    local Player = QBCore.Functions.GetPlayer(src)
--	local fish = MySQL.query.await('SELECT fishing, illegalfish, magnetfish, fishxp, magxp, illfishxp FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
--	
--	cb(fish[1])
--end)
-------------------------------
------------------------------- creates a table on players first log in with script
RegisterServerEvent('md-fishing:server:checksql', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
	local check = MySQL.query.await('SELECT citizenid FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
	if not check[1] then 
		MySQL.insert('INSERT INTO mdfishing (citizenid, name) VALUES (?, ?)', {
			Player.PlayerData.citizenid, Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    	})
	end	
end)
------------------------------- stores

RegisterServerEvent('md-fishing:server:buystuff', function(amount, type, item, cost)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local info = Player.PlayerData.charinfo
	if Config.Items[item]['price'] ~= cost then DropPlayer(src, 'cmon, its impossible to see this unless') return end
	if Config.Items[item] == nil then return end
	if Player.Functions.RemoveMoney(type, amount * cost) then
		AddItem(item, amount)
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Bought ' .. amount .. ' Of ' .. item .. ' For ' .. amount * cost .. '!', 'fishing')
	else
		Notifys("You Broke Ass", "error")
	end
end)
---------------------------------
--------------------------------- catch fish logic

RegisterServerEvent('md-fishing:server:givefish', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local caught = false
	local spinner =  Config.spinnerfishies[math.random(1, #Config.spinnerfishies)] 
	local smolplastic =  Config.softplasticbaitfishies[math.random(1, #Config.softplasticbaitfishies)] 
	local plug =  Config.plugbaitfishies[math.random(1, #Config.plugbaitfishies)] 
	local wormbait =  Config.wormsfishies[math.random(1, #Config.wormsfishies)] 
	local chestchance = math.random(1,100)
	local info = Player.PlayerData.charinfo
	if Player.Functions.GetItemByName("spinnerbait") then
		RemoveItem('spinnerbait', 1)
		AddItem(spinner, 1)
		caught = true
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Caught A ' .. spinner .. '!', 'fishing')
	elseif Player.Functions.GetItemByName("softplasticbait") then
		RemoveItem("softplasticbait", 1) 
		AddItem(smolplastic, 1)
		caught = true
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Caught A ' .. smolplastic .. '!', 'fishing')
	elseif Player.Functions.GetItemByName("plugbait") then
		RemoveItem("plugbait", 1)  
		AddItem(plug, 1) 
		caught = true
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Caught A ' .. plug .. '!', 'fishing')
	elseif Player.Functions.GetItemByName("worms") then 
		RemoveItem("worms", 1) 
		AddItem(wormbait, 1)
		caught = true
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Caught A ' .. wormbait .. '!', 'fishing')
	else
		Notifys("You Have No Bait", "error")
	end
	if chestchance <= Config.TreasureChestchance then AddItem("mdtreasurechest", 1) Notifys("You Got Lucky And Found A Chest", "success") end
	if caught then 
		local curRep = MySQL.scalar.await('SELECT fishxp FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		local curLvl = MySQL.scalar.await('SELECT fishing FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		if curRep == Config.LevelUpAmount then 
			MySQL.update('UPDATE mdfishing SET fishxp  = ?, fishing = ? WHERE citizenid = ?', {0, curLvl + 1, Player.PlayerData.citizenid})
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Leveled Up Fishing to Level ' .. curLvl + 1 .. '!', 'fishing')
		else
			MySQL.update('UPDATE mdfishing SET fishxp  = ? WHERE citizenid = ?', {curRep + 1, Player.PlayerData.citizenid})
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Is Now ' .. curRep + 1 .. ' XP In Fishing!', 'fishing')
		end
	end
end)

RegisterServerEvent('md-fishing:server:givemagnetfish', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local magnetreward =  Config.MagnetFishing[math.random(1, #Config.MagnetFishing)] 
	local chestchance = math.random(1,100)
	local info = Player.PlayerData.charinfo
	if RemoveItem("magnet", 1) then
		AddItem(magnetreward, 1)
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Caught A ' .. magnetreward .. '!', 'magnetfishing')
		local curRep = MySQL.scalar.await('SELECT magxp FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		local curLvl = MySQL.scalar.await('SELECT magnetfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		if curRep == Config.LevelUpAmount then 
			MySQL.update('UPDATE mdfishing SET magxp  = ?, magnetfish = ? WHERE citizenid = ?', {0, curLvl + 1, Player.PlayerData.citizenid})
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Leveled Up Magnet Fishing to Level ' .. curLvl + 1 .. '!', 'magnetfishing')
		else
			MySQL.update('UPDATE mdfishing SET magxp  = ? WHERE citizenid = ?', {curRep + 1, Player.PlayerData.citizenid})
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Is Now ' .. curRep + 1 .. ' XP In Magnet Fishing!', 'magnetfishing')
		end
	else
		Notifys("You Have No Magnets", "error")
	end
	if chestchance <= Config.TreasureChestchance then Player.Functions.AddItem("mdtreasurechest", 1) Notifys("You Got Lucky And Found A Chest", "success") end	
end)

RegisterServerEvent('md-fishing:server:giveillegalfish', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local illegalfish =  Config.IllegalFish[math.random(1, #Config.IllegalFish)] 
	local chestchance = math.random(1,100)
	local info = Player.PlayerData.charinfo
	if RemoveItem("chum", 1) then
		AddItem(illegalfish, 1)
		Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Caught A ' .. illegalfish .. '!', 'illegalfishing')
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[illegalfish], "add",  1)
		local curRep = MySQL.scalar.await('SELECT illfishxp FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		local curLvl = MySQL.scalar.await('SELECT illegalfish FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
		if curRep == Config.LevelUpAmount then 
			MySQL.update('UPDATE mdfishing SET illfishxp  = ?, illegalfish = ? WHERE citizenid = ?', {0, curLvl + 1, Player.PlayerData.citizenid})
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Leveled Up Magnet Fishing to Level ' .. curLvl + 1 .. '!', 'illegalfishing')
		else
			MySQL.update('UPDATE mdfishing SET illfishxp  = ? WHERE citizenid = ?', {curRep + 1, Player.PlayerData.citizenid})
			Log('ID:' .. source .. ' Name:' .. info.firstname .. ' ' .. info.lastname .. ' Is Now ' .. curRep + 1 .. ' XP In Illegal Fishing!', 'illegalfishing')
		end
	else
		Notifys("You Have No Chum", "error")
	end
	if chestchance <= Config.TreasureChestchance then  	Player.Functions.AddItem("mdtreasurechest", 1) 	Notifys("You Got Lucky And Found A Chest", "success") end	
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

RegisterNetEvent("md-fishing:server:sellfish", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fishamount = 0
	
	if Config.FishSells[data.item] == nil then return end
	local item = Player.Functions.GetItemByName(data.item)
	if item and item.amount > 0 then 
		if RemoveItem(data.item, item.amount) then
			Player.Functions.AddMoney('cash', item.amount * Config.FishSells[data.item]['price'])
		end
	end
end)

RegisterNetEvent('md-fishing:server:breakdownmagnetloot', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local material = 0
	local materialtype = Config.Materials[math.random(#Config.Materials)] 
	local amounts = math.random(materialtype.min, materialtype.max)
	local remove = Player.Functions.GetItemByName(data.item)

	if RemoveItem(remove.name, remove.amount) then
		AddItem(materialtype.item, amounts * remove.amount)
    end
    
end)
