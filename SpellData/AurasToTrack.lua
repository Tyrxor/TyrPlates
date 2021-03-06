local spellDB = tyrPlates.spellDB

spellDB.trackAura = {}

-- aura priority list
spellDB.trackPrio = {
	[1] = "Vampiric Touch",
	[2] = "Shadow Word: Pain",
}

-- auras to be shown if your own
spellDB.trackAura.own = {
	["Vampiric Touch"] = "Magic",
	["Shadow Word: Pain"] = "Magic",
}

-- auras to be shown on enemies
spellDB.trackAura.enemy = {
	
	--Racial
	["Arcane Torrent"] = "Magic",
	["War Stomp"] = "none",
	["Gift of the Naaru"] = "Magic",
	["Blood Fury"] = "none",
	["Stoneform"] = "none",
	["Will of the Forsaken"] = "none",
	
	--Druid
	["Barkskin"] = "Magic",
	["Cyclone"] = "none",
	["Entangling Roots"] = "Magic",
	["Innervate"] = "Magic",
	["Hibernate"] = "Magic",
	["Starfire Stun"] = "none",
	["Nature's Swiftness"] = "Magic",
	["Bash"] = "none",
	["Maim"] = "none",
	["Pounce"] = "none",
	["Feral Charge Effect"] = "none",
	
	--Warlock
	["Amplify Curse"] = "Magic",
	["Shadowfury"] = "Magic",
	["Pyroclasm"] = "none",
	["Curse of Tongues"] = "Curse",
	["Curse of Recklessness"] = "Curse",
	["Death Coil"] = "Magic",
	["Fear"] = "Magic",
	["Howl of Terror"] = "Magic",
	["Banish"] = "Magic",
	["Soulstone Resurrection"] = "none",
	["Enslave Demon"] = "none",
	["Nether Protection"] = "Magic",
	["Seduction"] = "Magic",
	["Spell Lock"] = "Magic",
	["Sacrifice"] = "Magic",
	["Shadow Trance"] = "Magic",
	[31117] = "Magic",	--Unstable Affliction Silence

	--Mage
	["Counterspell - Silenced"] = "Magic",
	["Invisibility"] = "none",
	["Polymorph"] = "Magic",
	["Presence of Mind"] = "Magic",
	["Arcane Power"] = "Magic",
	["Slow"] = "Magic",
	["Impact"] = "none",
	["Combustion"] = "Magic",
	["Dragon's Breath"] = "Magic",
	["Frost Nova"] = "Magic",
	["Ice Block"] = "Magic",
	["Icy Veins"] = "Magic",
	["Ice Barrier"] = "Magic",
	["Freeze"] = "Magic",
	["Frostbite"] = "Magic",
	["Hypothermia"] = "none",

	--Shaman
	["Stoneclaw Stun"] = "Magic",
	["Earth Shield"] = "Magic",
	["Shamanistic Rage"] = "none",
	["Heroism"] = "Magic",
	["Bloodlust"] = "Magic",
	
	--Priest
	["Fear Ward"] = "Magic",
	["Power Word: Shield"] = "Magic",
	["Mind Control"] = "Magic",
	["Psychic Scream"] = "Magic",
	["Silence"] = "Magic",
	["Blackout"] = "Magic",
	["Power Infusion"] = "Magic",
	["Pain Suppression"] = "Magic",
	["Focused Will"] = "Magic",
	["Shackle Undead"] = "Magic",
	
	--Rogue
	["Cheap Shot"] = "none",
	["Kidney Shot"] = "none",
	["Garrote - Silence"] = "none",
	["Evasion"] = "none",
	["Gouge"] = "none",
	["Cloak of Shadows"] = "none",
	["Blind"] = "none",
	["Sap"] = "none",
	["Adrenaline Rush"] = "none",
	["Blade Flurry"] = "none",
	["Kick - Silenced"] = "none",
	["Cheating Death"] = "none",
	
	--Hunter
	["Bestial Wrath"] = "none",
	["The Beast Within"] = "none",
	["Intimidation"] = "none",
	["Scare Beast"] = "Magic",
	["Rapid Fire"] = "Magic",
	["Freezing Trap Effect"] = "Magic",
	["Improved Concussive Shot"] = "none",
	["Scatter Shot"] = "none",
	["Silencing Shot"] = "Magic",
	["Improved Wing Clip"] = "none",
	["Entrapment"] = "Magic",
	["Counterattack"] = "none",
	[19386] = "Poison",	 -- Wyvern Sting (Rank 1)
	[24132] = "Poison",	 -- Wyvern Sting (Rank 2)
	[24133] = "Poison",	 -- Wyvern Sting (Rank 3)
	[27068] = "Poison",	 -- Wyvern Sting (Rank 4)
	
	--Warrior
	["Charge Stun"] = "none",
	["Berserker Rage"] = "none",
	["Intercept Stun"] = "none",
	["Intimidating Shout"] = "none",
	["Recklessness"] = "none",
	["Disarm"] = "none",
	["Shield Wall"] = "none",
	["Spell Reflection"] = "none",
	["Death Wish"] = "none",
	["Mace Stun Effect"] = "none",
	["Improved Hamstring"] = "none",
	["Sweeping Strikes"] = "none",
	["Last Stand"] = "none",
	["Concussion Blow"] = "none",
	["Shield Bash - Silenced"] = "none",
	["Revenge Stun"] = "none",
	["Disarm"] = "none",
	["Battle Stance"] = "none",
	["Defensive Stance"] = "none",
	["Berserker Stance"] = "none",
	
	--Paladin
	["Avenging Wrath"] = "Magic",
	["Forbearance"] = "none",
	["Repentance"] = "Magic",
	["Blessing of Freedom"] = "Magic",
	["Blessing of Protection"] = "Magic",
	["Divine Shield"] = "Magic",
	["Hammer of Justice"] = "Magic",
	["Divine Intervention"] = "Magic",
	["Stun"] = "Magic",
}

