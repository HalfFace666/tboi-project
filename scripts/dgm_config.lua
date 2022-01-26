DEGENMOD.ConfigMod = {
	--unlocks part 1
	["Unlocked Storepack"] = false,
	["Unlocked Specialpack"] = false,
	["Unlocked Sinspack"] = false,
	["Unlocked Mainpack"] = false,
	["Unlocked Genderbendpack"] = false,
	["Unlocked Taintedpack"] = false,
	
	["Unlocked Brothels"] = false,
	["Unlocked Shop"] = false,
	
	--unlocks part 2 electric boogaloo
	--TODO : think up collectibles for all the characters n toss em here
	["Unlocked Isaac Collectible"] = false,
	["Unlocked Eve Collectible"] = false,
	["Unlocked FemLaz Collectible"] = false,
	
	--variables for special unlocks
	["100 Completion Unlock"] = true,
	["Joke Unlock"] = true,
	
	--debug features
	["Debug"] = true,
	
	--compatibility and other (disable these if it's conflicting, or not... i'm not your dad)
	["Enable Achievement Tracker"] = false, --UNFINISHED UNFINISHED UNFINISHED
	["Enable Body Costumes"] = true, --does nothing
	
	--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::DO NOT EDIT ANYTHING BEYOND THIS POINT WITHOUT KNOWING WHAT YOU'RE DOING::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	--note for myself: if this proves to be too tedious or impede probably just try porting the saving & loading to fuckables_logic.lua file as a seperate thing
	--Character Torsos
	["MaleTorso"] = "gfx/screwable/fb_male_torso_sprites.png",
	["FemaleTorso"] = "gfx/screwable/fb_female_torso_sprites.png",
	
	--Character Heads
	["IsaacHead"] = "gfx/screwable/fb_isaac_head_part.png",
	["EveHead"] = "gfx/screwable/fb_eve_head_part.png",
	["FemLazHead"] = "gfx/screwable/fb_femlaz_head_part.png",
	["ShygalHead"] = "gfx/screwable/fb_shygal_head_part.png",
	
	--Price Attributes
	["Price"] = 5,
	["NewTag"] = false,
	["SaleTag"] = false
}