local QBCore = exports['qb-core']:GetCoreObject()
local notify = Config.Notify -- qb or ox
local logs = false 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
            ['Authorization'] = logapi,
            ['Content-Type'] = 'application/json',
    }

CreateThread(function()
if logs then 
    print'^2 Logs Enabled for md-fishing'
    if logapi == 'insert string here' then 
        print'^1 homie you gotta set your api on line 4'
    else
        print'^2 API Key Looks Good, Dont Trust Me Though, Im Not Smart'
    end
else
    print'^1 logs disabled for md-drugs'
end
end)
function Log(message, type)
if logs == false then return end	
    local buffer = {
        level = "info",
        message = message,
        resource = GetCurrentResourceName(),
        metadata = {
            fishing = type,
            playerid = source
        }
    }
     SetTimeout(500, function()
         PerformHttpRequest(endpoint, function(status, _, _, response)
             if status ~= 200 then 
                 if type(response) == 'string' then
                     response = json.decode(response) or response
                 end
             end
         end, 'POST', json.encode(buffer), headers)
         buffer = nil
     end)
end
---------------------------------------------------- inventory catcher
local invname = ''
CreateThread(function()
if GetResourceState('ps-inventory') == 'started' then
    invname = 'ps-inventory'
elseif GetResourceState('qb-inventory') == 'started' then
    invname = 'qb-inventory'
else
    invname = 'inventory'		
end
end)

local inventory = ''

CreateThread(function()
if GetResourceState('ox_inventory') == 'started' then
    inventory = 'ox'
else
    inventory = 'qb'
end
end)

----------------------------------------------------
---
function Notifys(source, text, type)
    local src = source
    if notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", src, text, type)
    elseif notify == 'ox' then
        lib.notify(src, { title = text, type = type})
    elseif notify == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, '', text, 4000, type, false)
    else
        print"^1 Look At The Config For Proper Alert Options"    
    end
end

function GetLabels(item) 
    if inventory == 'qb' then
        return QBCore.Shared.Items[item].label
    elseif inventory == 'ox' then
        local items = exports.ox_inventory:Items()
        return items[item].label
    end
end

function Itemcheck(source, item, amount) 
    if inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        local itemchecks = Player.Functions.GetItemByName(item)
        if itemchecks and itemchecks.amount >= amount then
            return true
        else 
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item)  .. ' To Do this', 'error')
            return false   
        end
    elseif inventory == 'ox' then
       local items = exports.ox_inventory:GetItem(source, item, nil, false) 
        if items.count >= amount then 
                return true
        else
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
            return false
        end
    end
end

function GetCoords(source) 
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    return playerCoords
end

function dist(source, coords)
    local playerPed = GetPlayerPed(source)
    local pcoords = GetEntityCoords(playerPed)
    local dist = #(pcoords - coords)
        return dist
end

