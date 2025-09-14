extends CharacterBody3D

class_name Enemy

signal died()
signal healthbar_values_changed()

@export var health : float = 500.0:
	set(value):
		healthbar_values_changed.emit()
		health = value
var max_health : float = health:
	set(value):
		healthbar_values_changed.emit()
		max_health = value
@export var defense : float = 50.0:
	set(value):
		healthbar_values_changed.emit()
		defense = value

func _ready() -> void:
	#Emit signal for UI to pick up for health bar
	var healthbardata : UIEnemyHealthBarData = UIEnemyHealthBarData.new()
	healthbardata.enemy = self
	Signals.create_enemy_healthbar.emit(healthbardata)

func hit(data : ProjectileData) -> void:
	Signals.create_damage_number.emit(data.damage)

func die() -> void:
	Signals.enemy_died.emit(self)
	died.emit()
	queue_free()