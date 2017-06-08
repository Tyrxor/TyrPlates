
local nameplate = tyrPlates.nameplate
local castbarDB = tyrPlates.castbarDB
local auraDB = tyrPlates.auraDB
local spellDB = tyrPlates.spellDB

--hide Playererrors (not LUA)
-- UIErrorsFrame:Hide()

function ConvertToNormalPlate(frame)
	local healthbar = frame:GetChildren()
	local healthbarBorder, _, _, glow, nameRegion = frame:GetRegions()
	
	healthbar:SetAlpha(1)
	healthbarBorder:Show()
	glow:Show()
	nameRegion:Show()
	frame.icon:SetTexture(0,0,0,0)
end

-- Update Nameplate
function nameplate:UpdateNameplate()
	if not this.setup then nameplate:CreateNameplate() return end
	 
	local healthbar, castbar = this:GetChildren()
	local _, _, _, _, nameRegion, level = this:GetRegions()
	local unitName = nameRegion:GetText()
	level:Hide()
  
	if IsTarget(this) then
		local unit = "target"
		local targetName = UnitName(unit)
		local targetGUID = UnitGUID(unit)


		-- update auras and casts
		if tyrPlates:IsPlayerOrPetGUID(targetGUID) then
			UpdateAuras(targetName, unit)
			UpdateCast(targetName, unit)
		else
			UpdateAuras(targetGUID, unit)
			UpdateCast(targetGUID, unit)
		end
	  
		if not tyrPlates:IsPlayerOrPetGUID(targetGUID) then
			nameplate.nameplateByGUID[this] = targetGUID
		end
		healthbar.targetBorder:Show()
		healthbar:SetPoint("TOP", this, "TOP", 0, 7)
		
		local spell = UnitCastingInfo("target") or UnitChannelInfo("target")
		castbar.spellNameRegion:SetText(spell)
	else
		this:SetAlpha(0.99)
		healthbar.targetBorder:Hide()
		healthbar:SetPoint("TOP", this, "TOP", 0, 5)
	end
  
	if MouseIsOver(this, 0, 0, 0, 0) then
		local mouseoverGUID = UnitGUID("mouseover")
		if mouseoverGUID and not tyrPlates:IsPlayerOrPetGUID(mouseoverGUID) then
			nameplate.nameplateByGUID[this] = mouseoverGUID
		end
	end
  
	if spellDB.TotemIdByName[unitName] then
		ConvertToTotemPlate(this)
	else
		ConvertToNormalPlate(this)
		UpdateHealthbarColor(this, nameRegion, healthbar)
		UpdateCastbar(this, nameRegion, healthbar)
		UpdateDebuffs(this, nameRegion, healthbar)
		UpdateHealth(healthbar) 
	end  
end


function UpdateDebuffsIdentifier(frame, healthbar, Identifier, currentTime)

	if auraDB[Identifier] then
		local currentTime = GetTime()
		local j, k = 1, 1
		local num = tableLength(auraDB[Identifier], frame.isFriendlyPlayer)
		for Aura in pairs(auraDB[Identifier]) do
			--don't show aura if plate is friendly and the aura not in friendlyFilter
			if not frame.isFriendlyPlayer or spellDB.friendlyFilter[Aura] then
				frame.auras[j]:SetTexture(auraDB[Identifier][Aura]["icon"])
				frame.auras[j]:SetAlpha(1)
				if j == 1 then
					frame.auras[j]:SetPoint("CENTER", healthbar, "CENTER", -(num-1)*18, 50)
				else
					frame.auras[j]:SetPoint("LEFT", frame.auras[j-1], "RIGHT", 5, 0)
				end
				local borderColor = DebuffTypeColor[auraDB[Identifier][Aura]["auratype"]]
				if borderColor then
					frame.auras[j].border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)
					frame.auras[j].border:Show()
				end
				
				local startTime = auraDB[Identifier][Aura]["startTime"]
				local duration = tonumber(auraDB[Identifier][Aura]["duration"])
				local timeLeft = duration+startTime-currentTime
				
				if timeLeft < 0 or timeLeft > 60 then --don't show timer
					frame.auras[j].counter:SetText("")
					if not borderColor then	--I don't really understand this
						auraDB[Identifier]["interrupt"] = nil
					end
				else	
					if timeLeft < 10 then
						timeLeft = floor( timeLeft * 10 ^ 1 + 0.5 ) / 10 ^ 1
					else
						timeLeft = ceil(timeLeft)
					end
					
					local perc = timeLeft / 15
					local r, g, b = ColorGradient(perc)
					frame.auras[j].counter:SetTextColor( r, g, b )
							
					if timeLeft < 3 then
						local f = currentTime % 1
						if f > 0.5 then 
							f = 1 - f
						end
						frame.auras[j]:SetAlpha(f * 2)
					end				
					frame.auras[j].counter:SetText(timeLeft)
				end						
				k = k + 1
				j = j + 1
			end	
		end
		for j = k, 10, 1 do
			frame.auras[j]:SetTexture(nil)
			frame.auras[j].counter:SetText("")
			frame.auras[j].border:Hide()
		end
	else
		for j = 1, 10, 1 do
			frame.auras[j]:SetTexture(nil)
			frame.auras[j].counter:SetText("")
			frame.auras[j].border:Hide()
		end
	end
