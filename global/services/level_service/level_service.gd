extends Node

var level_handler : LevelHandler
	
func select_hub_area():
	level_handler.select_hub_area()

func get_player_spawn() -> Node3D:
	return level_handler.get_player_spawn()

func next_level():
	level_handler.next_level()
