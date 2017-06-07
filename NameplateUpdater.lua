
local spellDB = tyrPlates.spellDB

local STANDARD_TEXT_FONT = "Interface\\AddOns\\TyrPlates\\fonts\\arial.ttf"

--hide Playererrors (not LUA)
-- UIErrorsFrame:Hide()

--ace:print(MAX_TARGET_DEBUFFS)

-- check if frame is target
function tyrPlates:IsTarget(frame)
	local healthbarBorder, castbarBorder, spellIconRegion, glow, name, level, bossIconRegion, raidIconRegion = frame:GetRegions()
	return frame:IsShown() and frame:GetAlpha() == 1 and UnitExists("target") or false
end

function tyrPlates:tablelength(auratable, isFriendlyPlayer)
	local count = 0
	for aura in pairs(auratable) do 
		if not isFriendlyPlayer or spellDB.friendlyFilter[aura] then
			count = count + 1 
		end
	end	
	return count
end

-- shows a colorgradient from green(100%) to red(0%)
function tyrPlates:ColorGradient(perc)
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

function tyrPlates:convertToTotemPlate(frame)
	local healthbar, castbar = frame:GetChildren()
	local healthbarBorder, castbarBorder, spellIconRegion, glow, name, level, bossIconRegion, raidIconRegion = frame:GetRegions()
	local _, _, icon = GetSpellInfo(spellDB.TotemIdByName[name:GetText()])
	
	healthbar:SetAlpha(0)	-- with the Hide()-function the icon floats if totem is tarteted
	healthbarBorder:Hide()
	castbar:Hide()
	castbarBorder:Hide()
	spellIconRegion:Hide()
	glow:Hide()
	name:Hide()

	frame.icon:SetTexture(icon)
	--[[
	--decrease nameplate space the totem uses
	if this then
		this:SetHeight(1)
		this:SetWidth(1)
	else
		frame:SetHeight(1)
		frame:SetWidth(1)
	end
	]]
end

function tyrPlates:convertToNormalPlate(frame)
	local healthbar, castbar = frame:GetChildren()
	local healthbarBorder, castbarBorder, spellIconRegion, glow, name, level, bossIconRegion, raidIconRegion = frame:GetRegions()
	
	healthbar:SetAlpha(1)
	healthbarBorder:Show()
	glow:Show()
	name:Show()
	frame.icon:SetTexture(0,0,0,0)
	
		--[[
	if this then
		this:SetHeight(60)
		this:SetWidth(40)
	else
		frame:SetHeight(60)
		frame:SetWidth(40)
	end
	]]

end

-- Update Nameplate
function tyrPlates:UpdateNameplate()
  if not this.setup then tyrPlates:CreateNameplate() return end
	 
  local healthbar, castbar = this:GetChildren()
  local _, _, _, glow, name, level = this:GetRegions()
  
  level:Hide()
  
  if tyrPlates:IsTarget(this) then
	local unit = "target"
  	local targetName = UnitName(unit)
	local targetGUID = UnitGUID(unit)


	-- update auras and casts
	if tyrPlates:IsPlayerOrPetGUID(targetGUID) then
		tyrPlates:UpdateAuras(targetName, unit)
		tyrPlates:UpdateCast(targetName, unit)
	else
		tyrPlates:UpdateAuras(targetGUID, unit)
		tyrPlates:UpdateCast(targetGUID, unit)
	end
  
	if not tyrPlates:IsPlayerOrPetGUID(targetGUID) then
		tyrPlates.nameplateByGUID[this] = targetGUID
	end
	healthbar.targetbg:Show()
	healthbar:SetPoint("TOP", this, "TOP", 0, 7)
	
	local spell = UnitCastingInfo("target") or UnitChannelInfo("target")
	castbar.spellNameTextRegion:SetText(spell)
  else
	this:SetAlpha(0.99)
	healthbar.targetbg:Hide()
	healthbar:SetPoint("TOP", this, "TOP", 0, 5)
  end
  
  if MouseIsOver(this, 0, 0, 0, 0) then
	  local mouseoverGUID = UnitGUID("mouseover")
	  if mouseoverGUID and not tyrPlates:IsPlayerOrPetGUID(mouseoverGUID) then
		tyrPlates.nameplateByGUID[this] = mouseoverGUID
	  end
  end
  
  if spellDB.TotemIdByName[name:GetText()] then
		tyrPlates:convertToTotemPlate(this)
  else
	tyrPlates:convertToNormalPlate(this)
	tyrPlates:UpdateColors(this, name, healthbar)
	tyrPlates:UpdateCastbar(this, name, healthbar)
	tyrPlates:UpdateDebuffs(this, name, healthbar)
	tyrPlates:UpdateHP(this,name, healthbar) 
  end  