function CheckDist(source, coords)
    local playerPed = GetPlayerPed(source)
    local pcoords = GetEntityCoords(playerPed)
    local ok 
    if #(pcoords - coords) < 4.0 then
        return ok
    else    
        DropPlayer(source, 'md-drugs: You Were A Total Of ' .. #(pcoords - coords) .. ' Too Far Away To Trigger This Event') 
        return false
    end
end

function RemoveItem(source, item, amount) 
    if inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.RemoveItem(item, amount) then 
            TriggerClientEvent(invname ..":client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)  
            return true
        else 
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
        end
    elseif inventory == 'ox' then
        if exports.ox_inventory:RemoveItem(source, item, amount) then 
            return true
        else
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
        end
    end
end

function AddItem(source, item, amount) 
    if inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.AddItem(item, amount) then 
            TriggerClientEvent(invname ..":client:ItemBox", source, QBCore.Shared.Items[item], "add", amount) 
            return true
         else 
            print('Failed To Give Item: ' .. item .. ' Check Your qb-core/shared/items.lua')
            return false
        end
    else
        local carry = exports.ox_inventory:CanCarryItem(source, item, amount)
        if not carry then Notifys(source, 'You Cant Carry that Much Weight!', 'error') return false end
        if exports.ox_inventory:AddItem(source, item, amount) then
            return true
        else
            print('Failed To Give Item: ' .. item .. ' Check Your ox_inventory/data/items.lua')
            return false
        end
    end
end

function sortTab(tbl, type)
    table.sort(tbl, function(a, b)
        return a[type] < b[type]
    end)
end

function GetName(source) 
    local Player = QBCore.Functions.GetPlayer(source)
    local info = Player.PlayerData.charinfo
    return info.firstname .. ' ' .. info.lastname
end

lib.callback.register('md-fishing:server:GetCoppers', function(source, cb, args)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
         if v.PlayerData.job.type == 'leo' and v.PlayerData.job.onduty then
          amount = amount + 1
         end
    end
    return amount
end)

CreateThread(function()
    local url = "https://raw.githubusercontent.com/Mustachedom/md-fishing/main/version.txt"
    local version = GetResourceMetadata('md-fishing', "version" )
     PerformHttpRequest(url, function(err, text, headers)
        if version == text then print'You Are On The latest Version' end
         if (text ~= nil) then
                print('^2 Your Version:' .. version .. ' | Current Version:' .. text .. '' )  
         end
     end, "GET", "", "")
end)

local stores = {
    fishshop = {
        {name = 'fishingpole', price = 1000, amount = 1},
        {name = 'worms', price = 25, amount = 50},
	    {name = 'spinnerbait', price = 25, amount = 50},
	    {name = 'softplasticbait', price = 25, amount = 50},
	    {name = 'plugbait', price = 25, amount = 50},
	    {name = 'magnet', price = 25, amount = 50},
	    {name = 'magnetpole', price = 10, amount = 1},
        {name = 'illegalpole', price = 10000, amount = 1},
    },
}

local sales = {
    fish = {  
        flounder          = {price = 50},
        reddrum           = {price = 50},
        tunafish          = {price = 50},
        bluefish          = {price = 50},
        halibut           = {price = 50},
        steelhead         = {price = 50},
        catfish           = {price = 50},
        whitebass         = {price = 50},
        salmon            = {price = 50},
        panfish           = {price = 50},
        trout             = {price = 50},
        tigershark        = {price = 50},
        groundshark       = {price = 50},
        goblinshark       = {price = 50},
        stripeddolphin    = {price = 50},
        largemouthbass    = {price = 50},
        chileandolphin    = {price = 50},
        atlanticdolphin   = {price = 50},
        belugawhale       = {price = 50},
        bluewhale         = {price = 50},
        narwhal           = {price = 50},
        spermwhale        = {price = 50},
        seaturtle         = {price = 50},
        tortoise          = {price = 50},
        leatherheadturtle = {price = 50},
    }
}

local breakdown = {
    items = {
        rustyak             = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustypistol         = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyshotgun	    = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustybike		    = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustysafe	        = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        copperpipe			= {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        closedsafe			= {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        sheetmetal			= {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustysign			= {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustytire			= {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustywheelchair	    = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustychain	        = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyantenna        = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyelectronickit  = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyscanner	    = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyraspberrypi    = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyusb		    = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
        rustyscrapmetal     = {items = {"metalscrap", "iron","copper", "steel", "aluminum"}, amount = {min = 1, max = 3}},
    }
}

lib.callback.register('md-fishing:server:menu', function(source, data)
    if data == 'fishshop' then 
        return {table = stores.fishshop, des = '$',  id = 'fishshop', title = 'Fishing Supply Store'}
    end
end)

lib.callback.register('md-fishing:server:getSales', function(source, data)
    if data == 'fish' then 
        return {table = sales.fish, des = '$',  id = 'fish', title = 'Sell Fish'}
    end
end)

lib.callback.register('md-fishing:server:breakDown', function(source, data)
    if data == 'breakDown' then 
        return {table = breakdown.items, des = '$',  id = 'breakDown', title = 'Rusty Material Breakdown'}
    end
end)

RegisterServerEvent("md-fishing:server:purchaseGoods", function(amount, money, item, price,table,num)
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	for i = 1, #table do 
		if table[i].name == item then
		if not table[i].price == price then return end
			if Player.Functions.RemoveMoney(tostring(money), tonumber(table[i].price) * tonumber(amount)) then
				AddItem(src, item, amount)
				Log(GetName(src) .. ' Bought ' .. amount .. ' Of ' .. item .. ' For ' .. tonumber(price) * tonumber(amount) .. '!', 'merchant')
			end
		end
	end
end)

RegisterServerEvent("md-fishing:server:sellGoods", function(price, table, item)
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	if table[item].price == price then
        if sales.fish[item].price == table[item].price then
            local Remove = Player.Functions.GetItemByName(item)
            local count = Remove.amount
            if RemoveItem(src, item, count) then 
                Player.Functions.AddMoney('cash', tonumber(table[item].price) * tonumber(count))
                Log(GetName(src) .. ' Sold ' .. count .. ' Of ' .. item .. ' For ' .. tonumber(table[item].price) * tonumber(count) .. '!', 'merchant')
            end
        end
    end
end)

RegisterServerEvent("md-fishing:server:breakDown", function(table, item)
	local src = source 
    if not breakdown.items[item] then return end
    local randItem = math.random(1, #breakdown.items[item].items)
    local items = breakdown.items[item].items[randItem]
    local amount = math.random(breakdown.items[item].amount.min, breakdown.items[item].amount.max)
    if RemoveItem(src, item, 1) then
        AddItem(src, items, amount)
    end
end)

function getRep(source) 
    local Player = QBCore.Functions.GetPlayer(source)
    local rep = MySQL.query.await('SELECT * FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
    return rep
end

function addRep(source, type) 
    local Player = QBCore.Functions.GetPlayer(source)
    local rep = MySQL.query.await('SELECT * FROM mdfishing WHERE citizenid = ?', { Player.PlayerData.citizenid })
    if type == 'fishxp' then
       if rep[1].fishxp + 1 >= Config.LevelUpAmount then
            MySQL.query.await('UPDATE mdfishing SET fishxp = ?, fishing = ? WHERE citizenid = ?', { 0, rep[1].fishing + 1, Player.PlayerData.citizenid })
       else
            MySQL.query.await('UPDATE mdfishing SET fishxp = ? WHERE citizenid = ?', { rep[1].fishxp + 1, Player.PlayerData.citizenid })
       end
    elseif type == 'magxp' then
        if rep[1].magxp + 1 >= Config.LevelUpAmount then
            MySQL.query.await('UPDATE mdfishing SET magxp = ?, magnetfish = ? WHERE citizenid = ?', { 0, rep[1].magnetfish + 1, Player.PlayerData.citizenid })
        else
            MySQL.query.await('UPDATE mdfishing SET magxp = ? WHERE citizenid = ?', { rep[1].magxp + 1, Player.PlayerData.citizenid })
        end
    elseif type == 'illfishxp' then
        if rep[1].illfishxp + 1 >= Config.LevelUpAmount then
            MySQL.query.await('UPDATE mdfishing SET illfishxp = ?, illegalfish = ? WHERE citizenid = ?', { 0, rep[1].illegalfish + 1, Player.PlayerData.citizenid })
        else
            MySQL.query.await('UPDATE mdfishing SET illfishxp = ? WHERE citizenid = ?', { rep[1].illfishxp + 1, Player.PlayerData.citizenid })
        end
    end
end

function isInFishingZone(source, type)
    local playerPed = GetPlayerPed(source)
    local playerPos = GetEntityCoords(playerPed)
    if type == 'fish' then
        for _, zone in ipairs(Config.FishingZones) do
            if zone.enabled then
                local distanceSquared = (playerPos.x - zone.loc.x)^2 + (playerPos.y - zone.loc.y)^2 + (playerPos.z - zone.loc.z)^2
                local radiusSquared = zone.radius * zone.radius

                if distanceSquared <= radiusSquared then
                    return true 
                end
            end
        end
        return false
    else
        for _, zone in ipairs(Config.illegalfishingzones) do
            if zone.enabled then
                local distanceSquared = (playerPos.x - zone.loc.x)^2 + (playerPos.y - zone.loc.y)^2 + (playerPos.z - zone.loc.z)^2
                local radiusSquared = zone.radius * zone.radius

                if distanceSquared <= radiusSquared then
                    return true 
                end
            end
        end
        return false
    end
end

lib.callback.register('md-fishing:server:GetItemCount',function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    local count = Player.Functions.GetItemByName(item)
    if not count then return 0 end
    return count.amount
end)