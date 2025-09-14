extends Node3D
class_name LevelHandler
#Responsible for handling the instancing of levels and keeping track of spawn locations

@export var hub_area : PackedScene
@export var levels : Array[PackedScene]

var current_level : Node3D
var level_index : int = -1

@export var spawn_rate : float = 0.5
@export var spawn_timer : float = 0.0

var objective_complete : bool = true

func _ready() -> void:
	LevelService.level_handler = self
	Signals.start_game.connect(select_hub_area)
	Signals.player_interact_with.connect(_handle_player_interaction)
	Signals.objective_completed.connect(_complete_objective)

func _process(delta : float) -> void:
	if spawn_timer > spawn_rate:
		spawn_enemy()
	else:
		spawn_timer += delta

func get_player_spawn() -> Node3D:
	for child in current_level.find_children("player_spawn*"):
		if child is Node3D and child.is_in_group("player_spawn"):
			return child
	push_error("No player spawn found in current level")
	return null

func get_enemy_spawns() -> Array[Node3D]:
	var spawn_points : Array[Node3D] = []
	for child in current_level.find_children("enemy_spawn*"):
		if child is Node3D and child.is_in_group("enemy_spawn"):
			spawn_points.append(child)
	return spawn_points

func spawn_enemy() -> void:
	spawn_timer = 0.0
	if objective_complete:
		return
	var enemy_spawn_points : Array[Node3D] = get_enemy_spawns()
	if !enemy_spawn_points.size() > 0:
		return
	var spawn_point : Node3D = get_enemy_spawns().pick_random()
	if spawn_point != null:
		spawn_point.add_child(EnemyService.get_random_enemy_instance())

func clear_level() -> void:
	if current_level != null:
		current_level.queue_free()
		
func select_hub_area() -> void:
	select_level(hub_area)
	level_index = -1
	Signals.hub_area_selected.emit()
	

func next_level() -> void:
	if level_index+1 == levels.size():
		select_hub_area()
		return
	
	var level_scene : PackedScene = levels[level_index+1]
	select_level(level_scene)
	level_index += 1
	objective_complete = false
	Signals.next_level_selected.emit()

func select_level(level_scene : PackedScene) -> void:
	if level_scene == null:
		push_error("level not defined")
		return
	clear_player()
	clear_level()
	current_level = level_scene.instantiate()
	add_child(current_level)
	spawn_player()
	spawn_timer = 0.0

func spawn_player() -> void:
	var spawn_point : Node3D = get_player_spawn()
	var command : SpawnPlayerCommand = SpawnPlayerCommand.new()
	command.spawn_point = spawn_point
	PlayerService.spawn_player(command)

func clear_player() -> void:
	PlayerService.clear_player()

func _handle_player_interaction(_player:Player, object:Object) -> void:
	if object is StartPortal && objective_complete:
		next_level()

func _complete_objective() -> void:
	objective_complete = true