end


function tyrPlates:UpdateDebuffsIdentifier(frame, healthbar, Identifier, currentTime)

	if tyrPlates.auraDB[Identifier] then
		local currentTime = GetTime()
		local j, k = 1, 1
		local num = tyrPlates:tablelength(tyrPlates.auraDB[Identifier], frame.isFriendlyPlayer)
		for Aura in pairs(tyrPlates.auraDB[Identifier]) do
			--don't show aura if plate is friendly and the aura not in friendlyFilter
			if not frame.isFriendlyPlayer or spellDB.friendlyFilter[Aura] then
				frame.debuffs[j]:SetTexture(tyrPlates.auraDB[Identifier][Aura]["icon"])
				frame.debuffs[j]:SetAlpha(1)
				if j == 1 then
					frame.debuffs[j]:SetPoint("CENTER", healthbar, "CENTER", -(num-1)*18, 50)
				else
					frame.debuffs[j]:SetPoint("LEFT", frame.debuffs[j-1], "RIGHT", 5, 0)
				end
				local borderColor = DebuffTypeColor[tyrPlates.auraDB[Identifier][Aura]["auratype"]]
				if borderColor then
					frame.debuffs[j].border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)
					frame.debuffs[j].border:Show()
				end
				
				local startTime = tyrPlates.auraDB[Identifier][Aura]["startTime"]
				local duration = tonumber(tyrPlates.auraDB[Identifier][Aura]["duration"])
				local timeLeft = duration+startTime-currentTime
				
				if timeLeft < 0 or timeLeft > 60 then --don't show timer
					frame.debuffs[j].counter:SetText("")
					if not borderColor then	--I don't really understand this
						tyrPlates.auraDB[Identifier]["interrupt"] = nil
					end
				else	
					if timeLeft < 10 then
						timeLeft = floor( timeLeft * 10 ^ 1 + 0.5 ) / 10 ^ 1
					else
						timeLeft = ceil(timeLeft)
					end
					
					local perc = timeLeft / 15
					local r, g, b = tyrPlates:ColorGradient(perc)
					frame.debuffs[j].counter:SetTextColor( r, g, b )
							
					if timeLeft < 3 then
						local f = currentTime % 1
						if f > 0.5 then 
							f = 1 - f
						end
						frame.debuffs[j]:SetAlpha(f * 2)
					end				
					frame.debuffs[j].counter:SetText(timeLeft)
				end						
				k = k + 1
				j = j + 1
			end	
		end
		for j = k, 10, 1 do
			frame.debuffs[j]:SetTexture(nil)
			frame.debuffs[j].counter:SetText("")
			frame.debuffs[j].border:Hide()
		end
	else
		for j = 1, 10, 1 do
			frame.debuffs[j]:SetTexture(nil)
			frame.debuffs[j].counter:SetText("")
			frame.debuffs[j].border:Hide()
		end
	end
end


