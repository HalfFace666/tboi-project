function DEGENMOD:PlayerCostumesInit(player)
	if player:GetPlayerType() == PlayerType.PLAYER_ISAAC then --Isaac
		local IsaacCostume = Isaac.GetCostumeIdByPath("gfx/characters/costume_001_isaac_body.anm2")
		player:AddNullCostume(IsaacCostume)
	elseif player:GetPlayerType() == PlayerType.PLAYER_MAGDALENA then --Magdalene
		local MagdaleneCostume = Isaac.GetCostumeIdByPath("gfx/characters/costume_002_magdalene_body.anm2")
		player:AddNullCostume(MagdaleneCostume)
	elseif player:GetPlayerType() == PlayerType.PLAYER_CAIN then --Cain
		local CainCostume = Isaac.GetCostumeIdByPath("gfx/characters/costume_003_cain_body.anm2")
		player:AddNullCostume(CainCostume)
	elseif player:GetPlayerType() == PlayerType.PLAYER_EVE then --Eve
		local EveCostume = Isaac.GetCostumeIdByPath("gfx/characters/costume_005_eve_body.anm2")
		player:AddNullCostume(EveCostume)
	elseif player:GetPlayerType() == PlayerType.PLAYER_SAMSON then --Samson
		local SamsonCostume = Isaac.GetCostumeIdByPath("gfx/characters/costume_007_samson_body.anm2")
		player:AddNullCostume(SamsonCostume)
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, DEGENMOD.PlayerCostumesInit)