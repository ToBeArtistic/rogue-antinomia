extends Node

var enemy_handler : EnemyHandler

func get_random_enemy_instance() -> Enemy:
	return enemy_handler.get_random_enemy_instance()
	
func enemy_killed(enemy : Enemy):
	enemy_handler.enemy_killed()
