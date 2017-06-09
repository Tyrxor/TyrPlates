tyrPlates.nameplate = CreateFrame("Frame")

local nameplate = tyrPlates.nameplate
local healthDiffDB = tyrPlates.healthDiffDB

nameplate.nameplateByGUID = {}

local FONT_ARIAL = "Interface\\AddOns\\TyrPlates\\fonts\\arial.ttf"

-- get all existing nameplates and give them an OnShow and OnUpdate event
nameplate.Scanner = CreateFrame("Frame", nil, UIParent)
nameplate.Scanner:SetScript("OnUpdate", function()
	for _, frame in ipairs({WorldFrame:GetChildren()}) do
		if not frame.done and IsNameplateFrame(frame) then
			frame:SetScript("OnShow", function() nameplate:CreateNameplate() end)
			frame:SetScript("OnUpdate", function() nameplate:UpdateNameplate() end)
			frame.done = true
		end
	end
end)

-- check if frame is a nameplate
function IsNameplateFrame(frame)

	if frame:GetName() then
		return false
	end
	
	local overlayRegion = frame:GetRegions()
	if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
		return false
	end	
	
	return true
end

-- create our nameplate layout
function nameplate:CreateNameplate()

	local healthbar, castbar = this:GetChildren()
	local healthbarBorder, castbarBorder, spellIconRegion, glow, nameRegion, level, bossIconRegion, raidIconRegion = this:GetRegions()
  
	-- healthbar
	healthbar:SetStatusBarTexture("Interface\\AddOns\\TyrPlates\\img\\Statusbar")
	healthbar:ClearAllPoints()
	healthbar:SetWidth(120)
	healthbar:SetHeight(10)
	healthbar:SetBackdrop({bgFile = [[Interface\AddOns\TyrPlates\img\StatusbarBackground]], insets = {left = -1, right = -1, top = -1, bottom = -1}})
  
	-- border of healthbar
	healthbarBorder:ClearAllPoints()
	healthbarBorder:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
	healthbarBorder:SetTexture("Interface\\AddOns\\TyrPlates\\img\\RegularBorder")
	healthbarBorder:SetWidth(155)
	healthbarBorder:SetHeight(64)
	healthbarBorder:SetDrawLayer("BACKGROUND")
	
	-- extra border to highlight the nameplate that is targeted
	if healthbar.targetBorder == nil then
		healthbar.targetBorder = healthbar:CreateTexture(nil, "BORDER")
		healthbar.targetBorder:SetTexture("Interface\\AddOns\\TyrPlates\\img\\TargetBox")
		healthbar.targetBorder:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
		healthbar.targetBorder:SetWidth(155)
		healthbar.targetBorder:SetHeight(64)
		healthbar.targetBorder:Hide()
	end

	-- glow effect if you mouseover the healthbar
	glow:ClearAllPoints()
	glow:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
	glow:SetTexture("Interface\\AddOns\\TyrPlates\\img\\Highlight")
	glow:SetWidth(155)
	glow:SetHeight(64)

	-- name of the unit the nameplate belongs to
	nameRegion:SetFont(FONT_ARIAL,12)
	nameRegion:SetPoint("BOTTOM", healthbar, "CENTER", 0, 5)
	nameRegion:SetDrawLayer("BACKGROUND")

	-- hide level
	level:Hide()
  
	-- hide bossicon
	bossIconRegion:Hide()
  
	-- raid icon
	raidIconRegion:SetWidth(26)
	raidIconRegion:SetHeight(26)
	raidIconRegion:SetPoint("RIGHT", healthbar, "CENTER", -52, 10)
 
	CreateHealthText(this)
	SetDefaultCastbar(this)
	CreateCastbar(this)
	CreateAuraSlots(this)
	CreateTotemIcon(this)

	--reset nameplates guid
	nameplate.nameplateByGUID[this] = nil
  
	--try to get guid through nameplates current healthDiff
	local unitName = nameRegion:GetText()
	local _, max = healthbar:GetMinMaxValues()
	local curHealth = healthbar:GetValue()
	local healthDiff = max-curHealth
	if healthDiffDB[healthDiff..unitName] then
		nameplate.nameplateByGUID[this] = healthDiffDB[healthDiff..unitName]
	end
  
	this.isFriendlyPlayer = nil
	this.aggro = false
	this.isPlayer = false
	this.isFriendlyNPC = false
	this.setup = true 
end