function tyrPlates:UpdateDebuffs(frame, name, healthbar)

	if tyrPlates.nameplateByGUID[frame] then
		local guid = tyrPlates.nameplateByGUID[frame]
		tyrPlates:UpdateDebuffsIdentifier(frame, healthbar, guid)

	elseif tyrPlates.auraDB[name:GetText()] then
		tyrPlates:UpdateDebuffsIdentifier(frame, healthbar, name:GetText())
	else
		for j = 1, 10, 1 do
			
			if j == 1 and tyrPlates.inCombat and not frame.isPlayer and not frame.isFriendlyNPC and tyrPlates.auraCounter[name:GetText()] and tyrPlates.auraCounter[name:GetText()] > 0 then
				frame.debuffs[j]:SetTexture("Interface\\Icons\\Inv_misc_questionmark")
				frame.debuffs[j]:SetPoint("CENTER", healthbar, "CENTER", 0, 50)
				frame.debuffs[j].counter:SetText("")
				frame.debuffs[j].border:Hide()
			else
				frame.debuffs[j]:SetTexture(nil)
				frame.debuffs[j].counter:SetText("")
				frame.debuffs[j].border:Hide()
			end
		end
	end
end

function tyrPlates:UpdateColors(frame, name, healthbar)

  name:SetTextColor(1,1,1,1)

  if frame.aggro then 
      if frame.aggro == 0 then
		healthbar:SetStatusBarColor(1,0,0,1)
		--healthbar:SetStatusBarColor(tyrPlates:ColorGradient(abs(percentage/100)),1)

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
		-- friendly npc/player	
		frame.isPlayer = true
		frame.isFriendlyPlayer = true
	else
		frame.isFriendlyPlayer = false
	end
  end

  -- if name is a player and in playerdatabase -> give class color
  if TyrPlatesDB.class[name:GetText()] then
  	frame.isPlayer = true
	if tyrPlates_config["friendlyClassColor"] or not frame.isFriendlyPlayer then
		local color = RAID_CLASS_COLORS[TyrPlatesDB.class[name:GetText()]]
		healthbar:SetStatusBarColor(color.r, color.g, color.b, 1)
	else
		healthbar:SetStatusBarColor(0,1,0,1)
	end
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

function tyrPlates:UpdateCastbarByUnit(unit, healthbar)

	local currentTime = GetTime()
	if tyrPlates.castbarDB.castDB[unit] and tyrPlates.castbarDB.castDB[unit]["cast"] then
		if tyrPlates.castbarDB.castDB[unit]["startTime"] + tyrPlates.castbarDB.castDB[unit]["castTime"] <= currentTime then
			tyrPlates.castbarDB.castDB[unit] = nil
			healthbar.castbar:Hide()
		else
			if spellDB.channelDuration[tyrPlates.castbarDB.castDB[unit]["cast"]] or spellDB.channelWithTarget[tyrPlates.castbarDB.castDB[unit]["cast"]] then
				healthbar.castbar:SetMinMaxValues(0, tyrPlates.castbarDB.castDB[unit]["castTime"])
				healthbar.castbar:SetValue(tyrPlates.castbarDB.castDB[unit]["castTime"] - (currentTime -  tyrPlates.castbarDB.castDB[unit]["startTime"]))
			else
				healthbar.castbar:SetMinMaxValues(0,  tyrPlates.castbarDB.castDB[unit]["castTime"])
				healthbar.castbar:SetValue(currentTime -  tyrPlates.castbarDB.castDB[unit]["startTime"])
			end
			
			if healthbar.castbar.spell then
				healthbar.castbar.spell:SetText(tyrPlates.castbarDB.castDB[unit]["cast"])
			else
				healthbar.castbar.spell:SetText("")
			end
			healthbar.castbar:Show()
		
			if tyrPlates.castbarDB.castDB[unit]["icon"] then
				healthbar.castbar.icon:SetTexture(tyrPlates.castbarDB.castDB[unit]["icon"])
				healthbar.castbar.icon:SetTexCoord(.1,.9,.1,.9)
			end
		end
	else
		healthbar.castbar:Hide()
	end
end

