extends Node3D

class_name Projectile

const LIFETIME : float = 1
const SPEED : float = 20.0
const DAMAGE : float = 2.0

var current_lifetime : float = 0.0

var has_hit : bool = false

@export var sprite : Sprite3D
@export var raycast : RayCast3D

func _process(delta):
	var movement = (transform.basis * Vector3(0,0,-SPEED)) * delta 
	raycast.target_position = movement
	_handle_hits()
	position += movement
	current_lifetime += delta
	if current_lifetime > LIFETIME or has_hit:
		queue_free()

func _handle_hits():
	if !raycast.is_colliding():
		return
	var collider = raycast.get_collider()
	if !collider.is_in_group("enemy"):
		return
	collider.take_damage(DAMAGE)
	has_hit = true
	


