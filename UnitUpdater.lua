tyrPlates.unitUpdater = CreateFrame("Frame", nil, UIParent)
local unitUpdater = tyrPlates.unitUpdater
local castbarDB = tyrPlates.castbarDB
local auraDB = tyrPlates.auraDB
local spellDB = tyrPlates.spellDB

--update casts and auras on units (target/focus/group etc.) after cahnging target, focus or mouseover
--tyrPlates.unitUpdater:RegisterEvent("PLAYER_TARGET_CHANGED")
tyrPlates.unitUpdater:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
tyrPlates.unitUpdater:RegisterEvent("PLAYER_FOCUS_CHANGED")
tyrPlates.unitUpdater:RegisterEvent("UNIT_AURA")
tyrPlates.unitUpdater:RegisterEvent("UNIT_TARGET")
tyrPlates.unitUpdater:SetScript("OnEvent", function()

	local unit
	if event == "UNIT_TARGET" then
		unit = arg1
		if unit == "player" then
			unit = "target"
		else
			unit = unit.."target"
		end
	elseif event == "UPDATE_MOUSEOVER_UNIT" then
		unit = "mouseover"
		
	elseif event == "PLAYER_FOCUS_CHANGED" then
		unit = "focus"
		
	elseif event == "UNIT_AURA" then
		unit = arg1
		if unit == "player" then return end
	end
	
	ace:print(unit)

	if not UnitExists(unit) then return end
	
	ace:print("do some")
	
	local unitName = UnitName(unit)
	local unitGUID = UnitGUID(unit)
	local isFriendly = UnitIsFriend("player", unit)
	
	local dest
	if tyrPlates:IsPlayerGUID(unitGUID) then
		dest = unitName
		-- if player, add name and class to the classDB
		if UnitIsPlayer(unit) and not TyrPlatesDB.class[unitName] then
			local _, class = UnitClass(unit)
			TyrPlatesDB.class[unitName] = class
		end	
	else
		dest = unitGUID
	end
	
	unitUpdater:UpdateUnitAuras(dest, unit, isFriendly)
	unitUpdater:UpdateUnitCast(dest, unit, isFriendly)
end)

--updates casts of a unit (target/focus/group etc.) after it starts casting
unitUpdater.cast = CreateFrame("Frame", nil, UIParent)
unitUpdater.cast:RegisterEvent("UNIT_SPELLCAST_START")
unitUpdater.cast:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
unitUpdater.cast:SetScript("OnEvent", function()

	local unit = arg1
	local unitName = UnitName(unit)
	local unitGUID = UnitGUID(unit)
	local isFriendly = UnitIsFriend("player", unit)
  
	--if not unitName or not unitGuid then return end
  
	if tyrPlates:IsPlayerGUID(unitGUID) then
		unitUpdater:UpdateUnitCast(unitName, unit, isFriendly)
	else
		unitUpdater:UpdateUnitCast(unitGUID, unit, isFriendly)
	end 
end)

function unitUpdater:UpdateUnitAuras(unitIdentifier, unit, isfriendly)

	local currentTime = GetTime()
	local auraFound = {}
	
	if not auraDB[unitIdentifier] then
		auraDB[unitIdentifier] = {}
	end

	--[[for testing
	if not auraDB[unitIdentifier]["Poison"] then 
		local auraIcon = TyrPlatesDB.icons[auraName] or tyrPlates:GetAuraIcon(auraName)
		auraDB[unitIdentifier]["Poison"] = {startTime = currentTime, stacks = 1, duration = 10, auraIcon = auraIcon, auraType = "Magic", isOwn = true}	
	end]]
	
	UpdateUnitAurasByauraType(unitIdentifier, unit, isfriendly, currentTime, auraFound, UnitDebuff)
	UpdateUnitAurasByauraType(unitIdentifier, unit, isfriendly, currentTime, auraFound, UnitBuff)
	
	--delete auras from the auraDB that were not found on the enemy
	for aura in pairs(auraDB[unitIdentifier]) do
		if not auraFound[aura] and not spellDB.trackAura.invisible[aura] then
			--only delete auras if aura wasn't recently applied
			--ace:print(currentTime - auraDB[unitIdentifier][aura]["startTime"])
			if spellDB.trackAura.own[aura] or spellDB.trackAura.enemy[aura] or currentTime - auraDB[unitIdentifier][aura]["startTime"] > 0.2 then
				--ace:print("remove ".. aura .. " from "..unitIdentifier)
				auraDB[unitIdentifier][aura] = nil
				if not UnitIsPlayer(unit) then
					local unitName = UnitName(unit)
					auraDB:decreaseAuraCounter(unitName)
				end
			end
		end
	end
