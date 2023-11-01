local QBCore = exports['qb-core']:GetCoreObject()
local fishing = nil
local magnetfishing = nil

--- insert police code inside function
function PoliceCall()
print "peepee tell your dev they didnt edit something"
end

CreateThread(function()
-------------- Blips
for k, v in pairs (Config.FishingZones) do 
local blip = AddBlipForCoord(v) 
SetBlipSprite(blip, 88)
 SetBlipDisplay(blip, 4)
 SetBlipScale  (blip, 0.55)
 SetBlipColour (blip, 2)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Fishing Zone")
 EndTextCommandSetBlipName(blip)		
end
local fishbuyerblip = AddBlipForCoord(Config.FishBuyer) 
SetBlipSprite(fishbuyerblip, 500)
 SetBlipDisplay(fishbuyerblip, 4)
 SetBlipScale  (fishbuyerblip, 0.55)
 SetBlipColour (fishbuyerblip, 2)
 SetBlipAsShortRange(fishbuyerblip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Fish Buyer")
 EndTextCommandSetBlipName(fishbuyerblip)	
 local FishShop = AddBlipForCoord(Config.ShopLoc) 
SetBlipSprite(FishShop, 500)
 SetBlipDisplay(FishShop, 4)
 SetBlipScale  (FishShop, 0.55)
 SetBlipColour (FishShop, 2)
 SetBlipAsShortRange(FishShop, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Fish Shop")
 EndTextCommandSetBlipName(FishShop)
 ------------------- Blips end
 local fishbuyer = "u_m_m_blane"
lib.requestModel(fishbuyer, 500)
local buyerloc = Config.FishBuyer
fishbuyer = CreatePed(0, fishbuyer,buyerloc.x,buyerloc.y,buyerloc.z-1, 189, false, false)
             FreezeEntityPosition(fishbuyer, true)
            SetEntityInvincible(fishbuyer, true)
		if Config.oxtarget then	
				options = {
                    {
                        label = "Sell Fish",
                        icon = "fas fa-eye",
                        serverEvent = 'md-fishing:server:sellfish',
                    },
                }
               
			exports.ox_target:addLocalEntity(fishbuyer, options)	
		else
			exports['qb-target']:AddTargetEntity(fishbuyer, { -- The specified entity number
				options = {
					{
						type = 'client',
						label = "Sell Fish ",
						icon = "fas fa-eye",
						event = 'md-fishing:server:sellfish',
					},
				},
				distance = 2.0
			})
		end
local fishchummer = "u_m_m_blane"
	lib.requestModel(fishchummer, 500)
	local chumloc = Config.ChumLoc
	
	 fishchum = CreatePed(0, fishchummer,chumloc.x,chumloc.y,chumloc.z-1, 189, false, false)
             FreezeEntityPosition(fishchum, true)
            SetEntityInvincible(fishchum, true)
		if Config.oxtarget then	
				options = {
                    {
                        label = "Make Chum",
                        icon = "fas fa-eye",
                        serverEvent = 'md-fishing:server:fishchum',
                    },
                }
               
			exports.ox_target:addLocalEntity(fishchum, options)	
		else
			exports['qb-target']:AddTargetEntity(fishchum, { -- The specified entity number
				options = {
					{
						type = 'server',
						label = "Make Chum",
						icon = "fas fa-eye",
						event = 'md-fishing:server:fishchum',
					},
				},
				distance = 2.0
			})
		end
		
if Config.oxinv then 
else
 local current = "u_m_m_blane"
	lib.requestModel(current, 500)
	local CurrentLocation = Config.ShopLoc
	
	 fishseller = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 189, false, false)
             FreezeEntityPosition(fishseller, true)
            SetEntityInvincible(fishseller, true)
		if Config.oxtarget then
				options = {
                    {
                        label = "Fish Shop",
                        icon = "fas fa-eye",
                        event = 'md-fishing:client:OpenFishShop',
                    },
					
                }
               
			exports.ox_target:addLocalEntity(fishseller, options)	
		else
			exports['qb-target']:AddTargetEntity(fishseller, { -- The specified entity number
				options = {
					{
						type = 'client',
						label = "Fish Shop",
						icon = "fas fa-eye",
						event = 'md-fishing:client:OpenFishShop',
					},
				},
				distance = 2.0
			})
		end	
end
if Config.oxtarget then
	materialbreak = exports.ox_target:addBoxZone({
	coords = Config.MaterialBreakdown ,
	size = vec3(2,2,2),
	debug = false,
	options = {
		{
			label = "Melt Rusty Materials",
			icon = "fas fa-eye",
			serverEvent = 'md-fishing:server:breakdownmagnetloot',
		}
	}
	})	
else
exports['qb-target']:AddBoxZone("magnetbreakdown",Config.MaterialBreakdown ,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "magnetbreakdown",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.MaterialBreakdown-2,
		maxZ = Config.MaterialBreakdown+2,
	}, {
		options = {
			{
			type = 'server',
			label = "Melt Rusty Materials",
			icon = "fas fa-eye",
			event = 'md-fishing:server:breakdownmagnetloot',
			}
		},
		distance = 2.5
	})
end		
end)