end


function UpdateDebuffs(frame, unitName, healthbar)

	if nameplate.nameplateByGUID[frame] then
		local guid = nameplate.nameplateByGUID[frame]
		UpdateDebuffsIdentifier(frame, healthbar, guid)

	elseif auraDB[unitName] then
		UpdateDebuffsIdentifier(frame, healthbar, unitName)
	else
		for j = 1, 10, 1 do
			
			if j == 1 and tyrPlates.inCombat and not frame.isPlayer and not frame.isFriendlyNPC and tyrPlates.auraCounter[unitName] and tyrPlates.auraCounter[unitName] > 0 then
				frame.auras[j]:SetTexture("Interface\\Icons\\Inv_misc_questionmark")
				frame.auras[j]:SetPoint("CENTER", healthbar, "CENTER", 0, 50)
				frame.auras[j].counter:SetText("")
				frame.auras[j].border:Hide()
			else
				frame.auras[j]:SetTexture(nil)
				frame.auras[j].counter:SetText("")
				frame.auras[j].border:Hide()
			end
		end
	end
end

function UpdateHealthbarColor(frame, nameRegion, healthbar)

	nameRegion:SetTextColor(1,1,1,1)

	if frame.aggro then 
		if frame.aggro == 0 then
			healthbar:SetStatusBarColor(1,0,0,1)
			--healthbar:SetStatusBarColor(ColorGradient(abs(percentage/100)),1)
		elseif frame.aggro == 1 then
			healthbar:SetStatusBarColor(1,0.33,0,1)	
		elseif frame.aggro == 2 then
			healthbar:SetStatusBarColor(1,0.66,0,1)		
		else
			healthbar:SetStatusBarColor(1,1,0,1)	
		end
	end
  
	local red, green, blue, _ = healthbar:GetStatusBarColor()
	if frame.isFriendlyPlayer == nil then	--nil is correct, don't use not
		if blue > 0.9 and red == 0 and green == 0 then
			-- friendly NPC/Player	
			frame.isPlayer = true
			frame.isFriendlyPlayer = true
		else
			frame.isFriendlyPlayer = false
		end
	end

	local unitName = nameRegion:GetText()
	-- if name is a player and in playerdatabase -> give class color
	if TyrPlatesDB.class[unitName] then
		frame.isPlayer = true
		local color = RAID_CLASS_COLORS[TyrPlatesDB.class[unitName]]
		healthbar:SetStatusBarColor(color.r, color.g, color.b, 1)
		return
	end
  
	if red > 0.9 and green < 0.2 and blue < 0.2 then
		-- enemy
		healthbar:SetStatusBarColor(1,0,0,1)
		return
	elseif red > 0.9 and green > 0.9 and blue < 0.2 then
		-- neutral
		healthbar:SetStatusBarColor(1,1,0,1)
		return
	elseif ( blue > 0.9 and red == 0 and green == 0 ) then
		--friendly player
		frame.isPlayer = true
		healthbar:SetStatusBarColor(0,0,0,1)
		return
	elseif red == 0 and green > 0.99 and blue == 0 then
		--friendly npc
		frame.isFriendlyNPC = true
		healthbar:SetStatusBarColor(0,1,0,1)	
	end
