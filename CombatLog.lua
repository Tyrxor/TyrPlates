
tyrPlates.combatlog = CreateFrame("Frame")
local combatlog = tyrPlates.combatlog
local spellDB = tyrPlates.spellDB
local castbarDB = tyrPlates.castbarDB
local auraDB = tyrPlates.auraDB

combatlog:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
combatlog:SetScript("OnEvent", function()
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
	--ace:print("")

	-- the combatlog event
	local event = arg2
	
	-- source of the event
	local srcGUID = arg3
	local srcName = arg4
	
	-- destination of the event 
	local destGUID = arg6
	local destName = arg7
	
	-- information about the spell that caused the event
	local spellId = arg9
	local spellName = arg10
	local spellSchool = arg11
   
   	-- track damage events only for non players
	if not tyrPlates:IsPlayerOrPetGUID(destGUID) then
		if event == "SWING_DAMAGE" then
			local amount = arg9
			tyrPlates:addDMG(destGUID, destName, amount)
			return
		end	
		
		local amount = arg12
		if event == "RANGE_DAMAGE" then
			tyrPlates:addDMG(destGUID, destName, amount)
			return
		end	
		
		if event == "SPELL_DAMAGE" then
			tyrPlates:addDMG(destGUID, destName, amount)
			return
		end	
		
		if event == "SPELL_PERIODIC_DAMAGE" then
			tyrPlates:addDMG(destGUID, destName, amount)
			return
		end	
		
		if event == "SPELL_HEAL" then
			tyrPlates:addHeal(destGUID, destName, amount)
			return
		end	
	end
   
    if event == "SPELL_CAST_START" then
		castbarDB:addCast(srcGUID, srcName, spellId, spellSchool)
		return
    end
	
	-- also includes spells without castTime
	if event == "SPELL_CAST_SUCCESS" then
		auraDB:ApplyAura(srcGUID, destGUID, destName, spellId)
		castbarDB:StopCast(srcGUID, srcName)
		if spellDB.channelDuration[spellName] then
			castbarDB:addCast(srcGUID, srcName, spellId, spellSchool)
		end
		if spellDB.channelWithTarget[spellName] then
			castbarDB:addChanneler(srcGUID, srcName, destGUID, destName, spellName)
		end
		return
    end
	
	-- only triggers if the source is in your party
	if event == "SPELL_CAST_FAILED" then
		castbarDB:StopCast(srcGUID, srcName)
		return
    end
	
	if event == "SPELL_MISSED" then
		castbarDB:StopCast(srcGUID, srcName)
	end
	
	
	if event == "SPELL_INTERRUPT" then
		local spellSchool = arg14
		auraDB:applyInterruptAura(destGUID, destName, spellName, spellSchool)
		castbarDB:StopCast(destGUID, destName)
		return
    end
	
	if event == "SPELL_AURA_APPLIED" then
		auraDB:ApplyAura(srcGUID, destGUID, destName, spellId)
		if spellDB.InterruptsCast[spellName] then
			castbarDB:StopCast(destGUID, destName)
		end
	  
	  --check if sapped
		if spellName == "Sap" and tyrPlates:IsOwnGUID(destGUID) then
			if srcName then
				SendChatMessage("Sapped by "..srcName);
			else
				SendChatMessage("Sapped");
			end
		end
		return
    end

	if event == "SPELL_AURA_APPLIED_DOSE" then
		auraDB:ApplyAura(srcGUID, destGUID, destName, spellId)
		return
    end
	
	if event == "SPELL_AURA_REFRESH" then
		auraDB:ApplyAura(srcGUID, destGUID, destName, spellId)
		if tyrPlates.auraCounter[destName] then
			tyrPlates.auraCounter[destName] = tyrPlates.auraCounter[destName] - 1
			--ace:print("counter on "..destName.." is "..tyrPlates.auraCounter[destName])
		end
		return
    end
	
	if event == "SPELL_AURA_REMOVED" then
		auraDB:RemoveAura(destGUID, destName, spellId, spellName)
		--for interrupted channeled spells?

		-- if the aura was created by a channeled spell(e.g. mind flay), interrupt the cast of the channeler
		if spellDB.channelDuration[spellName] or spellDB.channelWithTarget[spellName]then
			if not spellDB.channelWithTarget[spellName] then
				castbarDB.castDB[destGUID] = nil
				castbarDB.castDB[destGUID] = nil
			else
				if castbarDB.channelerDB[destGUID] and castbarDB.channelerDB[destGUID][spellName] then
					castbarDB.castDB[castbarDB.channelerDB[destGUID][spellName]] = nil
				elseif castbarDB.channelerDB[destName] and castbarDB.channelerDB[destName][spellName] then
					castbarDB.castDB[castbarDB.channelerDB[destName][spellName]] = nil
				end
			end
		end	  
		return
    end
	
	-- spell miss
	if event == "DAMAGE_SHIELD_MISSED" then
		castbarDB:StopCast(srcGUID, srcName)
	end
	
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
