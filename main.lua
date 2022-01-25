DEGENMOD = RegisterMod("Degenerate Mod", 1)

local fuckables_logic = require("scripts/fuckables_logic")
local configfile = require("scripts/dgm_config")
local character_attributes = require("scripts/dgm_character_attributes")
local achbook = require("scripts/achievement_book")
local cosmetics = require("scripts/cosmetics")
local wardrobe_mod_support = require("scripts/wardrobe_mod_support")

local json = require("json")

sound = SFXManager()
GameState = {}
CharacterList = {}


DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if GameState["Debug"] then
		local IsDebugHotkeyPressed = false
		if Input.IsButtonPressed(Keyboard.KEY_O, 0) and IsDebugHotkeyPressed == false then
			local IsDebugHotkeyPressed = true
			Isaac.RenderText("O - CLOSE DEBUG", Isaac.GetScreenWidth() / 1.5, Isaac.GetScreenHeight() / 2 + 75, 255, 255, 255, 255)
		else
			local IsDebugHotkeyPressed = false
			Isaac.RenderText("O - DEBUG", Isaac.GetScreenWidth() / 1.5, Isaac.GetScreenHeight() / 2 + 75, 255, 255, 255, 255)
		end
	end
end)

--############ SAVES & LOADING ############
function DEGENMOD:onStart()
	if DEGENMOD:HasData() then
		GameState = json.decode(DEGENMOD:LoadData())
		CharacterList = json.decode(DEGENMOD:LoadData())
	else
		GameState = DEGENMOD.ConfigMod
		CharacterList = DEGENMOD.LewdCharacterAttribTable
	end
end
DEGENMOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, DEGENMOD.onStart)

function DEGENMOD:onExit(save)
	DEGENMOD:SaveData(json.encode(GameState))
	DEGENMOD:SaveData(json.encode(CharacterList))
end

DEGENMOD:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, DEGENMOD.onExit)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_GAME_END, DEGENMOD.onExit)