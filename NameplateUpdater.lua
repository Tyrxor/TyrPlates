
local nameplate = tyrPlates.nameplate
local castbarDB = tyrPlates.castbarDB
local auraDB = tyrPlates.auraDB
local spellDB = tyrPlates.spellDB
local healthDiffDB = tyrPlates.healthDiffDB

--hides Playererrors (not LUA)
-- UIErrorsFrame:Hide()

function nameplate:UpdateNameplate()
	if not this.setup then nameplate:CreateNameplate() return end
	 
	local healthbar, castbar = this:GetChildren()
	local healthbarBorder, castbarBorder, spellIconRegion, glow, nameRegion, level = this:GetRegions()
	local unitName = nameRegion:GetText()
	level:Hide()
  
  	--try to get guid through nameplates current healthDiff
	if not nameplate.nameplateByGUID[this] then
		local _, max = healthbar:GetMinMaxValues()
		local curHealth = healthbar:GetValue()
		local healthDiff = max-curHealth
		if healthDiffDB[healthDiff..unitName] then
			nameplate.nameplateByGUID[this] = healthDiffDB[healthDiff..unitName]
		end
	end
  
  	UpdateHealthbarColor(this, nameRegion, healthbar) --check early to get the frames affiliation (like friendly)
  
	-- change layout if nameplate is the target, set it's guid and update it's auras and casts
	if IsTarget(this) then
		local target
		local unit = "target"
		local targetName = UnitName(unit) -- should be the same as unitName in this case
		local targetGUID = UnitGUID(unit)
		nameplate.nameplateByGUID[this] = targetGUID	-- set guid of the nameplate
		
		if tyrPlates:IsPlayerGUID(targetGUID) then
			target = targetName
		else
			target = targetGUID
		end

		tyrPlates.unitUpdater:UpdateUnitAuras(target, unit, this.isFriendly)
		tyrPlates.unitUpdater:UpdateUnitCast(target, unit, this.isFriendly)
	  
	  	-- show highlight around the nameplate
		healthbar.targetBorder:Show()
		healthbar:SetPoint("TOP", this, "TOP", 0, 7)
		
		-- show spellName on default castbar
		local spell = UnitCastingInfo("target") or UnitChannelInfo("target")
		castbar.spellNameRegion:SetText(spell)
		
		if not healthbar:IsShown() and not tyrPlates.hideFriendlyName and this.isFriendly then
			this.fakename:SetText(targetName)
			local color = RAID_CLASS_COLORS[TyrPlatesDB.class[targetName]]
			if color then
				this.fakename:SetTextColor(color.r, color.g, color.b)
			else
				this.fakename:SetTextColor(0,1,0)
			end
			this.fakename:Show()
		end
	else
		this:SetAlpha(0.99)	
		-- show highlight around the nameplate
		healthbar.targetBorder:Hide()
		healthbar:SetPoint("TOP", this, "TOP", 0, 5)
		if not healthbar:IsShown() and not tyrPlates.hideFriendlyPlayerName and this.isFriendly and this.isPlayer then
			this.fakename:SetText(unitName)
			local color = RAID_CLASS_COLORS[TyrPlatesDB.class[unitName]]
			if color then
				this.fakename:SetTextColor(color.r, color.g, color.b)
			else
				this.fakename:SetTextColor(0,1,0)
			end
			this.fakename:Show()
		else
			this.fakename:Hide()
		end	
	end
	
	if tyrPlates.hideFriendlyCastbar then
		this.fakename:SetPoint("TOP", this, "Center", 0, 15)
	else
		this.fakename:SetPoint("TOP", this, "Center", 0, 25)	
	end
  
	if MouseIsOver(this, 0, 0, 0, 0) then --should also work if healthbar is hidden
		local mouseoverGUID = UnitGUID("mouseover")
		if mouseoverGUID then
			nameplate.nameplateByGUID[this] = mouseoverGUID
		end
	end
	
	UpdateNameplateHealth(this)
	
	-- if unit is a friendly player, check if health- or castbar has to be hidden
	if this.isFriendly then 
		
		-- hide healthbar
		if tyrPlates.hideFriendlyHealthbar and not this.isLow then  
			healthbar:Hide()
			healthbarBorder:Hide()
			nameRegion:Hide()
			glow:Hide()
		else
			healthbar:Show()
			healthbarBorder:Show()
			nameRegion:Show()
			glow:Show()
		end		
		
		-- hide this addons castbar
		if tyrPlates.hideFriendlyCastbar then 
			castbar:Hide()
			castbarBorder:Hide()
			spellIconRegion:Hide()
			healthbar.castbar:Hide()
		else
			healthbar.castbar:Show()
			UpdateNameplateCastbar(this, unitName)
		end
	else
		healthbar:Show()
		UpdateNameplateCastbar(this, unitName)
	end
	UpdateNameplateAuras(this, unitName, healthbar)	
end

