extends Node3D

class_name GameHandler

@export var ph_rifle : PackedScene

var goal : int = 2
var current : int = 0

func _ready():
	GameService.game_handler = self
	Signals.player_select_equipment.connect(_set_player_equipment)
	Signals.create_projectile.connect(create_projectile)
	Signals.next_level_selected.connect(_reset_objective)
	Signals.enemy_died.connect(_increase_score)

func game_start(command:GameStartCommand):
	Signals.start_game.emit()

func _set_player_equipment(player : Player, type : Enum.EQUIPMENT):
	match type:
		Enum.EQUIPMENT.PH_RIFLE:
			_apply_equipment_scene_to_player(player, ph_rifle)

func _apply_equipment_scene_to_player(player : Player, scene : PackedScene):
	var instance = scene.instantiate()
	player.camera.add_child(instance)

func create_projectile(data : ProjectileData):
	var instance = data.scene.instantiate() as Projectile
	instance.projectile_data = data
	print_debug(instance)
	add_child(instance)
	
func _reset_objective():
	current = 0
	
func _increase_score(enemy:Enemy):
	current += 1
	if current >= goal:
		Signals.objective_completed.emit()
