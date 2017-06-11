local spellDB = tyrPlates.spellDB

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
	["Weakened Soul"] = 15,

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
	["Devouring Plague"] = 24,
	
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
	["Rapid Killing"] = 20,
	["Concussive Barrage"] = 4,
	["Aimed Shot"] = 10,

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
	["Polymorph"] = 50,	
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
	["Barkskin"] = 12,	
	["Cyclone"] = 6,
	["Entangling Roots"] = 15,
	["Faerie Fire"] = 40,
	["Innervate"] = 20,
	["Insect Swarm"] = 12,
	["Moonfire"] = 12,
	["Nature's Grace"] = 15,
	["Nature's Grasp"] = 45,
	["Starfire Stun"] = 3,
	["Soothe Animal"] = 15,
	["Thorns"] = 600,
	
	--Druid Feral
	["Enrage"] = 10,	
	["Prowl"] = 0,	
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
	["Ghost Wolf"] = 0,
	["Frostbrand Attack"] = 8,
	
	--Shaman Restoration
	["Ancestral Fortitude"] = 15,	
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
	["Curse of the Elements"] = 300,		
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
	["Summoning Disorientation"] = 5,		
	
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
	["Righteous Defense"] = 3,
	["Holy Shield"] = 10,
	
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
	["Cheap Shot"] = 4,	
	["Deadly Throw"] = 6,	
	["Kidney Shot"] = 6,	
	["Expose Armor"] = 30,	
	["Rupture"] = 16,	
	["Garrote"] = 18,	
	["Garrote - Silence"] = 3,	
	["Slice and Dice"] = 30,	
	["Remorseless"] = 20,	
	["Find Weakness"] = 10,	
	["Crippling Poison"] = 12,	
	["Wound Poison"] = 15,	
	["Deadly Poison"] = 12,	
	["Deadly Poison II"] = 12,	
	["Deadly Poison III"] = 12,	
	["Deadly Poison IV"] = 12,	
	["Deadly Poison V"] = 12,	
	["Deadly Poison VI"] = 12,	
	["Deadly Poison VII"] = 12,	
	["Mind-numbing Poison"] = 14,	
	["Mind-numbing Poison II"] = 14,	
	["Mind-numbing Poison III"] = 14,	
	
	--Rogue Combat
	["Evasion"] = 15,		
	["Gouge"] = 5.5,		
	["Kick - Silenced"] = 2,		
	["Sprint"] = 15,		
	["Riposte"] = 6,		
	["Blade Flurry"] = 15,		
	["Adrenaline Rush"] = 15,		
	
	--Rogue Subtlety
	["Blind"] = 10,	
	["Cloak of Shadows"] = 5,	
	["Hemorrhage"] = 15	,
	["Sap"] = 45,	
	["Stealth"] = 0,	
	["Vanish"] = 10,	
	["Ghostly Strike"] = 7,	
	["Master of Subtlety"] = 6,	
	["Cheating Death"] = 3,	
	["Cold Blood"] = 0,	
	
	--Racials
	["Heroic Presence"] = 0,	
	["Will of the Forsaken"] = 5,	
	["War Stomp"] = 2,	
	["Blood Fury"] = 15,	
	["Arcane Torrent"] = 2,	
	["Berserking"] = 10,	
	["Gift of the Naaru"] = 15,	
	["Stone Form"] = 8,		

	--PvP
	
	--General
	["Dazed"] = 4,
	["Web"] = 5,
	["Recently Bandaged"] = 60,
	["Resurrection Sickness"] = 600,
	["Alchemist's Stone"] = 0,
	["Arcane Bomb"] = 5,
	["Battle Standard"] = 0,
	["Warsong Flag"] = 0,
	["Silverwing Flag"] = 0,
	["Speed"] = 10,
	["Stormpike's Salvation"] = 120,
	["Hooked Net"] = 6,	
	["Net"] = 5,	
	["Poison"] = 30,
	["Deadly Poison"] = 120,
	["Thunderclap"] = 10,
	["Shield Slam"] = 2,
	["Localized Toxin"] = 60,
	["Backhand"] = 2,
	["Druid's Slumber"] = 15,
	["Veil of Shadow"] = 15,
	["Screams of the Past"] = 5,
	["Sleep"] = 10,
	["Deep Sleep"] = 10,
	["Greater Dreamless Sleep"] = 12,
	["Major Dreamless Sleep	"] = 12,
	["Deep Sleep"] = 10,
	["Anti-Magic Shield"] = 10,
	["Terrify"] = 4,
	["Battle Command"] = 6,
	["Tendon Rip"] = 8,
	["Putrid Stench"] = 10,
	["Bone Armor"] = 60,
	["Dominate Mind"] = 15,
	["Ravage"] = 2,
	["Improved Blocking"] = 6,
	["Netherstorm Flag"] = 0,
	["Hex"] = 10,
	["Frightening Shout"] = 6,
	["Pierce Armor"] = 20,
	["Slowing Poison"] = 25,
	["Petrify"] = 8,
	["Electrified Net"] = 6,
	["Cripple"] = 15,
	["Enveloping Winds"] = 10,
	["Shadow Sight"] = 15,
	["Thorn Volley"] = 2,
	["Damage Absorb"] = 15,

	
	
}	