end

function UpdateCastbarByUnit(unit, healthbar)

	local currentTime = GetTime()
	if castbarDB.castDB[unit] and castbarDB.castDB[unit]["cast"] then
		if castbarDB.castDB[unit]["startTime"] + castbarDB.castDB[unit]["castTime"] <= currentTime then
			castbarDB.castDB[unit] = nil
			healthbar.castbar:Hide()
		else
			if spellDB.channelDuration[castbarDB.castDB[unit]["cast"]] or spellDB.channelWithTarget[castbarDB.castDB[unit]["cast"]] then
				healthbar.castbar:SetMinMaxValues(0, castbarDB.castDB[unit]["castTime"])
				healthbar.castbar:SetValue(castbarDB.castDB[unit]["castTime"] - (currentTime -  castbarDB.castDB[unit]["startTime"]))
			else
				healthbar.castbar:SetMinMaxValues(0, castbarDB.castDB[unit]["castTime"])
				healthbar.castbar:SetValue(currentTime - castbarDB.castDB[unit]["startTime"])
			end
			
			if healthbar.castbar.text then
				healthbar.castbar.text:SetText(castbarDB.castDB[unit]["cast"])
			else
				healthbar.castbar.text:SetText("")
			end
			healthbar.castbar:Show()
		
			if castbarDB.castDB[unit]["icon"] then
				healthbar.castbar.icon:SetTexture(castbarDB.castDB[unit]["icon"])
				healthbar.castbar.icon:SetTexCoord(.1,.9,.1,.9)
			end
		end
	else
		healthbar.castbar:Hide()
	end
end

-- updates the nameplates castbar
function UpdateCastbar(frame, unitName, healthbar)
	if not IsTarget(frame) then
		local guid
		if nameplate.nameplateByGUID[frame] then 
			guid = nameplate.nameplateByGUID[frame]
			UpdateCastbarByUnit(guid, healthbar)
		else
			UpdateCastbarByUnit(unitName, healthbar)
		end
	else
		healthbar.castbar:Hide()
	end
end

-- updates shown health 
function UpdateHealth(healthbar)
	local min, max = healthbar:GetMinMaxValues()
	local currentHealth = healthbar:GetValue()
	local healthInPercent = floor(currentHealth / max*100)
	
	-- show no text if unit has 0% or 100% health
	if healthInPercent ~= 100 and healthInPercent ~= 0 then
		healthbar.text:SetText(healthInPercent .. "%")
	else
		healthbar.text:SetText("")
	end
end

