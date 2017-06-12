tyrPlates.auraDB = {}
tyrPlates.auraCounter = {}

local auraDB = tyrPlates.auraDB
local auraCounter = tyrPlates.auraCounter
local castbarDB = tyrPlates.castbarDB
local spellDB = tyrPlates.spellDB
local DRDB = {}

--applys auras to players and NPCs
function auraDB:AddAura(srcGUID, destGUID, destName, spellId, currentTime)
	
	-- can sometimes be the case if the spell has no target (e.g. cloak of shadows)
	if not destName then return end

	local auraName, _, AuraIcon = GetSpellInfo(spellId)
	local isOwn = tyrPlates:IsOwnGUID(srcGUID) or IsOwnCast(auraName, currentTime)

	--check if aura has to be shown/applied
	if shouldBeTracked(auraName, spellId, srcGUID, currentTime, isOwn) then
		
		--ace:print("add "..spellId)
		
		local auraDuration
		local ccCategories
		local dest
				
		local auraType = spellDB.trackAura.own[auraName] or spellDB.trackAura.own[spellId] or spellDB.trackAura.enemy[auraName] or spellDB.trackAura.enemy[spellId] 
		
		-- check if aura has a known auraType, if not it is set to none
		if auraType == true then 
			ace:print("auraType is missing for "..auraName)
			auraType = "none"
		end
		
		-- set reference, CC category and the auraDuration table depending on wheter the target is a player or not
		if tyrPlates:IsPlayerOrPetGUID(destGUID) then
			dest = destName
			ccCategories = spellDB.ccCategories.PvP
			auraDuration = spellDB.auraDuration.PvP[auraName] or spellDB.auraDuration.PvE[spellId] or spellDB.auraDuration.PvEByName[auraName]	
		else
			dest = destGUID
			ccCategories = spellDB.ccCategories.PvE
			auraDuration = spellDB.auraDuration.PvE[spellId] or spellDB.auraDuration.PvEByName[auraName]		
			if not auraCounter[destName] then auraCounter[destName] = 0 end
			
			-- increase auraCounter for this unit
			auraCounter[destName] = auraCounter[destName] + 1
			--ace:print(auraCounter[destName])
		end
		
		-- inform the user that the aura has no entry in the auraDurationDB
		if not auraDuration then
			ace:print(auraName .. " has unknown spellId " .. spellId)
			auraDuration = 0
		end
		
		-- check if aura influences cast speed, if yes change the cast speed value of the auras target
		if spellDB.castSpeedChange[auraName] then
			if not castbarDB.castingSpeedDB[dest] then castbarDB.castingSpeedDB[dest] = 1 end
			castbarDB.castingSpeedDB[dest] = castbarDB.castingSpeedDB[dest] * spellDB.castSpeedChange[auraName]
		end	

		-- check if the aura is influenced by a diminishing return
		if ccCategories[auraName] then
			auraDuration = incorparateDiminisingReturn(dest, auraName, auraDuration, ccCategories, currentTime)
		end
				
		-- add aura to auraDB
		if not auraDB[dest] then auraDB[dest] = {} end			
		auraDB[dest][auraName] = {startTime = currentTime, duration = auraDuration, icon = AuraIcon, auraType = auraType, isOwn = isOwn}
		
		-- if aura was seduction then find it's caster, add caster to the channelerDB
		if auraName == "Seduction" then
			local seductionCaster = findSeductionCaster(currentTime)
			if seductionCaster then
				castbarDB.castDB[seductionCaster] = {cast = auraName, startTime = currentTime, castTime = auraDuration, icon = AuraIcon, school = 32, pushbackCounter = 0}
				castbarDB:addChanneler(seductionCaster, seductionCaster, destGUID, destName, auraName)
			end
		end
	end
end

-- checks if the given aura should be tracked
function shouldBeTracked(auraName, spellId, srcGUID, currentTime, isOwn)

	-- track if aura was found in trackAura.enemy table
	if spellDB.trackAura.enemy[auraName] or spellDB.trackAura.enemy[spellId] then 
		return true 
	end
	
	-- track if aura was found in trackAura.own table and belongs to you
	if (spellDB.trackAura.own[auraName] or spellDB.trackAura.own[spellId]) and isOwn then
	   return true 
	end
	return false
end

