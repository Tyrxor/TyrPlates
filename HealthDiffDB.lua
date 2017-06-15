-- stores the current healthdifference (maxHP - currentHP) of NPCs referenced by their name and difference
tyrPlates.healthDiffDB = {}
local healthDiffDB = tyrPlates.healthDiffDB

function tyrPlates:addDMG(destGUID, destName, damageTaken)
	--ace:print("did damage")
	if not healthDiffDB[destGUID] then
		healthDiffDB[destGUID] = 0
	end
	
	local oldHealthDiff = healthDiffDB[destGUID]
	local newHealthDiff = oldHealthDiff + damageTaken
		
	healthDiffDB[destGUID] = newHealthDiff
	healthDiffDB[oldHealthDiff..destName] = nil
	healthDiffDB[newHealthDiff..destName] = destGUID
	
end

function tyrPlates:addHeal(destGUID, destName, healingTaken)

	if not healthDiffDB[destGUID] then
		healthDiffDB[destGUID] = 0
	end

	local oldHealthDiff = healthDiffDB[destGUID]
	local newHealthDiff = oldHealthDiff - healingTaken
	
	-- ignore overheal
	if newHealthDiff < 0 then newHealthDiff = 0 end
		
	healthDiffDB[destGUID] = newHealthDiff
	healthDiffDB[oldHealthDiff..destName] = nil
	healthDiffDB[newHealthDiff..destName] = destGUID
	
end

tyrPlates.maxHPTracker = CreateFrame("Frame")
tyrPlates.maxHPTracker:RegisterEvent("UNIT_HEALTH")
tyrPlates.maxHPTracker:RegisterEvent("PLAYER_TARGET_CHANGED")
tyrPlates.maxHPTracker:SetScript("OnEvent", function()

	local unit = "target"
	if event == "UNIT_HEALTH" and arg1 == unit or event == "PLAYER_TARGET_CHANGED" then
		--ace:print("update")
		ace:print(UnitHealth(unit))
		local targetGUID = UnitGUID(unit)
		local targetName = UnitName(unit)
		local targetLevel = UnitLevel(unit)
		
		if not targetName or not targetGUID then return end --can happen, as reseting your target also trigger the "PLAYER_TARGET_CHANGED" event
		
		local targetHealthInPercent = UnitHealth(unit)		
		local hpDiff = healthDiffDB[targetGUID]
		local oldMax = TyrPlatesDB.maxHealth[targetName.."_"..targetLevel]
		
		if not hpDiff then return end
						
		--ace:print(hpDiff)
		--ace:print(targetHealthInPercent)
		
		local newMax = math.floor((hpDiff*100)/(100-targetHealthInPercent))
		if not oldMax then
			TyrPlatesDB.maxHealth[targetName.."_"..targetLevel] = newMax	
			--ace:print(newMax.."_1")	
			TyrPlatesDB.getHealthDB[targetName.."_"..targetLevel..":"..hpDiff] = targetHealthInPercent			
		elseif newMax < oldMax then
			TyrPlatesDB.maxHealth[targetName.."_"..targetLevel] = newMax
			--ace:print(newMax.."_2")	
			TyrPlatesDB.getHealthDB[targetName.."_"..targetLevel..":"..hpDiff] = targetHealthInPercent
		elseif newMax == oldMax then
			--ace:print("same")
		end
	end
end)


function MobHealth3:UNIT_HEALTH(event, unit)
	if currentAccHP and unit == "target" then
		MobHealth3:CalculateMaxHealth(UnitHealth("target"), UnitHealthMax("target"))
	end
end
