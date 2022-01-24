DEGENMOD = RegisterMod("Degenerate Mod Test", 1)

local character_texture_table = require("scripts/dgm_character_list")
local fuckables_logic = require("scripts/fuckables_logic")
local configfile = require("scripts/dgm_config")
local achbook = require("scripts/achievement_book")
local cosmetics = require("scripts/cosmetics")
local wardrobe_mod_support = require("scripts/wardrobe_mod_support")

local json = require("json")
sound = SFXManager()

GameState = {}

--############ SAVES ############
function DEGENMOD:onStart()
	if DEGENMOD:HasData() then
		GameState = json.decode(DEGENMOD:LoadData())
	else
		GameState = DEGENMOD.ConfigMod
	end
end
DEGENMOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, DEGENMOD.onStart)

function DEGENMOD:onExit(save)
	DEGENMOD:SaveData(json.encode(GameState))
end

-- REMEMBER:: try that one idea where you compile a table with the appropriate body and head textures
-- could always be big lazy and make everything a seperate entity, but it wouldnt be as flexible



-- Functions to create/edit/acquire statistics.

-- floorStatistics : Set floor character spawning RNG, set type of character
-- roomStatistics : Acquire current room type for spawning, reset percentuntilfinish
function DEGENMOD:floorStatistics(_DEGENMOD)
	SpawnRollBossRoom = math.random(1,100)
	
	TypeRollShop = math.random(0,6)
	TypeRollSecret = math.random(0,6)
	TypeRollSuperSecret =  math.random(0,6)
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	local PreviewLogo = Sprite()
	PreviewLogo:Load("gfx/ui/previewfeatures.anm2")
	PreviewLogo:SetFrame("Idle", 0)
	PreviewLogo:Render(Vector(Isaac.GetScreenWidth() / 3.75, Isaac.GetScreenHeight() / 1.10), Vector.Zero, Vector.Zero)
	PreviewLogo:Update()
	
	if GameState["Debug"] then
		local IsDebugHotkeyPressed = false
		if Input.IsButtonPressed(Keyboard.KEY_O, 0) and IsDebugHotkeyPressed == false then
			--TODO: Convert into actual HUD elements, maybe...
			--Note: Code supposed to be sloppy, not normally accessible during mod use. It's for testing.
			local IsDebugHotkeyPressed = true
			
			local MainPackSprite = Sprite()
			MainPackSprite:Load("gfx/ui/debugstats.anm2")
			MainPackSprite:SetFrame("Idle", 10)
			MainPackSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 - 15), Vector.Zero, Vector.Zero)
			MainPackSprite:Update()
			Isaac.RenderText(tostring(GameState["Unlocked Storepack"]), Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 - 15, 255, 255, 255, 255)
			
			local TaintedPackSprite = Sprite()
			TaintedPackSprite:Load("gfx/ui/debugstats.anm2")
			TaintedPackSprite:SetFrame("Idle", 11)
			TaintedPackSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 - 30), Vector.Zero, Vector.Zero)
			TaintedPackSprite:Update()
			Isaac.RenderText(tostring(GameState["Unlocked Taintedpack"]), Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 - 30, 255, 255, 255, 255)
			
			local GenderBendPackSprite = Sprite()
			GenderBendPackSprite:Load("gfx/ui/debugstats.anm2")
			GenderBendPackSprite:SetFrame("Idle", 12)
			GenderBendPackSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 - 45), Vector.Zero, Vector.Zero)
			GenderBendPackSprite:Update()
			Isaac.RenderText(tostring(GameState["Unlocked Genderbendpack"]), Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 - 45, 255, 255, 255, 255)
			
			local ShopPackSprite = Sprite()
			ShopPackSprite:Load("gfx/ui/debugstats.anm2")
			ShopPackSprite:SetFrame("Idle", 13)
			ShopPackSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 - 60), Vector.Zero, Vector.Zero)
			ShopPackSprite:Update()
			Isaac.RenderText(tostring(GameState["Unlocked Storepack"]), Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 - 60, 255, 255, 255, 255)
			
			local DeadlySinsSprite = Sprite()
			DeadlySinsSprite:Load("gfx/ui/debugstats.anm2")
			DeadlySinsSprite:SetFrame("Idle", 14)
			DeadlySinsSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 - 75), Vector.Zero, Vector.Zero)
			DeadlySinsSprite:Update()
			Isaac.RenderText(tostring(GameState["Unlocked Sinspack"]), Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 - 75, 255, 255, 255, 255)
			
			local SpecialPackSprite = Sprite()
			SpecialPackSprite:Load("gfx/ui/debugstats.anm2")
			SpecialPackSprite:SetFrame("Idle", 15)
			SpecialPackSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 - 90), Vector.Zero, Vector.Zero)
			SpecialPackSprite:Update()
			Isaac.RenderText(tostring(GameState["Unlocked Specialpack"]), Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 - 90, 255, 255, 255, 255)
			
			local BossRoomPercentSprite = Sprite()
			BossRoomPercentSprite:Load("gfx/ui/debugstats.anm2")
			BossRoomPercentSprite:SetFrame("Idle", 4)
			BossRoomPercentSprite:Render(Vector(Isaac.GetScreenWidth() / 9, Isaac.GetScreenHeight() / 2.25 + 75), Vector.Zero, Vector.Zero)
			BossRoomPercentSprite:Update()
			Isaac.RenderText("Roll:" .. SpawnRollBossRoom .. " Perc:<" .. GameState["Boss Appear Chance"], Isaac.GetScreenWidth() / 9 + 25, Isaac.GetScreenHeight() / 2.25 + 75, 255, 255, 255, 255)
			
			--Isaac.RenderText("FINISH %", 65, 250, 255, 255, 255, 255)
			--Isaac.RenderText(percentuntilfinish, 125, 250, 255, 255, 255, 255)
			Isaac.RenderText("O - CLOSE DEBUG", Isaac.GetScreenWidth() / 1.5, Isaac.GetScreenHeight() / 2 + 75, 255, 255, 255, 255)
		else
			local IsDebugHotkeyPressed = false
			Isaac.RenderText("O - DEBUG", Isaac.GetScreenWidth() / 1.5, Isaac.GetScreenHeight() / 2 + 75, 255, 255, 255, 255)
		end
	end
end)

DEGENMOD:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, DEGENMOD.floorStatistics)

DEGENMOD:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, DEGENMOD.onExit)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_END, DEGENMOD.onExit)