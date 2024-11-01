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
	lib.requestModel("prop_fishing_rod_01", 1000)
	lib.requestAnimDict('amb@world_human_stand_fishing@idle_a', 1000)
	for k, v in pairs (Config.Blips) do 
		if v.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z) 
			SetBlipSprite(blip, v.sprite) SetBlipDisplay(blip, 6) SetBlipScale  (blip, v.scale) SetBlipColour (blip, v.color)
			SetBlipAsShortRange(blip,true) BeginTextCommandSetBlipName("STRING") AddTextComponentString(v.label) EndTextCommandSetBlipName(blip)		
		end
	end
	----------------- PED CREATION/STORE
	lib.requestModel("u_m_m_blane", 15000)
	local fishbuyer = CreatePed(0, "u_m_m_blane",Config.FishBuyer.x,Config.FishBuyer.y,Config.FishBuyer.z-1, Config.FishBuyer.w, false, false)
	local fishchum = CreatePed(0, "u_m_m_blane",Config.ChumLoc.x,Config.ChumLoc.y,Config.ChumLoc.z-1, Config.ChumLoc.w, false, false)
	local fishstore = CreatePed(0, "u_m_m_blane",Config.ShopLoc.x,Config.ShopLoc.y,Config.ShopLoc.z-1, Config.ShopLoc.w, false, false)
    Freeze(fishbuyer, true,Config.FishBuyer.w)
	Freeze(fishchum, true,Config.ChumLoc.w )
	Freeze(fishstore, true, Config.ShopLoc.w)
	AddSingleModel(fishbuyer, {label = "Sell Fish",    icon = "fas fa-eye",   action = function() makeSales('fish') lib.showContext('fish')end }, fishbuyer)
	AddSingleModel(fishchum,  {label = "Make Fish Chum",icon = "fas fa-eye", serverEvent = 'md-fishing:server:fishchum', }, fishbuyer)
	AddSingleModel(fishstore, {label = "Open Shop",    icon = "fas fa-eye", action = function() makeMenu('fishshop') lib.showContext('fishshop') end}, fishstore)
	AddBoxZoneSingle('breadown', Config.MaterialBreakdown, {label = "break Down",icon = "fas fa-eye",action = function() breakDown('breakDown') lib.showContext('breakDown') end})
end)

CreateThread(function() --- zone creation necessary to get the globals to allow/disallow fishing
	for k, v in pairs (Config.FishingZones) do
		if v.enabled then 
			sphere = lib.zones.sphere({ coords = v.loc, radius = v.radius, debug = v.debug,
				onEnter = function() Notify("Pull Your Fishing Pole Out")	infish = true end,
				onExit = function()	infish = false	end,
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

local pole = nil
function delete(pole)
    DetachEntity(pole, true, true)
    DeleteObject(pole)
    fishing = false
    ClearPedTasks(PlayerPedId())
    Notify("You Put Your Pole Away", 'success')
    if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), false) end
end

function poleMake()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local pole = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
    TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
    AttachEntityToEntity(pole, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    return pole
end

function startFishing(baitTypes, locationCheck, locationError, strengthCheck, strengthError)
    if strengthCheck and strengthCheck then Notify(strengthError, 'error') return end
    if not locationCheck then Notify(locationError, 'error') return end
    if fishing then delete(pole) return end
    local bait = getItemCount(baitTypes)
    if bait == 0 then Notify('You Have No Bait', 'error') return end
	local pos = GetEntityCoords(PlayerPedId(), true)
    pole = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
    TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
    AttachEntityToEntity(pole, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    fishing = true
    if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), true) end
    return pole
end

function fishLoop(baitTypes, fishLevel, eventType)
    repeat
		if not fishing then return end
        local baits = getItemCount(baitTypes)
        if baits == 0 then delete(pole) fishing = false return end
        Wait(Config.Levels[fishLevel]['time'] * 1000)
		if not fishing then return end
        found()
        if minigame() then TriggerServerEvent('md-fishing:server:givefish', eventType) end
        if not Config.AutoRecast then fishing = false end
    until not fishing
end

RegisterNetEvent("md-fishing:client:fishing", function(data)
    local fishingTypes = {
        fishing = {baits = {'spinnerbait', 'softplasticbait', 'plugbait', 'worms'}, event = 'fish', locationCheck = infish, locationError = 'You can\'t fish here'},
        magnetfishing = {baits = {'magnet'}, event = 'magnet', locationCheck = infish, locationError = 'You can\'t fish here'},
        illegal = {baits = {'chum'}, event = 'illegal', locationCheck = inillfish, locationError = 'You Cant Fish Here', strengthCheck = tooweak, strengthError = 'You Arent Strong Enough For This Yet'}
    }

    local fishingType = fishingTypes[data]
    if fishingType then
        local fish = startFishing(fishingType.baits, fishingType.locationCheck, fishingType.locationError, fishingType.strengthCheck, fishingType.strengthError)
        if not fish then return end
        local fishLevel = lib.callback.await('md-fishing:server:GetLevels', false, data)
        fishLoop(fishingType.baits, fishLevel, fishingType.event)
    end
end)

RegisterNetEvent("md-fishing:client:placechest", function() 
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
