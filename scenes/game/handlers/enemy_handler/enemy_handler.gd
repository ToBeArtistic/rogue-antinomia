extends Node3D

class_name EnemyHandler

@export var enemies : Array[PackedScene]

func _ready() -> void:
	EnemyService.enemy_handler = self

func get_random_enemy_instance() -> Enemy:
	var enemy : Enemy = enemies.pick_random().instantiate()
	enemy.died.connect(enemy_killed)
	return enemy

func enemy_killed() -> void:
	print_debug("enemy died")
