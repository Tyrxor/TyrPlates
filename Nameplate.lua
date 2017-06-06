-- create frame
tyrPlates.nameplateByGUID = {}

local STANDARD_TEXT_FONT = "Interface\\AddOns\\TyrPlates\\fonts\\arial.ttf"

-- catch all nameplates
tyrPlates.nameplateScanner = CreateFrame("Frame", nil, UIParent)
tyrPlates.nameplateScanner:SetScript("OnUpdate", function()
  for _, nameplate in ipairs({WorldFrame:GetChildren()}) do
	if not nameplate.done and tyrPlates:IsNameplateFrame(nameplate) then
      nameplate:SetScript("OnShow", function() tyrPlates:CreateNameplate() end)
      nameplate:SetScript("OnUpdate", function() tyrPlates:UpdateNameplate() end)
      nameplate.done = true
    end
  end
end)

-- check if frame is a nameplate
function tyrPlates:IsNameplateFrame(frame)
	if frame:GetName() then
		return false
	end
	
	local overlayRegion = frame:GetRegions()
	if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
		return false
	end
	
	return true
end

-- Create Nameplate
function tyrPlates:CreateNameplate()

  local healthbar, castbar = this:GetChildren()
  local healthbarBorder, castbarBorder, spellIconRegion, glow, name, level, bossIconRegion, raidIconRegion = this:GetRegions()
  
	-- create bigger mouseover region (for easier updating) creates higher vertical platedistance
  --this:SetHeight(60)
  --this:SetWidth(40)
    -- healthbar
  healthbar:SetStatusBarTexture("Interface\\AddOns\\TyrPlates\\img\\Statusbar")
  healthbar:ClearAllPoints()
  --healthbar:SetPoint("TOP", this, "TOP", 0, 5)
  healthbar:SetWidth(120)
  healthbar:SetHeight(10)
  healthbar:SetBackdrop({  bgFile = [[Interface\AddOns\TyrPlates\img\StatusbarBackground]],
                                     insets = {left = -1, right = -1, top = -1, bottom = -1} })
									 
  if healthbar.targetbg == nil then
    healthbar.targetbg = healthbar:CreateTexture(nil, "BORDER")
    healthbar.targetbg:SetTexture("Interface\\AddOns\\TyrPlates\\img\\TargetBox")
    healthbar.targetbg:ClearAllPoints()
    healthbar.targetbg:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
    healthbar.targetbg:SetWidth(155)
    healthbar.targetbg:SetHeight(64)
	healthbar.targetbg:Hide()
  end
  
  -- border of healthbar
  healthbarBorder:ClearAllPoints()
  healthbarBorder:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
  healthbarBorder:SetTexture("Interface\\AddOns\\TyrPlates\\img\\RegularBorder")
  healthbarBorder:SetWidth(155)
  healthbarBorder:SetHeight(64)
  healthbarBorder:SetDrawLayer("BACKGROUND")

  -- glow effect if you mouseover the healthbar
  glow:ClearAllPoints()
  glow:SetPoint("CENTER", healthbar, "CENTER", 0, -15)
  glow:SetTexture("Interface\\AddOns\\TyrPlates\\img\\Highlight")
  glow:SetWidth(155)
  glow:SetHeight(64)

  -- adjust font
  name:SetFont(STANDARD_TEXT_FONT,12)
  name:SetPoint("BOTTOM", healthbar, "CENTER", 0, 5)
  name:SetDrawLayer("BACKGROUND")

  level:Hide()
  
  bossIconRegion:Hide()
  
  raidIconRegion:SetWidth(26)
  raidIconRegion:SetHeight(26)
  raidIconRegion:SetPoint("RIGHT", healthbar, "CENTER", -52, 10)
 
  tyrPlates:CreateCastbar(healthbar, castbar, castbarBorder, spellIconRegion)
  tyrPlates:CreateHP(healthbar)
  tyrPlates:CreateDebuffs(this)
  tyrPlates:CreateTotemIcon(this, name)
  
  this.setup = true
  this.isFriendlyPlayer = nil
  this.aggro = false
  this.isPlayer = false
  this.isFriendlyNPC = false

  --reset guid of plate
  --without a reset, plates sometimes have a wrong guid
  tyrPlates.nameplateByGUID[this] = nil
  
  --try to get guid through hp
  local min, max = healthbar:GetMinMaxValues()
  local curHealth = healthbar:GetValue()
  local healthdiff = max-curHealth
  if tyrPlates.healthDiffDB[healthdiff..name:GetText()] then
	tyrPlates.nameplateByGUID[this] = tyrPlates.healthDiffDB[healthdiff..name:GetText()]
  end
  
  --tyrPlates:UpdateNameplate()
  
end


