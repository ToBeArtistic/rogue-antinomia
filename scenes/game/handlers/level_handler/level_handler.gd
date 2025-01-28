extends Node3D

class_name LevelHandler

@export var hub_area : PackedScene
@export var levels : Array[PackedScene]

var current_level
var level_index = -1

func get_player_spawn() -> Node3D:
	for child in current_level.find_children("player_spawn*"):
		if child is Node3D and child.is_in_group("player_spawn"):
			return child
	print_debug(current_level)		
	push_error("No player spawn found in current level")
	return null

func clear_level():
	if current_level != null:
		current_level.queue_free()
		
func select_hub_area():
	select_level(hub_area)
	level_index = -1
	

func next_level():
	var level_scene = levels[level_index+1]
	select_level(level_scene)
	level_index += 1

func select_level(level_scene : PackedScene):
	if level_scene == null:
		push_error("level not defined")
		return
	clear_player()
	clear_level()
	current_level = level_scene.instantiate()
	add_child(current_level)
	spawn_player()

func spawn_player():
	var spawn_point = get_player_spawn()
	var command = SpawnPlayerCommand.new()
	command.spawn_point = spawn_point
	PlayerService.spawn_player(command)

func clear_player():
	PlayerService.clear_player()
