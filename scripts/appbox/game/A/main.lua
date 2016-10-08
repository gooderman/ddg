local game = import(".game")
local function main()
	print("run game A")
	display.pushScene(game.new(),'fade',1.0)
end
return main