local spellDB = tyrPlates.spellDB

-- stores a predefined icon for the spell lockout aura
spellDB.spellSchoolIcon = {
	[2] = "Interface\\Icons\\Spell_Holy_HolyBolt",		--holy
	[4] = "Interface\\Icons\\Spell_Fire_SelfDestruct",	--fire
	[8] = "Interface\\Icons\\Spell_Nature_HealingTouch",--nature
	[16] = "Interface\\Icons\\Spell_Frost_FrostBlast",	--frost
	[32] = "Interface\\Icons\\Spell_Shadow_ShadowBolt",	--shadow
	[64] = "Interface\\Icons\\Spell_Arcane_StarFire"	--arcane
}

spellDB.friendlyCasts = {
	["Rain of Fire"] = true,
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
	["Berserking"] = 5/6, --not 100% accurate because it's health dependent
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
	--["Health Funnel"] = 10, has no target in Combatlog
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