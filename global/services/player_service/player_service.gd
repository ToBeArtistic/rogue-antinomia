extends Node


var player_handler : PlayerHandler

func get_player_position() -> Vector3:
	return player_handler.get_player_position()

func spawn_player(command:SpawnPlayerCommand) -> void:
	player_handler.spawn_player(command)

func can_interact(command:CanInteractCommand) -> void:
	player_handler.can_interact(command)

func clear_player() -> void:
	player_handler.clear_player()

func interact() -> void:
	player_handler.interact()
