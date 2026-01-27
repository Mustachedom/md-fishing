
local function found()
	Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.gotABite') , 'success')
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(500)
	FreezeEntityPosition(PlayerPedId(), false)
end

local function requestModel(model, timeout)
	if not IsModelValid(model) then return false end
	timeout = timeout or 10000
	local start = GetGameTimer()
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(100)
		if GetGameTimer() - start > timeout then
			return false
		end
	end
	return true
end

local peds = {}
local zones = {}
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
	local zoneLocations = Bridge.Callback.Trigger('md-fishing:server:getLocations')

	for k, v in pairs (zoneLocations.fishingZones) do
		if not v.enabled then goto continue end
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		local fishingZones = Bridge.Point.Register(
			'fishingZone' .. k,
			v.loc,
			v.radius,
			nil,
			function()
				if Config.AlertInZone then
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.enteredZone'), 'success')
				end
				TriggerServerEvent('md-fishing:server:inZone', 'fishingZones', k)
			end,
			function()
				if Config.AlertInZone then
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.outOfZone'), 'error')
				end
				TriggerServerEvent('md-fishing:server:outZone')
			end
		)
		zones[#zones + 1] = 'fishingZone' .. k
		::continue::
	end

	for k, v in pairs (zoneLocations.illegalFishingZones) do
		if not v.enabled then goto continue end
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		local illegalFishingZones = Bridge.Point.Register(
			'illegalFishingZone' .. k,
			v.loc,
			v.radius,
			nil,
			function()
				if Config.AlertInZone then
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.enteredZone'), 'success')
				end
				TriggerServerEvent('md-fishing:server:inZone', 'illegalFishingZones', k)
			end,
			function()
				if Config.AlertInZone then
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.outOfZone'), 'error')
				end
				TriggerServerEvent('md-fishing:server:outZone')
			end
		)
		zones[#zones + 1] = 'illegalFishingZone' .. k
		::continue::
	end

	for k, v in pairs (zoneLocations.fishBuyers) do
		requestModel(v.ped)
		peds[#peds + 1] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(peds[#peds], true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		Bridge.Target.AddLocalEntity(peds[#peds], {
			{
				icon = Bridge.Language.Locale('Targets.fishBuyer.icon'),
				label = Bridge.Language.Locale('Targets.fishBuyer.label'),
				action = function()
					local itemList = Bridge.Callback.Trigger('md-fishing:server:getStores', 'fishSales', k)
					if not itemList then return end
					local menu = {}
					menu[#menu + 1] = {
						order = 'a',
						title = Bridge.Language.Locale('Targets.fishBuyer.Menu.sellAllTitle'),
						icon = Bridge.Language.Locale('Targets.fishBuyer.Menu.sellAllIcon'),
						description = Bridge.Language.Locale('Targets.fishBuyer.Menu.sellAllDescription'),
						onSelect = function()
							TriggerServerEvent('md-fishing:server:sellFish', 'all', k)
						end
					}
					for item, price in pairs (itemList) do
						if not Bridge.Inventory.HasItem(item) then goto continue end
						local itemInfo = Bridge.Inventory.GetItemInfo(item)
						menu[#menu + 1] = {
							order = itemInfo.label,
							title = itemInfo.label,
							icon = itemInfo.image,
							description = '$' .. price,
							onSelect = function()
								TriggerServerEvent('md-fishing:server:sellFish', item, k)
							end
						}
						::continue::
					end
					table.sort(menu, function(a, b) return a.order < b.order end)
					Bridge.Menu.Open({
						id = Bridge.Language.Locale('Targets.fishBuyer.Menu.menuTitle'),
						title = Bridge.Language.Locale('Targets.fishBuyer.Menu.menuTitle'),
						options = menu
					})
				end,
			},
		})
	end

	for k, v in pairs (zoneLocations.shopLocation) do
		requestModel(v.ped)
		peds[#peds + 1] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(peds[#peds], true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		Bridge.Target.AddLocalEntity(peds[#peds], {
			{
				icon = Bridge.Language.Locale('Targets.shops.icon'),
				label = Bridge.Language.Locale('Targets.shops.label'),
				action = function()
					local itemList = Bridge.Callback.Trigger('md-fishing:server:getStores', 'fishShop', k)
					if not itemList then return end
					local menu = {}
					for itemName, price in pairs (itemList) do
						local itemInfo = Bridge.Inventory.GetItemInfo(itemName)
						menu[#menu + 1] = {
							title = itemInfo.label,
							description = '$' .. price,
							icon = itemInfo.image,
							onSelect = function()
								local input = Bridge.Input.Open(Bridge.Language.Locale('Targets.shops.input.title', itemInfo.label), {
									{type = 'number', min = 0, max = v.amount, title = Bridge.Language.Locale('Targets.shops.input.field1title')},
									{type = 'select', title = Bridge.Language.Locale('Targets.shops.input.field2title'),
										options = {
											{label = Bridge.Language.Locale('Targets.shops.input.field2option1'), value = 'cash'},
											{label = Bridge.Language.Locale('Targets.shops.input.field2option2'), value = 'bank'}
										}
									}
								})
								if input and not input[1] then return end
								TriggerServerEvent('md-fishing:server:buyFishGear', k, itemName, {amount = input[1], type = input[2] or 'cash'})
							end
						}
					end
					Bridge.Menu.Open({
						id = Bridge.Language.Locale('Targets.shops.menuTitle'),
						title = Bridge.Language.Locale('Targets.shops.menuTitle'),
						options = menu
					})
				end,
			},
		})
	end

	for k, v in pairs (zoneLocations.chumMaker) do 
		requestModel(v.ped)
		peds[#peds + 1] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
		Freeze(peds[#peds], true, v.loc.w)
		if v.blipData and v.blipData.enabled then
			createBlip(v.loc, v.blipData)
		end
		Bridge.Target.AddLocalEntity(peds[#peds], {
			{
				label = Bridge.Language.Locale('Targets.chumMaker.label'),
				icon = Bridge.Language.Locale('Targets.chumMaker.icon'),
				action = function()
					local input = Bridge.Input.Open(Bridge.Language.Locale('Targets.chumMaker.input.title'), {
						{
							type = 'select', options = {
								{label = Bridge.Language.Locale('Targets.chumMaker.input.yes'), value = true},
								{label = Bridge.Language.Locale('Targets.chumMaker.input.no'), value = false}
							},
							title = Bridge.Language.Locale('Targets.chumMaker.input.field1Title'),
							description = Bridge.Language.Locale('Targets.chumMaker.input.field1Description')
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
		Bridge.Target.AddBoxZone('matbreakdown' ..k, v.loc, vector3(1.0, 1.0, 1.0), v.loc.w or 0.0, {
			{
				label = Bridge.Language.Locale('Targets.breakDown.label'),
				icon = Bridge.Language.Locale('Targets.breakDown.icon'),
				action = function()
					local itemList = Bridge.Callback.Trigger('md-fishing:server:getBreakdown', k)
					local menu = {}
					for item, values in pairs (itemList) do
						local itemInfo = Bridge.Inventory.GetItemInfo(item)
						menu[#menu + 1] = {
							
							title = itemInfo.label,
							description = Bridge.Language.Locale('Targets.breakDown.input.description', itemInfo.label),
							icon = itemInfo.image,
							onSelect = function()
								if not ps.progressbar(Bridge.Language.Locale('Targets.breakDown.progressbar', itemInfo.label), 4000, 'weld') then return end
								TriggerServerEvent('md-fishing:server:breakDownRustys', k, item)
							end
						}
					end
					Bridge.Menu.Open({
						id = Bridge.Language.Locale('Targets.breakDown.menuTitle'),
						title = Bridge.Language.Locale('Targets.breakDown.menuTitle'),
						options = menu
					})
				end
			}
		})
	end
end

initScript()

local pole = nil
local function poleMake()
    local pos = GetEntityCoords(PlayerPedId(), true)
	requestModel('prop_fishing_rod_01')
	Bridge.Anim.RequestDict('amb@world_human_stand_fishing@idle_a')
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
		Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.inVehicle'), 'error')
		TriggerServerEvent('md-fishing:server:stopFishing')
		return
	end

	if fishing then
		Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.alreadyFishing'), 'error')
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
			Bridge.Notify.SendNotify(Bridge.Language.Locale('Fails.failedCatch'), 'error')
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
            Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.notInWater'), 'error')
            return
        end
        if anchor then
            SetBoatAnchor(boat, false)
            Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.unanchored'), 'success')
            anchor = false
        else
            SetBoatAnchor(boat, true)
            SetForcedBoatLocationWhenAnchored(boat, true)
            SetBoatFrozenWhenAnchored(boat, true)
            Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.anchored'), 'success')
            anchor = true
        end
    else
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.noBoat'), 'error')
    end
end, false)

RegisterCommand('fishingRep', function()
	local rep = Bridge.Callback.Trigger('md-fishing:server:getLevels')
	local menu = {}
	for k, v in pairs (rep.level) do
		local icon
		if k == 'fishing' then
			icon = Bridge.Language.Locale('Command.iconFish')
		elseif k == 'magnet' then
			icon = Bridge.Language.Locale('Command.iconMagnet')
		elseif k == 'illegal' then
			icon = Bridge.Language.Locale('Command.iconIllegal')
		end
		menu[#menu + 1] = {
			title = Bridge.Language.Locale('Command.Rep', k, v.level),
			description = Bridge.Language.Locale('Command.RepDescription', v.xp, rep.maxXP),
			icon = icon,
			onSelect = function()
				return
			end
		}
	end
	Bridge.Menu.Open({
		id = Bridge.Language.Locale('Command.id'),
		title = Bridge.Language.Locale('Command.header'),
		options = menu
	})
end, false)