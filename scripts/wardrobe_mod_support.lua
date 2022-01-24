function DEGENMOD:RegisterWardrobeModSupport(_DEGENMOD)
	if WardrobePlus ~= nil then
		if GameState["Enable Body Costumes"] then
			OWRP.AddNewCostume("DMSleeve", "Personal Cocksleeve", "gfx/characters/costume_001w_cocksleeve.anm2",false,false)
			OWRP.AddNewCostume("DMCondom", "Filled Protection", "gfx/characters/costume_002w_protection.anm2",false,false)
			OWRP.AddNewCostume("DMXLHard", "Extra Hard", "gfx/characters/costume_003w_xtrahard.anm2",false,false)
			OWRP.AddNewCostume("DMFacial", "Facial", "gfx/characters/costume_004w_facial.anm2",false,false)
			OWRP.AddNewCostume("DMDonger", "Regular Male", "gfx/characters/costume_005w_fat_schlonger.anm2",false,false)
			OWRP.AddNewCostume("DMBoober", "Regular Female", "gfx/characters/costume_006w_fat_booba.anm2",false,false)
			OWRP.AddNewCostume("DMElaSet", "Special Ops Set", "gfx/characters/costume_007w_ela_set.anm2",false,false)
			OWRP.AddNewCostume("DMElaHat", "Special Ops Hair", "gfx/characters/costume_008w_ela_hair.anm2",false,false)
			OWRP.AddNewCostume("DMJenSet", "Robo Set", "gfx/characters/costume_009w_jenny_set.anm2",false,false)
			OWRP.AddNewCostume("DMJenHat", "Robo Hair", "gfx/characters/costume_010w_jenny_hair.anm2",false,false)
		end
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DEGENMOD.RegisterWardrobeModSupport)