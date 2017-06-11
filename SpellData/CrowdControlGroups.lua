local spellDB = tyrPlates.spellDB

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