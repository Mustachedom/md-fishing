local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('fishingpole', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
if TriggerClientEvent('md-fishing:client:fishing', src, item.name) then
	end
end)

QBCore.Functions.CreateUseableItem('magnetpole', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
if TriggerClientEvent('md-fishing:client:magnetfishing', src, item.name) then
	end
end)

RegisterServerEvent('md-fishing:server:givefish', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local spinner =  Config.spinnerfishies[math.random(1, # Config.spinnerfishies)] 
	local smolplastic =  Config.softplasticbaitfishies[math.random(1, # Config.softplasticbaitfishies)] 
	local plug =  Config.plugbaitfishies[math.random(1, # Config.plugbaitfishies)] 
	local wormbait =  Config.wormsfishies[math.random(1, # Config.wormsfishies)] 
	local curRep = Player.PlayerData.metadata["fishingrep"]
	local chestchance = math.random(1,100)
	if Player.Functions.RemoveItem("spinnerbait", 1) then
		Player.Functions.AddItem(spinner, 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. spinner .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[spinner], "add",  1)
		Player.Functions.SetMetaData('fishingrep',  (curRep + 1))
	elseif Player.Functions.RemoveItem("softplasticbait", 1) then
		Player.Functions.AddItem(smolplastic, 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. smolplastic .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[smolplastic], "add",  1)
		Player.Functions.SetMetaData('fishingrep',  (curRep + 1))
	elseif Player.Functions.RemoveItem("plugbait", 1) then 
		Player.Functions.AddItem(plug, 1) 
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. plug .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[plug], "add",  1)
		Player.Functions.SetMetaData('fishingrep',  (curRep + 1))
	elseif Player.Functions.RemoveItem("worms", 1) then 
		Player.Functions.AddItem(wormbait, 1) 
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. wormbait .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[wormbait], "add",  1)
		Player.Functions.SetMetaData('fishingrep',  (curRep + 1))
	else
	TriggerClientEvent('QBCore:Notify', src, "You Have No Bait", "error")
	end
	if chestchance <= Config.TreasureChestchance then 
		Player.Functions.AddItem("mdtreasurechest", 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got Lucky And Found A Chest", "success")
	end
end)

RegisterServerEvent('md-fishing:server:givemagnetfish', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local magnetreward =  Config.MagnetFishing[math.random(1, #  Config.MagnetFishing)] 
	local curRep = Player.PlayerData.metadata["magnetfishingrep"]
	local chestchance = math.random(1,100)
	if Player.Functions.RemoveItem("magnet", 1) then
		Player.Functions.AddItem(magnetreward, 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. magnetreward .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[magnetreward], "add",  1)
		Player.Functions.SetMetaData('magnetfishingrep',  (curRep + 1))
	else
	TriggerClientEvent('QBCore:Notify', src, "You Have No Magnets", "error")
	end
	if chestchance <= Config.TreasureChestchance then 
		Player.Functions.AddItem("mdtreasurechest", 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got Lucky And Found A Chest", "success")
	end	
end)

RegisterNetEvent('md-fishing:server:fishchum', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local chumCount = 0

    for k, v in pairs(Config.ChumFish) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddItem("chum", item.amount)
            chumCount = chumCount + removed
        end
    end

    if chumCount > 0 then
        TriggerClientEvent('QBCore:Notify', src, "You received " .. chumCount .. " chum.", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You have no chum fish in your inventory.", "error")
    end
end)
RegisterServerEvent('md-fishing:server:giveillegalfish', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local illegalfish =  Config.IllegalFish[math.random(1, # Config.IllegalFish)] 
	local curRep = Player.PlayerData.metadata["illegalfishing"]
	 local chestchance = math.random(1,100)
	 
	if Player.Functions.RemoveItem("chum", 1) then
		Player.Functions.AddItem(illegalfish, 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. illegalfish .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[illegalfish], "add",  1)
		Player.Functions.SetMetaData('illegalfishing',  (curRep + 1))
	else
	TriggerClientEvent('QBCore:Notify', src, "You Have No Chum", "error")
	end
	
	if chestchance <= Config.TreasureChestchance then 
		Player.Functions.AddItem("mdtreasurechest", 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got Lucky And Found A Chest", "success")
	end	
end)

QBCore.Functions.CreateUseableItem('mdtreasurechest', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem("mdtreasurechest", 1) then 
	if Config.TreasureChestObject then
		TriggerClientEvent('md-fishing:client:placechest', src)
	else	
		local treasure1 =  Config.TreasureChest[math.random(1, #Config.TreasureChest)] 
		local treasure2 =  Config.TreasureChest[math.random(1, #Config.TreasureChest)] 
		local treasure3 =  Config.TreasureChest[math.random(1, #Config.TreasureChest)] 
		local luck = math.random(1,100)
		local itemamount = math.random(1,3)

		if luck <= 99 then
			Player.Functions.AddItem(treasure1, itemamount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[treasure1], "add",  itemamount)
		end
		if luck <= 20 then 
			Player.Functions.AddItem(treasure2, itemamount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[treasure2], "add",  itemamount)
		end
		if luck <= 5 then
			Player.Functions.AddItem(treasure3, itemamount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[treasure3], "add",  itemamount)	
		end
	end
end
end)

RegisterServerEvent('md-fishing:server:getchestreward', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local treasure1 =  Config.TreasureChest[math.random(1, #Config.TreasureChest)] 
local treasure2 =  Config.TreasureChest[math.random(1, #Config.TreasureChest)] 
local treasure3 =  Config.TreasureChest[math.random(1, #Config.TreasureChest)] 
local luck = math.random(1,100)
local itemamount = math.random(1,3)

if luck <= 99 then
	Player.Functions.AddItem(treasure1, itemamount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[treasure1], "add",  itemamount)
end
if luck <= 20 then 
	Player.Functions.AddItem(treasure2, itemamount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[treasure2], "add",  itemamount)
end
if luck <= 5 then
	Player.Functions.AddItem(treasure3, itemamount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[treasure3], "add",  itemamount)	
end
end)	

RegisterNetEvent('md-fishing:server:sellfish', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fishamount = 0
	
    for i = 1, #Config.FishSells do
        local item = Player.Functions.GetItemByName(Config.FishSells[i].label)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(Config.FishSells[i].label, item.amount)
            Player.Functions.AddMoney("cash", item.amount * Config.FishSells[i].price)
            fishamount = fishamount + removed
        end
    end

    if fishamount > 0 then
        TriggerClientEvent('QBCore:Notify', src, "You received " .. fishamount .. " Bucks!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You have nothing to Sell!", "error")
    end
end)

RegisterNetEvent('md-fishing:server:breakdownmagnetloot', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local material = 0
	local materialtype = Config.Materials[math.random(#Config.Materials)] 
	
    for k, v in pairs(Config.MagnetFishing) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddItem(materialtype, item.amount * Config.Materialamount)
            material = material + removed
        end
    end

    if material > 0 then
        TriggerClientEvent('QBCore:Notify', src, "You received " .. material .. " Pieces Of " ..materialtype.. "!" , "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You Have No Rusty Materials!", "error")
    end
end)