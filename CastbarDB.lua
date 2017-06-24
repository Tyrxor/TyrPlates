
tyrPlates.castbarDB = CreateFrame("Frame")

local castbarDB = tyrPlates.castbarDB
local spellDB = tyrPlates.spellDB

castbarDB.castDB = {}			--stores casts and channels with the caster as key
castbarDB.castingSpeedDB = {}	--stores current castspeed of players, is 1 by default
castbarDB.channelerDB = {}		--stores the source of a targeted channel with the target and spellName as key
castbarDB.specialAuras = {
	["Nature's Grace"] = 0.5,
	["Light's Grace"] = 0.5,
	["Arcane Blast"] = 0.3333,
}

local castDB = castbarDB.castDB
local castingSpeedDB = castbarDB.castingSpeedDB
local channelerDB = castbarDB.channelerDB

-- adds a cast or channel to the castDB
function castbarDB:addCast(srcGUID, srcName, srcFlags, spellId, spellSchool, currentTime)

	local source
	local isFriendly = tyrPlates:isFriendly(srcFlags)
	local spellName, _, spellIcon, _, _, _, castTime = GetSpellInfo(spellId)
	
	castTime = castTime/1000
	
	-- if caster is friendly, filter casts that are not in spellDB.friendlyCasts
	if tyrPlates.filterFriendlyCasts and isFriendly and not (spellDB.friendlyCasts[spellName] or spellDB.friendlyCasts[spellId]) then return end
	
	-- GetSpellInfo doesn't seem to return a castTime value for channeled spells, 
	-- therefore if it is a channel, set castTime to the duration stored in our spellDB
	if spellDB.channelDuration[spellName] then
		castTime = spellDB.channelDuration[spellName]
	end
	
	if tyrPlates:IsPlayerGUID(srcGUID) then	
		-- reduce cast time if the casted spell can be reduced by talents (e.g. fireball, shadowbolt)
		if spellDB.reducedCastTime[spellName] then
			castTime = castTime - spellDB.reducedCastTime[spellName]
		end
		source = srcName
	else
		source = srcGUID
	end
	--ace:print(castTime)
	if tyrPlates.auraDB.castReduce[srcName] then
		if tyrPlates.auraDB.castReduce[srcName]["Nature's Grace"] then
			castTime = castTime - 0.5
		elseif spellName == "Holy Light" and tyrPlates.auraDB.castReduce[srcName]["Light's Grace"] then
			castTime = castTime - 0.5
		elseif spellName == "Arcane Blast" and tyrPlates.auraDB.castReduce[srcName]["Arcane Blast"] then
			castTime = castTime - castbarDB.specialAuras["Arcane Blast"] * tyrPlates.auraDB.castReduce[srcName]["Arcane Blast"]
		end
	end

	-- change cast time depending on the casters casting speed
	if castingSpeedDB[source] then
		castTime = castTime * castingSpeedDB[source]
	end
	-- add cast
	castDB[source] = {cast = spellName, startTime = currentTime, castTime = castTime, icon = spellIcon, school = spellSchool, pushbackCounter = 0}
end

function castbarDB:resetCast(GUID, name)
	if tyrPlates:IsPlayerGUID(GUID) then
		castbarDB:resetPlayerCast(name)
	else
		castbarDB:resetNPCCast(GUID)
	end
end

function castbarDB:resetPlayerCast(name)
	if castbarDB.castDB[name] then castbarDB.castDB[name] = nil end
end

function castbarDB:resetNPCCast(GUID)
	if castbarDB.castDB[GUID] then castbarDB.castDB[GUID] = nil end
end

-- adds a channeler to the channelerDB
function castbarDB:addChanneler(srcGUID, srcName, destGUID, destName, spell)

	local dest
	if tyrPlates:IsPlayerGUID(destGUID) then
		dest = destName
	else
		dest = destGUID
	end
	
	if not channelerDB[dest] then
		channelerDB[dest] = {}
	end

	if not srcGUID or tyrPlates:IsPlayerGUID(srcGUID) then
		channelerDB[dest][spell] = srcName
	else
		channelerDB[dest][spell] = srcGUID
	end
end

-- tracks if a unit stops a cast by themselves (e.g. moving, press esc) and deletes this cast from the castDB
castStopTracker = CreateFrame("Frame")
castStopTracker:RegisterEvent("UNIT_SPELLCAST_STOP")
castStopTracker:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
castStopTracker:SetScript("OnEvent", function()
	local unit = arg1
	local unitName = UnitName(unit)
	castDB[unitName] = nil
end)

-- change cast time of a unit if he recieves a pushback
pushbackTracker = CreateFrame("Frame")
pushbackTracker:RegisterEvent("UNIT_SPELLCAST_DELAYED")
pushbackTracker:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE") -- triggers after channeled spell is pushed back
pushbackTracker:SetScript("OnEvent", function()

	local currentTime = GetTime()
	local unit = arg1
	local spell = arg2	
	local unitName = UnitName(unit)
	
	if not castDB[unitName] then return end
	
	local startTime = castDB[unitName]["startTime"]
	local pushback = 1 - castDB[unitName]["pushbackCounter"]*0.2 
	
	-- reduce cast time for channels
	-- increase cast time for casts
	if spellDB.channelDuration[spell] then
		castDB[unitName]["startTime"] = startTime - pushback
	else
		-- make sure the current cast progress isn't set under zero
		local castProgress = currentTime-startTime
		if pushback > castProgress then
			pushback = castProgress
		end
		castDB[unitName]["startTime"] = startTime + pushback
	end
	
	-- reduce the next pushback of this cast by 0.2s until it reaches the minimum pushback of 0.2s
	castDB[unitName]["pushbackCounter"] = castDB[unitName]["pushbackCounter"] + 1
	if castDB[unitName]["pushbackCounter"] > 4 then
		castDB[unitName]["pushbackCounter"] = 4
	end
end)

function castbarDB:resetPlayerCastSpeed(name)
	castbarDB.castingSpeedDB[name] = 1
end

function castbarDB:resetNPCCastSpeed(GUID)
	castbarDB.castingSpeedDB[GUID] = 1
end
