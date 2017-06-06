
tyrPlates.castbarDB = CreateFrame("Frame")

local castbarDB = tyrPlates.castbarDB
local spellDB = tyrPlates.spellDB

castbarDB.castDB = {}			--stores casts and channels with the caster as key
castbarDB.castingSpeedDB = {}	--stores current castspeed of players, is 1 by default
castbarDB.channelerDB = {}		--stores the source of a targeted channel with the target and spellName as key

local castDB = castbarDB.castDB
local castingSpeedDB = castbarDB.castingSpeedDB
local channelerDB = castbarDB.channelerDB

-- adds a cast or channel to the castDB
function castbarDB:addCast(srcGUID, srcName, spellId, spellSchool)
	local spellName, _, spellIcon, _, _, _, castTime = GetSpellInfo(spellId)
	
	-- if the caster is a player, save cast by name otherwise save cast by GUID
	if tyrPlates:IsPlayerOrPetGUID(srcGUID) then
	
		-- GetSpellInfo doesn't seem to return a castTime value for channeled spells, 
		-- therefore if it is a channel, set castTime to the duration stored in our spellDB
		if spellDB.channelDuration[spellName] then
			castTime = spellDB.channelDuration[spellName]*1000
		end

		-- reduce cast time if the casted spell can be reduced by talents (e.g. fireball, shadowbolt)
		if spellDB.reducedCastTime[spellName] then
			castTime = castTime - spellDB.reducedCastTime[spellName]*1000
		end
	
		-- change cast time depending on the casters casting speed
		if castingSpeedDB[srcName] then
			castTime = castTime * castingSpeedDB[srcName]
		end
		
		castDB[srcName] = {cast = spellName, startTime = GetTime(), castTime = castTime/1000, icon = spellIcon, school = spellSchool, pushbackCounter = 0}
	else
		castDB[srcGUID] = {cast = spellName, startTime = GetTime(), castTime = castTime/1000, icon = spellIcon, school = spellSchool, pushbackCounter = 0}
	end
end

-- stop a cast or channel by deleting it from the castDB
function castbarDB:StopCast(srcGUID, srcName)
  if tyrPlates:IsPlayerOrPetGUID(srcGUID) and castDB[srcName] then
    castDB[srcName] = nil
  elseif castDB[srcGUID] then
    castDB[srcGUID] = nil
  end
end

-- adds a channeler to the channelerDB
function castbarDB:addChanneler(srcGUID, srcName, destGUID, destName, spell)
	
	local dest
	if tyrPlates:IsPlayerOrPetGUID(destGUID) then
		dest = destName
	else
		dest = destGUID
	end
	
	if not channelerDB[dest] then
		channelerDB[dest] = {}
	end
	if srcGUID and tyrPlates:IsPlayerOrPetGUID(srcGUID) then
		channelerDB[dest][spell] = srcName
	else
		channelerDB[dest][spell] = srcGUID
	end
end


-- change cast time of a unit if he recieves a pushback
pushbackTracker = CreateFrame("Frame")
pushbackTracker:RegisterEvent("UNIT_SPELLCAST_DELAYED")
pushbackTracker:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE") -- triggers after channeled spell is pushed back
pushbackTracker:SetScript("OnEvent", function()

	local unit = arg1
	local spell = arg2
	
	local currentTime = GetTime()
	local unitName = UnitName(unit)
	
	if not castDB[unitName] then return end
	
	local startTime = castDB[unitName]["startTime"]
	local castingTime = currentTime-startTime
	local pushback = 1 - castDB[unitName]["pushbackCounter"]*0.2 
	
	-- make sure the base cast time isn't overtaken
	if pushback > castingTime then
		pushback = castingTime
	end
	
	-- reduce cast time for channels
	-- increase cast time for casts
	if spellDB.channelDuration[spell] then
		castDB[unitName]["startTime"] = startTime - pushback
	else
		castDB[unitName]["startTime"] = startTime + pushback
	end
	
	-- reduce the next pushback of this cast by 0.2s until it reaches the minimum pushback of 0.2s
	castDB[unitName]["pushbackCounter"] = castDB[unitName]["pushbackCounter"] + 1
	if castDB[unitName]["pushbackCounter"] > 4 then
		castDB[unitName]["pushbackCounter"] = 4
	end
end)

-- tracks if a unit stops a cast by themselves (e.g. moving, press esc) and deletes this cast from the castDB
castStopTracker = CreateFrame("Frame")
castStopTracker:RegisterEvent("UNIT_SPELLCAST_STOP")
castStopTracker:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
castStopTracker:SetScript("OnEvent", function()
	local unit = arg1
	local unitName = UnitName(unit)
	castDB[unitName] = nil
end)
