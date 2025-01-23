extends Node3D

class_name ProjectileEmitter

var projectile = preload("res://projectile.tscn")
var instance
# Fire a projectile toward a point in global space
func fire_at_target(target:Vector3):
	instance = projectile.instantiate()
	instance.global_position = global_position
	ProjectilesGlobal.ADD_CHILD.emit(instance)
	instance.look_at(target, Vector3.UP)
	
	
