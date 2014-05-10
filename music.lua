local box = periph.getPeripheral("bottom")

local lengths = { "Whole", "Half", "Quarter", "Eighth", "Sixteenth" }
local notes = { "F", "F#", "G", "G#", "A", "Bb", "B", "C", "C#", "D", "Eb", "E" }
local instruments = { "Rest", "Guitar", "Bass", "Pling", "BassDrum", "Snare", "Clave" }

-- Now to calculate the length of the notes.

function main()
	clearChannels()

	for line in io.lines("snowman.song") do
		local t = fromCSV(line)
		local note = tostring(t[1])
		local voice = tonumber(t[5])
		
		if note == "-" then
			note = "A"
			voice = 0
		end
		
		addNote(note, t[2], t[3], t[4], voice)
	end
end

function clearChannels()
	for i = 0, 15 do
		box.clearChannel(i)
	end
end

function addNote(note, oct, channel, length, voice)
	local n = table.indexOf(notes, note) - 1
	--local l = table.indexOf(lengths, length) - 1
	--local i = table.indexOf(instruments, voice) - 1
	
	local l = length
	local i = voice
	
	box.addNote(tonumber(n) + (tonumber(oct) * #notes), tonumber(channel), tonumber(l), tonumber(i))
end

function getNoteName(pitch)
	return notes[pitch % 12]
end

function fromCSV (s)
	s = s .. ','        -- ending comma
	local t = {}        -- table to collect fields
	local fieldstart = 1

	repeat
		-- next field is quoted? (start with `"'?)
        if string.find(s, '^"', fieldstart) then
			local a, c
			local i  = fieldstart
			
			repeat
				-- find closing quote
				a, i, c = string.find(s, '"("?)', i+1)
			until c ~= '"'    -- quote not followed by quote?

			if not i then error('unmatched "') end
			
			local f = string.sub(s, fieldstart+1, i-1)
			table.insert(t, (string.gsub(f, '""', '"')))
			fieldstart = string.find(s, ',', i) + 1
		else                -- unquoted; find next comma
			local nexti = string.find(s, ',', fieldstart)
			table.insert(t, string.sub(s, fieldstart, nexti-1))
			fieldstart = nexti + 1
		end
	until fieldstart > string.len(s)
  
	return t
end
	
-- Helper functions
table.indexOf = function( t, object )
	local result
 
	if "table" == type( t ) then
		for i=1, #t do
			if object == t[i] then
				result = i
				break
			end
		end
	end
 
	return result
end

main()