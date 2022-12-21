-- Debug printer
function dprint(msg)
	if debugMode then
		print(msg)
	end
end

local vehicles = {} -- Table where all the vehicle data will be saved.

-- Event to replace the id of the despawned vehicle with the id of the replaced vehicle.
RegisterServerEvent('hd:updateId')
AddEventHandler('hd:updateId', function(oldId, newId)
	for i=1,#vehicles,1 do
		if vehicles[i].id == oldId then
			vehicles[i].id = newId
		end
	end
end)

-- Completes the saving by inserting all the info in the table.
function insert(index, id, model, x, y, z, heading)
	vehicles[index] = {
		['id'] = id,
		['model'] = model,
		['position'] = {
			['x'] = x,
			['y'] = y,
			['z'] = z
		},
		['heading'] = heading
	}
end

-- Event to evaluate where should every vehicle be saved in the table.
RegisterServerEvent('hd:save')
AddEventHandler('hd:save', function(id, model, x, y, z, heading)
	if vehicles[1] then
		for i=1,#vehicles,1 do
			if vehicles[i].id == id then
				insert(i, id, model, x, y, z, heading)
				dprint(model .. '(' .. id ..')' .. 'updated!')
				break
			elseif i == #vehicles then
				insert(#vehicles+1, id, model, x, y, z, heading)
				dprint(model .. '(' .. id ..')' .. 'added!')
			end
		end
	else
		insert(#vehicles+1, id, model, x, y, z, heading)
		dprint(model .. '(' .. id ..')' .. 'added!')
	end
end)

RegisterServerEvent('hd:retrieveTable')
AddEventHandler('hd:retrieveTable', function()
	dprint('Checking vehicles...')
	TriggerClientEvent('hd:checkVehs', GetPlayers()[1], vehicles)
end)

AddEventHandler('EnteredVehicle')