function UpdateAuras(identifier, unit)

	local currentTime = GetTime()
	local aurasOnEnemy = {}
	local i = 1
	local name, _, _, _, _, duration, timeLeft  =  UnitDebuff(unit, i)
	
	if not auraDB[identifier] then
		auraDB[identifier] = {}
	end
	local tmpTable = auraDB[identifier]

	while name do
		if auraDB[identifier] and auraDB[identifier][name] then
			if timeLeft then
				local timediff = timeLeft - (auraDB[identifier][name]["duration"] - (currentTime - auraDB[identifier][name]["startTime"]))
				auraDB[identifier][name]["startTime"] = auraDB[identifier][name]["startTime"] + timediff
			end
			aurasOnEnemy[name] = true
		elseif spellDB.trackAura.enemy[name] or spellDB.trackAura.own[name] then
		
			local spellId = spellDB.getSpellId[name]
			if not spellId then
				ace:print("SpellID missing for "..name)
				aurasOnEnemy[name] = true
				return
			end 
		
			local _, _, auraIcon = GetSpellInfo(spellId)
			
			local auraType = spellDB.trackAura.own[name] or spellDB.trackAura.enemy[name] 
			if not auraDB[identifier] then auraDB[identifier] = {} end
			if timeLeft then
				auraDB[identifier][name] = {startTime = currentTime, duration = timeLeft, icon = auraIcon, auratype = auraType}
			else
				auraDB[identifier][name] = {startTime = 0, duration = 0, icon = auraIcon, auratype = auraType}
			end
			aurasOnEnemy[name] = true			
		end 
		i = i + 1
		name, _, _, _, _, duration, timeLeft  =  UnitDebuff(unit, i)
	end
	
	i = 1
	name, _, _, _, _, _, timeLeft  =  UnitBuff(unit, i)
	while name do
		if auraDB[identifier] and auraDB[identifier][name] then
			if timeLeft then
				local timediff = timeLeft - (auraDB[identifier][name]["duration"] - (currentTime - auraDB[identifier][name]["startTime"]))
				auraDB[identifier][name]["startTime"] = auraDB[identifier][name]["startTime"] + timediff
			end
			aurasOnEnemy[name] = true
		elseif spellDB.trackAura.enemy[name] or spellDB.trackAura.own[name] then
		
			local spellId = spellDB.getSpellId[name]
			if not spellId then
				ace:print("SpellID missing for "..name)
				aurasOnEnemy[name] = true
				return
			end 
		
			local _, _, auraIcon = GetSpellInfo(spellId)
			
			local auraType = spellDB.trackAura.own[name] or spellDB.trackAura.enemy[name] 
			if not auraDB[identifier] then auraDB[identifier] = {} end
			if timeLeft then
				auraDB[identifier][name] = {startTime = currentTime, duration = timeLeft, icon = auraIcon, auratype = auraType}
			else
				auraDB[identifier][name] = {startTime = 0, duration = 0, icon = auraIcon, auratype = auraType}
			end
			aurasOnEnemy[name] = true	
		end 
		i = i + 1
		name, _, _, _, _, _, timeLeft  =  UnitBuff(unit, i)
	end
	
	--delete auras on enemy that were not found 
	if tmpTable then
		for aura in pairs(tmpTable) do
			if not aurasOnEnemy[aura] then
				--ace:print("remove ".. aura .. " from "..identifier)
				auraDB[identifier][aura] = nil
			end
		end
	end
end

function UpdateCast(identifier, unit)

	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
	if spell then
		if castbarDB.castDB[identifier] then
			local castTime = castbarDB.castDB[identifier]["castTime"]
			local trueCastTime = (endTime-startTime)/1000
			
			castbarDB.castDB[identifier]["castTime"] = trueCastTime
			
			--change basecastTime
			if UnitIsPlayer(unit) then
				if not spellDB.reducedCastTime[spell] then
					if not castbarDB.castingSpeedDB[identifier] then castbarDB.castingSpeedDB[identifier] = 1 end
					castbarDB.castingSpeedDB[identifier] = castbarDB.castingSpeedDB[identifier] * (trueCastTime/castTime)
				end
			end				
		else
			castbarDB.castDB[identifier] = {cast = spell, startTime = startTime/1000, castTime = (endTime-startTime)/1000, icon = icon, school = nil, pushbackCounter = 0}
		end
	else
		spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
		if not spell then 
			if castbarDB.castDB[identifier] then
				castbarDB.castDB[identifier] = nil 
			end
			return 
		end
		
		if castbarDB.castDB[identifier] then
			local castTime = castbarDB.castDB[identifier]["castTime"]
			local trueCastTime = (endTime-startTime)/1000
			
			castbarDB.castDB[identifier]["castTime"] = trueCastTime
			
			--change basecastTime
			if UnitIsPlayer(unit) then
				if not spellDB.reducedCastTime[spell] then
					if not castbarDB.castingSpeedDB[identifier] then castbarDB.castingSpeedDB[identifier] = 1 end
					castbarDB.castingSpeedDB[identifier] = castbarDB.castingSpeedDB[identifier] * (trueCastTime/castTime)
				end
			end		
		else
			castbarDB.castDB[identifier] = {cast = spell, startTime = startTime/1000, castTime = (endTime-startTime)/1000, icon = icon, school = nil, pushbackCounter = 0}
		end
	end
