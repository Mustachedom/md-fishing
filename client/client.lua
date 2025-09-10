
TriggerServerEvent('md-fishing:server:checksql')

local function found()
	ps.notify("You found something!" , 'success')
	TriggerEvent('InteractSound_CL:PlayOnOne','fishsplash', 50.0)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(500)
	FreezeEntityPosition(PlayerPedId(), false)
end

local peds = {}

local function createBlip(loc, blipData)
	local blip = AddBlipForCoord(loc.x, loc.y, loc.z)
	SetBlipSprite(blip, blipData.sprite)
	SetBlipScale(blip, blipData.scale)
	SetBlipColour(blip, blipData.color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(blipData.label)
	EndTextCommandSetBlipName(blip)
end

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
		peds[#peds + 1] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(peds[#peds], true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		ps.entityTarget(peds[#peds], {
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

	for k, v in pairs (zoneLocations.shopLocation) do
		ps.requestModel(v.ped)
		peds[#peds + 1] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(peds[#peds], true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		ps.entityTarget(peds[#peds], {
			{
				icon = 'fas fa-shopping-basket',
				label = 'Browse Shop',
				action = function()
					local itemList = ps.callback('md-fishing:server:getStores', 'fishShop', k)
					if not itemList then return end
					local menu = {}
					for itemName, price in pairs (itemList) do
						menu[#menu + 1] = {
							title = ps.getLabel(itemName),
							description = '$' .. price,
							icon = ps.getImage(itemName),
							action = function()
								local input = ps.input('Purchase ' .. ps.getLabel(itemName), {
									{type = 'number', min = 0, max = v.amount, title = 'How Many To Buy'},
									{type = 'select', options = {{label = 'Cash', value = 'cash'}, {label = 'Bank', value = 'bank'}}, title = 'Payment Type'}
								})
								if input and not input[1] then return end
								TriggerServerEvent('md-fishing:server:buyFishGear', k, itemName, {amount = input[1], type = input[2] or 'cash'})
							end
						}
					end
					ps.menu('Fish Shop', 'Fish Shop', menu)
				end,
			},
		})
	end

	for k, v in pairs (zoneLocations.chumMaker) do 
		ps.requestModel(v.ped)
		peds[#peds + 1] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(peds[#peds], true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		ps.entityTarget(peds[#peds], {
			{
				label = 'Make Chum',
				icon = 'fas fa-shopping-basket',
				action = function()
					local input = ps.input('Confirm You Want To Make Chum ', {
						{
							type = 'select', options = {{label = 'Yes', value = true}, {label = 'No', value = false}}, title = 'Confirm',
							description = 'This will remove all your fish'
						}
					})
					if input and not input[1] then return end
					TriggerServerEvent('md-fishing:server:fishchum', k)
				end
			}
		})
	end

	for k, v in pairs (zoneLocations.breakDown) do
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		ps.boxTarget('matbreakdown' ..k, v.loc, {length = 1.0, width = 1.0, height = 1.0}, {
			{
				label = 'Break Down',
				icon = 'fas fa-shopping-basket',
				action = function()
					local itemList = ps.callback('md-fishing:server:getBreakdown', k)
					local menu = {}
					for item, values in pairs (itemList) do
						menu[#menu + 1] = {
							title = ps.getLabel(item),
							description = 'Break Down ' .. ps.getLabel(item),
							action = function()
								if not ps.progressbar('Breaking Down ' .. ps.getLabel(item), 4000, 'weld') then return end
								TriggerServerEvent('md-fishing:server:breakDownRustys', k, item)
							end
						}
					end
					ps.menu('Break Down Materials', 'Break Down Materials', menu)
				end
			}
		})
	end
end

initScript()

local pole = nil
local function poleMake()
    local pos = GetEntityCoords(PlayerPedId(), true)
	ps.requestModel('prop_fishing_rod_01')
	ps.requestAnim('amb@world_human_stand_fishing@idle_a')
	TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a', 'idle_a', 5.0, -1, -1, 50, 0, false, false, false)
	pole = CreateObject("prop_fishing_rod_01", pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(pole, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    return pole
end

local function deletePole()
    DetachEntity(pole, true, true)
    DeleteObject(pole)
    ClearPedTasks(PlayerPedId())
    if Config.FreezePlayerWhileFishing then FreezeEntityPosition(PlayerPedId(), false) end
end

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		for _, ped in ipairs(peds) do
			DeletePed(ped)
		end
	end
end)

local fishing = false
RegisterNetEvent('md-fishing:client:fishing', function(Timer)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ps.notify("You can't fish in a vehicle!", 'error')
		TriggerServerEvent('md-fishing:server:stopFishing')
		return
	end
	if fishing then
		ps.notify("You are already fishing!", 'error')
		return
	end
	fishing = true
	poleMake()

	repeat
		local time = Timer
		if Config.FreezePlayerWhileFishing then
			FreezeEntityPosition(PlayerPedId(), true)
		end
		repeat
			Wait(1000)
			time = time - 1
		until time == 0 or not fishing or not DoesEntityExist(pole)
		if not fishing then
			return
		end
		if not DoesEntityExist(pole) then
			TriggerServerEvent('md-fishing:server:stopFishingNoAlert')
			return
		end
		found()
		if minigame() then
			TriggerServerEvent('md-fishing:server:catchFish')
		else
			ps.notify("You failed to catch anything!", 'error')
		end
		if not Config.AutoRecast then
			fishing = false
			deletePole()
		end
	until not fishing
end)

RegisterNetEvent('md-fishing:client:stopfishing', function()
	fishing = false
	FreezeEntityPosition(PlayerPedId(), false)
	deletePole()
end)

local anchor = false
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