end

function UpdateUnitAurasByauraType(unitIdentifier, unit, isfriendly, currentTime, auraFound, auraTypeFunction)

	local i = 1
	local auraName, _, auraIcon, stackCount, _, _, timeLeft = auraTypeFunction(unit, i)
	
	while auraName do
		-- if an entry for this aura exists and belongs to the player, update it's entry
		if auraDB[unitIdentifier][auraName] then
			-- update duration, stacks and affiliation
			if timeLeft then
				auraDB[unitIdentifier][auraName]["startTime"] = currentTime
				auraDB[unitIdentifier][auraName]["duration"] = timeLeft
				auraDB[unitIdentifier][auraName]["stacks"] = stackCount			
				auraDB[unitIdentifier][auraName]["isOwn"] = true
			else
				auraDB[unitIdentifier][auraName]["isOwn"] = false
			end
			auraFound[auraName] = true
		-- if this aura wasn't found but should be shown, create a new entry
		elseif isfriendly and spellDB.trackAura.friendly[auraName] or not isfriendly and (spellDB.trackAura.enemy[auraName] or (spellDB.trackAura.own[auraName] and timeLeft)) then
			
			local auraType = spellDB.trackAura.own[auraName] or spellDB.trackAura.enemy[auraName] or spellDB.trackAura.friendly[auraName]
			
			if timeLeft then
				auraDB[unitIdentifier][auraName] = {startTime = currentTime, stacks = stackCount, duration = timeLeft, icon = auraIcon, auraType = auraType, isOwn = true}
			else
				auraDB[unitIdentifier][auraName] = {startTime = 0, stacks = stackCount, duration = 0, icon = auraIcon, auraType = auraType, isOwn = false}
			end
			
			if not UnitIsPlayer(unit) then
			local unitName = UnitName(unit)
				auraDB:increaseAuraCounter(unitName)
			end
			
			auraFound[auraName] = true			
		end 
		i = i + 1
		auraName, _, auraIcon, stackCount, _, _, timeLeft = auraTypeFunction(unit, i)
	end
end

-- updates the current cast of a given unit
function unitUpdater:UpdateUnitCast(unitIdentifier, unit, isFriendly)

	local spellName, _, displayName, spellIcon, startTime, endTime = UnitCastingInfo(unit)
	if not spellName then
		spellName, _, displayName, spellIcon, startTime, endTime = UnitChannelInfo(unit)
	end
	
	-- check if unit is currently casting
	if spellName then
		-- if unit is friendly show only casts in the trackAura.friendly table
		if not filterFriendlyCasts or not isFriendly or spellDB.friendlyCasts[spellName] then
			local remainingCastTime = (endTime-startTime)/1000 	-- divided by 1000 to convert both values to seconds
			-- if our castDB has an entry for this cast, update this entry otherwise create a new one
			if castbarDB.castDB[unitIdentifier] then
				local castTime = castbarDB.castDB[unitIdentifier]["castTime"]
			
				-- update spell casttime for the player
				castbarDB.castDB[unitIdentifier]["castTime"] = remainingCastTime
				
				-- if the updated castTime doesn't align with the castDB, change the casters base casting speed 
				if tyrPlates.updateCastSpeed and UnitIsPlayer(unit) and not spellDB.reducedCastTime[spellName] then
					if not castbarDB.castingSpeedDB[unitIdentifier] then castbarDB.castingSpeedDB[unitIdentifier] = 1 end
					castbarDB.castingSpeedDB[unitIdentifier] = castbarDB.castingSpeedDB[unitIdentifier] * (remainingCastTime/castTime)
				end				
			else
				-- create new cast entry in the castDB
				castbarDB.castDB[unitIdentifier] = {cast = spellName, startTime = startTime/1000, castTime = remainingCastTime, icon = spellIcon, school = nil, pushbackCounter = 0}
			end
		end
	else
		--reset current cast in castDB
		castbarDB.castDB[unitIdentifier] = nil
	end
end