-- change layout of default castbar and create an artificial castbar
function SetDefaultCastbar(frame)
	local healthbar, castbar = frame:GetChildren()
	local _, castbarBorder, spellIconRegion = frame:GetRegions()
	
	-- set castbar layout
	castbar:ClearAllPoints()
    castbar:SetWidth(120)
    castbar:SetHeight(10)
    castbar:SetStatusBarTexture("Interface\\AddOns\\TyrPlates\\img\\Statusbar")
    castbar:SetStatusBarColor(1,1,0,1)
	castbar:SetPoint("CENTER", healthbar, "CENTER", 0, -17)
	
	-- set layout of castbarBorder
	castbarBorder:SetPoint("CENTER", healthbar, "CENTER", 0, -32)
	castbarBorder:SetTexture("Interface\\AddOns\\TyrPlates\\img\\RegularBorder")
	castbarBorder:SetWidth(155)
	castbarBorder:SetHeight(64)
	--castbarBorder:SetAlpha(0)

	-- set layout of the spell icon
	spellIconRegion:ClearAllPoints()
	spellIconRegion:SetPoint("CENTER", healthbar, "CENTER", -81, -7)
	spellIconRegion:SetWidth(30)
	spellIconRegion:SetHeight(30)
	spellIconRegion:SetTexCoord( 0.1, 0.9, 0.1, 0.9 )
	
	-- create text containg the spellname
	if not castbar.spellNameRegion then
		castbar.spellNameRegion = castbar:CreateFontString()
		castbar.spellNameRegion:SetFont(FONT_ARIAL,12,"OUTLINE")
		castbar.spellNameRegion:ClearAllPoints()
		castbar.spellNameRegion:SetPoint("Center", castbar, "Center", 0, -13)
	end
end

-- create new castbar used whenever the default blizzard castbar isn't shown
function CreateCastbar(frame)

	local healthbar = frame:GetChildren()

	if healthbar.castbar == nil then
		healthbar.castbar = CreateFrame("Statusbar", nil, healthbar)
		healthbar.castbar:Hide()
		healthbar.castbar:SetWidth(120)
		healthbar.castbar:SetHeight(10)
		healthbar.castbar:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
		healthbar.castbar:SetStatusBarTexture("Interface\\AddOns\\TyrPlates\\img\\Statusbar")
		healthbar.castbar:SetStatusBarColor(1,0.75,0,1)
	
		-- create border
		if not healthbar.castbar.border then
			healthbar.castbar.border = healthbar.castbar:CreateTexture()
			healthbar.castbar.border:SetPoint("CENTER", healthbar.castbar, "CENTER", 0, -15)
			healthbar.castbar.border:SetTexture("Interface\\AddOns\\TyrPlates\\img\\RegularBorder")
			healthbar.castbar.border:SetWidth(155)
			healthbar.castbar.border:SetHeight(64)
			healthbar.castbar.border:SetDrawLayer("OVERLAY")
		end
		
		-- create text for the spell name
		if not healthbar.castbar.text then  
			healthbar.castbar.text = healthbar.castbar:CreateFontString()
			healthbar.castbar.text:SetFont(FONT_ARIAL,12,"OUTLINE")
			healthbar.castbar.text:SetPoint("CENTER", healthbar.castbar, "CENTER", 0, -12)
		end

		-- create icon for the cast spell
		if not healthbar.castbar.icon then
			healthbar.castbar.icon = healthbar.castbar:CreateTexture("Icon", nil, frame)
			healthbar.castbar.icon:SetPoint("CENTER", healthbar.castbar, "CENTER", -79, 7.5)
			healthbar.castbar.icon:SetTexCoord(.1,.9,.1,.9)
			healthbar.castbar.icon:SetWidth(27)
			healthbar.castbar.icon:SetHeight(27)
		end
	end	
end

-- create text for the healthbar
function CreateHealthText(frame)

	local healthbar = frame:GetChildren()
	
	if not healthbar.text then
		healthbar.text = healthbar:CreateFontString()
		healthbar.text:SetPoint("RIGHT", healthbar, "RIGHT")
		healthbar.text:SetNonSpaceWrap(false)
		healthbar.text:SetFontObject(GameFontWhite)
		healthbar.text:SetTextColor(1,1,1,1)
		healthbar.text:SetFont(FONT_ARIAL, 10)
		healthbar.text:SetText("")
	end
end

-- creates aura slots above the nameplate
function CreateAuraSlots(frame)
	if not frame.auras then
		frame.auras = {}
		for j = 1, 10 do
			if not frame.auras[j] then
				-- create aura icon
				frame.auras[j] = frame:CreateTexture(nil, "ARTWORK")
				frame.auras[j]:SetTexture(0,0,0,0)
				frame.auras[j]:ClearAllPoints()
				frame.auras[j]:SetWidth(30)
				frame.auras[j]:SetHeight(30)
		  
				-- create aura counter showing the duration
				frame.auras[j].counter = frame:CreateFontString( nil, "OVERLAY", this )
				frame.auras[j].counter:SetNonSpaceWrap(true)
				frame.auras[j].counter:SetFont( FONT_ARIAL,14, "OUTLINE" )
				frame.auras[j].counter:SetPoint( "CENTER", frame.auras[j], "CENTER", 0, -22 )
		  
				-- create aura border showing the aura type
				frame.auras[j].border = frame:CreateTexture(nil, "OVERLAY") 
				frame.auras[j].border:SetAllPoints(frame.auras[j])
				frame.auras[j].border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
				frame.auras[j].border:SetTexCoord(0.296875,0.5703125,0,0.515625)	  
			end
		end
	end
end

-- creates an icon used if the unit is a totem
function CreateTotemIcon(frame)
    if frame.icon == nil then
		local healthbar = frame:GetChildren()
		frame.icon = frame:CreateTexture( "Icon", nil, frame )
		frame.icon:SetTexture(0,0,0,0)
		frame.icon:SetPoint("CENTER", healthbar, "CENTER", 0, 0)
		frame.icon:SetWidth(30)
		frame.icon:SetHeight(30)
    end
end