local sides = {"Left", "Right", "Front", "Back", "Top", "Bottom"}

function isPresent(side)
	return peripheral.isPresent(string.lower(side))
end

function findPeripheral(t)
	for i, side in ipairs(sides) do
		if (string.lower(getPeripheralType(side)) == string.lower(t)) then
			return getPeripheral(side)
		end
	end
	
	return nil;
end

function listPeripheral()
	for i, side in ipairs(sides) do
		if (isPresent(side)) then
			print("[" .. side .. "] " .. peripheral.getType(string.lower(side)))
		end
	end
end

function getPeripheralType(side)
	if (isPresent(side)) then
		return peripheral.getType(string.lower(side))
	end
	
	return ""
end

function getPeripheral(side)
	if (isPresent(side)) then
		return peripheral.wrap(string.lower(side))
	end
	
	return nil
end

function listMethods(side)
	local p = getPeripheralType(side)
	
	for key, value in pairs(peripheral.getMethods(side)) do
		print (p .. "." .. key .. "()")
	end
end