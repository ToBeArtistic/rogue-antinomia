extends Node3D

class_name GameHandler

@export var ph_rifle : PackedScene

var goal : int = 30
var current : int = 0

func _ready() -> void:
	GameService.game_handler = self
	Signals.player_select_equipment.connect(_set_player_equipment)
	Signals.create_projectile.connect(create_projectile)
	Signals.next_level_selected.connect(_reset_objective)
	Signals.enemy_died.connect(_increase_score)

func game_start(_command:GameStartCommand) -> void:
	Signals.start_game.emit()

func _set_player_equipment(player : Player, type : Enum.EQUIPMENT) -> void:
	match type:
		Enum.EQUIPMENT.PH_RIFLE:
			_apply_equipment_scene_to_player(player, ph_rifle)

func _apply_equipment_scene_to_player(player : Player, scene : PackedScene) -> void:
	var instance : Node3D = scene.instantiate()
	player.camera.add_child(instance)

func create_projectile(data : ProjectileData) -> void:
	var instance : Projectile = data.scene.instantiate() as Projectile
	instance.apply_data(data)
	add_child(instance)
	
func _reset_objective() -> void:
	current = 0
	
func _increase_score(_enemy:Enemy) -> void:
	current += 1
	if current >= goal:
		Signals.objective_completed.emit()