CreateThread(function()
local fishrep = QBCore.Functions.GetPlayerData().metadata["fishingrep"]
local magnetrep = QBCore.Functions.GetPlayerData().metadata["magnetfishingrep"]
local illegalfish = QBCore.Functions.GetPlayerData().metadata["illegalfishing"]
for k, v in pairs (Config.FishingZones) do
 sphere = lib.zones.sphere({
    coords = v,
	radius = 30,
    debug = false,
    inside = function()
			if fishing then
				if  fishrep <= Config.tier1rep then
					Wait(Config.tierWaitTimer1) 
					LegalFishing()
				elseif  fishrep >= Config.tier2rep then
					Wait(Config.tierWaitTimer2) 
					LegalFishing()
				elseif  fishrep >= Config.tier3rep then	
					Wait(Config.tierWaitTimer3) 
					LegalFishing()
				elseif  fishrep >= Config.tier4rep then
					Wait(Config.tierWaitTimer4) 
					LegalFishing()
				elseif  fishrep >= Config.tier5rep then
					Wait(Config.tierWaitTimer5) 
					LegalFishing()
				elseif  fishrep >= Config.tier6rep then
					Wait(Config.tierWaitTimer6) 
					LegalFishing()
				elseif  fishrep >= Config.tier7rep then
					Wait(Config.tierWaitTimer7) 
					LegalFishing()
				elseif  fishrep >= Config.tier8rep then
					Wait(Config.tierWaitTimer8) 
					LegalFishing()
				elseif  fishrep >= Config.tier9rep then
					Wait(Config.tierWaitTimer9) 
					LegalFishing()
				elseif  fishrep >= Config.tier10rep then
					Wait(Config.tierWaitTimer10)
					LegalFishing()				
				end	
			elseif magnetfishing then 
				if  fishrep >= Config.tier2rep  then
					Wait(Config.tierWaitTimer1) 
					MagnetFish()
				elseif  magnetrep >= Config.tier2rep then
					Wait(Config.tierWaitTimer2)
					MagnetFish()
				elseif  magnetrep >= Config.tier3rep then	
					Wait(Config.tierWaitTimer3) 
					MagnetFish()
				elseif  magnetrep >= Config.tier4rep then
					Wait(Config.tierWaitTimer4) 
					MagnetFish()
				elseif  magnetrep >= Config.tier5rep then
					Wait(Config.tierWaitTimer5) 
					MagnetFish()
				elseif  magnetrep >= Config.tier6rep then
					Wait(Config.tierWaitTimer6) 
					MagnetFish()
				elseif  magnetrep >= Config.tier7rep then
					Wait(Config.tierWaitTimer7) 
					MagnetFish()
				elseif  magnetrep >= Config.tier8rep then
					Wait(Config.tierWaitTimer8)
					MagnetFish()
				elseif  magnetrep >= Config.tier9rep then
					Wait(Config.tierWaitTimer9) 
					MagnetFish()
				elseif  magnetrep >= Config.tier10rep then
					Wait(Config.tierWaitTimer10) 
					MagnetFish()
				else
					QBCore.Functions.Notify("You Need " .. Config.tier2rep .. " Fishing Rep To Use Magnet Fishing Here")
					Wait(5000)
				end
			else		
			end	
			end,
    onEnter = function()
			QBCore.Functions.Notify("Pull Your Fishing Pole Out")
			end,
    onExit = onExit
})
end
local polchance = math.random(1,100)
local attackchance = math.random(1,100)
for k, v in pairs (Config.illegalfishingzones) do 
 illegalsphere = lib.zones.sphere({
    coords = v,
	radius = 250,
    debug = false,
    inside = function()
			if fishing then
				if  fishrep >= Config.tier10rep then
					Wait(Config.tierWaitTimer1) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier2rep then
					Wait(Config.tierWaitTimer2) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier3rep then	
					Wait(Config.tierWaitTimer3) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier4rep then
					Wait(Config.tierWaitTimer4) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier5rep then
					Wait(Config.tierWaitTimer5) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier6rep then
					Wait(Config.tierWaitTimer6) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier7rep then
					Wait(Config.tierWaitTimer7) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier8rep then
					Wait(Config.tierWaitTimer8) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier9rep then
					Wait(Config.tierWaitTimer9) 
					IllegalFishing()
				elseif  illegalfish >= Config.tier10rep then
					Wait(Config.tierWaitTimer10) 
					IllegalFishing()
				else
					QBCore.Functions.Notify("You Need " .. Config.tier10rep .. " Fishing Rep To Use Fishing Here")
					Wait(5000)			
						
				end
			end	
			end,
    onEnter = function()
			
				if  QBCore.Functions.GetPlayerData().metadata["fishingrep"] >= Config.tier10rep then
					QBCore.Functions.Notify("Pull Your Fishing Pole Out And Get Some Chum")
				else
					QBCore.Functions.Notify("You Need " .. Config.tier10rep .. " Regular Fishing Rep To Fish Here")
				end	
			end,
    onExit = onExit
})
end
end)	

