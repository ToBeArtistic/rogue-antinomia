extends Node


var player_handler : PlayerHandler

func get_player_position() -> Vector3:
	return player_handler.get_player_position()

func spawn_player(command:SpawnPlayerCommand):
	player_handler.spawn_player(command)

func can_interact(command:CanInteractCommand):
	player_handler.can_interact(command)

func clear_player():
	player_handler.clear_player()

func interact():
	player_handler.interact()
