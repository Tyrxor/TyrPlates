tyrPlates = CreateFrame("Frame", nil, UIParent)

tyrPlates:RegisterEvent("ADDON_LOADED")
tyrPlates:SetScript("OnEvent", function()
	if not ( TyrPlatesDB ) then TyrPlatesDB = {} end
	if not ( TyrPlatesDB.class ) then TyrPlatesDB.class = {} end
end)

tyrPlates.inCombat = false

-- tracks if player is in combat
tyrPlates.combat = CreateFrame("Frame", nil, UIParent)
tyrPlates.combat:RegisterEvent("PLAYER_REGEN_ENABLED")
tyrPlates.combat:RegisterEvent("PLAYER_REGEN_DISABLED")
tyrPlates.combat:SetScript("OnEvent", function()

	if event == "PLAYER_REGEN_ENABLED" then
		tyrPlates.inCombat = false
		tyrPlates:ClearTable(tyrPlates.healthDiffDB)
	else
		tyrPlates.inCombat = true
	end
end)

function tyrPlates:IsPlayerOrPetGUID(guid)
	--ace:print(guid)
	local first3Numbers = tonumber("0x"..strsub(guid, 3,5))
	if not first3Numbers then return false end
	return bit.band(first3Numbers,0x00F) == 0 or bit.band(first3Numbers,0x00F) == 4
end

function tyrPlates:IsPetGUID(guid)
	local first3Numbers = tonumber("0x"..strsub(guid, 3,5))
	if not first3Numbers then return false end
	return bit.band(first3Numbers,0x00F) == 4
end
--[[
function tyrPlates:IsNPCGUID(guid)
	local first3Numbers = tonumber("0x"..strsub(guid, 3,5))
	if not first3Numbers then return false end
	return bit.band(first3,first3Numbers) == 3
end
]]

function tyrPlates:IsOwnGUID(guid)
	return guid == UnitGUID("player")
end

function tyrPlates:ClearTable(Table)
	for element in pairs (Table) do
		Table[element] = nil
	end
end


