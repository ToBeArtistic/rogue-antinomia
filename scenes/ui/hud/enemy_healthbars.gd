extends Control

class_name UIEnemyHealthbarHandler

@export var healthbar_scene : PackedScene

func _ready() -> void:
	Signals.create_enemy_healthbar.connect(create_enemy_healthbar)

func create_enemy_healthbar(data: UIEnemyHealthBarData) -> void:
	var healthbar : UIEnemyHealthbar = healthbar_scene.instantiate()
	healthbar.data = data
	add_child(healthbar)