-- aura duration on NPCs by spellId
spellDB.auraDuration.PvE = {
[66] = 6, --Invisibility (Mage)
[32612] = 20, --Invisibility (Mage)
[31125] = 8, --Dazed (Blade Twisting)
[14874] = 10, --Rupture (NPC)
[15583] = 10, --Rupture (NPC)
[1022] = 6, --Blessing of Protection (Rank 1)
[5599] = 8, --Blessing of Protection (Rank 2)
[10278] = 10, --Blessing of Protection (Rank 3)
[2878] = 10, --Turn Undead (Rank 1)
[5627] = 15, --Turn Undead (Rank 2)
[19725] = 20, --Turn Undead (NPC)
[8921] = 9, --Moonfire (Rank 1)
[5276] = 15, -- Freeze (NPC)
[18763] = 15, -- Freeze (NPC)
[16350] = 10, -- Freeze (NPC)
[12557] = 8, --Cone of Cold (NPC)
[15244] = 8, --Cone of Cold (NPC)
[31117] = 5, --Unstable Affliction - Silence
[642] = 10, --Divine Shield (Rank 1)
[1020] = 12, --Divine Shield (Rank 2)
[33581] = 10, --Divine Shield (NPC)
[13874] = 8, --Divine Shield (NPC)
[1513] = 10, --Scare Beast (Rank 1)
[14326] = 15, --Scare Beast (Rank 2)
[14327] = 20, --Scare Beast (Rank 3)
[19386] = 12, --Wyvern Sting (CC Rank 1)	
[24132] = 12, --Wyvern Sting (CC Rank 2)	
[24133] = 12, --Wyvern Sting (CC Rank 3)	
[27068] = 12, --Wyvern Sting (CC Rank 4)	
[24131] = 12, --Wyvern Sting (DoT Rank 1)
[24134] = 12, --Wyvern Sting (DoT Rank 2)
[24135] = 12, --Wyvern Sting (DoT Rank 3)
[27069] = 12, --Wyvern Sting (DoT Rank 4)
[6770] = 25, --Sap (Rank 1)
[2070] = 35, --Sap (Rank 2)
[11297] = 45, --Sap (Rank 3)
[30980] = 8, --Sap (NPC)
[118] = 20, --Polymorph (Rank 1)
[12824] = 30, --Polymorph (Rank 2)
[12825] = 40, --Polymorph (Rank 2)
[34639] = 5, --Polymorph (NPC)
[43309] = 6, --Polymorph (NPC)
[13323] = 8, --Polymorph (NPC)
[851] = 10, --Polymorph (NPC)
[33173] = 10, --Polymorph (NPC)
[15534] = 20, --Polymorph (NPC)
[22274] = 20, --Polymorph (NPC)
[29848] = 20, --Polymorph (NPC)
[339] = 12, --Entangling Roots (Rank 1)
[5195] = 18, --Entangling Roots (Rank 3)
[5196] = 21, --Entangling Roots (Rank 4)
[9852] = 24, --Entangling Roots (Rank 5)
[9853] = 27, --Entangling Roots (Rank 6)
[26989] = 27, --Entangling Roots (Rank 7)
[32173] = 8, --Entangling Roots (NPC)
[35234] = 8, --Entangling Roots (NPC)
[12747] = 10, --Entangling Roots (NPC)
[22127] = 10, --Entangling Roots (NPC)
[22415] = 10, --Entangling Roots (NPC)
[24648] = 10, --Entangling Roots (NPC)
[37823] = 10, --Entangling Roots (NPC)
[498] = 6, --Divine Protection (Rank 1)
[5573] = 8, --Divine Protection (Rank 2)
[13496] = 10,  --Dazed (NPC)
[2479] = 30, --Honorless Target
[3355] = 10, --Freezing Trap Effect (Rank 1)
[14308] = 15, --Freezing Trap Effect (Rank 2)
[14309] = 20, --Freezing Trap Effect (Rank 3)
[28991] = 10, --Web (NPC)
[5484] = 6, --Howl of Terror (Rank 1)
[17928] = 8, --Howl of Terror (Rank 2)
[5782] = 10, --Fear (Rank 1)
[6213] = 15, --Fear (Rank 2)
[6215] = 20, --Fear (Rank 3)
[12096] = 8, --Fear (NPC)
[5211] = 3, --Bash (Rank 1)
[6798] = 4, --Bash (Rank 2)
[8983] = 5, --Bash (Rank 3)
[9484] = 30, --Shackle Undead (Rank 1)
[9485] = 40, --Shackle Undead (Rank 2)
[10955] = 50, --Shackle Undead (Rank 3)
[853] = 3, --Hammer of Justice (Rank 1)
[5588] = 4, --Hammer of Justice (Rank 2)
[5589] = 5, --Hammer of Justice (Rank 3)
[10308] = 6, --Hammer of Justice (Rank 4)
[15708] = 5, --Mortal Strike (NPC)
[32736] = 5, --Mortal Strike (NPC)
[710] = 20, --Banish (Rank 1)
[18647] = 30, --Banish (Rank 2)
[2637] = 20, --Hibernate (Rank 1)
[18657] = 30, --Hibernate (Rank 2)
[18658] = 40, --Hibernate (Rank 3)
[12484] = 5, --Chilled (Improved Blizzard Rank 1)
[12485] = 5, --Chilled (Improved Blizzard Rank 1)
[12486] = 5, --Chilled (improved Blizzard Rank 3)
[20005] = 5, --Chilled (NPC)
[36554] = 3, --Shadowstep (Haste)
[36563] = 10, --Shadowstep (+Damage)
[6533] = 6, --Net (NPC)
[11572] = 9, --Rend (Rank 1)
[11572] = 12, --Rend (Rank 2)
[11572] = 18, --Rend (Rank 4)
[11572] = 21, --Rend (Rank 5)
[11572] = 21, --Rend (Rank 6)
[11572] = 21, --Rend (Rank 7)
[11572] = 21, --Rend (Rank 8)
[116] = 8, --Frostbolt (Rank 1)
[205] = 9, --Frostbolt (Rank 2)
[837] = 9, --Frostbolt (Rank 3)
[7322] = 10, --Frostbolt (Rank 4)
[8406] = 10, --Frostbolt (Rank 5)
[8407] = 11, --Frostbolt (Rank 6)
[8408] = 11, --Frostbolt (Rank 7)
[10179] = 12, --Frostbolt (Rank 8)
[10180] = 12, --Frostbolt (Rank 9)
[10181] = 12, --Frostbolt (Rank 10)
[25304] = 12, --Frostbolt (Rank 11)
[27071] = 12, --Frostbolt (Rank 12)
[27072] = 12, --Frostbolt (Rank 13)
[9672] = 4, --Frostbolt (NPC)
[8398] = 8, --Frostbolt Volley
[172] = 12, --Corruption (Rank 1)
[6222] = 15, --Corruption (Rank 2)
[21068] = 24, --Corruption (NPC)
[6343] = 14, --Thunder Clap (Rank 2)
[6343] = 18, --Thunder Clap (Rank 3)
[6343] = 22, --Thunder Clap (Rank 4)
[6343] = 26, --Thunder Clap (Rank 5)
[6343] = 30, --Thunder Clap (Rank 6)
[6343] = 30, --Thunder Clap (Rank 7)
[18267] = 30, --Curse of Weakness (NPC)
[20800] = 21, --Immolate (NPC)
[9275] = 21, --Immolate (NPC)
[18266] = 15, --Curse of Agony (NPC)
[8599] = 120, --Enrage (NPC)
[8269] = 120, --Enrage (NPC)
[38232] = 20, --Battle Shout (NPC)
[30931] = 20, --Battle Shout (NPC)
[6742] = 30, --Bloodlust (NPC)
[21049] = 30, --Bloodlust (NPC)
[6713] = 5, --Disarm (NPC)
[8379] = 10, --Disarm (NPC)
[700] = 20, --Sleep (Rank 1)
[1090] = 30, --Sleep (Rank 2)
[12098] = 20, --Sleep (NPC)
[36402] = 3, --Sleep (NPC)
[41396] = 8, --Sleep (NPC)
[7295] = 10, --Soul Drain (NPC)
[7140] = 5, --Expose Weakness (NPC)
[746] = 6, --First Aid (Rank 1)
[1159] = 6, --First Aid (Rank 2)
[3267] = 7, --First Aid (Rank 3)
[3268] = 7, --First Aid (Rank 4)
[7926] = 8, --First Aid (Rank 5)
[7927] = 8, --First Aid (Rank 6)
[10838] = 8, --First Aid (Rank 7)
[10839] = 8, --First Aid (Rank 8)
[18608] = 8, --First Aid (Rank 9)
[18610] = 8, --First Aid (Rank 10)
[27030] = 8, --First Aid (Rank 11)
[27031] = 8, --First Aid (Rank 12)
[13704] = 6, --Psychic Scream (NPC)
[11876] = 5, --War Stomp (NPC)
[15859] = 5, --Dominate Mind (NPC)
[7645] = 10, --Dominate Mind (NPC)
[14515] = 15, --Dominate Mind (NPC)
[8391] = 3, --Ravage (NPC)
[12531] = 8, --Chilling Touch (NPC)
[29044] = 3, --Hex (NPC)
[17172] = 5, --Hex (NPC)
[24053] = 5, --Hex (NPC)
[12890] = 15, --Deep Slumber (NPC)
[11436] = 10, --Slow (NPC)
[18972] = 20, --Slow (NPC)
[7964] = 4, --Smoke Bomb (NPC)
[3742] = 15, --Static Electricity (Weapon)
[12528] = 10, --Silence (NPC)
[8988] = 10, --Silence (NPC)
[29904] = 5, --Sonic Burst (NPC)
[8281] = 6, --Sonic Burst (NPC)
[23918] = 10, --Sonic Burst (NPC)
[39052] = 10, --Sonic Burst (NPC)
[12540] = 4, --Gouge (NPC)
[12248] = 10, --Amplify Damage (NPC)
[12421] = 2, --Mithril Frag Bomb (Item)
[9906] = 5, --Reflection (NPC)
[31406] = 12, --Cripple (NPC)
[31477] = 12, --Cripple (NPC)
[9080] = 10, --Hamstring (NPC)
[31718] = 6, --Enveloping Winds (NPC)
[11264] = 10, --Ice Blast (NPC)
[8362] = 20, --Renew (NPC)
[6524] = 2, --Ground Tremor (NPC)
[12479] = 10, --Hex of Jammal'an (NPC)
}