RegisterNetEvent("md-fishing:client:fishing")
AddEventHandler("md-fishing:client:fishing", function() 
	if fishing then
		QBCore.Functions.Notify("You Put Your Pole Away")
		DetachEntity(fishing, true, true)
		DeleteObject(fishing)
		fishing = nil
		ClearPedTasks(PlayerPedId())
	else	
			local pos = GetEntityCoords(PlayerPedId(), true)
		RequestAnimDict('amb@world_human_stand_fishing@idle_a')
		while (not HasAnimDictLoaded('amb@world_human_stand_fishing@idle_a')) do
			Wait(7)
		end
		TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
		RequestModel("prop_fishing_rod_01")
		while not HasModelLoaded("prop_fishing_rod_01") do
			Wait(0)
		end
		local object = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		fishing = object
	end	
end)

RegisterNetEvent("md-fishing:client:magnetfishing")
AddEventHandler("md-fishing:client:magnetfishing", function() 
	if magnetfishing then
		QBCore.Functions.Notify("You Put Your Pole Away")
		DetachEntity(magnetfishing, true, true)
		DeleteObject(magnetfishing)
		magnetfishing = nil
		ClearPedTasks(PlayerPedId())
	else	
			local pos = GetEntityCoords(PlayerPedId(), true)
		RequestAnimDict('amb@world_human_stand_fishing@idle_a')
		while (not HasAnimDictLoaded('amb@world_human_stand_fishing@idle_a')) do
			Wait(7)
		end
		TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
		RequestModel("prop_fishing_rod_01")
		while not HasModelLoaded("prop_fishing_rod_01") do
			Wait(0)
		end
		local object = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		magnetfishing = object
	end	
end)

RegisterNetEvent('md-fishing:client:placechest')
AddEventHandler("md-fishing:client:placechest", function() 
local chest = "xm_prop_x17_chest_closed"
local chestloc = GetEntityCoords(PlayerPedId())
lib.requestModel(chest, 500)
treasurechest = CreateObject(chest,chestloc.x,chestloc.y,chestloc.z-1, true, false)
PlaceObjectOnGroundProperly(treasurechest)
if Config.oxtarget then
	options = {
        {
            label = "Open Chest",
            icon = "fas fa-eye",
            onSelect = function()
				exports['ps-ui']:Circle(function(success)
					if success then
						DeleteObject(treasurechest)
						
						TriggerEvent('md-fishing:client:openchest')
		
					else
						QBCore.Functions.Notify("Its A Circle Not Rocket Science")
					end
					end, 1, 8)
				end,	
        }
    }
   
	exports.ox_target:addLocalEntity(treasurechest, options)	
else
	exports['qb-target']:AddTargetEntity(treasurechest, { -- The specified entity number
	options = {
		{
			name = 'unlock',
			 label = "Open Chest",
           		 icon = "fas fa-eye",
           		 action = function()
				exports['ps-ui']:Circle(function(success)
					if success then
						DeleteObject(treasurechest)
						TriggerEvent('md-fishing:client:openchest')
						exports.ox_target:removeLocalEntity(treasurechest, 'unlock')
					else
						QBCore.Functions.Notify("Its A Circle Not Rocket Science")
					end
					end, 1, 8)
				end,	
		},
	},
	distance = 2.0
})
end
end)

