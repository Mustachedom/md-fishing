local QBCore = exports['qb-core']:GetCoreObject()
local fishing = false
local magnetfishing = false
local chestspawned = false
local infish = false
local inillfish = false
local illfish = false
local tooweak = false

AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	TriggerServerEvent('md-fishing:server:checksql')
end)

local function found()
	Notify("You found something!")
	TriggerEvent('InteractSound_CL:PlayOnOne','fishsplash', 50.0)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(500)
	FreezeEntityPosition(PlayerPedId(), false)
end
CreateThread(function()
	------------------ Blip Creation
	for k, v in pairs (Config.Blips) do 
		if v.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z) 
			SetBlipSprite(blip, v.sprite) SetBlipDisplay(blip, 6) SetBlipScale  (blip, v.scale) SetBlipColour (blip, v.color)
			SetBlipAsShortRange(blip,true) BeginTextCommandSetBlipName("STRING") AddTextComponentString(v.label) EndTextCommandSetBlipName(blip)		
		end
	end
	----------------- END BLIPS
	----------------- PED CREATION/STORE
	lib.requestModel("u_m_m_blane", 15000)
	local fishbuyer = CreatePed(0, "u_m_m_blane",Config.FishBuyer.x,Config.FishBuyer.y,Config.FishBuyer.z-1, Config.FishBuyer.w, false, false)
    Freeze(fishbuyer, true,Config.FishBuyer.w)
	local options = {{    label = "Sell Fish",    icon = "fas fa-eye",   event = "md-fishing:client:sellfish" }}
	local optionsqb = {{    label = "Sell Fish",    icon = "fas fa-eye", event = "md-fishing:client:sellfish" }}
		if Config.oxtarget then	 
			exports.ox_target:addLocalEntity(fishbuyer, options)	
		else
			exports['qb-target']:AddTargetEntity(fishbuyer, { options = optionsqb, distance = 2.0})
		end
	-------------------------------------------------------------------- illegal chummer
	local fishchum = CreatePed(0, "u_m_m_blane",Config.ChumLoc.x,Config.ChumLoc.y,Config.ChumLoc.z-1, Config.ChumLoc.w, false, false)
    Freeze(fishchum, true,Config.ChumLoc.w )
	local options2 = { {label = "Make Fish Chum",icon = "fas fa-eye", serverEvent = 'md-fishing:server:fishchum', },}
	local options2qb = { {label = "Make Fish Chum",icon = "fas fa-eye", type = 'server', event = 'md-fishing:server:fishchum', },}
		if Config.oxtarget then	  
			exports.ox_target:addLocalEntity(fishchum, options2)	
		else
			exports['qb-target']:AddTargetEntity(fishchum, { options = options2qb, distance = 2.0})
		end	
	-------------------------------------------------------------------- Shop Creation
	local Shop = {}
	for k, v in pairs (Config.Items) do 
		Shop[#Shop + 1] = {
			   icon = GetImage(k),
				title = GetLabel(k),
				description = '$'..v.price,
				event = "md-fishing:client:shopamounts",
				args = {
					item = k,
					amount = v.amount,
					price = v.price
				},
			}
		lib.registerContext({id = 'fishshop',title = "Fish Supplies", options = Shop})
	end
	---------------------------------------------------------------------- Shop Ped
	local fishstore = CreatePed(0, "u_m_m_blane",Config.ShopLoc.x,Config.ShopLoc.y,Config.ShopLoc.z-1, Config.ShopLoc.w, false, false)
	Freeze(fishstore, true, Config.ShopLoc.w)
	local options3 = {{    label = "Open Shop",    icon = "fas fa-eye", action = function() lib.showContext('fishshop') end},}
	local options3ox = {{    label = "Open Shop",    icon = "fas fa-eye", onSelect = function() lib.showContext('fishshop') end},}
		if Config.oxtarget then	
			exports.ox_target:addLocalEntity(fishstore, options3ox)	
		else
			exports['qb-target']:AddTargetEntity(fishstore, { options = options3, distance = 2.0})
		end
	----------------------------------------------------------------------- breakdown loot creation
	local Loot = {}
	for k, v in pairs (Config.MagnetFishing) do 
		Loot[#Loot + 1] = {
			   icon = GetImage(v),
				title = GetLabel(v),
				serverEvent = 'md-fishing:server:breakdownmagnetloot',
				args = {
					item = v
				},
			}
		lib.registerContext({id = 'magnetbreak',title = "Rusty Item Breakdown", options = Loot})
	end
	if Config.oxtarget then
		materialbreak = exports.ox_target:addBoxZone({ coords = Config.MaterialBreakdown , size = vec3(2,2,2), debug = false,
			options = {{	label = "Break Down",	icon = "fas fa-eye",	onSelect = function() lib.showContext('magnetbreak') end}
		}
		})	
	else
		exports['qb-target']:AddBoxZone("magnetbreakdown",Config.MaterialBreakdown ,1.5, 1.75, {name = "magnetbreakdown",heading = 11.0,minZ = Config.MaterialBreakdown.z-2,maxZ = Config.MaterialBreakdown.z+2,}, {
			options = {	{label = "Break Down",icon = "fas fa-eye",action = function() lib.showContext('magnetbreak') end}},
		distance = 2.5
		})
	end
