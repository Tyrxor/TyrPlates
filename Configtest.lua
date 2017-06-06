local config = LibStub("AceConfig-3.0")
local dialog = LibStub("AceConfigDialog-3.0")

function tyrPlates:OnInitialize()
	local options = {
		type = "group",
		name = "tyrPlates",
		args = {
			PlayerClassDB = {
				type = "group",
				name = "PlayerClassDB",
				get = get,
				set = set,
				args = {
					header_resetdb = {
						type = "header",
						name = "Reset",
						order = 10,
					},
					resetdb = {
						type = "execute",
						confirm = true,
						confirmText = "Do you really want to reset the PlayerClassDB",
						func = function()
							tyrPlates:ClearTable(TyrPlatesDB.class)
							self:Print("PlayerClassDB was reset")
						end,
						name = "Reset",
						order = 11,
					},
				},
			},
		},
	}

	config:RegisterOptionsTable("TyrPlates", {
		name = "TyrPlates",
		type = "group",
		args = {
		},
	})
	dialog:AddToBlizOptions("TyrPlates", "TyrPlates")

	config:RegisterOptionsTable("TyrPlates-PlayerClassDB", options.args.PlayerClassDB)
	dialog:AddToBlizOptions("TyrPlates-PlayerClassDB", options.args.PlayerClassDB.name, "TyrPlates")
	
	config:RegisterOptionsTable("TyrPlates-SpellsTable", tyrPlates.SpellsTable)
	dialog:AddToBlizOptions("TyrPlates-SpellsTable", tyrPlates.SpellsTable.name, "TyrPlates")
	
	InterfaceOptionsFrame_OpenToFrame("TyrPlates")
	
end

tyrPlates.SpellsTable = {
	name = "Specific spells",
	type = "group",
	childGroups = "tree",
	args = {
		addSpell = {
			order = 1,
			type = "input",
			name = "Add new spell to list",
			desc = "Enter spell ID or name (case sensitive)\nand press OK",
			set = function(info, value)
				if value then
					local spellID = tonumber(value)
					if spellID then
						local spellName = GetSpellInfo(spellID)
						if spellName then
							newspellName = spellName
							tyrPlates.AddNewSpell(spellID)
						end
					else
						newspellName = value
						tyrPlates.AddNewSpell(newspellName)
					end
				end
			end,
			get = function(info)
				return newspellName
			end,
		},
		blank = {
			order = 2,
			type = "description",
			name = "",
			width = "normal",
		},
		showSpellID = {
			type = "toggle",
			order = 3,
			name = "Show spell ID in tooltips",
			desc = "Usefull for configuring spell list.\nRequires ReloadUI to turn off.",
			get = function(info)
				return db[info[#info]]
			end,
			set = function(info,value)
				db.showSpellID = value
				if value then
					tyrPlates.ShowSpellID()
				end
			end,
		},

		-- fills up with BuildSpellList()
	},
}
tyrPlates:OnInitialize()

