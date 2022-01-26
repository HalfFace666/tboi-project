
--TODO : reset stats that you'd otherwise gain thru fuckable character

local hotkeyUIEnabled = false
local numberUIEnabled = false

local fb = nil
local paidCharacter = false
local pointsuntilfinish = 0
local inputdisabled = false

--preload UIs and stuff meant specifically for the fuckening
local hotkeyUI = Sprite()
hotkeyUI:Load("gfx/ui/uiHotkeys.anm2")

local numberUI = Sprite()
numberUI:Load("gfx/ui/uiHotkeys2.anm2")

local sexbarUI = Sprite()
sexbarUI:Load("gfx/ui/uiProgressBar.anm2")

function DEGENMOD:ToggleInputFX(isenabled)
	local inputdisabled = isenabled
	if inputdisabled == false then
		Isaac.GetPlayer().ControlsEnabled = true
		player.Visible = true
	elseif inputdisabled == true then
		Isaac.GetPlayer().ControlsEnabled = false
		player.Visible = false
	end
end

--this makes me miserable but is required to generate the lewd characters
function DEGENMOD:initFloor()
	fb = nil
	cachedfbType_Brothel = math.random(0,2)
	paidCharacter = false
	cachedfbType_Head_Brothel = nil
	cachedfbType_Body_Brothel = nil
	sexbarUI:SetFrame("Pre", 0) --todo : remove pre and put in idle frame 0 like everything else, im too lazy to do it rn lol
	numberUI:SetFrame("Idle", 0)
	hotkeyUI:SetFrame("Idle", 0)
	pointsuntilfinish = 0
	
	if cachedfbType_Brothel == 0 then
		cachedfbType_Head_Brothel = GameState["IsaacHead"]
		cachedfbType_Body_Brothel = GameState["FemaleTorso"]
	elseif cachedfbType_Brothel == 1 then
		cachedfbType_Head_Brothel = GameState["EveHead"]
		cachedfbType_Body_Brothel = GameState["FemaleTorso"]
	elseif cachedfbType_Brothel == 2 then
		cachedfbType_Head_Brothel = GameState["FemLazHead"]
		cachedfbType_Body_Brothel = GameState["FemaleTorso"]
	end
end

function DEGENMOD:checkforCharactersInRoom()
	for i,fuckableCharacter in pairs(Isaac.GetRoomEntities()) do
		if fuckableCharacter.Type == 979 then
			fb = fuckableCharacter
			fbSprite = fb:GetSprite()
			fbSprite:ReplaceSpritesheet(1, cachedfbType_Head_Brothel)
			fbSprite:ReplaceSpritesheet(0, cachedfbType_Body_Brothel)
			fbSprite:LoadGraphics()
			fbSprite:Play("idle", true)
		end
	end
	
	--custom backdrops are a pain in the ass so i'm checking whether the room qualifies as a brothel room by searching for the brothel bed entity and spawning the entire backdrop entity way back in depthoffset.
	--i WOULD change it to a system where room IDs are checked instead but that'd interfere with a bunch of mods that would add in new rooms and shit due to incrementing so... mightaswell anchor detection onto smn else
	for i,brothelAssets in pairs(Isaac.GetRoomEntities()) do
		if brothelAssets.Type == 981 then
			BrothelBackdropWall = Isaac.Spawn(982, 0, 0, Vector(320,280), Vector(0,0), nil)
			BrothelBackdropWall.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
			BrothelBackdropWall.DepthOffset = -999
		end
	end
end

function DEGENMOD:onFuckableCharacter(_DEGENMOD)
	if fb then
		--game does not like when these are outside cached on the first line so here they stay... will fix later
		local player = Isaac.GetPlayer(0)
		local cachedPlayerCoins = player:GetNumCoins()
		
		--pay animation & retract coins
		if player:GetNumCoins() >= 15 then
			if (fb.Position - player.Position):Length() <= fb.Size + player.Size and paidCharacter == false then
				fbSprite:Play("pay", true)
				player:AddCoins(-15)
				paidCharacter = true
				for i,brothelPrice in pairs(Isaac.GetRoomEntities()) do
					brothelPrice.DepthOffset = -998
					if brothelPrice.Type == 980 then
						brothelPrice:Remove()
					end
				end
			end
		end
		
		--qualifies for the big sex after payment n shit
		--icky yunky if elseif if if if else leseif ififikfsfil fififslf
		if paidCharacter == true then
			if Input.IsButtonTriggered(Keyboard.KEY_Y, 0) then
				fbSprite:Play("idlealt", true)
				DEGENMOD:ToggleInputFX(false)
			elseif Input.IsButtonTriggered(Keyboard.KEY_1, 0) then
				fbSprite:Play("cowgirlanim", true)
				DEGENMOD:ToggleInputFX(true)
				if numberUIEnabled == true then
					numberUI:SetFrame("Idle", 2)
				end
			elseif Input.IsButtonTriggered(Keyboard.KEY_2, 0) then
				fbSprite:Play("frombackanim", true)
				DEGENMOD:ToggleInputFX(true)
				if numberUIEnabled == true then
					numberUI:SetFrame("Idle", 3)
				end
			elseif Input.IsButtonTriggered(Keyboard.KEY_3, 0) then
				fbSprite:Play("blowjobanim", true)
				DEGENMOD:ToggleInputFX(true)
				if numberUIEnabled == true then
					numberUI:SetFrame("Idle", 4)
				end
			elseif Input.IsButtonTriggered(Keyboard.KEY_4, 0) then
				fbSprite:Play("missionaryanim", true)
				DEGENMOD:ToggleInputFX(true)
				if numberUIEnabled == true then
					numberUI:SetFrame("Idle", 5)
				end
			end
			
			if fbSprite:IsEventTriggered("smackSfx") then
				pointsuntilfinish = pointsuntilfinish + 1
				sexbarUI:SetFrame("Idle", pointsuntilfinish)
				sound:Play(SoundEffect.SOUND_ANIMAL_SQUISH, 1, 0, false, 1)
			end
			
			if fbSprite:IsEventTriggered("paySfx") then
				sound:Play(SoundEffect.SOUND_SCAMPER, 1, 0, false, 1)
			end
			
			if Input.IsButtonTriggered(Keyboard.KEY_T, 0) then
				if hotkeyUIEnabled == false then
					hotkeyUIEnabled = true
					numberUIEnabled = true
					hotkeyUI:Play("Appear", true)
					numberUI:Play("Appear", true)
				elseif hotkeyUIEnabled == true then
					hotkeyUIEnabled = false
					numberUIEnabled = false
					hotkeyUI:Play("Disappear", true)
					numberUI:Play("Disappear", true)
				end
			end
			
			--todo : align in a good spot but i'm lazy so im todoing it
			hotkeyUI:Render(Vector(Isaac.GetScreenWidth() / 2, Isaac.GetScreenHeight() / 1.20), Vector.Zero, Vector.Zero)
			hotkeyUI:Update()
			numberUI:Render(Vector(Isaac.GetScreenWidth() / 2.25, Isaac.GetScreenHeight() / 1.10), Vector.Zero, Vector.Zero)
			numberUI:Update()
			sexbarUI:Render(Vector(Isaac.GetScreenWidth() / 3.35, Isaac.GetScreenHeight() / 1.10), Vector.Zero, Vector.Zero)
			sexbarUI:Update()
		end
	end
	if pointsuntilfinish >= 81 then
		pointsuntilfinish = 81
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, DEGENMOD.initFloor)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DEGENMOD.checkforCharactersInRoom)
DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, DEGENMOD.onFuckableCharacter)