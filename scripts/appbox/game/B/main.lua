local game = import(".game")
local function main()
	print("run game B")
	display.pushScene(game.new())
end
return main