end)

RegisterNetEvent("md-fishing:client:shopamounts", function(data)
	local price = data.price 
	local settext = "Amnt: "..data.amount.." | Cost: "..price or "Cost: "..price
	local max = data.amount  
	local input = exports.ox_lib:inputDialog(data.item .."!",   {
		{ type = 'select', label = "Payment Type", default = "cash",
			options = {	{ value = "cash"},	{ value = "bank"},}
		},
		{ type = 'number', label = "Amount to buy", description = settext, min = 0, max = max, default = 1 },
	})
	if input[2] == nil or input[2] == 0 then return end
	TriggerServerEvent("md-fishing:server:buystuff", input[2], input[1], data.item, data.price )
end)

RegisterNetEvent("md-fishing:client:sellfish", function(data)
	local sales = {}
	for k, v in pairs (Config.FishSells) do 
	   if QBCore.Functions.HasItem(k) then
		sales[#sales + 1] = {
			   icon = GetImage(k),
				title = GetLabel(k),
				description = '$'..v.price,
				serverEvent = "md-fishing:server:sellfish",
				args = {
					item = k,
					price = v.price
				},
			}
		end
		lib.registerContext({id = 'sellfishies',title = "Fish Buyer", options = sales})
	end
	lib.showContext('sellfishies')
end)
CreateThread(function() --- zone creation necessary to get the globals to allow/disallow fishing
	for k, v in pairs (Config.FishingZones) do
		if v.enabled then 
			sphere = lib.zones.sphere({ coords = v.loc, radius = v.radius, debug = v.debug,
				onEnter = function()
					Notify("Pull Your Fishing Pole Out")
					infish = true
				end,
				onExit = function()
					infish = false	
				end,
			})
		end
	end
	for k, v in pairs (Config.illegalfishingzones) do 
		if v.enabled then
			illegalsphere = lib.zones.sphere({ coords = v.loc, radius = v.radius, debug = v.debug,
				onEnter = function()
					local fish, ill, mag = lib.callback.await('md-fishing:server:GetLevels', false)
						if fish >= Config.StarIllLvl then
							inillfish = true
							tooweak = false
							Notify('Maybe A Really Strong Pole Will Do Well Here', 'success')
						else
							inillfish = false
							tooweak = true
							Notify('You Must Be Level ' .. Config.StarIllLvl .. ' In Fishing To Fish Here', 'error')
						end
				end,
				onExit = function()	inillfish = false end
			})
		end	
	end
end)		