function getIterator(auraTable)
	local iterator = {}
	local takenAuras = {}
	local i = 1
	for _, auraName in ipairs(spellDB.trackPrio) do
		if auraTable[auraName] then
			iterator[i] = auraName
			--ace:print("add "..auraName.." with id "..i)
			takenAuras[auraName] = true
			i = i + 1
		end
	end
	
	for auraName, aura in pairs(auraTable) do
		if not takenAuras[auraName] then
			iterator[i] = auraName
			--ace:print("add "..auraName)
			i = i + 1
		end
	end
	return iterator
end

function UpdateNameplateAuras(frame, unitName, healthbar)

	local unit
	local unitGuid = nameplate.nameplateByGUID[frame]
	
	if auraDB[unitGuid] or auraDB[unitName] then
		if auraDB[unitName] then 
			unit = unitName
		else
			unit = unitGuid
		end

		local currentTime = GetTime()
		local j, k = 1, 1
		local numberOfAuras = tableLength(auraDB[unit])
		local auraIterator = getIterator(auraDB[unit])
		for _, aura in ipairs(auraIterator) do
			--ace:print("here")
			--ace:print(auraName)
			-- set alignment of the auraslots, depends on the number of auras that have to be shown
			if j == 1 then
				-- move auraslots down if castbar isn't shown
				if healthbar:IsShown() then
					if tyrPlates.hideFriendlyCastbar then
						frame.auras[j]:SetPoint("CENTER", frame, "CENTER", -(numberOfAuras-1)*18, 65)
					else
						frame.auras[j]:SetPoint("CENTER", frame, "CENTER", -(numberOfAuras-1)*18, 70)	
					end
				else
					if tyrPlates.hideFriendlyCastbar then
						frame.auras[j]:SetPoint("CENTER", frame, "CENTER", -(numberOfAuras-1)*18, 45)
					else
						frame.auras[j]:SetPoint("CENTER", frame, "CENTER", -(numberOfAuras-1)*18, 55)	
					end				
				end
			else
				frame.auras[j]:SetPoint("LEFT", frame.auras[j-1], "RIGHT", 5, 0)
			end
			
			-- set auraIcon
			frame.auras[j]:SetTexture(auraDB[unit][aura]["icon"])
			frame.auras[j]:SetAlpha(1)
			
			-- set stacks
			local stacks = auraDB[unit][aura]["stacks"]
			if stacks ~= 1 then
				frame.auras[j].stack:SetText(auraDB[unit][aura]["stacks"])
			end
			
			-- set color of border and show it
			local borderColor = DebuffTypeColor[auraDB[unit][aura]["auraType"]]
			if borderColor then
				frame.auras[j].border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)
				frame.auras[j].border:Show()
			end
				
			local startTime = auraDB[unit][aura]["startTime"]
			local duration = auraDB[unit][aura]["duration"]
			local timeLeft = startTime + duration - currentTime
			
			-- show duration timer
			if timeLeft <= 0 or timeLeft > 60 then
				frame.auras[j].counter:SetText("")
			else	
				-- show timer above 10s only as full seconds
				if timeLeft < 10 then
					timeLeft = floor( timeLeft * 10 ^ 1 + 0.5 ) / 10 ^ 1
				else
					timeLeft = ceil(timeLeft)
				end
				
				-- set timer
				frame.auras[j].counter:SetText(timeLeft)
				
				-- change color of the timer depending on it's duration
				local percent = timeLeft / 15
				local r, g, b = ColorGradient(percent)
				frame.auras[j].counter:SetTextColor( r, g, b )
					
				-- let icon blink if close to expiration
				if timeLeft < 3 then
					local f = currentTime % 1
					if f > 0.5 then 
						f = 1 - f
					end
					frame.auras[j]:SetAlpha(f * 2)
					frame.auras[j].border:SetAlpha(f * 2)
				end				
			end		
			
			k = k + 1
			j = j + 1
		end
		-- reset and hide remaining auraslots 
		for j = k, 10 do
			frame.auras[j]:SetTexture(nil)
			frame.auras[j].stack:SetText("")
			frame.auras[j].counter:SetText("")
			frame.auras[j].border:Hide()
		end
	else
		-- reset and hide all auraslots and show a questionmark if necessary
		for j = 1, 10 do		
			if j == 1 and tyrPlates.inCombat and not frame.isPlayer and not frame.isFriendlyNPC and tyrPlates.auraCounter[unitName] and tyrPlates.auraCounter[unitName] > 0 then
				if healthbar:IsShown() then
					frame.auras[j]:SetPoint("CENTER", frame, "CENTER", 0, 70)
				else
					frame.auras[j]:SetPoint("CENTER", frame, "CENTER", 0, 45)			
				end
				frame.auras[j]:SetTexture("Interface\\Icons\\Inv_misc_questionmark")
			else
				frame.auras[j]:SetTexture(nil)
			end
			frame.auras[j].stack:SetText("")
			frame.auras[j].counter:SetText("")
			frame.auras[j].border:Hide()
		end
	end
end

