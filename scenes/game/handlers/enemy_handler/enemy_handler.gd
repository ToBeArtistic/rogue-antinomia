extends Node3D

class_name EnemyHandler

@export var enemies : Array[PackedScene]

func get_random_enemy_instance() -> Enemy:
	return enemies.pick_random().instantiate()
