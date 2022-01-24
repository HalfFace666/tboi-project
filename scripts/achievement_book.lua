local AchievementBook = Sprite()
local AchievementBookPage = 1
AchievementBook:Load("gfx/ui/book_of_art.anm2")
guiopen = false

local function GetScreenSize() -- By Kilburn himself.
  local room = Game():GetRoom()
  local pos = Isaac.WorldToScreen(Vector(0, 0)) - room:GetRenderScrollOffset() - Game().ScreenShakeOffset

  local rx = pos.X + 60 * 26 / 40
  local ry = pos.Y + 140 * (26 / 40)

  return rx * 2 + 13 * 26, ry * 2 + 7 * 26
end

local posx, posy = GetScreenSize()

--holy shit this makes me want to fucking hang myself
function DEGENMOD:PolaroidPageCheck(_DEGENMOD)
	if AchievementBookPage == 1 then
		local x = GameState["Unlocked 1st Polaroid"]
		local y = GameState["Unlocked 2nd Polaroid"]
		if x == false and y == true then AchievementBook:Play("1XO", true) end
		if x == true and y == false then AchievementBook:Play("1OX", true) end
		if x == false and y == false then AchievementBook:Play("1XX", true) end
		if x == true and y == true then AchievementBook:Play("1OO", true) end
	elseif AchievementBookPage == 2 then
		local x = GameState["Unlocked 3rd Polaroid"]
		local y = GameState["Unlocked 4th Polaroid"]
		if x == false and y == true then AchievementBook:Play("2XO", true) end
		if x == true and y == false then AchievementBook:Play("2OX", true) end
		if x == false and y == false then AchievementBook:Play("2XX", true) end
		if x == true and y == true then AchievementBook:Play("2OO", true) end
	elseif AchievementBookPage == 3 then
		local x = GameState["Unlocked 5th Polaroid"]
		local y = GameState["Unlocked 6th Polaroid"]
		if x == false and y == true then AchievementBook:Play("3XO", true) end
		if x == true and y == false then AchievementBook:Play("3OX", true) end
		if x == false and y == false then AchievementBook:Play("3XX", true) end
		if x == true and y == true then AchievementBook:Play("3OO", true) end
	elseif AchievementBookPage == 4 then
		local x = GameState["Unlocked 7th Polaroid"]
		local y = GameState["Unlocked 8th Polaroid"]
		if x == false and y == true then AchievementBook:Play("4XO", true) end
		if x == true and y == false then AchievementBook:Play("4OX", true) end
		if x == false and y == false then AchievementBook:Play("4XX", true) end
		if x == true and y == true then AchievementBook:Play("4OO", true) end
	elseif AchievementBookPage == 5 then
		local x = GameState["Unlocked 9th Polaroid"]
		local y = GameState["Unlocked 10th Polaroid"]
		if x == false and y == true then AchievementBook:Play("5XO", true) end
		if x == true and y == false then AchievementBook:Play("5OX", true) end
		if x == false and y == false then AchievementBook:Play("5XX", true) end
		if x == true and y == true then AchievementBook:Play("5OO", true) end
	end
end

function DEGENMOD:onUpdateAchievementBook(_DEGENMOD)
	if GameState["Enable Babylon Whores"] then
		if Input.IsButtonTriggered(Keyboard.KEY_C, 0) then
			if guiopen == false then
				sound:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12, 1, 0, false, 1)
				guiopen = true
				AchievementBook:Play("Open", true)
			elseif guiopen == true then
				sound:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12, 1, 0, false, 1)
				guiopen = false
				AchievementBook:Play("Close", true)
			end
		end
		
		if AchievementBook:IsFinished("Open") then
			DEGENMOD:PolaroidPageCheck()
		end
		
		if guiopen == true then
			if Input.IsButtonTriggered(Keyboard.KEY_U, 0) and AchievementBookPage ~= 5 then
				AchievementBook:Play("TurnPageRight", false)
			elseif Input.IsButtonTriggered(Keyboard.KEY_Y, 0) and AchievementBookPage ~= 1 then
				AchievementBook:Play("TurnPageLeft", false)
			end
			if AchievementBook:IsFinished("TurnPageRight") then
				sound:Play(SoundEffect.SOUND_PAPER_IN, 1, 0, false, 1)
				AchievementBookPage = AchievementBookPage + 1
				DEGENMOD:PolaroidPageCheck()
			elseif AchievementBook:IsFinished("TurnPageLeft") then
				sound:Play(SoundEffect.SOUND_PAPER_OUT, 1, 0, false, 1)
				AchievementBookPage = AchievementBookPage - 1
				DEGENMOD:PolaroidPageCheck()
			end
		end
		local CenterX, CenterY = GetScreenSize()
		AchievementBook:Render(Vector(CenterX / 2, CenterY / 2), Vector.Zero, Vector.Zero)
		AchievementBook:Update()
	end
end

function DEGENMOD:RegisterNewPolaroid(_DEGENMOD)
	if fb.Variant == 0 then
		CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/achievement_image_unlock.png")
		GameState["Unlocked 1st Polaroid"] = true
	end
end

DEGENMOD:AddCallback(ModCallbacks.MC_POST_RENDER, DEGENMOD.onUpdateAchievementBook)