local QBCore = exports['qb-core']:GetCoreObject()

local progressbartype = Config.progressbartype 
local minigametype = Config.minigametype
local notifytype = Config.Notify 
local dispatch = Config.Dispatch

function progressbar(text, time, anim)
	TriggerEvent('animations:client:EmoteCommandStart', {anim}) 
	if progressbartype == 'oxbar' then 
	  if lib.progressBar({ duration = time, label = text, useWhileDead = false, canCancel = true, disable = { car = true, move = true},}) then 
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
		return true
	  end	 
	elseif progressbartype == 'oxcir' then
	  if lib.progressCircle({ duration = time, label = text, useWhileDead = false, canCancel = true, position = 'bottom', disable = { car = true,move = true},}) then 
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
		return true
	  end
	elseif progressbartype == 'qb' then
	local test = false
		local cancelled = false
	  QBCore.Functions.Progressbar("drink_something", text, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, disableInventory = true,
	  }, {}, {}, {}, function()-- Done
		test = true
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
	  end, function()
		cancelled = true
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
	end)
	  repeat 
		Wait(100)
	  until cancelled or test
	  if test then return true end
	else
		print"dude, it literally tells you what you need to set it as in the config"
	end	  
  end

function minigame(num1, num2)
    local check
	if minigametype == 'ps' then
    	exports['ps-ui']:Circle(function(success)
        	check = success
    	end, num1, num2) 
    	return check
	elseif minigametype == 'ox' then
		num1 = 'easy'
		if num2 <= 6 then num2 = 'hard' elseif num2 >= 7 and num2 <= 12 then num2 = 'medium' else num2 = 'easy' end
		local success = lib.skillCheck({num1, num2}, {'1', '2', '3', '4'})
		return success 
    elseif minigametype == 'none' then
		return true
	else	
		
        print"dude, it literally tells you what you need to set it as in the config"
    end
end


 function Notify(text, type)
	if notifytype =='ox' then
	  lib.notify({title = text, type = type})
        elseif notifytype == 'qb' then
	  QBCore.Functions.Notify(text, type)
	elseif notifytype == 'okok' then
	  exports['okokNotify']:Alert('', text, 4000, type, false)
	else 
       	print"dude, it literally tells you what you need to set it as in the config"
    	end   
  end

function GetImage(img)
	if GetResourceState('ox_inventory') == 'started' then
		local Items = exports['ox_inventory']:Items()
		if Items[img]['client'] then 
			if Items[img]['client']['image'] then
				return Items[img]['client']['image']
			else
				return "nui://ox_inventory/web/images/".. img.. '.png'
			end
		else
			return "nui://ox_inventory/web/images/".. img.. '.png'
		end
	elseif GetResourceState('ps-inventory') == 'started' then
		return "nui://ps-inventory/html/images/".. QBCore.Shared.Items[img].image
	elseif GetResourceState('lj-inventory') == 'started' then
		return "nui://lj-inventory/html/images/".. QBCore.Shared.Items[img].image
	elseif GetResourceState('qb-inventory') == 'started' then
		return "nui://qb-inventory/html/images/".. QBCore.Shared.Items[img].image
	elseif GetResourceState('qs-inventory') == 'started' then
		return "nui://qs-inventory/html/img/".. QBCore.Shared.Items[img].image
	elseif GetResourceState('origen_inventory') == 'started' then
		return "nui://origen_inventory/html/img/".. QBCore.Shared.Items[img].image
	elseif GetResourceState('core_inventory') == 'started' then
		return "nui://core_inventory/html/img/".. QBCore.Shared.Items[img].image
	end
end

function GetLabel(label)
	if GetResourceState('ox_inventory') == 'started' then
		local Items = exports['ox_inventory']:Items()
		return Items[label]['label']
	else
		return QBCore.Shared.Items[label]['label']
	end
end


function ItemCheck(item)
local success 
if GetResourceState('ox_inventory') == 'started' then
    if exports.ox_inventory:GetItemCount(item) >= 1 then return true else Notify('You Need ' .. GetLabel(item) .. " !", 'error') end
else
    if QBCore.Shared.Items[item] == nil then print("There Is No " .. item .. " In Your QB Items.lua") return end
    if QBCore.Functions.HasItem(item) then success = item return success else Notify('You Need ' .. QBCore.Shared.Items[item].label .. " !", 'error') end
end
end
function CheckItems(item)
	local success = 0
	if GetResourceState('ox_inventory') == 'started' then
		for k, v in pairs (item) do 
			if exports.ox_inventory:GetItemCount(v) >= 1 then success = success + 1 end
		end
		if success >= 1 then return true end
	else
		for k, v in pairs (item) do 
			if QBCore.Functions.HasItem(v) then success = success + 1 end 
		end
		if success >= 1 then return true end
	end
end
function Email(sender, subject, message)
	if Config.Phone == 'yflip' then
		local receiver = GetPlayerServerId(PlayerId())
		local insertId, received = exports["yflip-phone"]:SendMail({
			title = subject,
			sender = sender,
			senderDisplayName = sender,
			content = message,
			
		}, 'phoneNumber', receiver)
	elseif Config.Phone == 'qs' then
		TriggerServerEvent('qs-smartphone:server:sendNewMail', {
   		sender = sender,
   		subject = subject,
    		message = message,
    		button = {}
		})
	else
		TriggerServerEvent('qb-phone:server:sendNewMail', {
			sender = sender,
			subject = subject,
			message = message,
		})
	end
end	  

function PoliceCall(chance)
	local math = math.random(1,100)
	if math <= chance then
		if dispatch == 'ps' then 
			exports['ps-dispatch']:DrugSale()
		elseif dispatch == 'cd' then
			local data = exports['cd_dispatch']:GetPlayerInfo()
			TriggerServerEvent('cd_dispatch:AddNotification', {
				job_table = {'police', }, 
				coords = data.coords,
				title = '420-69 Drug Sale',
				message = 'A '..data.sex..' robbing a store at '..data.street, 
				flash = 0,
				unique_id = data.unique_id,
				sound = 1,
				blip = {
					sprite = 431, 
					scale = 1.2, 
					colour = 3,
					flashes = false, 
					text = '420-69 Drug Sale',
					time = 5,
					radius = 0,
				}
			})
		elseif	dispatch == 'core' then
			exports['core_dispatch']:addCall("420-69", "Drugs Are Being Sold", {
				{icon="fa-ruler", info="4.5 MILES"},
				}, {GetEntityCoords(PlayerPedId())}, "police", 3000, 11, 5 )
		elseif dispatch == 'aty' then 
			exports["aty_dispatch"]:SendDispatch('Drug Sale', '420-69', 40, {'police'})
		elseif dispatch == 'qs' then
			exports['qs-dispatch']:DrugSale()
		else
			print('Congrats, You Choose 0 of the options :)')	
		end
	else
	end
end

function GetCops(number)
	if number == 0 then return true end
	local amount = lib.callback.await('md-fishing:server:GetCoppers', false)
	if amount >= number then return true else Notify('You Need '.. number - amount .. ' More Cops To Do This', 'error')  end
end


function Freeze(entity, toggle, head)
		SetEntityInvincible(entity, toggle)
		SetEntityAsMissionEntity(entity, toggle, toggle)
        FreezeEntityPosition(entity, toggle)
        SetEntityHeading(entity, head)
		SetBlockingOfNonTemporaryEvents(entity, toggle)
end