RegisterNetEvent("md-fishing:client:fishing", function()  --- reg fishing creation
	if not infish then Notify('You Cant Fish here', 'error') return end
	local count = 0
	local items = {'spinnerbait', 'softplasticbait', 'plugbait', 'worms' }
	for k, v in pairs (items) do 
		if QBCore.Functions.HasItem(v) then
			count = count + 1
		end
	end
	
	if fishing or count == 0 then 
		Notify("You Put Your Pole Away", 'success')
		DetachEntity(fishing, true, true)
		DeleteObject(fishing)
		fishing = false
		ClearPedTasks(PlayerPedId())
		if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), false) end
	else	
		local pos = GetEntityCoords(PlayerPedId(), true)
		lib.requestAnimDict('amb@world_human_stand_fishing@idle_a', 1000)
		TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
		lib.requestModel("prop_fishing_rod_01", 1000)
		local object = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		fishing = object
		if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), true) end
		local fish, ill, mag = lib.callback.await('md-fishing:server:GetLevels', false)
		if Config.AutoRecast then 
			repeat
				Wait(Config.Levels[fish]['time'] * 1000)
				if fishing == false then return end
				found()
				if  minigame(2,10) then TriggerServerEvent('md-fishing:server:givefish', GetEntityCoords(PlayerPedId())) end
			until fishing == false
		else
			Wait(Config.Levels[fish]['time'] * 1000)
			if not fishing then return end
			found()
			if not minigame(2,10) then return end
			TriggerServerEvent('md-fishing:server:givefish')
			if fishing then 
				DetachEntity(fishing, true, true)
				DeleteObject(fishing)
				ClearPedTasks(PlayerPedId())
				fishing = false
			end
		end
	end	
end)

RegisterNetEvent("md-fishing:client:illegalfishing", function() 
	if tooweak then Notify('You Arent Strong Enough For This Yet', 'error') return end
	if not inillfish then Notify('You Cant Fish Here', 'error') return end
	if illfish or not QBCore.Functions.HasItem('chum') then 
		Notify("You Put Your Pole Away", 'success')
		DetachEntity(illfish, true, true)
		DeleteObject(illfish)
		illfish = false
		ClearPedTasks(PlayerPedId())
		if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), false) end
	else	
		local pos = GetEntityCoords(PlayerPedId(), true)
		lib.requestAnimDict('amb@world_human_stand_fishing@idle_a', 1000)
		TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
		lib.requestModel("prop_fishing_rod_01", 1000)
		local object = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		illfish = object
		if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), true) end
		local fish, ill, mag = lib.callback.await('md-fishing:server:GetLevels', false)
		
		if Config.AutoRecast then 
			repeat
				Wait(Config.Levels[ill]['time'] * 1000)
				if illfish == false then return end
				found()
				if  minigame(2,10) then TriggerServerEvent('md-fishing:server:giveillegalfish') end
				PoliceCall(Config.PoliceChance)
			until illfish == false
		else
			Wait(Config.Levels[ill]['time'] * 1000)
			if not illfish then return end
			found()
			if minigame(2,10) then TriggerServerEvent('md-fishing:server:giveillegalfish') PoliceCall(Config.PoliceChance) end
			if illfish then 
				DetachEntity(illfish, true, true)
				DeleteObject(illfish)
				illfish = false
				ClearPedTasks(PlayerPedId())
			end	
		end
	end	
end)

