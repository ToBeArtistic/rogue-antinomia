extends Node

#Autoload GameService

var game_handler : GameHandler

func game_start(command:GameStartCommand):
	game_handler.game_start(command)