-- checks if the duration of the aura has to be reduced because of the diminishing returns mechanic
-- adds an entry in the DRDB that for every player tracks auras gained from each CC group (e.g. stuns, fear, roots)
function incorparateDiminisingReturn(dest, aura, auraDuration, ccCategories, currentTime)
				
	local ccGroup = ccCategories[aura]
	if ccGroup == "self" then
		-- aura with cc group self form their own group
		ccGroup = "DR"..aura
	end
					
	-- create empty DRDB entry
	if not DRDB[dest] then
		DRDB[dest] = {}
	end				

	-- create entry for the CC group
	if not DRDB[dest][ccGroup] then
		DRDB[dest][ccGroup] = 1
	end
					
	-- if last aura of this group was more than 15s ago, reset the diminishing return coefficient
	if DRDB[dest][ccGroup.."timer"] and (currentTime - DRDB[dest][ccGroup.."timer"]) > 15 then
		DRDB[dest][ccGroup] = 1
	end
							
	-- multiply auraDuration with the diminishing return coefficient
	local DRCoefficient = DRDB[dest][ccGroup]
	auraDuration = auraDuration * DRCoefficient
	DRDB[dest][ccGroup] = DRCoefficient / 2
	
	return auraDuration
end

-- applies an aura on units showing the duration their spell school is locked out
function auraDB:applySpellLockAura(destGUID, destName, spell, school, currentTime)

	local dest
	local lockOutDuration = spellDB.interrupt[spell]

	local schoolIcon = spellDB.spellSchoolIcon[school]
	
	if tyrPlates:IsPlayerOrPetGUID(destGUID) then
		dest = destName
	else
		dest = destGUID
	end
	
	-- add an artificial aura to the auraDB
	if not auraDB[dest] then auraDB[dest] = {} end
	auraDB[dest]["interrupt"] = {startTime = currentTime, duration = lockOutDuration, auraIcon = icon, auraType = "school", isOwn = false}	
end

-- removes an aura from the auraDB
function auraDB:RemoveAura(destGUID, destName, spellId, aura, currentTime)

	local dest
	local ccCategories

	-- set reference and CC category depending on wheter the target is a player or not
	if tyrPlates:IsPlayerOrPetGUID(destGUID) then
		dest = destName
		ccCategories = spellDB.ccCategories.PvP
	else
		dest = destGUID
		ccCategories = spellDB.ccCategories.PvE
		
		-- increase auraCounter for this unit
		if auraCounter[destName] then
			auraCounter[destName] = auraCounter[destName] - 1
		end
		--ace:print(auraCounter[destName])
	end

	-- check if the unit even has the removed aura in our DB
	if auraDB[dest] and auraDB[dest][aura] then

		-- if the aura influenced the cast speed, change it back
		if spellDB.castSpeedChange[aura] then
			castbarDB.castingSpeedDB[dest] = castbarDB.castingSpeedDB[dest] / spellDB.castSpeedChange[aura]
		end	

		-- delete all auras with the given name unless you track it and it's not your own 
		if not auraDB[dest][aura]["isOwn"] or (spellDB.trackAura.own[aura] or spellDB.trackAura.own[spellId]) then
			auraDB[dest][aura] = nil
			--ace:print("removed "..aura)
			
			-- check if the removed aura has a diminishing return
			if ccCategories[aura] then
				-- get CC group
				local ccGroup = ccCategories[aura]
				if ccGroup == "none" then
					ccGroup = "DR"..aura
				end
				
				-- start diminishing return timer for the CC group of the removed aura
				if DRDB[dest] and DRDB[dest][ccGroup] then
					DRDB[dest][ccGroup.."timer"] = currentTime
				end
			end
		end
	end
end

-- removes all auras on a unit after it's death
function auraDB:RemoveAllAuras(destGUID, destName)
	if tyrPlates:IsPlayerOrPetGUID(destGUID) then
		tyrPlates:ClearTable(auraDB[destName])
		if DRDB[destName] then
			tyrPlates:ClearTable(DRDB[destName])
		end
	elseif auraDB[destGUID] then
		for aura in pairs(auraDB[destGUID]) do
			auraDB[destGUID][aura] = nil
			auraCounter[destName] = auraCounter[destName] - 1
			--ace:print(auraCounter[destName])
			--ace:print("counter on "..destName.." is "..auraCounter[destName])
		end
		auraDB[destGUID] = nil
		
		if DRDB[destGUID] then
			tyrPlates:ClearTable(DRDB[destGUID])
		end
	end  
end

-- returns true if the given spell was cast by the player
function IsOwnCast(spell, currentTime)
	local player = UnitName("player")
	local offset = 0.2
	if castbarDB.castDB[player] and castbarDB.castDB[player]["cast"] == spell then
		local startTime = castbarDB.castDB[player]["startTime"]
		local castTime = castbarDB.castDB[player]["castTime"]
		local endTime = startTime + castTime
		return currentTime < endTime + offset and currentTime > endTime - offset
	end
	return false
end

-- finds the caster responsible for applying the seduction aura
function findSeductionCaster(currentTime)
	local seductionCastTime = 1.5
	local offset = 0.5
	for caster, spell in pairs(castbarDB.castDB) do
		if spell["cast"] == "Seduction" then
			local startTime = spell["startTime"]
			local endTime = startTime + seductionCastTime
			if currentTime < endTime + offset and currentTime > endTime - offset then
				return caster
			end
		end
	end
	return nil
end