function UpdateHealthbarColor(frame, nameRegion, healthbar)

	-- set color of unitName to white
	nameRegion:SetTextColor(1,1,1,1)

	-- change color depending on aggro level
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
		return
	end
  
	local red, green, blue, _ = healthbar:GetStatusBarColor()

	-- check if unit is a friendly player
	if frame.isFriendlyPlayer == nil then	--nil is correct, don't use not to make sure you only check once
		if blue > 0.9 and red == 0 and green == 0 then
			frame.isPlayer = true
			frame.isFriendly = true
			frame.isFriendlyPlayer = true
		else
			frame.isFriendly = false
			frame.isFriendlyPlayer = false
		end
	end

	local unitName = nameRegion:GetText()
	
	-- if the unitName is in the classDB, give classcolor
	if TyrPlatesDB.class[unitName] then
		frame.isPlayer = true
		if tyrPlates.friendlyClasscolorHealthbars then
			local color = RAID_CLASS_COLORS[TyrPlatesDB.class[unitName]]
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
		frame.isFriendly = true
		frame.isFriendlyNPC = true
		healthbar:SetStatusBarColor(0,1,0,1)	
	end
end

function UpdateNameplateCastbar(frame, unitName)

	local unit	
	local unitGuid = nameplate.nameplateByGUID[frame]
	if castbarDB.castDB[unitName] then 
		unit = unitName
	else
		unit = unitGuid
	end
	
	local healthbar, originalCastbar = this:GetChildren()
	local _, castbarBorder, spellIconRegion = this:GetRegions()

	-- show and update castbar if a cast exist and the default blizzard one isn't shown (not target)
	if not IsTarget(frame) and castbarDB.castDB[unit] and castbarDB.castDB[unit]["cast"] then --has problems with originalCastbar:IsShown() instaed of IsTarget(), causes delay in visbibility
		local currentTime = GetTime()
		local startTime = castbarDB.castDB[unit]["startTime"]
		local castProgress = currentTime - startTime
		local castTime = castbarDB.castDB[unit]["castTime"]
		
		-- delete entry if cast has finished
		if castProgress >= castTime + 0.1 then	
			castbarDB.castDB[unit] = nil
			healthbar.castbar:Hide()
			healthbar.castbar:SetStatusBarColor(1,0.75,0,1)
			return
		elseif castProgress >= castTime then	
			-- show castbar green for a short time after cast has finished to show it's success
			healthbar.castbar:SetStatusBarColor(0,1,0,1)
		else 
			healthbar.castbar:SetStatusBarColor(1,0.75,0,1)		
		end
		-- set castProgressBar depending on if spell is a cast or channel
		local spellName = castbarDB.castDB[unit]["cast"]
		healthbar.castbar:SetMinMaxValues(0, castTime)
		if spellDB.channelDuration[spellName] or spellDB.channelWithTarget[spellName] then
			healthbar.castbar:SetValue(castTime - castProgress)
		else
			healthbar.castbar:SetValue(castProgress)
		end
	
		-- set spelltext
		healthbar.castbar.text:SetText(castbarDB.castDB[unit]["cast"])
		
		-- set icon
		healthbar.castbar.icon:SetTexture(castbarDB.castDB[unit]["icon"])
		
		-- transform spellicon
		if healthbar:IsShown() then
			healthbar.castbar.icon:SetPoint("CENTER", healthbar.castbar, "CENTER", -77, 6.5)
			healthbar.castbar.icon:SetWidth(25)
			healthbar.castbar.icon:SetHeight(25)
		else
			healthbar.castbar.icon:SetPoint("CENTER", frame, "CENTER", -70, 4)
			healthbar.castbar.icon:SetWidth(14)
			healthbar.castbar.icon:SetHeight(14)
		end	
		healthbar.castbar:Show()
	else		
		-- transform spellicon
		if healthbar:IsShown() then
			spellIconRegion:SetPoint("CENTER", originalCastbar, "CENTER", -82, 9)
			spellIconRegion:SetWidth(30)
			spellIconRegion:SetHeight(30)
		else
			spellIconRegion:SetPoint("CENTER", originalCastbar, "CENTER", -70, -1)
			spellIconRegion:SetWidth(14)
			spellIconRegion:SetHeight(14)
		end	
		healthbar.castbar:Hide()
	end
	
	if IsTarget(frame) then
		originalCastbar:Show()
		castbarBorder:Show()
		spellIconRegion:Show()
	end
end

-- updates shown health 
function UpdateNameplateHealth(frame)
	local healthbar = frame:GetChildren()
	local min, max = healthbar:GetMinMaxValues()
	local currentHealth = healthbar:GetValue()
	local healthInPercent = ceil(currentHealth / max*100)
	
	if healthInPercent < tyrPlates.isLow then
		frame.isLow = true
	else
		frame.isLow = false
	end
	
	-- show no text if unit has 100% health
	if healthInPercent ~= 100 then
		healthbar.text:SetText(healthInPercent .. "%")
	else
		healthbar.text:SetText("")
	end
end

-- check if nameplateframe is the current target
function IsTarget(frame)
	return frame:IsShown() and frame:GetAlpha() == 1 and UnitExists("target") or false
end


function tableLength(auratable)
	local length = 0
	for aura in pairs(auratable) do	length = length + 1 end	
	return length
end

-- returns a color depending on the argument, from green(100%) to red(0%)
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