RegisterNetEvent('md-fishing:client:openchest')
AddEventHandler("md-fishing:client:openchest", function() 
local chest = GetEntityCoords(PlayerPedId())
lib.requestModel("xm_prop_x17_chest_open", 500)
openedchest = CreateObject("xm_prop_x17_chest_open", chest.x,chest.y,chest.z-1, true, false)
if Config.oxtarget then
	options2 = {
		{
			name = 'openchest',
			label = "Loot Chest",
			icon = "fas fa-eye",
			onSelect = function()
					DeleteObject(openedchest)
					TriggerServerEvent('md-fishing:server:getchestreward')
					exports.ox_target:removeLocalEntity(openedchest, 'openchest')
					
				end,
		}
	}
	exports.ox_target:addLocalEntity(openedchest, options2)	
else
	exports['qb-target']:AddTargetEntity(openedchest, { -- The specified entity number
				options = {
					{
						
						label = "Loot Chest",
						icon = "fas fa-eye",
						action = function()
								DeleteObject(openedchest)
								Wait(1000)
								TriggerServerEvent('md-fishing:server:getchestreward')
							end,
					}
				},
				distance = 2.0
			})
end			
end)
--------- commands
RegisterCommand('fishingrep', function()
    local fishing = QBCore.Functions.GetPlayerData().metadata["fishingrep"]
    QBCore.Functions.Notify("Current Rep: "..fishing)
end)

RegisterCommand('magnetrep', function()
    local magnetfishingrep = QBCore.Functions.GetPlayerData().metadata["magnetfishingrep"]
    QBCore.Functions.Notify("Current Rep: "..magnetfishingrep)
end)

RegisterCommand('illegalfishrep', function()
    local illegalfishing = QBCore.Functions.GetPlayerData().metadata["illegalfishing"]
    QBCore.Functions.Notify("Current Rep: "..illegalfishing)
end)

RegisterNetEvent('md-fishing:client:OpenFishShop')
AddEventHandler('md-fishing:client:OpenFishShop', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Fishing Shop", Config.Items)
end)

function MagnetFish()
exports['ps-ui']:Circle(function(success)
	if success then
		if Config.AutoRecast then
			TriggerServerEvent('md-fishing:server:givemagnetfish')
		else
			TriggerServerEvent('md-fishing:server:givemagnetfish')
			QBCore.Functions.Notify("You Put Your Pole Away")
			DetachEntity(magnetfishing, true, true)
			DeleteObject(magnetfishing)
			magnetfishing = nil
			ClearPedTasks(PlayerPedId())
		end
	else
		QBCore.Functions.Notify("The Line Broke Because The Item Was To Heavy")					
	end
	end, 1, 8) -- NumberOfCircles, 	
end

function IllegalFishing()
local polchance = math.random(1,100)
exports['ps-ui']:Circle(function(success)
if success then
	if Config.AutoRecast then
		TriggerServerEvent('md-fishing:server:giveillegalfish')
	else
		TriggerServerEvent('md-fishing:server:giveillegalfish')
		QBCore.Functions.Notify("You Put Your Pole Away")
		DetachEntity(fishing, true, true)
		DeleteObject(fishing)
		fishing = nil
		ClearPedTasks(PlayerPedId())
	end
else
	QBCore.Functions.Notify("Fish Got Away")
	if polchance <= Config.PoliceChance then
	PoliceCall()
	end
	
end
end, 3, 10) -- NumberOfCircles, 
end

function LegalFishing()
exports['ps-ui']:Circle(function(success)
if success then
	if Config.AutoRecast then
		TriggerServerEvent('md-fishing:server:givefish')
	else
		TriggerServerEvent('md-fishing:server:givefish')
		QBCore.Functions.Notify("You Put Your Pole Away")
		DetachEntity(fishing, true, true)
		DeleteObject(fishing)
		fishing = nil
		ClearPedTasks(PlayerPedId())
		
	end
else
	QBCore.Functions.Notify("Fish Got Away")
end
end, 1, 8) -- NumberOfCircles, 
end

RegisterCommand('anchor', function()
  local ped = GetPlayerPed(-1)
	if IsPedInAnyBoat(ped) then
	boat  = GetVehiclePedIsIn(ped, true)
	
		if anchor then 
			SetBoatAnchor(boat, false)
			QBCore.Functions.Notify("Stopped The Anchor")
			anchor = false
		else
			SetBoatAnchor(boat, true)
			SetForcedBoatLocationWhenAnchored(boat, true)
			anchor = true
			QBCore.Functions.Notify("Let The Anchor Down")
			SetBoatFrozenWhenAnchored(boat, true)
		end
	else
	QBCore.Functions.Notify("Not In A Boat You Silly Goose")
	end
end)
