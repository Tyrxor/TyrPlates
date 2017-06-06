local backdrop = {
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local checkbox = {
  ["pvp"]    = "Enable PvP Modus",
  ["friendlyClassColor"]    = "Enable ClassColor for friendly Playerplates",
}

-- config
tpConfig = CreateFrame("Frame", nil, UIParent)
tpConfig:RegisterEvent("VARIABLES_LOADED")


function tpConfig:ResetConfig()
  tyrPlates_config = { }
  tyrPlates_config["pvp"] = false
  tyrPlates_config["friendlyClassColor"] = true
end

tpConfig:SetScript("OnEvent", function()
  if not tyrPlates_config then
    tpConfig:ResetConfig()
  end

  tyrPlatesConfig:Initialize()

end)

tyrPlatesConfig = tyrPlatesConfig or CreateFrame("Frame", "tyrPlatesConfig", UIParent)
function tyrPlatesConfig:Initialize()
  tyrPlatesConfig:Hide()
  tyrPlatesConfig:SetBackdrop(backdrop)
  tyrPlatesConfig:SetBackdropColor(0,0,0,1)
  tyrPlatesConfig:SetWidth(400)
  tyrPlatesConfig:SetHeight(500)
  tyrPlatesConfig:SetPoint("CENTER", 0, 0)
  tyrPlatesConfig:SetMovable(true)
  tyrPlatesConfig:EnableMouse(true)
  tyrPlatesConfig:SetScript("OnMouseDown",function()
    tyrPlatesConfig:StartMoving()
  end)

  tyrPlatesConfig:SetScript("OnMouseUp",function()
    tyrPlatesConfig:StopMovingOrSizing()
  end)

  tyrPlatesConfig.vpos = 60

  tyrPlatesConfig.title = CreateFrame("Frame", nil, tyrPlatesConfig)
  tyrPlatesConfig.title:SetPoint("TOP", 0, -2);
  tyrPlatesConfig.title:SetWidth(396);
  tyrPlatesConfig.title:SetHeight(40);
  tyrPlatesConfig.title.tex = tyrPlatesConfig.title:CreateTexture("LOW");
  tyrPlatesConfig.title.tex:SetAllPoints();
  tyrPlatesConfig.title.tex:SetTexture(0,0,0,.5);

  tyrPlatesConfig.caption = tyrPlatesConfig.caption or tyrPlatesConfig.title:CreateFontString("Status", "LOW", "GameFontWhite")
  tyrPlatesConfig.caption:SetPoint("TOP", 0, -10)
  tyrPlatesConfig.caption:SetJustifyH("CENTER")
  tyrPlatesConfig.caption:SetText("ShaguPlates")
  tyrPlatesConfig.caption:SetFont("Interface\\AddOns\\ShaguPlates\\fonts\\arial.ttf", 24)
  tyrPlatesConfig.caption:SetTextColor(.2,1,.8,1)

  for config, description in pairs(checkbox) do
    tyrPlatesConfig:CreateEntry(config, description, "checkbox")
  end
  
  if not MySlider then
   tyrPlatesConfig.MySlider = CreateFrame('Slider', 'MySlider', tyrPlatesConfig, 'OptionsSliderTemplate')
  end

 tyrPlatesConfig.MySlider:ClearAllPoints()
 tyrPlatesConfig.MySlider:SetPoint("CENTER", tyrPlatesConfig, "CENTER", 0, 0)
 tyrPlatesConfig.MySlider:SetMinMaxValues(1, 100)
 tyrPlatesConfig.MySlider:SetValue(50)
 getglobal(MySlider:GetName() .. 'Low'):SetText('1');
 getglobal(MySlider:GetName() .. 'High'):SetText('100');
 getglobal(MySlider:GetName() .. 'Text'):SetText('My Slider');
 --tyrPlatesConfig.MySlider:Show()

  tyrPlatesConfig.reload = CreateFrame("Button", nil, tyrPlatesConfig, "UIPanelButtonTemplate")
  tyrPlatesConfig.reload:SetWidth(150)
  tyrPlatesConfig.reload:SetHeight(30)
  tyrPlatesConfig.reload:SetNormalTexture(nil)
  tyrPlatesConfig.reload:SetHighlightTexture(nil)
  tyrPlatesConfig.reload:SetPushedTexture(nil)
  tyrPlatesConfig.reload:SetDisabledTexture(nil)
  tyrPlatesConfig.reload:SetBackdrop(backdrop)
  tyrPlatesConfig.reload:SetBackdropColor(0,0,0,1)
  tyrPlatesConfig.reload:SetPoint("BOTTOMRIGHT", -20, 20)
  tyrPlatesConfig.reload:SetText("Save")
  tyrPlatesConfig.reload:SetScript("OnClick", function()
    ReloadUI()
  end)

  tyrPlatesConfig.reset = CreateFrame("Button", nil, tyrPlatesConfig, "UIPanelButtonTemplate")
  tyrPlatesConfig.reset:SetWidth(150)
  tyrPlatesConfig.reset:SetHeight(30)
  tyrPlatesConfig.reset:SetNormalTexture(nil)
  tyrPlatesConfig.reset:SetHighlightTexture(nil)
  tyrPlatesConfig.reset:SetPushedTexture(nil)
  tyrPlatesConfig.reset:SetDisabledTexture(nil)
  tyrPlatesConfig.reset:SetBackdrop(backdrop)
  tyrPlatesConfig.reset:SetBackdropColor(0,0,0,1)
  tyrPlatesConfig.reset:SetPoint("BOTTOMLEFT", 20, 20)
  tyrPlatesConfig.reset:SetText("Reset")
  tyrPlatesConfig.reset:SetScript("OnClick", function()
    tyrPlates_config = nil
    ReloadUI()
  end)
end

function tyrPlatesConfig:CreateEntry(config, description, type)
  -- sanity check
  if not tyrPlates_config[config] then
    tpConfig:ResetConfig()
  end

  -- basic frame
  local frame = getglobal("SPC" .. config) or CreateFrame("Frame", "SPC" .. config, tyrPlatesConfig)
  frame:SetWidth(400)
  frame:SetHeight(25)
  frame:SetPoint("TOP", 0, -tyrPlatesConfig.vpos)

  -- caption
  frame.caption = frame.caption or frame:CreateFontString("Status", "LOW", "GameFontWhite")
  frame.caption:SetFont("Interface\\AddOns\\ShaguPlates\\fonts\\arial.ttf", 14)
  frame.caption:SetPoint("LEFT", 20, 0)
  frame.caption:SetJustifyH("LEFT")
  frame.caption:SetText(description)

  -- checkbox
  if type == "checkbox" then
    frame.input = frame.input or CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    frame.input:SetWidth(24)
    frame.input:SetHeight(24)
    frame.input:SetPoint("RIGHT" , -20, 0)

    frame.input.config = config
    if tyrPlates_config[config] then
      frame.input:SetChecked()
    end

    frame.input:SetScript("OnClick", function ()
      if this:GetChecked() then
        tyrPlates_config[this.config] = true
      else
		tyrPlates_config[this.config] = false
      end
    end)

  elseif type == "text" then
    -- input field
    frame.input = frame.input or CreateFrame("EditBox", nil, frame)
    frame.input:SetTextColor(.2,1,.8,1)
    frame.input:SetJustifyH("RIGHT")

    frame.input:SetWidth(50)
    frame.input:SetHeight(20)
    frame.input:SetPoint("RIGHT" , -20, 0)
    frame.input:SetFontObject(GameFontNormal)
    frame.input:SetAutoFocus(false)
    frame.input:SetScript("OnEscapePressed", function(self)
      this:ClearFocus()
    end)

    frame.input.config = config
    frame.input:SetText(tyrPlates_config[config])

    frame.input:SetScript("OnTextChanged", function(self)
      tyrPlates_config[this.config] = this:GetText()
    end)
  end

  tyrPlatesConfig.vpos = tyrPlatesConfig.vpos + 30
end

SLASH_SHAGUPLATES1 = '/shaguplates'
SLASH_SHAGUPLATES2 = '/sp'

function SlashCmdList.SHAGUPLATES(msg)
  if tyrPlatesConfig:IsShown() then
    tyrPlatesConfig:Hide()
  else
    tyrPlatesConfig:Show()
  end
end