function tyrPlates:UpdateCastbar(frame, name, healthbar)
	if not tyrPlates:IsTarget(frame) then
		local guid
		if tyrPlates.nameplateByGUID[frame] then 
			guid = tyrPlates.nameplateByGUID[frame]
			tyrPlates:UpdateCastbarByUnit(guid, healthbar)
		else
			tyrPlates:UpdateCastbarByUnit(name:GetText(), healthbar)
		end
	else
		healthbar.castbar:Hide()
	end
end


function tyrPlates:UpdateHP(frame, name, healthbar)
	local min, max = healthbar:GetMinMaxValues()
	local cur = healthbar:GetValue()
	local hppercent = floor(cur / max*100)
	if hppercent ~= 100 and hppercent~= 0 then
		healthbar.hptext:SetText(hppercent .. "%")
	else
		healthbar.hptext:SetText("")
	end
end

function tyrPlates:UpdateAuras(identifier, unit)

	local currentTime = GetTime()
	local aurasOnEnemy = {}
	local i = 1
	local name, _, _, _, _, duration, timeLeft  =  UnitDebuff(unit, i)
	
	if not tyrPlates.auraDB[identifier] then
		tyrPlates.auraDB[identifier] = {}
	end
	local tmpTable = tyrPlates.auraDB[identifier]

	while name do
		if tyrPlates.auraDB[identifier] and tyrPlates.auraDB[identifier][name] then
			if timeLeft then
				local timediff = timeLeft - (tyrPlates.auraDB[identifier][name]["duration"]-(currentTime-tyrPlates.auraDB[identifier][name]["startTime"]))
				tyrPlates.auraDB[identifier][name]["startTime"] = tyrPlates.auraDB[identifier][name]["startTime"] + timediff
			end
			aurasOnEnemy[name] = true
		elseif spellDB.auraFilter[name] or spellDB.ownAuraFilter[name] then
		
			local spellId = spellDB.spellIdByName[name]
			if not spellId then
				ace:print("SpellID missing for "..name)
				aurasOnEnemy[name] = true
				return
			end 
		
			local _, _, auraIcon = GetSpellInfo(spellId)
			
			local auraType = spellDB.ownAuraFilter[name] or spellDB.auraFilter[name] 
			if not tyrPlates.auraDB[identifier] then tyrPlates.auraDB[identifier] = {} end
			if timeLeft then
				tyrPlates.auraDB[identifier][name] = {startTime = currentTime, duration = timeLeft, icon = auraIcon, auratype = auraType}
			else
				tyrPlates.auraDB[identifier][name] = {startTime = 0, duration = 0, icon = auraIcon, auratype = auraType}
			end
			aurasOnEnemy[name] = true			
		end 
		i = i + 1
		name, _, _, _, _, duration, timeLeft  =  UnitDebuff(unit, i)
	end
	
	i = 1
	name, _, _, _, _, _, timeLeft  =  UnitBuff(unit, i)
	while name do
		if tyrPlates.auraDB[identifier] and tyrPlates.auraDB[identifier][name] then
			if timeLeft then
				local timediff = timeLeft - (tyrPlates.auraDB[identifier][name]["duration"]-(currentTime-tyrPlates.auraDB[identifier][name]["startTime"]))
				tyrPlates.auraDB[identifier][name]["startTime"] = tyrPlates.auraDB[identifier][name]["startTime"] + timediff
			end
			aurasOnEnemy[name] = true
		elseif spellDB.auraFilter[name] or spellDB.ownAuraFilter[name] then
		
			local spellId = spellDB.spellIdByName[name]
			if not spellId then
				ace:print("SpellID missing for "..name)
				aurasOnEnemy[name] = true
				return
			end 
		
			local _, _, auraIcon = GetSpellInfo(spellId)
			
			local auraType = spellDB.ownAuraFilter[name] or spellDB.auraFilter[name] 
			if not tyrPlates.auraDB[identifier] then tyrPlates.auraDB[identifier] = {} end
			if timeLeft then
				tyrPlates.auraDB[identifier][name] = {startTime = currentTime, duration = timeLeft, icon = auraIcon, auratype = auraType}
			else
				tyrPlates.auraDB[identifier][name] = {startTime = 0, duration = 0, icon = auraIcon, auratype = auraType}
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
				tyrPlates.auraDB[identifier][aura] = nil
			end
		end
	end
