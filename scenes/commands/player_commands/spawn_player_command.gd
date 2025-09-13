class_name SpawnPlayerCommand

var spawn_point : Node3D

func run(player_handler:PlayerHandler) -> void:
	player_handler.player = player_handler.player_scene.instantiate()
	spawn_point.add_child(player_handler.player)
