tyrPlates.spellDB = {}

local spellDB = tyrPlates.spellDB

spellDB.trackAura = {}

--auras to be shown if your own
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

--auras to be shown on friendly players
spellDB.trackAura.friendlyPlayer = {

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

-- stores a predefined icon for the spell lockout aura
spellDB.spellSchoolIcon = {
	[2] = "Interface\\Icons\\Spell_Holy_HolyBolt",		--holy
	[4] = "Interface\\Icons\\Spell_Fire_SelfDestruct",	--fire
	[8] = "Interface\\Icons\\Spell_Nature_HealingTouch",--nature
	[16] = "Interface\\Icons\\Spell_Frost_FrostBlast",	--frost
	[32] = "Interface\\Icons\\Spell_Shadow_ShadowBolt",	--shadow
	[64] = "Interface\\Icons\\Spell_Arcane_StarFire"	--arcane
}


spellDB.getSpellId = {
	["Fear Ward"] = 6346,
	["Divine Intervention"] = 19753,
	["Heroism"] = 32182,
	["Bloodlust"] = 37067,
	["Hypothermia"] = 41425,	
	["Ice Barrier"] = 11426,	
	["Avenging Wrath"] = 31884,	
	["Shackle Undead"] = 9484,
	["Polymorph"] = 118,	
	["Combustion"] = 28682,	
	["Presence of Mind"] = 12043,	
	["Mind Control"] = 10912,
	["Power Infusion"] = 10060,
	["Earth Shield"] = 49284,
	["Icy Veins"] = 12472,
	["Arcane Power"] = 12042,
	["Soulstone Resurrection"] = 27239,
	["Enslave Demon"] = 11726,
	["Seduction"] = 6358,
	["Sacrifice"] = 27273,	
	["Entangling Roots"] = 339,
	["Innervate"] = 29166,
	["Hibernate"] = 18657,
	["Nature's Swiftness"] = 16188,	
	["Power Word: Shield"] = 10901,
	["Vampiric Touch"] = 34917,
	["Shadow Word: Pain"] = 10894,
	["Curse of Recklessness"] = 27226,
	["Fear"] = 5782,
}

-- stores auras that change casting speed with their cast speed modifier as value
spellDB.castSpeedChange = {
	["Icy Veins"] = 5/6,
	["Power Infusion"] = 5/6,
	["Curse of Tongues"] = 1.6,
	["Mind-Numbing Poison III"] = 1.6,
	["Slow"] = 1.5,
	["Bloodlust"] = 10/13,
	["Heroism"] = 10/13,
	--["Berserking"] = ,
}


spellDB.getTotemId = {
	["Earthbind Totem"] = 2484,
	--["Fire Elemental Totem"] = 2894,
	["Fire Nova Totem VII"] = 25547,
	["Magma Totem V"] = 25552,
	["Searing Totem VII"] = 25533,
	["Stoneclaw Totem VII"] = 25525,
	--["Earth Elemental Totem"] = 2062,
	["Fire Resistance Totem IV"] = 25563,
	["Frost Resistance Totem IV"] = 25560,
	["Nature Resistance Totem IV"] = 25574,
	["Flametongue Totem V"] = 25557,
	["Grace of Air Totem III"] = 25359,
	["Grounding Totem"] = 8177,
	["Sentry Totem"] = 6495,
	["Stoneskin Totem VIII"] = 25509,
	["Strength of Earth Totem VI"] = 25528,
	["Windfury Totem V"] = 25587,
	["Windwall Totem IV"] = 25577,
	["Wrath of Air Totem"] = 3738,
	["Disease Cleansing Totem"] = 8170,
	["Poison Cleansing Totem"] = 8166,
	["Healing Stream Totem VI"] = 25567,
	["Mana Spring Totem V"] = 25570,
	["Mana Tide Totem"] = 16190,
	["Tranquil Air Totem"] = 25908,
	["Tremor Totem"] = 8143,

}

-- auras that interrupt the targets current cast
spellDB.interruptsCast = {
	["Arcane Torrent"] = true,
	["War Stomp"] = true,
	["Cyclone"] = true,
	["Hibernate"] = true,
	["Starfire Stun"] = true,
	["Bash"] = true,
	["Maim"] = true,
	["Pounce"] = true,
	["Feral Charge Effect"] = true,
	["Shadowfury"] = true,
	["Pyroclasm"] = true,
	["Death Coil"] = true,
	["Fear"] = true,
	["Howl of Terror"] = true,
	["Banish"] = true,
	["Enslave Demon"] = true,
	["Seduction"] = true,
	["Spell Lock"] = true,
	["Counterspell - Silenced"] = true,
	["Polymorph"] = true,
	["Impact"] = true,
	["Unstable Affliction"] = true,
	["Dragon's Breath"] = true,
	["Ice Block"] = true,
	["Stoneclaw Stun"] = true,	
	["Mind Control"] = true,
	["Psychic Scream"] = true,
	["Silence"] = true,
	["Blackout"] = true,
	["Shackle Undead"] = true,
	["Cheap Shot"] = true,
	["Kidney Shot"] = true,
	["Garrote - Silence"] = true,
	["Gouge"] = true,
	["Blind"] = true,
	["Sap"] = true,
	["Kick - Silenced"] = true,
	["Intimidation"] = true,
	["Scare Beast"] = true,
	["Freezing Trap Effect"] = true,
	["Improved Concussive Shot"] = true,
	["Scatter Shot"] = true,
	["Silencing Shot"] = true,
	["Wyvern Sting"] = true,	
	["Charge Stun"] = true,
	["Intercept Stun"] = true,
	["Intimidating Shout"] = true,
	["Mace Stun Effect"] = true,
	["Concussion Blow"] = true,
	["Shield Bash - Silenced"] = true,
	["Revenge Stun"] = true,
	["Repentance"] = true,
	["Hammer of Justice"] = true,
	["Divine Intervention"] = true,
	["Stun"] = true,
}

-- channels that have a target
spellDB.channelWithTarget = {
	["Drain Life"] = 5, 	
	["Drain Mana"] = 5,		
	["Seduction"] = 15, 	
	["Mind Flay"] = 3,		
	["Drain Soul"] = 15,	
	["Health Funnel"] = 10,
	--["Arcane Missiles"] = 5, doesn't create a aura on the target
}

-- duration of channeled spells
spellDB.channelDuration = {
	["Blizzard"] = 8,		
	["Evocation"] = 8,		
	["Tranquility"] = 8,	
	["Hurricane"] = 10,		
	["Drain Life"] = 5, 	
	["Hellfire"] = 15, 		
	["Rain of Fire"] = 8, 
	["Drain Soul"] = 15,	
	["Drain Mana"] = 5,		
	["Health Funnel"] = 10, 
	--["Seduction"] = 15, special because it's a channel with a cast time, instead of being instant	
	["Volley"] = 6,			
	["Arcane Missiles"] = 5,
	["Mind Flay"] = 3,	
}

-- casts which base cast time can be reduced by talents
spellDB.reducedCastTime = {
	["Healing Wave"] = 0.5,
	["Lightning Bolt"] = 0.5,
	["Chain Lightning"] = 0.5,
	["Fireball"] = 0.5,
	["Frostbolt"] = 0.5,
	["Shadowbolt"] = 0.5,
	["Immolate"] = 0.5,
	["Soulfire"] = 2,
	["Wrath"] = 0.5,
	["Starfire"] = 0.5,
	["Healing Touch"] = 0.5,
	["Smite"] = 0.5,
	["Holy Fire"] = 0.5,
	["Heal"] = 0.5,
	["Greater Heal"] = 0.5,
	["Corruption"] = 2,
	--["Arcane Missiles"] = 1
}

-- abilities that interrupt the target
spellDB.interrupt = {
	["Pummel"] = 4,
	["Shield Bash"] = 6,	
	["Kick"] = 5,
	["Earth Shock"] = 2,
	["Counterspell"] = 8,
	["Spell Lock"] = 6,
	["Feral Charge"] = 4,
}


spellDB.ccCategories = {}

-- diminishing return groups in PvP
spellDB.ccCategories.PvP = {
	--GPS
	["Gouge"] = "GPS",
	["Sap"] = "GPS",
	["Maim"] = "GPS",
	["Polymorph"] = "GPS",
	["Repentance"] = "GPS",
	
	--stun
	["Bash"] = "stun",	
	["Cheap Shot"] = "stun",
	["Concussion Blow"] = "stun",
	["Charge Stun"] = "stun",
	["Intercept Stun"] = "stun",
	["Hammer of Justice"] = "stun",
	["Shadowfury"] = "stun",	
	["Pounce"] = "stun",
	["Intimidation"] = "stun",
	["War Stomp"] = "stun",
	
	--BC
	["Cyclone"] = "BC",
	["Blind"] = "BC",
	
	--stun proc
	["Starfire Stun"] = "stun proc",
	["Blackout"] = "stun proc",
	["Stun"] = "stun proc",
	["Pyroclasm"] = "stun proc",
	["Impact"] = "stun proc",
	["Improved Concussive Shot"] = "stun proc",
	["Revenge Stun"] = "stun proc",
	["Mace Stun Effect"] = "stun proc",	
	
	--root
	["Entangling Roots"] = "root",
	["Frost Nova"] = "root",
	["Counterattack"] = "root",
	["Freeze"] = "root",
	
	--snare
	["Improved Wing Clip"] = "snare",
	["Improved Hamstring"] = "snare",
	["Entrapment"] = "snare",
	["Frostbite"] = "snare",
	
	--fear
	["Fear"] = "feargroup",
	["Howl of Terror"] = "feargroup",
	["Psychic Scream"] = "feargroup",
	["Seduction"] = "feargroup",
	["Scare Beast"] = "feargroup",
	["Intimidating Shout"] = "feargroup",
	
	--sleep
	["Hibernate"] = "sleep",	
	["Wyvern Sting"] = "sleep",
	
	
	--self
	["Dragon's Breath"] = "self",
	["Scatter Shot"] = "self",
	["Death Coil"] = "self",
	["Mind Control"] = "self",
	["Freezing Trap Effect"] = "self",
	["Kidney Shot"] = "self",				
	["Feral Charge Effect"] = "self",
	["Disarm"] = "self",
}

-- diminishing return groups in PvP
spellDB.ccCategories.PvE = {

	--BC
	["Cyclone"] = "BC",
	["Blind"] = "BC",

	--stun
	["Hammer of Justice"] = "stun",
	["Cheap Shot"] = "stun",
	["War Stomp"] = "stun",
	["Bash"] = "stun",
	["Concussion Blow"] = "stun",
	["Charge Stun"] = "stun",
	["Intercept Stun"] = "stun",
	["Shadowfury"] = "stun",	
	["Pounce"] = "stun",
	["Intimidation"] = "stun",
	
	--stun proc
	["Starfire Stun"] = "stun proc",
	["Blackout"] = "stun proc",
	["Stun"] = "stun proc",
	["Pyroclasm"] = "stun proc",
	["Impact"] = "stun proc",
	["Improved Concussive Shot"] = "stun proc",
	["Revenge Stun"] = "stun proc",
	["Mace Stun Effect"] = "stun proc",	
	
	--self
	["Kidney Shot"] = "self",	--?	
}

spellDB.auraDuration = {}

-- aura duration on players
spellDB.auraDuration.PvP = {
	["Entangling Roots"] = 10,
	["Hibernate"] = 10,
	["Curse of Tongues"] = 12,
	["Fear"] = 10, 	
	["Seduction"] = 10,
	["Polymorph"] = 10,
	["Mind Control"] = 10,
	["Sap"] = 10,
	["Scare Beast"] = 10,
	["Freezing Trap Effect"] = 10,
	["Wyvern Sting"] = 10,
}
--[[
spellDB.auraDuration.PvP = {
	[26989] = 10, 	--Entangling Roots Rank 7
	[18658] = 10, 	--Hibernate Rank 3
	[11719] = 12, 	--Curse of Tongues
	[6215] = 10, 	--Fear
	[6358] = 10, 	--Seduction	
	[12826] = 10, 	--Polymorph
	[28271] = 10, 	--Polymorph
	[28272] = 10, 	--Polymorph
	[10912] = 10, 	--Mind Control
	[11297] = 10, 	--Sap
	[14327] = 10, 	--Scare Beast
	[14309] = 10, 	--Freezing Trap Effect
	[27068] = 10, 	--Wyvern Sting
}
]]


spellDB.auraDuration.PvEByName = {
	--Priest--
	--Priest Discipline
	["Divine Spirit"] = 1800,
	["Fear Ward"] = 180,
	["Focused Casting"] = 6,
	["Focused Will"] = 8,
	["Inner Fire"] = 1800,
	["Inner Focus"] = 0,
	["Levitate"] = 120,
	["Pain Suppression"] = 8,
	["Power Infusion"] = 15,
	["Power Word: Fortitude"] = 1800,
	["Power Word: Shield"] = 1800,
	["Prayer of Fortitude"] = 3600,
	["Prayer of Spirit"] = 3600,
	
	--Priest Holy	
	["Abolish Disease"] = 20,
	["Blessed Recovery"] = 6,
	["Blessed Resilience"] = 6,	
	["Inspiration"] = 15,
	["Holy Fire"] = 10,
	["Lightwell Renew"] = 6,
	["Prayer of Mending"] = 30,
	["Renew"] = 15,
	["Spirit of Redemption"] = 15,
	["Surge of Light"] = 10,
	
	--Priest Shadow		
	["Blackout"] = 3,
	["Fade"] = 10,
	["Mind Control"] = 60,
	["Mind Flay"] = 3,
	["Mind Soothe"] = 15,
	["Mind Vision"] = 60,
	["Misery"] = 24,
	["Prayer of Shadow Protection"] = 1200,
	["Psychic Scream"] = 8,
	["Shadow Protection"] = 600,
	["Shadow Word: Pain"] = 24,
	["Shadow Vulnerability"] = 15,
	["Shadowform"] = 0,
	["Silence"] = 5,
	["Spirit Tap"] = 15,
	["Vampiric Embrace"] = 60,
	["Vampiric Touch"] = 15,
	
	--Hunter--
	--Hunter Beastmaster
	["Aspect of the Beast"] = 0,
	["Aspect of the Cheetah"] = 0,
	["Aspect of the Hawk"] = 0,
	["Aspect of the Monkey"] = 0,
	["Aspect of the Pack"] = 0,
	["Aspect of the Viper"] = 0,
	["Aspect of the Wild"] = 0,
	["Bestial Wrath"] = 18,
	["Eagle Eye"] = 60,
	["Eyes of the Beast"] = 60,
	["Ferocious Inspiration"] = 10,
	["Intimidation"] = 3,
	["Mend Pet"] = 15,
	["Quick Shots"] = 12,
	["Spirit Bond"] = 0,
	["The Beast Within"] = 18,
	
	--Hunter Marksmanship
	["Concussive Shot"] = 4,
	["Improved Concussive Shot"] = 3,
	["Flare"] = 0,
	["Hunter's Mark"] = 120,
	["Rapid Fire"] = 15,
	["Scatter Shot"] = 4,
	["Scorpid Sting"] = 20,
	["Serpent Sting"] = 15,
	["Silencing Shot"] = 3,
	["Trueshot Aura"] = 0,
	["Viper Sting"] = 8,

	--Hunter Survival
	["Counterattack"] = 5,
	["Deterrence"] = 10,
	["Entrapment"] = 4,
	["Explosive Trap Effect"] = 0,
	["Expose Weakness"] = 7,
	["Feign Death"] = 360,
	["Frost Trap Aura"] = 0,	
	["Immolation Trap Effect"] = 15,	
	["Improved Wing Clip"] = 5,	
	["Master Tactician"] = 8,	
	["Misdirection"] = 30,	
	["Wing Clip"] = 10,		

	
	--Mage--
	--Mage Arcane
	["Amplify Magic"] = 600,	
	["Arcane Blast"] = 8,	
	["Arcane Brilliance"] = 3600,	
	["Arcane Intellect"] = 1800,	
	["Arcane Power"] = 15,	
	["Clearcasting"] = 15,	
	["Counterspell - Silenced"] = 4,
	["Dampen Magic"] = 600,	
	["Evocation"] = 8,		
	["Improved Blink"] = 4,		
	["Mage Armor"] = 1800,	
	["Mana Shield"] = 60,	
	["Presence of Mind"] = 0,	
	["Slow"] = 15,	
	["Slow Fall"] = 30,	
	
	--Mage Fire
	["Blast Wave"] = 6,
	["Blazing Speed"] = 8,
	["Dragon's Breath"] = 3,
	["Fire Ward"] = 30,
	["Molten Armor"] = 1800,
	["Impact"] = 2,
	["Ignite"] = 4,
	["Fire Vulnerability"] = 30,
	
	--Mage Frost
	["Chilled"] = 8,
	["Cone of Cold"] = 11,
	["Freeze"] = 8,
	["Frost Armor"] = 1800,
	["Frost Nova"] = 8,
	["Frost Ward"] = 30,
	["Frostbite"] = 5,
	["Frostbolt"] = 4,
	["Hypothermia"] = 30,
	["Ice Armor"] = 1800,
	["Ice Barrier"] = 60,
	["Ice Block"] = 10,
	["Icy Veins"] = 20,
	["Winter's Chill"] = 15,
	
	--Druid--
	--Druid Balance
	["Bark Skin"] = 12,	
	["Cyclone"] = 6,
	["Entangling Roots"] = 15,
	["Faerie Fire"] = 40,
	["Innervate"] = 20,
	["Insect Swarm"] = 12,
	["Moonfire"] = 12,
	["Nature's Grace"] = 15,
	["Nature's Grasp"] = 45,
	["Soothe Animal"] = 15,
	["Thorns"] = 600,
	
	--Druid Feral
	["Challenging Roar"] = 6,	
	["Dash"] = 15,	
	["Demoralizing Roar"] = 30,	
	["Feral Charge Effect"] = 4,	
	["Frenzied Regeneration"] = 10,	
	["Growl"] = 4,	
	["Lacerate"] = 15,	
	["Leader of the Pack"] = 0,	
	["Maim"] = 6,	
	["Mangle"] = 12,	
	["Pounce"] = 4,	
	["Pounce Bleed"] = 18,	
	["Rake"] = 9,	
	["Rip"] = 12,	
	["Tiger's Fury"] = 6,	
	
	--Druid Restoration
	["Abolish Poison"] = 8,	
	["Gift of the Wild"] = 3600,	
	["Lifebloom"] = 7,	
	["Mark of the Wild"] = 1800,	
	["Natural Perfection"] = 8,	
	["Nature's Swiftness"] = 0,	
	["Omen of Clarity"] = 1800,	
	["Regrowth"] = 21,	
	["Rejuvenation"] = 12,	
	["Tranquility"] = 8,	
	
	--Shaman--
	--Shaman Elemental
	["Earthbind"] = 4,	
	["Flame Shock"] = 12,	
	["Frost Shock"] = 12,	
	["Stoneclaw Stun"] = 3,	
	["Elemental Devastation"] = 10,	
	["Elemental Mastery"] = 0,	
	
	--Shaman Enhancement	
	["Bloodlust"] = 40,	
	["Heroism"] = 40,	
	["Far Sight"] = 60,	
	["Flurry"] = 15,	
	["Focused"] = 15,	
	["Grounding Totem Effect"] = 0,	
	["Lightning Shield"] = 600,	
	["Sentry Totem"] = 300,	
	["Shamanistic Rage"] = 15,	
	["Stormstrike"] = 12,	
	["Unleashed Rage"] = 10,	
	["Water Breathing"] = 600,	
	["Water Walking"] = 600,	
	
	--Shaman Restoration
	["Earth Shield"] = 600,	
	["Healing Way"] = 15,	
	["Water Shield"] = 600,	
	
	--Warlock--
	--Warlock Affliction
	["Amplify Curse"] = 30,		
	["Corruption"] = 18,		
	["Curse of Agony"] = 24,		
	["Curse of Doom"] = 60,		
	["Curse of Exhaustion"] = 12,		
	["Curse of Recklessness"] = 120,		
	["Curse of Elements"] = 300,		
	["Curse of Tongues"] = 30,		
	["Curse of Weakness"] = 120,		
	["Death Coil"] = 3,		
	["Drain Life"] = 5,		
	["Drain Mana"] = 5,		
	["Drain Soul"] = 15,		
	["Seed of Corruption"] = 18,		
	["Siphon Life"] = 30,		
	["Unstable Affliction"] = 18,		
	["Shadow Trance"] = 10,		
	["Shadow Embrace"] = 0,		
	
	--Warlock Demonology
	["Soulstone Resurrection"] = 1800,		
	["Demon Armor"] = 1800,		
	["Demon Skin"] = 1800,		
	["Detect Invisibility"] = 600,		
	["Enslave Demon"] = 300,		
	["Eye of Kilrogg"] = 45,		
	["Fel Armor"] = 1800,		
	["Health Funnel"] = 10,		
	["Shadow Ward"] = 30,		
	["Unending Breath"] = 600,		
	["Blood Pact"] = 0,		
	["Phase Shift"] = 0,		
	["Suffering"] = 15,		
	["Sacrifice"] = 30,		
	["Consume Shadows"] = 10,		
	["Shadows Consumed"] = 600,		
	["Seduction"] = 15,		
	["Soothing Kiss"] = 10,		
	["Paranoia"] = 0,		
	["Spell Lock"] = 3,		
	["Fel Domination"] = 15,		
	["Demonic Sacrifice"] = 3600,		
	["Soul Link"] = 0,		
	
	--Warlock Destruction
	["Hellfire"] = 15,		
	["Immolate"] = 15,		
	["Aftermath"] = 5,		
	["Shadowburn"] = 5,		
	["Pyroclasm"] = 3,		
	["Nether Protection"] = 4,		
	["Backlash"] = 8,		
	["Shadowfury"] = 2,	

	--Paladin--
	--Paladin Holy
	["Blessing of Light"] = 600,				
	["Blessing of Wisdom"] = 600,		
	["Divine Favor"] = 0,		
	["Divine Illumination"] = 15,		
	["Greater Blessing of Light"] = 1800,	
	["Greater Blessing of Wisdom"] = 1800,	
	["Seal of Light"] = 30,	
	["Seal of Righteousness"] = 30,	
	["Seal of Wisdom"] = 30,		
	["Turn Evil"] = 20,		
	["Lay on Hands"] = 120,		
	["Light's Grace"] = 15,		
	
	--Paladin Protection
	["Blessing of Freedom"] = 14,
	["Blessing of Sacrifice"] = 30,		
	["Blessing of Kings"] = 600,	
	["Greater Blessing of Kings"] = 1800,			
	["Blessing of Salvation"] = 600,
	["Greater Blessing of Salvation"] = 1800,		
	["Blessing of Sanctuary"] = 600,		
	["Greater Blessing of Sanctuary"] = 1800,			
	["Concentration Aura"] = 0,		
	["Devotion Aura"] = 0,		
	["Divine Intervention"] = 180,		
	["Fire Resistance Aura"] = 0,		
	["Frost Resistance Aura"] = 0,		
	["Shadow Resistance Aura"] = 0,		
	["Righteous Fury"] = 1800,		
	["Seal of Justice"] = 30,	
	
	--Paladin Retribution
	["Avenging Wrath"] = 20,
	["Forbearance"] = 60,
	["Blessing of Might"] = 600,
	["Crusader Aura"] = 0,
	["Sanctity Aura"] = 0,
	["Greater Blessing of Might"] = 1800,
	["Retribution Aura"] = 0,
	["Seal of the Crusader"] = 30,
	["Seal of Command"] = 30,
	["Aura of the Crusader"] = 10,
	["Judgement of Justice"] = 20,
	["Judgement of Light"] = 20,
	["Judgement of Wisdom"] = 20,
	["Judgement of the Crusader"] = 20,
	["Vindication"] = 15,
	["Vengeance"] = 30,
	["Repentance"] = 6,
	
	--Warrior--
	--Warrior Arms
	["Charge Stun"] = 1.5,	
	["Hamstring"] = 15,	
	["Improved Hamstring"] = 5,	
	["Mocking Blow"] = 6,	
	["Rend"] = 15,	
	["Retaliation"] = 21,	
	["Thunder Clap"] = 10,	
	["Deep Wound"] = 12,	
	["Death Wish"] = 30,	
	["Mace Stun Effect"] = 3,	
	["Mortal Strike"] = 10,	
	["Second Wind"] = 10,	
	
	--Warrior Fury
	["Battle Shout"] = 120,		
	["Berserker Rage"] = 10,		
	["Challenging Shout"] = 6,		
	["Commanding Shout"] = 120,		
	["Demoralizing Shout"] = 30,		
	["Intimidating Shout"] = 8,		
	["Intercept Stun"] = 3,		
	["Recklessness"] = 21,		
	["Piercing Howl"] = 6,		
	["Blood Craze"] = 6,		
	["Sweeping Strikes"] = 10,				
	["Bloodthirst"] = 8,				
	["Rampage"] = 30,				
	
	--Warrior Protection
	["Bloodrage"] = 10,	
	["Disarm"] = 13,	
	["Revenge Stun"] = 3,	
	["Shield Block"] = 6,	
	["Shield Wall"] = 16,	
	["Spell Reflection"] = 5,	
	["Sunder Armor"] = 30,	
	["Taunt"] = 3,	
	["Last Stand"] = 20,	
	["Concussion Blow"] = 5,	
	["Shield Bash - Silenced"] = 3,	
	
	--Rogue--
	--Rogue Assasination
	--Rogue Multilate
	--Rogue Subtlety

}	

-- aura duration on NPCs
spellDB.auraDuration.PvE = {
[66] = 5, --Invisibility
[1022] = 6, --Blessing of Protection
[5599] = 8, --Blessing of Protection
[10278] = 10, --Blessing of Protection
[2878] = 10, --Turn Undead
[5627] = 15, --Turn Undead
[19725] = 20, --Turn Undead (NPC)
[8921] = 9, --Moonfire (Rank 1)
[32173] = 8, --Entangling Roots (NPC)
[35234] = 8, --Entangling Roots (NPC)
[12747] = 10, --Entangling Roots (NPC)
[22127] = 10, --Entangling Roots (NPC)
[22415] = 10, --Entangling Roots (NPC)
[24648] = 10, --Entangling Roots (NPC)
[37823] = 10, --Entangling Roots (NPC)
[5276] = 15, -- Freeze (NPC)
[18763] = 15, -- Freeze (NPC)
[16350] = 10, -- Freeze (NPC)
[12557] = 8, --Cone of Cold (NPC)
[15244] = 8, --Cone of Cold (NPC)
[31117] = 5, --Unstable Affliction
[1020] = 12, --Divine Shield (Rank 2)
[33581] = 10, --Divine Shield (NPC)
[13874] = 8, --Divine Shield (NPC)
[10912] = 60, --Mind Control
[14327] = 20, --Scare Beast
[27068] = 12, --Wyvern Sting (CC Rank 4)	
[27069] = 12, --Wyvern Sting (DoT Rank 4)
[11297] = 45, --Sap
[38764] = 5, --Gouge
[118] = 50, --Polymorph (Rank 1)
[339] = 12, --Entangling Roots (Rank 1)
[498] = 12, --Divine Protection
[642] = 10, --Divine Shield (Rank 1)
[673] = 3600, --Lesser Armor
[694] = 6, --Mocking Blow
[982] = 3, --Revive Pet
[1038] = 10, --Hand of Salvation
[1044] = 14, --Hand of Freedom
[1330] = 3, --Garrote - Silence
[1513] = 20, --Scare Beast (Rank 1)
[1539] = 10, --Feed Pet
[1604] = 4, --Dazed
[1776] = 4, --Gouge
[1784] = 0, --Stealth
[1833] = 4, --Cheap Shot
[1953] = 1, --Blink
[2094] = 10, --Blind
[2367] = 3600, --Lesser Strength
[2374] = 3600, --Lesser Agility
[2378] = 3600, --Health
[2479] = 30, --Honorless Target
[2584] = 0, --Waiting to Resurrect
[2645] = 0, --Ghost Wolf
[2895] = 0, --Wrath of Air Totem
[3166] = 3600, --Lesser Intellect
[3355] = 10, --Freezing Trap Effect (Rank 1)
[3409] = 12, --Crippling Poison
[3436] = 300, --Wandering Plague
[3714] = 600, --Path of Frost
[4167] = 4, --Web (Rank 1)
[5209] = 6, --Challenging Roar
[5215] = 0, --Prowl
[5229] = 10, --Enrage
[5484] = 6, --Howl of Terror (Rank 1)
[5760] = 10, --Mind-numbing Poison
[6215] = 20, --Fear (Rank 3)
[6562] = 0, --Heroic Presence (Racial Passive)
[6653] = 0, --Dire Wolf
[6770] = 60, --Sap (Rank 1)
[6774] = 6,  --Slice and Dice (Rank 2)
[6788] = 15, --Weakened Soul
[7353] = 60, --Cozy Fire
[7744] = 5, --Will of the Forsaken (Racial)
[7870] = 300, --Lesser Invisibility
[8212] = 1200, --Enlarge
[8219] = 3600, --Flip Out
[8220] = 3600, --Flip Out
[8221] = 3600, --Yaaarrrr
[8222] = 3600, --Yaaarrrr
[8326] = 0, --Ghost
[8385] = 3600, --Swift Wind
[8395] = 0, --Emerald Raptor
[8515] = 0, --Windfury Totem (Rank 1)
[8643] = 6, --Kidney Shot (Rank 2)
[8647] = 6, --Expose Armor
[8983] = 5, --Bash (Rank 3)
[9484] = 30, --Shackle Undead (Rank 1)
[9485] = 40, --Shackle Undead (Rank 2)
[10278] = 10, --Hand of Protection (Rank 3)
[10308] = 6, --Hammer of Justice (Rank 4)
[10796] = 0, --Turquoise Raptor
[10799] = 0, --Violet Raptor
[10955] = 50, --Shackle Undead (Rank 3)
[11196] = 60, --Recently Bandaged
[11305] = 15, --Sprint (Rank 3)
[12043] = 0, --Presence of Mind
[13750] = 15, --Adrenaline Rush
[13877] = 15, --Blade Flurry
[14149] = 20, --Remorseless (Rank 2)
[14177] = 0, --Cold Blood
[14203] = 12, --Enrage (Rank 4)
[14267] = 0, --Horde Flag
[14268] = 0, --Alliance Flag
[14278] = 7, --Ghostly Strike
[14308] = 15, --Freezing Trap Effect (Rank 2)
[14309] = 20, --Freezing Trap Effect (Rank 3)
[15007] = 600, --Resurrection Sickness (assuming level 20+)
[15571] = 4,  --Dazed
[15588] = 10, --Thunderclap (NPC)
[15708] = 5, --Mortal Strike (NPC)
[16166] = 30, --Elemental Mastery
[16236] = 15, --Ancestral Fortitude (Rank 2)
[16237] = 15, --Ancestral Fortitude (Rank 3)
[16468] = 0, --Mother's Milk
[16567] = 600, --Tainted Mind
[16609] = 3600, --Warchief's Blessing
[17539] = 7200, --Greater Arcane Elixir
[17619] = 0, --Alchemist's Stone
[17670] = 0, --Argent Dawn Commission
[17800] = 30, --Shadow Mastery
[17928] = 8, --Howl of Terror (Rank 2)
[17962] = 6, --Conflagrate
[18425] = 2, --Silenced - Improved Kick
[18498] = 3, --Silenced - Gag Order
[18499] = 10, --Berserker Rage
[18647] = 30, --Banish (Rank 2)
[2637] = 20, --Hibernate (Rank 1)
[18657] = 30, --Hibernate (Rank 2)
[18990] = 0, --Brown Kodo
[19136] = 0, --Stormbolt
[19615] = 8,  --Frenzy Effect (Rank 1)
[19683] = 900, --Tame Armored Scorpid
[19821] = 5, --Arcane Bomb
[20580] = 0, --Shadowmeld
[20005] = 5, --Chilled (NPC)
[20007] = 15, --Holy Strength
[20132] = 10, --Redoubt
[20170] = 2, --Stun
[20178] = 8, --Reckoning
[20253] = 3, --Intercept (Rank 1)
[20549] = 2, --War Stomp (Racial)
[20572] = 15, --Blood Fury (Racial)
[20578] = 10, --Cannibalize
[20736] = 6, --Distracting Shot
[21183] = 20, --Heart of the Crusader (Rank 1)
[22812] = 12, --Barkskin
[22842] = 10, --Frenzied Regeneration
[22888] = 7200, --Rallying Cry of the Dragonslayer
[22911] = 0, --Charge
[23033] = 0, --Battle Standard
[23036] = 0, --Battle Standard
[23161] = 0, --Dreadsteed (Summon)
[23214] = 0, --Charger (Summon)
[23219] = 0, --Swift Mistsaber
[23221] = 0, --Swift Frostsaber
[23227] = 0, --Swift Palomino
[23228] = 0, --Swift White Steed
[23229] = 0, --Swift Brown Steed
[23238] = 0, --Swift Brown Ram
[23239] = 0, --Swift Gray Ram
[23240] = 0, --Swift White Ram
[23241] = 0, --Swift Blue Raptor
[23242] = 0, --Swift Olive Raptor
[23243] = 0, --Swift Orange Raptor
[23246] = 0, --Purple Skeletal Warhorse
[23247] = 0, --Great White Kodo
[23248] = 0, --Great Gray Kodo
[23249] = 0, --Great Brown Kodo
[23250] = 0, --Swift Brown Wolf
[23251] = 0, --Swift Timber Wolf
[23252] = 0, --Swift Gray Wolf
[23333] = 0, --Warsong Flag
[23335] = 0, --Silverwing Flag
[23338] = 0, --Swift Stormsaber
[23451] = 10, --Speed
[23493] = 10, --Restoration
[23693] = 120, --Stormpike's Salvation
[23978] = 10, --Speed
[24378] = 60, --Berserking
[24450] = 0, --Prowl (Rank 1)
[24452] = 0, --Prowl (Rank 2)
[24907] = 0, --Moonkin Aura
[25046] = 2, --Arcane Torrent (Racial)
[25809] = 12, --Crippling Poison (Rank 1)
[25810] = 12, --Mind-numbing Poison
[26004] = 1800, --Mistletoe
[26013] = 900, --Deserter
[26297] = 10, --Berserking (Racial)
[26669] = 15, --Evasion (Rank 2)
[26864] = 15, --Hemorrhage (Rank 4)
[26888] = 10, --Vanish (Rank 3)
[27089] = 30, --Drink
[28093] = 15, --Lightning Speed
[28497] = 3600, --Mighty Agility
[28520] = 7200, --Flask of Relentless Assault
[28730] = 2, --Arcane Torrent (Racial)
[28878] = 0, --Heroic Presence (Racial Passive)
[29348] = 3600, --Goldenmist Special Brew
[29703] = 6, --Dazed
[30070] = 0, --Blood Frenzy (Rank 2)
[30708] = 0, --Totem of Wrath
[31224] = 5, --Cloak of Shadows
[31579] = 0, --Arcane Empowerment (Rank 1)
[31583] = 0, --Arcane Empowerment (Rank 3)
[31616] = 10, --Nature's Guardian
[31665] = 6, --Master of Subtlety
[31790] = 3, --Righteous Defense
[32600] = 10, --Avoidance
[32612] = 0, --Invisibility
[32851] = 10, --Demonic Frenzy
[33256] = 1800, --Well Fed
[33263] = 1800, --Well Fed
[33268] = 1800, --Well Fed
[33280] = 0, --Corporal
[33357] = 15, --Dash (Rank 3)
[33660] = 0, --Swift Pink Hawkstrider
[33697] = 15, --Blood Fury (Racial)
[33721] = 3600, --Spellpower Elixir
[33891] = 0, --Tree of Life (Shapeshift)
[33943] = 0, --Flight Form (Shapeshift)
[34027] = 30, --Kill Command (Rank 1)
[34123] = 0, --Tree of Life (Passive)
[34321] = 10, --Call of the Nexus
[34655] = 8, --Deadly Poison
[35098] = 20, --Rapid Killing (Rank 1)
[35099] = 20, --Rapid Killing (Rank 2)
[35101] = 4, --Concussive Barrage
[35696] = 0, --Demonic Knowledge
[35706] = 0, --Master Demonologist
[36444] = 0, --Wintergrasp Water
[36554] = 3, --Shadowstep
[36563] = 10, --Shadowstep
[37795] = 0, --Recruit
[39627] = 3600, --Elixir of Draenic Wisdom
[40623] = 3600, --Apexis Vibrations
[40625] = 5400, --Apexis Emanations
[42138] = 7200, --Brewfest Enthusiast
[42292] = 0, --PvP Trinket
[42650] = 4, --Army of the Dead
[42891] = 0, --Pyroblast (Rank 12)
[43180] = 30, --Food
[43183] = 30, --Drink
[43196] = 1800, --Armor (Rank 6)
[43265] = 0, --Death and Decay (Rank 1)
[43680] = 60, --Idle
[43681] = 60, --Inactive
[43688] = 0, --Amani War Bear
[43751] = 10, --Energized
[43771] = 3600, --Well Fed
[43900] = 0, --Swift Brewfest Ram
[43927] = 0, --Cenarion War Hippogryph
[44151] = 0, --Turbo-Charged Flying Machine
[44153] = 0, --Flying Machine
[44401] = 15, --Missile Barrage
[44413] = 10, --Incanter's Absorption
[44521] = 0, --Preparation
[44535] = 6, --Spirit Heal
[44572] = 5, --Deep Freeze
[44795] = 0, --Parachute
[45182] = 3, --Cheating Death
[45282] = 8, --Natural Perfection (Rank 2)
[45283] = 8, --Natural Perfection (Rank 3)
[45373] = 7200, --Bloodberry
[45472] = 60, --Parachute
[45524] = 10, --Chains of Ice
[45529] = 20, --Blood Tap
[45544] = 8, --First Aid (Rank 15)
[45548] = 30, --Food
[46168] = 0, --Pet Biscuit
[46199] = 0, --X-51 Nether-Rocket X-TREME
[46356] = 300, --Blood Elf Illusion
[46628] = 0, --Swift White Hawkstrider
[46833] = 15, --Wrath of Elune
[46857] = 60, --Trauma (Rank 2)
[46202] = 10, --Pierce Armor
[57107] = 3600, --Well Fed
[25040] = 900, --Mark of Nature
[53747] = 3600, --Elixir of Spirit
[57565] = 0, --Fel Intelligence (Rank 3)
[45123] = 0, --Romantic Picnic
[23844] = 0, --Master Demonologist
[28682] = 0, --Combustion
[32752] = 5, --Summoning Disorientation
[33257] = 1800, --Well Fed
[50434] = 10, --Icy Clutch
[11396] = 3600, --Greater Intellect
[8272] = 600, --Mind Tremor
[3593] = 3600, --Elixir of Fortitude
[10403] = 0, --Stoneskin (Rank 4)
[11841] = 600, --Static Barrier
[11334] = 3600, --Greater Agility
[16711] = 300, --Grow
[28491] = 3600, --Healing Power
[24453] = 0, --Prowl (Rank 3)
[16511] = 15, --Hemorrhage (Rank 1)
[10668] = 3600, --Spirit of Boar
[48846] = 20, --Runic Infusion
[52419] = 10, --Deflection
[48102] = 1800, --Stamina (Level 6)
[66808] = 15, --Meteor Fists
[18989] = 0, --Gray Kodo
[8119] = 1800, --Strength (Rank 2)
[46355] = 300, --Blood Elf Illusion
[23829] = 0, --Master Demonologist
[8117] = 1800, --Agility (Rank 3)
[14030] = 6, --Hooked Net
[48108] = 10, --Hot Streak
[17038] = 1200, --Winterfall Firewater
[28694] = 900, --Dreaming Glory
[33254] = 1800, --Well Fed
[62305] = 4, --Master's Call
[12178] = 1800, --Stamina (Level 4)
[11328] = 3600, --Agility
[44614] = 9, --Frostfire Bolt (Rank 1)
[28518] = 3600, --Flask of Fortification
[19705] = 900, --Well Fed
[20903] = 10, --Aimed Shot (Rank 5)
[17628] = 7200, --Supreme Power
[8314] = 3600, --Rock Skin
[8096] = 1800, --Intellect (Rank 1)
[49005] = 20, --Mark of Blood
[3219] = 3600, --Weak Troll's Blood Elixir
[7844] = 3600, --Fire Power
[6114] = 300, --Raptor Punch
[23760] = 0, --Master Demonologist
[26276] = 7200, --Greater Firepower
[17535] = 7200, --Elixir of the Sages
[21163] = 1800, --Polished Armor (Rank 1)
[48058] = 30, --Crystal Bloom
[12024] = 5, --Net
[744] = 30, --Poison
[19706] = 900, --Well Fed
[3220] = 3600, --Armor
[47748] = 45, --Rift Shield
[45716] = 40, --Torch Tossing Training
[11572] = 9, --Rend (Rank 1)
[11572] = 12, --Rend (Rank 2)
[11572] = 18, --Rend (Rank 4)
[11572] = 21, --Rend (Rank 5)
[11572] = 21, --Rend (Rank 6)
[11572] = 21, --Rend (Rank 7)
[11572] = 21, --Rend (Rank 8)
[42728] = 60, --Dreadful Roar
[28747] = 600, --Frenzy
[11349] = 3600, --Armor
[47781] = 6, --Spellbreaker
[42705] = 60, --Enrage
[116] = 8, --Frostbolt (Rank 1)
[205] = 9, --Frostbolt (Rank 2)
[172] = 12, --Corruption (Rank 1)
[6222] = 15, --Corruption (Rank 2)
[43182] = 30, --Drink
[3248] = 6, --Improved Blocking
[34410] = 3600, --Hellscream's Warsong
[42833] = 8, --Fireball (Rank 16)
[29882] = 0, --Loose Mana
[25527] = 0, --Strength of Earth (Rank 6)
[26867] = 14, --Rupture (Rank 7)
[133] = 4, --Fireball (Rank 1)
[17464] = 0, --Brown Skeletal Horse
[25467] = 23, --Devouring Plague (Rank 7)
[2947] = 180, --Fire Shield (Rank 1)
[8042] = 8, --Earth Shock (Rank 1)
[8045] = 8, --Earth Shock (Rank 3)
[18267] = 30, --Curse of Weakness (NPC)
[6268] = 3, --Rushing Charge (Rank 1)
[18070] = 30, --Earthborer Acid
[46221] = 180, --Animal Blood
[29334] = 3600, --Toasted Smorc
[6278] = 60, --Creeping Mold
[5262] = 10, --Fanatic Blade
[12541] = 600, --Ghoul Rot
[5782] = 10, --Fear (Rank 1)
[46899] = 900, --Well Fed
[42702] = 10, --Decrepify
[8076] = 0, --Strength of Earth (Rank 1)
[25569] = 0, --Mana Spring (Rank 5)
[5280] = 45, --Razor Mane (Rank 1)
[43664] = 15, --Unholy Rage
[8242] = 2, --Shield Slam
[26884] = 18, --Garrote (Rank 8)
[8202] = 1200, --Sapta Sight
[42740] = 8, --Njord's Rune of Protection
[48095] = 0, --Intense Cold
[20800] = 21, --Immolate (NPC)
[27187] = 12, --Deadly Poison VII (Rank 7)
[18266] = 15, --Curse of Agony (NPC)
[29235] = 3600, --Fire Festival Fortitude
[26968] = 12, --Deadly Poison VI (Rank 6)
[11348] = 3600, --Greater Armor
[25454] = 8, --Earth Shock (Rank 8)
[25207] = 1800, --Amulet of the Moon
[8316] = 180, --Fire Shield (Rank 2)
[6343] = 14, --Thunder Clap (Rank 2)
[6343] = 18, --Thunder Clap (Rank 3)
[6343] = 22, --Thunder Clap (Rank 4)
[6343] = 26, --Thunder Clap (Rank 5)
[6343] = 30, --Thunder Clap (Rank 6)
[6343] = 30, --Thunder Clap (Rank 7)
[11390] = 3600, --Arcane Elixir
[432] = 24, --Drink
[47283] = 8, --Empowered Imp
[8599] = 120, --Enrage
[19709] = 900, --Well Fed
[38232] = 20, --Battle Shout (NPC)
[33702] = 15, --Blood Fury (Racial)
[31462] = 3600, --Moonwell Restoration
[24586] = 10, --Scorpid Poison (Rank 3)
[37578] = 5, --Debilitating Strike
[8156] = 0, --Stoneskin (Rank 2)
[17462] = 0, --Red Skeletal Horse
[28521] = 3600, --Flask of Blinding Light
[42723] = 2, --Dark Smash
[46352] = 3600, --Fire Festival Fury
[580] = 0, --Timber Wolf
[36702] = 0, --Fiery Warhorse
[21049] = 30, --Bloodlust (NPC)
[47699] = 300, --Crystal Bark
[45444] = 0, --Bonfire's Blessing
[47747] = 45, --Charge Rifts
[47779] = 4, --Arcane Torrent
[25746] = 15, --Damage Absorb
[1127] = 27, --Food
[8898] = 1200, --Sapta Sight
[5171] = 15,  --Slice and Dice (Rank 1)
[29073] = 30, --Food
[7947] = 60, --Localized Toxin
[7948] = 20, --Wild Regeneration
[22766] = 0, --Sneak (Rank 1)
[3603] = 15, --Distracting Pain
[6432] = 10, --Smite Stomp
[113] = 15, --Chains of Ice (Rank 1)
[5171] = 12, --Slice and Dice (Rank 1)
[9821] = 15, --Dash (Rank 2)
[6713] = 5, --Disarm (NPC)
[28273] = 600, --Bloodthistle
[7483] = 300, --Howling Rage
[7484] = 300, --Howling Rage
[6466] = 3, --Axe Toss
[29333] = 3600, --Midsummer Sausage
[17627] = 3600, --Distilled Wisdom
[27863] = 600, --The Baron's Ultimatum
[5213] = 15, --Molten Metal
[19974] = 15, --Entangling Roots (Rank 2)
[20006] = 12, --Unholy Curse
[30991] = 0, --Stealth
[6253] = 2, --Backhand
[9672] = 4, --Frostbolt (NPC)
[8040] = 15, --Druid's Slumber
[16739] = 300, --Orb of Deception
[3140] = 8, --Fireball (Rank 4)
[6016] = 20, --Pierce Armor
[7038] = 60, --Forsaken Skill: Swords
[7039] = 60, --Forsaken Skill: Axes
[7040] = 60, --Forsaken Skill: Daggers
[7041] = 60, --Forsaken Skill: Maces
[7042] = 60, --Forsaken Skill: Staves
[7044] = 60, --Forsaken Skill: Guns
[7045] = 60, --Forsaken Skill: 2H Axes
[8066] = 120, --Shrink
[7049] = 60, --Forsaken Skill: Fire
[7053] = 60, --Forsaken Skill: Shadow
[7057] = 300, --Haunting Spirits
[5277] = 15, --Evasion (Rank 1)
[7322] = 10, --Frostbolt (Rank 4)
[7068] = 15, --Veil of Shadow
[6306] = 30, --Acid Splash
[7072] = 60, --Wild Rage
[7074] = 5, --Screams of the Past
[7046] = 60, --Forsaken Skill: 2H Maces
[7047] = 60, --Forsaken Skill: 2H Swords
[42777] = 0, --Swift Spectral Tiger
[435] = 24, --Food
[8365] = 10, --Enlarge
[430] = 18, --Drink
[14143] = 20, --Remorseless (Rank 1)
[8379] = 10, --Disarm (NPC)
[700] = 20, --Sleep (Rank 1)
[8041] = 10, --Serpent Form (Shapeshift)
[8112] = 1800, --Spirit (Rank 1)
[33720] = 7200, --Onslaught Elixir
[10405] = 0, --Stoneskin (Rank 6)
[7295] = 10, --Soul Drain
[431] = 21, --Drink
[7481] = 300, --Howling Rage
[26522] = 1800, --Lunar Fortune
[19386] = 6, --Wyvern Sting (Rank 1)
[29335] = 3600, --Elderberry Pie
[7621] = 10, --Arugal's Curse
[7051] = 60, --Forsaken Skill: Holy
[703] = 18, --Garrote (Rank 1)
[28274] = 1200, --Bloodthistle Withdrawal
[1850] = 15, --Dash (Rank 1)
[19434] = 10, --Aimed Shot (Rank 1)
[8140] = 15, --Befuddlement (Rank 1)
[7121] = 10, --Anti-Magic Shield
[29332] = 3600, --Fire-toasted Bun
[7124] = 300, --Arugal's Gift
[7125] = 120, --Toxic Saliva
[7127] = 60, --Wavering Will
[8148] = 0, --Thorns Aura
[18381] = 30, --Cripple (Rank 1)
[7054] = 300, --Forsaken Skills
[7389] = 15, --Attack
[7399] = 4, --Terrify
[8382] = 45, --Leech Poison
[7140] = 5, --Expose Weakness (NPC)
[8162] = 0, --Strength of Earth (Rank 2)
[5159] = 20, --Melt Ore
[8398] = 8, --Frostbolt Volley
[2944] = 24, --Devouring Plague (Rank 1)
[434] = 21, --Food
[2983] = 15, --Sprint (Rank 1)
[853] = 3, --Hammer of Justice (Rank 1)
[5115] = 6, --Battle Command
[1159] = 6, --First Aid (Rank 2)
[27065] = 10, --Aimed Shot (Rank 7)
[45693] = 0, --Torches Caught
[3427] = 30, --Infected Wound
[837] = 9, --Frostbolt (Rank 3)
[43197] = 1800, --Spirit (Rank 6)
[13797] = 15, --Immolation Trap (Rank 1)
[21069] = 6, --Larva Goo
[8101] = 1800, --Stamina (Level 3)
[64128] = 4, --Body and Soul
[33053] = 7200, --Mr Pinchy's Blessing
[18610] = 8, --First Aid (Rank 10)
[23768] = 7200, --Sayge's Dark Fortune of Damage
[13704] = 6, --Psychic Scream (NPC)
[5588] = 4, --Hammer of Justice (Rank 2)
[45062] = 0, --Holy Energy
[24870] = 900, --Well Fed
[14251] = 30, --Riposte
[8157] = 0, --Stoneskin (Rank 3)
[12255] = 900, --Curse of Tuten'kash
[3583] = 60, --Deadly Poison
[10730] = 10, --Pacify
[10734] = 3, --Hail Storm
[32727] = 0, --Arena Preparation
[11273] = 10, --Rupture (Rank 4)
[5137] = 60, --Call of the Grave
[12826] = 50, --Polymorph (Rank 4)
[28271] = 50, --Polymorph Turtle
[28272] = 50, --Polymorph Pig
[28703] = 900, --Netherbloom Pollen
[21062] = 30, --Putrid Breath
[2070] = 35, --Sap (Rank 2)
[3604] = 8, --Tendon Rip
[8263] = 0, --Elemental Protection Totem Aura (Rank 1)
[8267] = 600, --Cursed Blood
[43195] = 1800, --Intellect (Rank 6)
[20615] = 3, --Intercept (Rank 3)
[10838] = 8, --First Aid (Rank 7)
[11876] = 3, --War Stomp
[15976] = 10, --Puncture
[11397] = 300, --Diseased Shot
[2602] = 15, --Fire Shield IV
[12946] = 10, --Putrid Stench
[6742] = 30, --Bloodlust (NPC)
[5211] = 3, --Bash (Rank 1)
[6798] = 4, --Bash (Rank 2)
[11445] = 60, --Bone Armor
[14515] = 15, --Dominate Mind
[25941] = 900, --Well Fed
[8391] = 3, --Ravage
[3639] = 6, --Improved Blocking
[8399] = 10, --Sleep
[8407] = 11, --Frostbolt (Rank 6)
[21909] = 8, --Dust Field
[12523] = 12, --Pyroblast (Rank 4)
[12531] = 8, --Chilling Touch
[10491] = 0, --Mana Spring (Rank 2)
[1062] = 15, --Entangling Roots (Rank 2)
[32736] = 5, --Mortal Strike (NPC)
[25606] = 1800, --Pendant of the Agate Shield
[25694] = 900, --Well Fed
[25702] = 21, --Food
[12627] = 0, --Disease Cloud
[11641] = 10, --Hex
[30931] = 20, --Battle Shout (NPC)
[12890] = 15, --Deep Slumber
[13218] = 15, --Wound Poison (Rank 1)
[13222] = 15, --Wound Poison II (Rank 2)
[28489] = 3600, --Camouflage
[8639] = 16, --Rupture (Rank 2)
[24425] = 7200, --Spirit of Zandalar
[20925] = 10, --Holy Shield (Rank 1)
[10458] = 8, --Frostbrand Attack (Rank 3)
[12795] = 120, --Frenzy
[39318] = 0, --Tan Riding Talbuk
[18658] = 40, --Hibernate (Rank 3)
[676] = 13, --Disarm
[18972] = 20, --Slow (NPC)
[6213] = 15, --Fear (Rank 2)
[5403] = 6, --Crash of Waves
[6940] = 12, --Hand of Sacrifice
[7964] = 4, --Smoke Bomb
[7966] = 60, --Thorns Aura
[5413] = 120, --Noxious Catalyst
[3222] = 7200, --Strong Troll's Blood Elixir
[10831] = 5, --Reflection Field
[12891] = 45, --Acid Breath
[3742] = 15, --Static Electricity
[10348] = 20, --Tune Up
[11366] = 12, --Pyroblast (Rank 1)
[20902] = 10, --Aimed Shot (Rank 4)
[24712] = 3600, --Leper Gnome Costume
[10412] = 8, --Earth Shock (Rank 5)
[25859] = 0, --Reindeer
[11442] = 180, --Withered Touch
[34976] = 0, --Netherstorm Flag
[12484] = 5, --Chilled (Improved Blizzard Rank 1)
[29544] = 6, --Frightening Shout
[408] = 1, --Kidney Shot (Rank 1)
[8046] = 8, --Earth Shock (Rank 4)
[9438] = 8, --Arcane Bubble
[31125] = 4, --Blade Twisting
[3267] = 7, --First Aid (Rank 3)
[15087] = 15, --Evasion
[8068] = 1800, --Healthy Spirit
[9482] = 30, --Amplify Flames
[12528] = 10, --Silence (NPC)
[8078] = 10, --Thunderclap
[14201] = 12, --Enrage (Rank 2)
[24379] = 10, --Restoration
[16177] = 15, --Ancestral Fortitude (Rank 1)
[12097] = 20, --Pierce Armor
[45724] = 0, --Braziers Hit!
[1135] = 30, --Drink
[45245] = 1800, --Well Fed
[1137] = 30, --Drink
[1490] = 300, --Curse of the Elements (Rank 1)
[10596] = 0, --Nature Resistance (Rank 1)
[10404] = 0, --Stoneskin (Rank 5)
[11131] = 10, --Icicle
[3815] = 45, --Poison Cloud
[8282] = 120, --Curse of Blood
[8600] = 180, --Fevered Plague
[5589] = 5, --Hammer of Justice (Rank 3)
[16914] = 0, --Hurricane (Rank 1)
[9275] = 21, --Immolate (NPC)
[5599] = 8, --Hand of Protection (Rank 2)
[8632] = 18, --Garrote (Rank 3)
[8640] = 6, --Rupture (Rank 3)
[26008] = 1800, --Toast
[7992] = 24, --Slowing Poison
[12245] = 300, --Infected Spine
[33726] = 3600, --Elixir of Mastery
[10732] = 10, --Supercharge
[2819] = 12, --Deadly Poison II (Rank 2)
[8696] = 15, --Sprint (Rank 2)
[11770] = 180, --Fire Shield (Rank 4)
[36899] = 3600, --Transporter Malfunction
[5196] = 21, --Entangling Roots (Rank 4)
[9852] = 24, --Entangling Roots (Rank 5)
[9853] = 27, --Entangling Roots (Rank 6)
[26989] = 27, --Entangling Roots (Rank 7)
[17154] = 30, --The Green Tower (Rank 1)
[19972] = 21, --Entangling Roots (Rank 4)
[12824] = 30, --Polymorph (Rank 2)
[8377] = 4, --Earthgrab
[32292] = 0, --Swift Purple Gryphon
[710] = 20, --Banish (Rank 1)
[19278] = 24, --Devouring Plague (Rank 4)
[8163] = 0, --Strength of Earth (Rank 3)
[11327] = 10, --Vanish (Rank 1)
[9798] = 0, --Radiation
[8269] = 120, --Frenzy
[5677] = 0, --Mana Spring (Rank 1)
[8281] = 6, --Sonic Burst
[12884] = 45, --Acid Breath
[21655] = 1, --Blink
[3356] = 45, --Flame Lash
[12540] = 4, --Gouge
[12248] = 10, --Amplify Damage
[7739] = 10, --Inferno Shell
[12251] = 30, --Virulent Poison
[8317] = 180, --Fire Shield (Rank 3)
[12421] = 2, --Mithril Frag Bomb
[10452] = 20, --Flame Buffet
[11922] = 15, --Entangling Roots
[14298] = 15, --Immolation Trap (Rank 2)
[2601] = 30, --Fire Shield III
[10413] = 8, --Earth Shock (Rank 6)
[12461] = 2, --Backhand
[14517] = 30, --Crusader Strike
[9256] = 10, --Deep Sleep
[20875] = 900, --Rumsey Rum
[11020] = 8, --Petrify
[9459] = 60, --Corrosive Ooze
[38254] = 1800, --Festering Wound
[10493] = 0, --Mana Spring (Rank 3)
[29674] = 0, --Lesser Shielding
[19973] = 18, --Entangling Roots (Rank 3)
[10598] = 0, --Nature Resistance (Rank 2)
[8988] = 10, --Silence (NPC)
[21331] = 15, --Entangling Roots
[8633] = 18, --Garrote (Rank 4)
[9906] = 5, --Reflection
[21067] = 10, --Poison Bolt
[12098] = 20, --Sleep
[12096] = 8, --Fear (NPC)
[19276] = 24, --Devouring Plague (Rank 2)
[39628] = 3600, --Elixir of Ironskin
[3419] = 6, --Improved Blocking
[5195] = 18, --Entangling Roots (Rank 3)
[24709] = 3600, --Pirate Costume
[19277] = 24, --Devouring Plague (Rank 3)
[11820] = 6, --Electrified Net
[11443] = 15, --Cripple
[9080] = 10, --Hamstring (NPC)
[46630] = 90, --Torch Tossing Practice
[19710] = 900, --Well Fed
[6728] = 10, --Enveloping Winds (Rank 1)
[36893] = 3600, --Transporter Malfunction
[13298] = 30, --Poison
[8275] = 75, --Poisoned Shot
[3439] = 300, --Wandering Plague
[4318] = 1800, --Guile of the Raptor
[1943] = 16, --Rupture (Rank 1)
[28509] = 3600, --Greater Mana Regeneration
[34709] = 15, --Shadow Sight
[33082] = 1800, --Strength (Rank 5)
[17347] = 15, --Hemorrhage (Rank 2)
[8408] = 11, --Frostbolt (Rank 7)
[10179] = 12, --Frostbolt (Rank 8)
[10180] = 12, --Frostbolt (Rank 9)
[10181] = 12, --Frostbolt (Rank 10)
[25304] = 12, --Frostbolt (Rank 11)
[27071] = 12, --Frostbolt (Rank 12)
[27072] = 12, --Frostbolt (Rank 13)
[11264] = 10, --Ice Blast
[17537] = 3600, --Elixir of Brute Force
[45694] = 180, --Captain Rumsey's Lager
[21547] = 5, --Spore Cloud
[9775] = 60, --Irradiated
[2818] = 12, --Deadly Poison (Rank 1)
[21068] = 24, --Corruption (NPC)
[8258] = 240, --Devotion Aura (NPC)
[1133] = 27, --Drink
[21749] = 2, --Thorn Volley
[20927] = 10, --Holy Shield (Rank 2)
[25747] = 15, --Damage Absorb
[745] = 5, --Web
[21687] = 15, --Toxic Volley
[10093] = 1, --Harsh Winds
[23759] = 0, --Master Demonologist
[23767] = 7200, --Sayge's Dark Fortune of Armor
[3256] = 240, --Plague Cloud
[6533] = 2, --Net
[33259] = 1800, --Well Fed
[1129] = 30, --Food
[21787] = 120, --Deadly Poison
[8362] = 20, --Renew (NPC)
[13526] = 30, --Corrosive Poison
[11436] = 10, --Slow (NPC)
[11329] = 10, --Vanish (Rank 2)
[14518] = 30, --Crusader Strike
[45699] = 5, --Flames of Failure
[15548] = 10, --Thunderclap
[12486] = 5, --Chilled (improved Blizzard Rank 3)
[8402] = 8, --Fireball (Rank 7)
[8406] = 10, --Frostbolt (Rank 5)
[20901] = 10, --Aimed Shot (Rank 3)
[6524] = 2, --Ground Tremor
[12530] = 60, --Frailty
[10494] = 0, --Mana Spring (Rank 4)
[12040] = 30, --Shadow Shield
[5005] = 21, --Food
[47057] = 180, --Fiery Seduction
[12479] = 10, --Hex of Jammal'an
[16922] = 3, --Starfire Stun
[28880] = 15, --Gift of the Naaru
[20594] = 8, --Stone Form
}