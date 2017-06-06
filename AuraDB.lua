tyrPlates.auraDB = {}
tyrPlates.auraCounter = {}

local auraDB = tyrPlates.auraDB
local auraCounter = tyrPlates.auraCounter
local castbarDB = tyrPlates.castbarDB
local spellDB = tyrPlates.spellDB

auraDB.DRDB = {}

--applys auras to players and npcs
function auraDB:ApplyAura(srcGUID, destGUID, destName, spellId)

	--tritt ein falls man was castet was einen selbst als Ziel hat (cloak of shadows)
	if not destName then return end

	local aura, _, AuraIcon = GetSpellInfo(spellId)
	local currentTime = GetTime()
	
	--check if aura has to be shown/applied
	if spellDB.auraFilter[aura] or (spellDB.ownAuraFilter[aura] and (tyrPlates:IsOwnGUID(srcGUID) or IsOwnCast(aura))) then
		
		local duration
		local seductionCaster
		local crowdControlDB
		local dest
	
		--check seduction
		if aura == "Seduction" then
			seductionCaster = findSeductionCaster(currentTime)
			if seductionCaster then
				castbarDB:addChanneler(seductionCaster, seductionCaster, destGUID, destName, aura)
			end
		end
				
		local auraType = spellDB.ownAuraFilter[aura] or spellDB.auraFilter[aura] 
		
		--check if aura has a known auraType, if not it is set to none
		if auraType == true then 
			ace:print("auraType is missing for "..aura)
			auraType = "none"
		end
		
		if tyrPlates:IsPlayerOrPetGUID(destGUID) then
			dest = destName
			crowdControlDB = spellDB.CC
			duration = spellDB.auraInfoPvP[spellId] or spellDB.auraInfo[spellId]			
		else
			dest = destGUID
			crowdControlDB = spellDB.PvECC
			duration = spellDB.auraInfo[spellId]
			if not auraCounter[destName] then auraCounter[destName] = 0 end
			auraCounter[destName] = auraCounter[destName] + 1
		end
		
		if not duration then
			ace:print(aura .. " has unknown spellId " .. spellId)
			duration = 0
		end
		
		if spellDB.castSpeedChange[aura] then
			if not castbarDB.castingSpeedDB[dest] then castbarDB.castingSpeedDB[dest] = 1 end
			castbarDB.castingSpeedDB[dest] = castbarDB.castingSpeedDB[dest] * spellDB.castSpeedChange[aura]
		end	

		duration = checkDR(crowdControlDB, aura, dest, currentTime, duration)
			
		if not auraDB[destName] then auraDB[destName] = {} end			
		auraDB[destName][aura] = {startTime = GetTime(), duration = duration, icon = AuraIcon, auratype = auraType}
		
		--seduction
		if seductionCaster then
			castbarDB.castDB[seductionCaster] = {cast = aura, startTime = currentTime, castTime = duration, icon = AuraIcon, school = 32, pushbackCounter = 0}
		end	
	end
end

function checkDR(crowdControlDB, aura, dest, currentTime, duration)
	if crowdControlDB[aura] then
		if not auraDB.DRDB[dest] then
			auraDB.DRDB[dest] = {}
		end
				
		auraDB.DRDB[dest..aura] = currentTime
							
		local group = crowdControlDB[aura]
		if group == "none" then
			group = "DR"..aura
		end
					
		if not auraDB.DRDB[dest][group.."timer"] then 
			auraDB.DRDB[dest][group.."timer"] = currentTime
		end
					
		if not auraDB.DRDB[dest][group] then
			auraDB.DRDB[dest][group] = 2
		end
						
		if (currentTime - auraDB.DRDB[dest][group.."timer"]) > 15 then
			auraDB.DRDB[dest][group.."timer"] = currentTime
			auraDB.DRDB[dest][group] = 2
		end
							
		local DRCounter = auraDB.DRDB[dest][group]
		ace:print(DRCounter)
		if DRCounter == 1 then
			duration = duration*0.5		
		elseif DRCounter == 0 then
			duration = duration*0.25	
		end
		auraDB.DRDB[dest][group] = auraDB.DRDB[dest][group] - 1
	end
	return duration
