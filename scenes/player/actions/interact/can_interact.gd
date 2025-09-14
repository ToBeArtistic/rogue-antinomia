extends Node

class_name CanInteractCommand

var interact_object : Object
var player : Player

func run(player_handler:PlayerHandler) -> void:
	player_handler.interact_object = interact_object