end

function tyrPlates:UpdateCast(identifier, unit)

	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
	if spell then
		if tyrPlates.castbarDB.castDB[identifier] then
			local castTime = tyrPlates.castbarDB.castDB[identifier]["castTime"]
			local trueCastTime = (endTime-startTime)/1000
			
			tyrPlates.castbarDB.castDB[identifier]["castTime"] = trueCastTime
			
			--change basecastTime
			if UnitIsPlayer(unit) then
				if not spellDB.reducedCastTime[spell] then
					if not tyrPlates.castbarDB.castingSpeedDB[identifier] then tyrPlates.castbarDB.castingSpeedDB[identifier] = 1 end
					tyrPlates.castbarDB.castingSpeedDB[identifier] = tyrPlates.castbarDB.castingSpeedDB[identifier] * (trueCastTime/castTime)
				end
			end				
		else
			tyrPlates.castbarDB.castDB[identifier] = {cast = spell, startTime = startTime/1000, castTime = (endTime-startTime)/1000, icon = icon, school = nil, pushbackCounter = 0}
		end
	else
		spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
		if not spell then 
			if tyrPlates.castbarDB.castDB[identifier] then
				tyrPlates.castbarDB.castDB[identifier] = nil 
			end
			return 
		end
		
		if tyrPlates.castbarDB.castDB[identifier] then
			local castTime = tyrPlates.castbarDB.castDB[identifier]["castTime"]
			local trueCastTime = (endTime-startTime)/1000
			
			tyrPlates.castbarDB.castDB[identifier]["castTime"] = trueCastTime
			
			--change basecastTime
			if UnitIsPlayer(unit) then
				if not spellDB.reducedCastTime[spell] then
					if not tyrPlates.castbarDB.castingSpeedDB[identifier] then tyrPlates.castbarDB.castingSpeedDB[identifier] = 1 end
					tyrPlates.castbarDB.castingSpeedDB[identifier] = tyrPlates.castbarDB.castingSpeedDB[identifier] * (trueCastTime/castTime)
				end
			end		
		else
			tyrPlates.castbarDB.castDB[identifier] = {cast = spell, startTime = startTime/1000, castTime = (endTime-startTime)/1000, icon = icon, school = nil, pushbackCounter = 0}
		end
	end
end

--update casts and auras on units
tyrPlates.target = CreateFrame("Frame", nil, UIParent)
tyrPlates.target:RegisterEvent("PLAYER_TARGET_CHANGED")
tyrPlates.target:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
tyrPlates.target:RegisterEvent("PLAYER_FOCUS_CHANGED")
tyrPlates.target:RegisterEvent("UNIT_AURA")
--tyrPlates.target:RegisterEvent("UNIT_TARGET")

tyrPlates.target:SetScript("OnEvent", function()

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
		tyrPlates:UpdateAuras(name, unit)
		tyrPlates:UpdateCast(name, unit)
	else
		tyrPlates:UpdateAuras(guid, unit)
		tyrPlates:UpdateCast(guid, unit)
	end
end)

--updates the castbar of a unit (target/focus/group etc.) after it starts casting
tyrPlates.castUpdate = CreateFrame("Frame", nil, UIParent)
tyrPlates.castUpdate:RegisterEvent("UNIT_SPELLCAST_START")
tyrPlates.castUpdate:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
tyrPlates.castUpdate:SetScript("OnEvent", function()

	local name = UnitName(arg1)
	local guid = UnitGUID(arg1)
  
	if guid and tyrPlates:IsPlayerOrPetGUID(guid) then
		tyrPlates:UpdateCast(name, arg1)
	else
		tyrPlates:UpdateCast(guid, arg1)
	end 
end)