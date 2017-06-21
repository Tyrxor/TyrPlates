
tyrPlates.combatlog = CreateFrame("Frame")
tyrPlates.auraCounter = {}
local combatlog = tyrPlates.combatlog
local spellDB = tyrPlates.spellDB
local castbarDB = tyrPlates.castbarDB
local auraDB = tyrPlates.auraDB
local auraCounter = tyrPlates.auraCounter

local relevantEvents = {
	["SPELL_CAST_START"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_CAST_FAILED"] = true,
	["SPELL_INTERRUPT"] = true,
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_APPLIED_DOSE"] = true,
	--["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_REMOVED"] = true,
	["DAMAGE_SHIELD_MISSED"] = true,
	["UNIT_DIED"] = true,
}

relevantEvents.damage = {
	["SWING_DAMAGE"] = true,
	["RANGE_DAMAGE"] = true,
	["SPELL_DAMAGE"] = true,
	["SPELL_PERIODIC_DAMAGE"] = true,
}

relevantEvents.healing = {
	["SPELL_HEAL"] = true,
	["SPELL_PERIODIC_HEAL"] = true,
}

-- combatlog tracker
-- tracks casts, auras and deaths
combatlog:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
combatlog:SetScript("OnEvent", function(self, _, ...)
	--ace:print(arg1)		--timestamp
		--ace:print(arg2)	--event
		--ace:print(arg3)	--srcGUID
		--ace:print(arg4)	--srcName
	--ace:print(arg5)		--srcFlags
		--ace:print(arg6)	--destGUID
	    --ace:print(arg7)	--destName
	--ace:print(arg8)		--destFlags
	--ace:print(arg9)		--spellId
		--ace:print(arg10)	--spellName
	--ace:print(arg11)		--spellschool
	--ace:print(arg12)
	--ace:print(arg13)
	--ace:print(arg14)
	--ace:print(arg15)
	--ace:print("---")
	
	local currentTime = GetTime()
	local timestamp, event, srcGUID, srcName, srcFlags, destGUID, destName, destFlags  = ...
	local destIsNPC = tyrPlates:IsNPCGUID(destGUID)
	
	if not isRelevantEvent(event) then return end
	
	-- if target is NPC, save it's dmg and healing taken
	if destIsNPC then
		if isDMGEvent(event) then
			local amountOfDamage
			if event == "SWING_DAMAGE" then
				amountOfDamage = arg9
			else
				amountOfDamage = arg12
			end
			tyrPlates:addDMG(destGUID, destName, amountOfDamage)
			return
		elseif isHealEvent(event) then
			local amountOfHealing = arg12
			tyrPlates:addHeal(destGUID, destName, amountOfHealing)
			return
		end
	end
		
	-- information about the spell that caused the event
	local spellId = arg9
	local spellName = arg10
	local spellSchool = arg11

   
	-- triggers if a unit starts casting
	--> add cast to castDB
    if event == "SPELL_CAST_START" then
		castbarDB:addCast(srcGUID, srcName, srcFlags, spellId, spellSchool, currentTime)
		return
    end
	
	-- triggers from instant spells and channels
	--> try to add spell as aura or channel, stop unit's current cast
	if event == "SPELL_CAST_SUCCESS" then
		auraDB:AddAura(srcGUID, destGUID, destName, destFlags, spellId, currentTime)
		castbarDB:StopCast(srcGUID, srcName)
		-- if spell is a channel, add it as cast
		if spellDB.channelDuration[spellName] then
			castbarDB:addCast(srcGUID, srcName, srcFlags, spellId, spellSchool, currentTime)
		end
		-- if channel has a target (e.g. mindflay, drain soul) add it's caster to the channelerDB
		if spellDB.channelWithTarget[spellName] then
			castbarDB:addChanneler(srcGUID, srcName, destGUID, destName, spellName)
		end
		return
    end
	
	-- triggers if a unit in your group interrupts a cast by himself (e.g. moving, pressing ESC)
	--> stop unit's current cast
	if event == "SPELL_CAST_FAILED" then
		castbarDB:StopCast(srcGUID, srcName)
		return
    end
	
	-- triggers if a unit's cast was interrupted by an enemy (e.g. kick, counter spell)
	--> add a spell lock aura to the unit and stop any current casts of the interrupter
	if event == "SPELL_INTERRUPT" then
		local spellSchool = arg14
		auraDB:applySpellLockAura(destGUID, destName, spellName, spellSchool, currentTime)
		castbarDB:StopCast(destGUID, destName)
		return
    end
	
	-- triggers if a aura is applied
	--> adds the aura to the auraDB and interrupts the target if the aura causes a "lose control" effect
	if event == "SPELL_AURA_APPLIED" then
		auraDB:AddAura(srcGUID, destGUID, destName, destFlags, spellId, currentTime)
		if spellDB.interruptsCast[spellName] then
			castbarDB:StopCast(destGUID, destName)
		end
	
		-- if npc, increase auraCounter for this unit
		if destIsNPC then
			if not auraCounter[destName] then auraCounter[destName] = 0 end
			auraCounter[destName] = auraCounter[destName] + 1
		end
		
	  --[[
	  --check if sapped
		if spellName == "Sap" and tyrPlates:IsOwnGUID(destGUID) then
			if srcName then
				SendChatMessage("Sapped by "..srcName);
			else
				SendChatMessage("Sapped");
			end
		end
		]]
		return
    end

	if event == "SPELL_AURA_APPLIED_DOSE" then
		auraDB:AddStack(destGUID, spellName)
		if castbarDB.specialAuras[spellName] then
			tyrPlates.auraDB.castReduce[destName][spellName] = tyrPlates.auraDB.castReduce[destName][spellName] + 1
		end
		return
    end
	--[[
	if event == "SPELL_AURA_REFRESH" then
		auraDB:RefreshAura(srcGUID, destGUID, destName, destFlags, spellId, currentTime)
		return
    end
	]]
	
	-- triggers if a aura is removed
	--> remove aura from the auraDB
	if event == "SPELL_AURA_REMOVED" then
		auraDB:RemoveAura(destGUID, destName, spellId, spellName, currentTime)

		-- if the aura was created by a channeled spell(e.g. mind flay, drain soul), interrupt the cast of the channeler
		if spellDB.channelDuration[spellName] or spellDB.channelWithTarget[spellName]then
			if not spellDB.channelWithTarget[spellName] then
				castbarDB.castDB[destName] = nil
				castbarDB.castDB[destGUID] = nil
			else
				-- check who was the caster of the aura, delete his cast from the castDB and delete his entry from channelerDB
				if castbarDB.channelerDB[destGUID] and castbarDB.channelerDB[destGUID][spellName] then
					castbarDB.castDB[castbarDB.channelerDB[destGUID][spellName]] = nil
					castbarDB.channelerDB[destGUID][spellName] = nil
				elseif castbarDB.channelerDB[destName] and castbarDB.channelerDB[destName][spellName] then
					castbarDB.castDB[castbarDB.channelerDB[destName][spellName]] = nil
					castbarDB.channelerDB[destName][spellName] = nil
				end
			end
		end	 

		-- if npc, decrease auraCounter for this unit
		if destIsNPC then
			if not auraCounter[destName] then 
				auraCounter[destName] = 0
			else
				auraCounter[destName] = auraCounter[destName] - 1
			end
		end
		return
    end
	
	-- spell miss! was tested multiple times
	if event == "DAMAGE_SHIELD_MISSED" then
		castbarDB:StopCast(srcGUID, srcName)
	end
	
	-- triggers if a unit died
	--> delete the unit's cast, auras and entry in the healthDiffDB
	if event == "UNIT_DIED" then
		castbarDB:StopCast(destGUID, destName)
		auraDB:RemoveAllAuras(destGUID, destName)
		if tyrPlates.healthDiffDB[destGUID] then
			local oldAmount = tyrPlates.healthDiffDB[destGUID]
			tyrPlates.healthDiffDB[oldAmount..destName] = nil
			return
		end
    end
end)

function isDMGEvent(event)
	return relevantEvents.damage[event]
end

function isHealEvent(event)
	return relevantEvents.healing[event]
end

function isRelevantEvent(event)
	return relevantEvents[event]
end
