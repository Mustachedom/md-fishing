
local function found()
	ps.notify(ps.lang('Fishing.found') , 'success')
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
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		local fishingZones = ps.zones.sphere({
			name = 'fishingZone' .. k,
			coords = v.loc,
			radius = v.radius,
			onEnter = function()
				if Config.AlertInZone then
					ps.notify(ps.lang('Fishing.inZone'), 'success')
				end
				TriggerServerEvent('md-fishing:server:inZone', 'fishingZones', k)
			end,
			onExit = function()
				if Config.AlertInZone then
					ps.notify(ps.lang('Fishing.outZone'), 'error')
				end
				TriggerServerEvent('md-fishing:server:outZone')
			end,
			debug = v.debug,
		})
		::continue::
	end

	for k, v in pairs (zoneLocations.illegalFishingZones) do
		if not v.enabled then goto continue end
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		local illegalFishingZones = ps.zones.sphere({
			name = 'illegalFishingZone' .. k,
			coords = v.loc,
			radius = v.radius,
			onEnter = function()
				if Config.AlertInZone then
					ps.notify(ps.lang('Fishing.inZone'), 'success')
				end
				TriggerServerEvent('md-fishing:server:inZone', 'illegalFishingZones', k)
			end,
			onExit = function()
				if Config.AlertInZone then
					ps.notify(ps.lang('Fishing.outZone'), 'error')
				end
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
				icon = ps.lang('Targets.fishBuyer.icon'),
				label = ps.lang('Targets.fishBuyer.label'),
				action = function()
					local itemList = ps.callback('md-fishing:server:getStores', 'fishSales', k)
					if not itemList then return end
					local menu = {}
					menu[#menu + 1] = {
						title = ps.lang('Targets.fishBuyer.sell.label'),
						icon = ps.lang('Targets.fishBuyer.sell.icon'),
						description = ps.lang('Targets.fishBuyer.sell.description'),
						action = function()
							TriggerServerEvent('md-fishing:server:sellFish', 'all', k)
						end
					}
					for item, price in pairs (itemList) do
						menu[#menu + 1] = {
							title = ps.getLabel(item),
							icon = ps.getImage(item),
							description = ps.lang('Targets.fishBuyer.description', price),
							action = function()
								TriggerServerEvent('md-fishing:server:sellFish', item, k)
							end
						}
					end
					ps.menu(ps.lang('Targets.fishBuyer.menuTitle'), ps.lang('Targets.fishBuyer.menuTitle'), menu)
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
							description = ps.lang('Info.currency').. price,
							icon = ps.getImage(itemName),
							action = function()
								local input = ps.input(ps.lang('Targets.shopLocs.input.title', ps.getLabel(itemName)), {
									{type = 'number', min = 0, max = v.amount, title = ps.lang('Targets.shopLocs.input.field1title')},
									{type = 'select', title = ps.lang('Targets.shopLocs.input.field2title'),
										options = {
											{label = ps.lang('Targets.shopLocs.input.field2option1'), value = 'cash'},
											{label = ps.lang('Targets.shopLocs.input.field2option2'), value = 'bank'}
										}
									}
								})
								if input and not input[1] then return end
								TriggerServerEvent('md-fishing:server:buyFishGear', k, itemName, {amount = input[1], type = input[2] or 'cash'})
							end
						}
					end
					ps.menu(ps.lang('Targets.shopLocs.menuTitle'), ps.lang('Targets.shopLocs.menuTitle'), menu)
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
				label = ps.lang('Targets.chumMaker.label'),
				icon = ps.lang('Targets.chumMaker.icon'),
				action = function()
					local input = ps.input(ps.lang('Targets.chumMaker.input.title'), {
						{
							type = 'select', options = {{label = ps.lang('Info.yes'), value = true}, {label = ps.lang('Info.no'), value = false}},
							title = ps.lang('Targets.chumMaker.input.field1title'),
							description = ps.lang('Targets.chumMaker.input.description')
						}
					})
					if not input then return end
					if not input[1] then return end
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
				label = ps.lang('Targets.breakDown.label'),
				icon = ps.lang('Targets.breakDown.icon'),
				action = function()
					local itemList = ps.callback('md-fishing:server:getBreakdown', k)
					local menu = {}
					for item, values in pairs (itemList) do
						menu[#menu + 1] = {
							title = ps.getLabel(item),
							description = ps.lang('Targets.breakDown.input.description', ps.getLabel(item)),
							action = function()
								if not ps.progressbar(ps.lang('Targets.breakDown.progressbar', ps.getLabel(item)), 4000, 'weld') then return end
								TriggerServerEvent('md-fishing:server:breakDownRustys', k, item)
							end
						}
					end
					ps.menu(ps.lang('Targets.breakDown.menuTitle'), ps.lang('Targets.breakDown.menuTitle'), menu)
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
		ps.notify(ps.lang('Fails.inVehicle'), 'error')
		TriggerServerEvent('md-fishing:server:stopFishing')
		return
	end
	if fishing then
		ps.notify(ps.lang('Fails.alreadyFishing'), 'error')
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
			TriggerServerEvent('md-fishing:server:givefish')
		else
			ps.notify(ps.lang('Fails.failedCatch'), 'error')
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
            ps.notify(ps.lang('anchor.notInWater'), 'error')
            return
        end
        if anchor then
            SetBoatAnchor(boat, false)
            ps.notify(ps.lang('anchor.unanchored'), 'success')
            anchor = false
        else
            SetBoatAnchor(boat, true)
            SetForcedBoatLocationWhenAnchored(boat, true)
            SetBoatFrozenWhenAnchored(boat, true)
            ps.notify(ps.lang('anchor.anchored') 'success')
            anchor = true
        end
    else
        ps.notify(ps.lang('anchor.noBoat'))
    end
end, false)