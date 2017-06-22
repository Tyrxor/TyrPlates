local Combatlog = CreateFrame("Frame")
local spellDB = tyrPlates.spellDB
local castbarDB = tyrPlates.castbarDB
local auraDB = tyrPlates.auraDB

tyrPlates.auraCounter = {}
local auraCounter = tyrPlates.auraCounter

Combatlog.eventTracker = CreateFrame("Frame")
Combatlog.eventTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Combatlog.eventTracker:SetScript("OnEvent", function(self, event, timestamp, combatlogEvent, ...)
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
	if Combatlog.relevantEvents[combatlogEvent] then
		Combatlog.relevantEvents[combatlogEvent](currentTime, ...)
	end
end)

function SWING_DAMAGE(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, amount)
	tyrPlates:addDMG(destGUID, destName, amount)
end

function RANGE_DAMAGE(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount)
	tyrPlates:addDMG(destGUID, destName, amount)
end

function SPELL_DAMAGE(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount)
	tyrPlates:addDMG(destGUID, destName, amount)
end

function SPELL_PERIODIC_DAMAGE(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount)
	tyrPlates:addDMG(destGUID, destName, amount)
end

function SPELL_HEAL(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount)
	tyrPlates:addHeal(destGUID, destName, amount)
end

function SPELL_PERIODIC_HEAL(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount)
	tyrPlates:addHeal(destGUID, destName, amount)
end

-- triggers if a unit starts casting
--> add cast to castDB
function SPELL_CAST_START(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool)
	castbarDB:addCast(srcGUID, srcName, srcFlags, spellId, spellSchool, currentTime)
end

-- triggers if a unit in your group interrupts a cast by himself (e.g. moving, pressing ESC)
--> stop unit's current cast
function SPELL_CAST_FAILED(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, failedType)
	castbarDB:StopCast(srcGUID, srcName)
end

-- triggers from instant spells and channels
--> try to add spell as aura or channel, stop unit's current cast
function SPELL_CAST_SUCCESS(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool)
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
end

-- triggers if a unit's cast was interrupted by an enemy (e.g. kick, counter spell)
--> add a spell lock aura to the unit and stop any current casts of the interrupter
function SPELL_INTERRUPT(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, interruptedSpellID, interruptedSpellName, interruptedSpellSchool)
	auraDB:applySpellLockAura(destGUID, destName, spellName, interruptedSpellSchool, currentTime)
	castbarDB:StopCast(destGUID, destName)
end

-- triggers if a aura is applied
--> adds the aura to the auraDB and interrupts the target if the aura causes a "lose control" effect
function SPELL_AURA_APPLIED(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, auraType)
	auraDB:AddAura(srcGUID, destGUID, destName, destFlags, spellId, currentTime)
	
	if spellDB.interruptsCast[spellName] then
		castbarDB:StopCast(destGUID, destName)
	end
	
	-- if npc, increase auraCounter for this unit
	if destIsNPC then
		if not auraCounter[destName] then auraCounter[destName] = 0 end
		auraCounter[destName] = auraCounter[destName] + 1
	end
	
	--check if sapped
	if spellName == "Sap" and tyrPlates:IsOwnGUID(destGUID) then
		if srcName then
			SendChatMessage("Sapped by "..srcName);
		else
			SendChatMessage("Sapped");
		end
	end
end

function SPELL_AURA_REMOVED(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, auraType)
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
end
-- gaining stacks
function SPELL_AURA_APPLIED_DOSE(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, auraType, amount)
	auraDB:AddStacks(destGUID, spellName, amount)
end

-- losing stacks
function SPELL_AURA_REMOVED_DOSE(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, auraType, amount)
	auraDB:RemoveStacks(destGUID, spellName, amount)
end

-- spell miss
function DAMAGE_SHIELD_MISSED(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, missType)
	castbarDB:StopCast(srcGUID, srcName)
end

function UNIT_DIED(currentTime, srcGUID, srcName, srcFlags, destGUID, destName, destFlags)
	castbarDB:StopCast(destGUID, destName)
	auraDB:RemoveAllAuras(destGUID, destName)
	if tyrPlates.healthDiffDB[destGUID] then
		local oldAmount = tyrPlates.healthDiffDB[destGUID]
		tyrPlates.healthDiffDB[oldAmount..destName] = nil
		return
	end
end

Combatlog.relevantEvents = {
	["SWING_DAMAGE"] = SWING_DAMAGE,
	["RANGE_DAMAGE"] = RANGE_DAMAGE,
	["SPELL_DAMAGE"] = SPELL_DAMAGE,
	["SPELL_PERIODIC_DAMAGE"] = SPELL_PERIODIC_DAMAGE,
	["SPELL_HEAL"] = SPELL_HEAL,
	["SPELL_PERIODIC_HEAL"] = SPELL_PERIODIC_HEAL,
	["SPELL_CAST_START"] = SPELL_CAST_START,
	["SPELL_CAST_FAILED"] = SPELL_CAST_FAILED,
	["SPELL_CAST_SUCCESS"] = SPELL_CAST_SUCCESS,
	["SPELL_INTERRUPT"] = SPELL_INTERRUPT,
	["SPELL_AURA_APPLIED"] = SPELL_AURA_APPLIED,
	["SPELL_AURA_REMOVED"] = SPELL_AURA_REMOVED,
	["SPELL_AURA_APPLIED_DOSE"] = SPELL_AURA_APPLIED_DOSE,
	["SPELL_AURA_REMOVED_DOSE"] = SPELL_AURA_REMOVED_DOSE,
	["DAMAGE_SHIELD_MISSED"] = DAMAGE_SHIELD_MISSED,
	["UNIT_DIED"] = UNIT_DIED,
}