end

--update casts and auras on units (target/focus/group etc.) after target, focus or mouseover has changed
nameplate.unitUpdater = CreateFrame("Frame", nil, UIParent)
nameplate.unitUpdater:RegisterEvent("PLAYER_TARGET_CHANGED")
nameplate.unitUpdater:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
nameplate.unitUpdater:RegisterEvent("PLAYER_FOCUS_CHANGED")
nameplate.unitUpdater:RegisterEvent("UNIT_AURA")
--tyrPlates.target:RegisterEvent("UNIT_TARGET")
nameplate.target:SetScript("OnEvent", function()

	local unit
	if event == "PLAYER_TARGET_CHANGED" then
		unit = "target"
		
	elseif event == "UPDATE_MOUSEOVER_UNIT" then
		unit = "mouseover"
		
	elseif event == "PLAYER_FOCUS_CHANGED" then
		unit = "focus"
		
	elseif event == "UNIT_AURA" then
		unit = arg1
		if unit == "player" then return end
	end
	
	local name = UnitName(unit)
	local guid = UnitGUID(unit)

	if not name or not guid then return end
	--add player to classDB
	if UnitIsPlayer(unit) and not TyrPlatesDB.class[name] then
		local _, class = UnitClass(unit)
		TyrPlatesDB.class[name] = class
	end

	-- update auras and casts
	if tyrPlates:IsPlayerOrPetGUID(guid) then
		UpdateAuras(name, unit)
		UpdateCast(name, unit)
	else
		UpdateAuras(guid, unit)
		UpdateCast(guid, unit)
	end
end)

--updates casts of a unit (target/focus/group etc.) after it starts casting
nameplate.unitCastUpdater = CreateFrame("Frame", nil, UIParent)
nameplate.unitCastUpdater:RegisterEvent("UNIT_SPELLCAST_START")
nameplate.unitCastUpdater:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
nameplate.unitCastUpdater:SetScript("OnEvent", function()

	local name = UnitName(arg1)
	local guid = UnitGUID(arg1)
  
	if guid and tyrPlates:IsPlayerOrPetGUID(guid) then
		UpdateCast(name, arg1)
	else
		UpdateCast(guid, arg1)
	end 
end)

-- check if frame is target
function IsTarget(frame)
	return frame:IsShown() and frame:GetAlpha() == 1 and UnitExists("target") or false
end

function tableLength(auratable, isFriendlyPlayer)
	local count = 0
	for aura in pairs(auratable) do 
		if not isFriendlyPlayer or spellDB.friendlyFilter[aura] then
			count = count + 1 
		end
	end	
	return count
end

-- shows a colorgradient from green(100%) to red(0%)
function ColorGradient(perc)
	local r1, g1, b1
	local r2, g2, b2
	if perc <= 0.5 then
		perc = perc * 2
		r1, g1, b1 = 1, 0, 0 
		r2, g2, b2 = 1, 1, 0 
	else
		perc = perc * 2 - 1
		r1, g1, b1 = 1, 1, 0 
		r2, g2, b2 = 0, 1, 0
	end
	return r1 + (r2-r1)*perc, g1 + (g2-g1)*perc, b1 + (b2-b1)*perc
end

function ConvertToTotemPlate(frame)
	local healthbar, castbar = frame:GetChildren()
	local healthbarBorder, castbarBorder, spellIconRegion, glow, nameRegion, level, bossIconRegion, raidIconRegion = frame:GetRegions()
	local _, _, icon = GetSpellInfo(spellDB.TotemIdByName[nameRegion:GetText()])
	
	healthbar:SetAlpha(0)	-- with the Hide()-function the icon floats if totem is tarteted
	healthbarBorder:Hide()
	castbar:Hide()
	castbarBorder:Hide()
	spellIconRegion:Hide()
	glow:Hide()
	nameRegion:Hide()

	frame.icon:SetTexture(icon)
end