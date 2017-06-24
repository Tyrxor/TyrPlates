-- stores the current healthdifference (maxHP - currentHP) of NPCs referenced by their name and difference
tyrPlates.healthDiffDB = {}
local healthDiffDB = tyrPlates.healthDiffDB

function tyrPlates:addDMG(GUID, name, damage)
	if tyrPlates:IsPlayerOrPetGUID(GUID) then return end
	local oldHealthDiff = getHealthDiff(GUID)
	local newHealthDiff = oldHealthDiff + damage
	setHealthDiff(GUID, name, oldHealthDiff, newHealthDiff)
end

function tyrPlates:addHeal(GUID, name, healing)

	if tyrPlates:IsPlayerOrPetGUID(GUID) then return end

	local oldHealthDiff = getHealthDiff(GUID)
	local newHealthDiff = oldHealthDiff - healing
	if newHealthDiff < 0 then newHealthDiff = 0 end -- ignore overheal		
	setHealthDiff(GUID, name, oldHealthDiff, newHealthDiff)
end

function getHealthDiff(GUID)
	if not healthDiffDB[GUID] then
		healthDiffDB[GUID] = 0
	end
	return healthDiffDB[GUID]
end

function setHealthDiff(GUID, name, oldHealthDiff, newHealthDiff)
	healthDiffDB[GUID] = newHealthDiff
	healthDiffDB[oldHealthDiff..name] = nil
	healthDiffDB[newHealthDiff..name] = GUID
end

function tyrPlates:resetHealthDiff(GUID, name)
	if tyrPlates.healthDiffDB[GUID] then
		local oldAmount = tyrPlates.healthDiffDB[GUID]
		tyrPlates.healthDiffDB[oldAmount..name] = nil
		tyrPlates.healthDiffDB[GUID] = nil
	end
end