RegisterNetEvent("md-fishing:client:magnetfishing")
AddEventHandler("md-fishing:client:magnetfishing", function() 
	if not infish then Notify('You Cant Fish Here', 'error') return end
	
	if magnetfishing or not QBCore.Functions.HasItem('magnet') then 
		Notify("You Put Your Pole Away", 'success')
		DetachEntity(magnetfishing, true, true)
		DeleteObject(magnetfishing)
		magnetfishing = false
		ClearPedTasks(PlayerPedId())
		if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), false) end
	else	
		local pos = GetEntityCoords(PlayerPedId(), true)
		lib.requestAnimDict('amb@world_human_stand_fishing@idle_a', 1000)
		TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
		lib.requestModel("prop_fishing_rod_01", 1000)
		local object = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		magnetfishing = object
		if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), true) end
			local fish, ill, mag = lib.callback.await('md-fishing:server:GetLevels', false)
			if Config.AutoRecast then 
				repeat
					Wait(Config.Levels[mag]['time'] * 1000)
					if magnetfishing == false then return end
					found()
					if  minigame(2,10) then TriggerServerEvent('md-fishing:server:givemagnetfish') end
				until magnetfishing == false
			else
				Wait(Config.Levels[mag]['time'] * 1000)
				if magnetfishing == false then return end
				found()
				if minigame(2,10) then TriggerServerEvent('md-fishing:server:givemagnetfish')  end
				if magnetfishing then
					DetachEntity(magnetfishing, true, true)
					DeleteObject(magnetfishing)
					magnetfishing = false
					ClearPedTasks(PlayerPedId())
				end
			end
	end	
end)

RegisterNetEvent('md-fishing:client:placechest')
AddEventHandler("md-fishing:client:placechest", function() 
	local chest = "prop_box_wood01a"
	local chestloc = GetEntityCoords(PlayerPedId())

	if chestspawned then
		Notify("You Have A Chest Out", 'error')			
	else
		if not progressbar('Placing The Chest On The Ground', 4000, 'mechanic4') then return end
		Notify('The Latch Is Seized, Break It Open!', 'success')
		chestspawned = true			
		lib.requestModel(chest, 500)
		local treasurechest = CreateObject(chest,chestloc.x +1,chestloc.y,chestloc.z-1, true, false)
		PlaceObjectOnGroundProperly(treasurechest)
		SetEntityHealth(treasurechest, math.random(50, 100))
		FreezeEntityPosition(treasurechest, true)
		repeat
			Wait(100)
		until GetEntityHealth(treasurechest) == 0 or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(treasurechest)) > 25.0
		if GetEntityHealth(treasurechest) == 0 then
			DeleteObject(treasurechest)
			TriggerServerEvent('md-fishing:server:getchestreward')
		else
			DeleteObject(treasurechest)
		end
		chestspawned = false
	end			
end)
--------- commands
RegisterCommand('fishingrep', function()
	local data = lib.callback.await('md-fishing:server:LevelMenu', false)
	lib.registerContext({
		id = 'fishlvls',
		title = 'Fishing Levels',
		options = {
		  { icon = "fa-solid fa-fish", title = 'Fishing Level: ' .. data['fishing'], description = ' You Are ' .. Config.LevelUpAmount - data['fishxp'] .. ' Catches From Level ' .. data['fishing'] + 1 .. "!"},
		  { icon = "fa-solid fa-fish", title = 'Magnet Fishing Level: ' .. data['magnetfish'], description = ' You Are ' .. Config.LevelUpAmount - data['magxp'] .. ' Catches From Level ' .. data['magnetfish'] + 1 .. "!"},
		  { icon = "fa-solid fa-fish", title = 'Illegal Fishing Level: ' .. data['illegalfish'], description = ' You Are ' .. Config.LevelUpAmount - data['illfishxp'] .. ' Catches From Level ' .. data['illegalfish'] + 1 .. "!"},
		}
	  })
	  lib.showContext('fishlvls')
end,false)

RegisterCommand('anchor', function()
  local ped = GetPlayerPed(-1)
	if IsPedInAnyBoat(ped) then
	local boat  = GetVehiclePedIsIn(ped, true)
		if anchor then 
			SetBoatAnchor(boat, false)
			Notify("Un Anchored")
			anchor = false
		else
			SetBoatAnchor(boat, true)
			SetForcedBoatLocationWhenAnchored(boat, true)
			anchor = true
			Notify("Anchored")
			SetBoatFrozenWhenAnchored(boat, true)
		end
	else
		Notify("Where Is Your Bloody Anchor")
	end
end, false)
