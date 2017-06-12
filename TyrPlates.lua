-- create main frame
tyrPlates = CreateFrame("Frame", nil, UIParent)
tyrPlates.spellDB = {}

tyrPlates:RegisterEvent("ADDON_LOADED")
tyrPlates:SetScript("OnEvent", function()
	if arg1 ~= "TyrPlates" then return end
	if not ( TyrPlatesDB ) then TyrPlatesDB = {} end
	if not ( TyrPlatesDB.class ) then TyrPlatesDB.class = {} end
	if not ( TyrPlatesDB.icons ) then TyrPlatesDB.icons = {} end
	tyrPlates:UnregisterEvent("ADDON_LOADED")
end)

function tyrPlates:GetAuraIcon(aura)
	for i = 1, 50000 do
		local auraName, _, auraIcon = GetSpellInfo(i)
		if aura == auraName then
			return auraIcon
		end
	end
end

function tyrPlates:track(what, auraName, spellId)

	if what == "own" then
		return tyrPlates.spellDB.trackAura.own[auraName] or tyrPlates.spellDB.trackAura.own[spellId]
	end
	
	if what == "enemy" then
		return tyrPlates.spellDB.trackAura.enemy[auraName] or tyrPlates.spellDB.trackAura.enemy[spellId]
	end
	
	if what == "friendlyPlayer" then
		return tyrPlates.spellDB.trackAura.friendlyPlayer[auraName] or tyrPlates.spellDB.trackAura.friendlyPlayer[spellId]
	end
end

tyrPlates.inCombat = false

-- tracks if player is in combat
tyrPlates.combatTracker = CreateFrame("Frame", nil, UIParent)
tyrPlates.combatTracker:RegisterEvent("PLAYER_REGEN_ENABLED")
tyrPlates.combatTracker:RegisterEvent("PLAYER_REGEN_DISABLED")
tyrPlates.combatTracker:SetScript("OnEvent", function()
	if event == "PLAYER_REGEN_ENABLED" then
		tyrPlates.inCombat = false
		tyrPlates:ClearTable(tyrPlates.healthDiffDB)
		tyrPlates:ClearTable(tyrPlates.auraCounter)
	else
		tyrPlates.inCombat = true
	end
end)

-- checks if the given guid is the guid of a pet or player
function tyrPlates:IsPlayerOrPetGUID(guid)
	local first3Numbers = tonumber("0x"..strsub(guid, 3,5))
	if not first3Numbers then return false end
	return bit.band(first3Numbers,0x00F) == 0 or bit.band(first3Numbers,0x00F) == 4
end

-- check if the given guid is the guid of the player
function tyrPlates:IsOwnGUID(guid)
	return guid == UnitGUID("player")
end

function tyrPlates:ClearTable(Table)
	if not Table then ace:print("empty table") return end
	for element in pairs (Table) do
		Table[element] = nil
	end
end