--auras to be shown on friendly units
spellDB.trackAura.friendly = {

	--test
	["Power Word: Shield"] = "Magic",

	--Racial
	["Arcane Torrent"] = "Magic",
	["War Stomp"] = "none",
	
	--Druid
	["Cyclone"] = "none",
	["Entangling Roots"] = "Magic",
	["Hibernate"] = "Magic",
	["Starfire Stun"] = "none",
	["Bash"] = "none",
	["Maim"] = "none",
	["Pounce"] = "none",
	["Feral Charge Effect"] = "none",
	
	--Warlock
	["Shadowfury"] = "Magic",
	["Pyroclasm"] = "none",
	["Curse of Tongues"] = "Curse",
	["Death Coil"] = "Magic",
	["Fear"] = "Magic",
	["Howl of Terror"] = "Magic",
	["Banish"] = "Magic",
	["Soulstone Resurrection"] = "none",
	["Enslave Demon"] = "none",
	["Seduction"] = "Magic",
	["Spell Lock"] = "Magic",
	["Sacrifice"] = "Magic",
	[31117] = "Magic",	--Unstable Affliction
	
	--Mage
	["Counterspell - Silenced"] = "Magic",
	["Invisibility"] = "none",
	["Polymorph"] = "Magic",
	["Presence of Mind"] = "Magic",
	["Arcane Power"] = "Magic",
	["Slow"] = "Magic",
	["Impact"] = "none",
	["Combustion"] = "Magic",
	["Dragon's Breath"] = "Magic",
	["Frost Nova"] = "Magic",
	["Ice Block"] = "Magic",
	["Icy Veins"] = "Magic",
	["Freeze"] = "Magic",
	["Frostbite"] = "Magic",
	["Hypothermia"] = "none",
	
	--Shaman
	["Stoneclaw Stun"] = "Magic",
	["Shamanistic Rage"] = "none",
	["Heroism"] = "Magic",
	["Bloodlust"] = "Magic",
	["Grounding Totem Effect"] = "none",	
	
	--Priest
	["Mind Control"] = "Magic",
	["Psychic Scream"] = "Magic",
	["Silence"] = "Magic",
	["Blackout"] = "Magic",
	["Power Infusion"] = "Magic",
	["Pain Suppression"] = "Magic",
	["Focused Will"] = "Magic",
	["Shackle Undead"] = "Magic",
	
	--Rogue
	["Cheap Shot"] = "none",
	["Kidney Shot"] = "none",
	["Garrote - Silence"] = "none",
	["Evasion"] = "none",
	["Gouge"] = "none",
	["Cloak of Shadows"] = "none",
	["Blind"] = "none",
	["Sap"] = "none",
	["Adrenaline Rush"] = "none",
	["Blade Flurry"] = "none",
	["Kick - Silenced"] = "none",
	["Cheating Death"] = "none",
	
	--Hunter
	["Bestial Wrath"] = "none",
	["The Beast Within"] = "none",
	["Intimidation"] = "none",
	["Scare Beast"] = "Magic",
	["Rapid Fire"] = "Magic",
	["Freezing Trap Effect"] = "Magic",
	["Improved Concussive Shot"] = "none",
	["Scatter Shot"] = "none",
	["Silencing Shot"] = "Magic",
	["Improved Wing Clip"] = "none",
	["Entrapment"] = "Magic",
	["Wyvern Sting"] = "Poison",
	["Counterattack"] = "none",
	
	--Warrior
	["Charge Stun"] = "none",
	["Berserker Rage"] = "none",
	["Intercept Stun"] = "none",
	["Intimidating Shout"] = "none",
	["Recklessness"] = "none",
	["Disarm"] = "none",
	["Shield Wall"] = "none",
	["Spell Reflection"] = "none",
	["Death Wish"] = "none",
	["Mace Stun Effect"] = "none",
	["Improved Hamstring"] = "none",
	["Sweeping Strikes"] = "none",
	["Last Stand"] = "none",
	["Concussion Blow"] = "none",
	["Shield Bash - Silenced"] = "none",
	["Revenge Stun"] = "none",
	
	--Paladin
	["Avenging Wrath"] = "Magic",
	["Forbearance"] = "none",
	["Repentance"] = "Magic",
	["Blessing of Freedom"] = "Magic",
	["Blessing of Protection"] = "Magic",
	["Divine Shield"] = "Magic",
	["Hammer of Justice"] = "Magic",
	["Divine Intervention"] = "Magic",
	["Stun"] = "Magic",
}

spellDB.trackAura.invisible = {
	["Battle Stance"] = "none",
	["Defensive Stance"] = "none",
	["Berserker Stance"] = "none",
	["Interrupt"] = "none",
	}
