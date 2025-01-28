extends Node3D

class_name PlayerHandler

@export var player_scene : PackedScene

var player : Player
var interact_object

func spawn_player(command:SpawnPlayerCommand):
	command.run(self)

func can_interact(command:CanInteractCommand):
	command.run(self)

func clear_player():
	if player != null:
		player.queue_free()

func interact():
	var params = InteractionParams.new()
	params.player = player
	interact_object.interact(params)
