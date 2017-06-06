-- stores the current healthdifference (maxHP - currentHP) of npcs referenced by their name and difference
tyrPlates.healthDiffDB = {}
local healthDiffDB = tyrPlates.healthDiffDB

function tyrPlates:addDMG(destGUID, destName, damageTaken)

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
