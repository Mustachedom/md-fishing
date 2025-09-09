
local fishing = false
local chestspawned = false
local infish = false
local inillfish = false
local tooweak = false
local pole = nil
local anchor = nil

TriggerServerEvent('md-fishing:server:checksql')

local function found()
	ps.notify("You found something!" , 'success')
	TriggerEvent('InteractSound_CL:PlayOnOne','fishsplash', 50.0)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(500)
	FreezeEntityPosition(PlayerPedId(), false)
end
local peds = {}
local function initScript()
	local zoneLocations = ps.callback('md-fishing:server:getLocations')

	for k, v in pairs (zoneLocations.fishingZones) do
		if not v.enabled then goto continue end
		local fishingZones = ps.zones.sphere({
			name = 'fishingZone' .. k,
			coords = v.loc,
			radius = v.radius,
			onEnter = function()
				TriggerServerEvent('md-fishing:server:inZone', 'fishingZones', k)
			end,
			onExit = function()
				TriggerServerEvent('md-fishing:server:outZone')
			end,
			debug = v.debug,
		})
		::continue::
	end

	for k, v in pairs (zoneLocations.illegalFishingZones) do
		if not v.enabled then goto continue end
		local illegalFishingZones = ps.zones.sphere({
			name = 'illegalFishingZone' .. k,
			coords = v.loc,
			radius = v.radius,
			onEnter = function()
				TriggerServerEvent('md-fishing:server:inZone', 'illegalFishingZones', k)
			end,
			onExit = function()
				TriggerServerEvent('md-fishing:server:outZone')
			end,
			debug = v.debug,
		})
		::continue::
	end
	for k, v in pairs (zoneLocations.fishBuyers) do
		ps.requestModel(v.ped)
		local ped = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(ped, true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
			SetBlipSprite(blip, v.blipData.sprite)
			SetBlipScale(blip, v.blipData.scale)
			SetBlipColour(blip, v.blipData.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipData.label)
			EndTextCommandSetBlipName(blip)
		end
		ps.entityTarget(ped, {
			{
				icon = 'fas fa-fish',
				label = 'Sell Your Fish',
				action = function()
					local itemList = ps.callback('md-fishing:server:getStores', 'fishSales', k)
					if not itemList then return end
					local menu = {}
					menu[#menu + 1] = {
						title = 'Sell All',
						icon = 'fas fa-donate',
						description = 'Sell all fish for their set prices',
						action = function()
							TriggerServerEvent('md-fishing:server:sellFish', 'all', k)
						end
					}
					for item, price in pairs (itemList) do
						menu[#menu + 1] = {
							title = ps.getLabel(item),
							icon = ps.getImage(item),
							description = 'Sell for $' .. price .. ' each',
							action = function()
								TriggerServerEvent('md-fishing:server:sellFish', item, k)
							end
						}
					end
					ps.menu('Sell Fish', 'Sell Fish', menu)
				end,
			},
		})
	end
end

initScript()


local function Fm(ped, bool)
	FreezeEntityPosition(ped, bool)
end

local function delete(pole)
    DetachEntity(pole, true, true)
    DeleteObject(pole)
    fishing = false
    ClearPedTasks(PlayerPedId())
    if Config.FreezePlayerWhileFishing then Fm(PlayerPedId(), false) end
end

local function poleMake()
    local thisIsYourPlayersCurrentLocationOnTheMapRepresentedByThreeNumbersXYandZXmeansXaxisYmeansYaxisZmeansHeightItMakesSenseWhenYouThinkOf3D = GetEntityCoords(PlayerPedId(), true)
    pole = CreateObject("prop_fishing_rod_01",
	thisIsYourPlayersCurrentLocationOnTheMapRepresentedByThreeNumbersXYandZXmeansXaxisYmeansYaxisZmeansHeightItMakesSenseWhenYouThinkOf3D.x,
	thisIsYourPlayersCurrentLocationOnTheMapRepresentedByThreeNumbersXYandZXmeansXaxisYmeansYaxisZmeansHeightItMakesSenseWhenYouThinkOf3D.y,
	thisIsYourPlayersCurrentLocationOnTheMapRepresentedByThreeNumbersXYandZXmeansXaxisYmeansYaxisZmeansHeightItMakesSenseWhenYouThinkOf3D.z,
	true, true, true)
    TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
    AttachEntityToEntity(pole, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    return pole
end

local function startFishing(baitTypes, locationCheck, locationError, strengthCheck, strengthError)
    if strengthCheck and strengthCheck then ps.notify(strengthError, 'error') return end
    if not locationCheck then ps.notify(locationError, 'error')return end
    local bait = getItemCount(baitTypes)
    if bait == 0 then ps.notify('You Have No Bait', 'error') return end
    pole = poleMake()
    fishing = true
    return pole
end

local function fishLoop(baitTypes, fishLevel, eventType)
    local time = 0
    repeat
        if not fishing then break end
        local baits = getItemCount(baitTypes)
        if baits == 0 then break end
        if Config.FreezePlayerWhileFishing then Fm(PlayerPedId(), true) end

        repeat
            time = time + 1
            Wait(1000) 
            if not DoesEntityExist(pole) then
                delete(pole)
                Fm(PlayerPedId(), false)
                return
            end
        until Config.Levels[fishLevel]['time'] == time or not DoesEntityExist(pole)
        time = 0
        found()
        if minigame() then
            TriggerServerEvent('md-fishing:server:givefish', eventType)
        end
        if not Config.AutoRecast then fishing = false end
    until not fishing
	delete(pole)
	Fm(PlayerPedId(), false)
end


RegisterNetEvent("md-fishing:client:fishing", function(data)
    local fishingTypes = {
        fishing = {baits = {'spinnerbait', 'softplasticbait', 'plugbait', 'worms'}, event = 'fish', locationCheck = infish, locationError = 'You can\'t fish here'},
        magnetfishing = {baits = {'magnet'}, event = 'magnet', locationCheck = infish, locationError = 'You can\'t fish here'},
        illegal = {baits = {'chum'}, event = 'illegal', locationCheck = inillfish, locationError = 'You Cant Fish Here', strengthCheck = tooweak, strengthError = 'You Arent Strong Enough For This Yet'}
    }
    local fishingType = fishingTypes[data]
	if fishing then delete(pole) Fm(PlayerPedId(), false)  return end
    if fishingType then
        local fish = startFishing(fishingType.baits, fishingType.locationCheck, fishingType.locationError, fishingType.strengthCheck, fishingType.strengthError)
        if not fish then return end
        local fishLevel = lib.callback.await('md-fishing:server:GetLevels', false, data)
        fishLoop(fishingType.baits, fishLevel, fishingType.event)
    end
end)

RegisterCommand('anchor', function()
    local ped = PlayerPedId()
    if IsPedInAnyBoat(ped) then
        local boat = GetVehiclePedIsIn(ped, true)
        if not IsEntityInWater(boat) then
            ps.notify("Your boat is not in the water!", 'error')
            return
        end
        if anchor then
            SetBoatAnchor(boat, false)
            ps.notify("Unanchored", 'success')
            anchor = false
        else
            SetBoatAnchor(boat, true)
            SetForcedBoatLocationWhenAnchored(boat, true)
            SetBoatFrozenWhenAnchored(boat, true)
            ps.notify("Anchored", 'success')
            anchor = true
        end
    else
        ps.notify("Where is your boat?")
    end
end, false)

RegisterCommand('testFish', function()
	TriggerServerEvent('md-fishing:server:givefish')
end, false)