function tyrPlates:CreateCastbar(healthbar, castbar, castbarBorder, spellIconRegion)
	castbar:ClearAllPoints()
    castbar:SetWidth(120)
    castbar:SetHeight(10)
    castbar:SetStatusBarTexture("Interface\\AddOns\\TyrPlates\\img\\Statusbar")
    castbar:SetStatusBarColor(1,1,0,1)
	castbar:SetPoint("CENTER", healthbar, "CENTER", 0, -17)
	
	-- border of castbar
	castbarBorder:SetPoint("CENTER", healthbar, "CENTER", 0, -32)
	castbarBorder:SetTexture("Interface\\AddOns\\TyrPlates\\img\\RegularBorder")
	castbarBorder:SetWidth(155)
	castbarBorder:SetHeight(64)

	spellIconRegion:ClearAllPoints()
	spellIconRegion:SetPoint("CENTER", healthbar, "CENTER", -81, -8)
	spellIconRegion:SetWidth(30)
	spellIconRegion:SetHeight(30)
	spellIconRegion:SetTexCoord( 0.1, 0.9, 0.1, 0.9 )
	if not castbar.spellNameTextRegion then
		castbar.spellNameTextRegion = castbar:CreateFontString()
		castbar.spellNameTextRegion:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
		castbar.spellNameTextRegion:ClearAllPoints()
		castbar.spellNameTextRegion:SetPoint("Center", castbar, "Center", 0, -12)
	end
	
  -- create fake castbar
  if healthbar.castbar == nil then
    healthbar.castbar = CreateFrame("StatusBar", nil, healthbar)
    healthbar.castbar:Hide()
    healthbar.castbar:SetWidth(120)
    healthbar.castbar:SetHeight(10)
    healthbar.castbar:SetPoint("CENTER", healthbar, "CENTER", 0, -17)
    healthbar.castbar:SetStatusBarTexture("Interface\\AddOns\\TyrPlates\\img\\Statusbar")
    healthbar.castbar:SetStatusBarColor(1,1,0,1)
	
	if healthbar.castbar.border == nil then
		healthbar.castbar.border = healthbar.castbar:CreateTexture()
		healthbar.castbar.border:SetPoint("CENTER", healthbar, "CENTER", 0, -32)
		healthbar.castbar.border:SetTexture("Interface\\AddOns\\TyrPlates\\img\\RegularBorder")
		healthbar.castbar.border:SetWidth(155)
		healthbar.castbar.border:SetHeight(64)
		healthbar.castbar.border:SetDrawLayer("OVERLAY")
	end

    if healthbar.castbar.spell == nil then  
		healthbar.castbar.spell = healthbar.castbar:CreateFontString()
		healthbar.castbar.spell:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
		healthbar.castbar.spell:SetPoint("Center", castbar, "Center", 0, -12)
    end

    if healthbar.castbar.icon == nil then
		healthbar.castbar.icon = healthbar.castbar:CreateTexture( "Icon", nil, frame )
		healthbar.castbar.icon:SetPoint("CENTER", healthbar, "CENTER", -81, -8)
		healthbar.castbar.icon:SetWidth(30)
		healthbar.castbar.icon:SetHeight(30)
    end
  end	
end

function tyrPlates:CreateHP(healthbar)
	if not healthbar.hptext then
		healthbar.hptext = healthbar:CreateFontString("Status", "DIALOG", "GameFontNormal")
		healthbar.hptext:SetPoint("RIGHT", healthbar, "RIGHT")
		healthbar.hptext:SetNonSpaceWrap(false)
		healthbar.hptext:SetFontObject(GameFontWhite)
		healthbar.hptext:SetTextColor(1,1,1,1)
		healthbar.hptext:SetFont(STANDARD_TEXT_FONT, 10)
		healthbar.hptext:SetText("")
	end
end

function tyrPlates:CreateDebuffs(frame)

  if frame.debuffs == nil then frame.debuffs = {} end
  for j=1, 10, 1 do
    if frame.debuffs[j] == nil then
      frame.debuffs[j] = frame:CreateTexture(nil, "ARTWORK")
	  --frame.debuffs[j]:SetDrawLayer("OVERLAY")
      frame.debuffs[j]:SetTexture(0,0,0,0)
	  --frame.debuffs[j]:SetTexCoord( 0.05, 0.95, 0.05, 0.95 )
      frame.debuffs[j]:ClearAllPoints()
      frame.debuffs[j]:SetWidth(30)
      frame.debuffs[j]:SetHeight(30)
	  frame.debuffs[j].counter = frame:CreateFontString( nil, "OVERLAY", this )
	  frame.debuffs[j].counter:SetNonSpaceWrap(true)
	  frame.debuffs[j].counter:SetFont( STANDARD_TEXT_FONT,14, "OUTLINE" )
	  frame.debuffs[j].counter:SetPoint( "CENTER", frame.debuffs[j], "CENTER", 0, -22 )
	  frame.debuffs[j].border = frame:CreateTexture(nil, "OVERLAY") 
	  frame.debuffs[j].border:SetAllPoints(frame.debuffs[j])
	  frame.debuffs[j].border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
	  frame.debuffs[j].border:SetTexCoord(0.296875,0.5703125,0,0.515625)	  
	  frame.debuffs[j].border:Hide()
    end
  end
end

function tyrPlates:CreateTotemIcon(frame, name)

    if frame.icon == nil then
		local healthbar = frame:GetChildren()
		frame.icon = frame:CreateTexture( "Icon", nil, frame )
		frame.icon:SetTexture(0,0,0,0)
		frame.icon:SetPoint("CENTER", healthbar, "CENTER", 0, 0)
		frame.icon:SetWidth(30)
		frame.icon:SetHeight(30)
    end
end