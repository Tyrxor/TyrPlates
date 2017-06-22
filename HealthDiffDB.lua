-- stores the current healthdifference (maxHP - currentHP) of NPCs referenced by their name and difference
tyrPlates.healthDiffDB = {}
local healthDiffDB = tyrPlates.healthDiffDB

function tyrPlates:addDMG(destGUID, destName, damage)
	if tyrPlates:IsPlayerOrPetGUID(destGUID) then return end
	local oldHealthDiff = getHealthDiff(destGUID)
	local newHealthDiff = oldHealthDiff + damage
	setHealthDiff(destGUID, destName, oldHealthDiff, newHealthDiff)
end

function tyrPlates:addHeal(destGUID, destName, healing)

	if tyrPlates:IsPlayerOrPetGUID(destGUID) then return end

	local oldHealthDiff = getHealthDiff(destGUID)
	local newHealthDiff = oldHealthDiff - healing
	if newHealthDiff < 0 then newHealthDiff = 0 end -- ignore overheal		
	setHealthDiff(destGUID, destName, oldHealthDiff, newHealthDiff)
end

function getHealthDiff(destGUID)
	if not healthDiffDB[destGUID] then
		healthDiffDB[destGUID] = 0
	end
	return healthDiffDB[destGUID]
end

function setHealthDiff(destGUID, destName, oldHealthDiff, newHealthDiff)
	healthDiffDB[destGUID] = newHealthDiff
	healthDiffDB[oldHealthDiff..destName] = nil
	healthDiffDB[newHealthDiff..destName] = destGUID
end