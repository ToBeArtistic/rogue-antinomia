extends Node

class_name CanInteractCommand

var interact_object 
var player

func run(player_handler:PlayerHandler):
	player_handler.interact_object = interact_object