end

function auraDB:applyInterruptAura(destGUID, destName, spell, school)

	local icon = nil
	local duration = spellDB.interrupt[spell]
	if school == 1 then 
		return
	else
		icon = spellDB.spellSchoolIcon[school]
	end
	if tyrPlates:IsPlayerOrPetGUID(destGUID) then
		if not auraDB[destName] then auraDB[destName] = {} end
		auraDB[destName]["interrupt"] = {startTime = GetTime(), duration = duration, auraIcon = icon, auraType = "school"}
	else
		if not auraDB[destGUID] then auraDB[destGUID] = {} end
		auraDB[destGUID]["interrupt"] = {startTime = GetTime(), duration = duration, auraIcon = icon, auraType = "school"}
	end
end

function auraDB:RemoveAura(destGUID, destName, spellId, aura)

	if tyrPlates:IsPlayerOrPetGUID(destGUID) then
		dest = destName
		crowdControlDB = spellDB.CC
	else
		dest = destGUID
		crowdControlDB = spellDB.PvECC
		auraDB[dest][aura] = nil
		auraCounter[destName] = auraCounter[destName] - 1
	end

	if auraDB[dest] and auraDB[dest][aura] then
	
		if spellDB.castSpeedChange[aura] then
			castbarDB.castingSpeedDB[dest] = castbarDB.castingSpeedDB[dest] / spellDB.castSpeedChange[aura]
		end	

		if tyrPlates_config["pvp"] or not spellDB.ownAuraFilter[aura] or IsOwnAura(aura, destName, destGUID) then
			auraDB[dest][aura] = nil
			
			if crowdControlDB[aura] then
				local group = crowdControlDB[aura]
				if group == "none" then
					group = "DR"..aura
				end

				if auraDB.DRDB[dest] and auraDB.DRDB[dest][group] then
					auraDB.DRDB[dest][group.."timer"] = GetTime()
				end
			end
		end
	end
end

function auraDB:RemoveAllAuras(destGUID, destName)
	if auraDB[destName] and tyrPlates:IsPlayerOrPetGUID(destGUID) then
		for aura in pairs(auraDB[destName]) do
			auraDB[destName][aura] = nil		
		end
		auraDB[destName] = nil
		auraDB.DRDB[destName] = nil
	elseif auraDB[destGUID] then
		for aura in pairs(auraDB[destGUID]) do
			auraDB[destGUID][aura] = nil
			auraCounter[destName] = auraCounter[destName] - 1
			--ace:print("counter on "..destName.." is "..auraCounter[destName])
		end
		auraDB[destGUID] = nil
	end  
end

function IsOwnAura(aura, destName, destGUID)
	local offset = 0.2
	local currentTime = GetTime()
	if auraDB[destName] and auraDB[destName][aura] then
		local startTime = auraDB[destName][aura]["startTime"]
		local duration = auraDB[destName][aura]["duration"]
		local endTime = startTime + duration
		return currentTime < endTime + offset and currentTime > endTime - offset
	end
	if auraDB[destGUID] and auraDB[destGUID][aura] then
		local startTime = auraDB[destGUID][aura]["startTime"]
		local duration = auraDB[destGUID][aura]["duration"]
		local endTime = startTime + duration
		return currentTime < endTime + offset and currentTime > endTime - offset
	end
	return false
end

function IsOwnCast(spell)
	local currentTime = GetTime()
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

function findSeductionCaster(currentTime)
	local seductioncastTime = 1.5
	local offset = 0.5
	for caster, spell in pairs(castbarDB.castDB) do
		if spell["cast"] == "Seduction" then
			local startTime = spell["startTime"]
			local endTime = startTime + seductioncastTime
			if currentTime < endTime + offset and currentTime > endTime - offset then
				return caster
			end
		end
	end
	return nil
end
