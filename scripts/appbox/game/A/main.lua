local game = import(".game")
local function main()
	print("run game A")
	display.pushScene(game.new())
end
return main