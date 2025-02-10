extends Node3D

class_name Projectile

@onready var projectile_visual : Node3D = $projectile_visual
@onready var hit_raycast : RayCast3D = $hit_raycast
@onready var hit_thing : Node3D = $hit_thing

var current_lifetime : float = 0.0
var projectile_data : ProjectileData
var has_hit : bool = false

func _ready():
	projectile_visual.global_position = projectile_data.origin_visual

func apply_data(data:ProjectileData):
	projectile_data = data
	global_position = projectile_data.origin
	basis = projectile_data.basis

func _process(delta):
	if has_hit:
		pass
	
	var movement = (transform.basis * Vector3(0,0,-1)).normalized() * delta * projectile_data.speed
	hit_raycast.target_position = Vector3(0,0,-projectile_data.speed)
	var collider = hit_raycast.get_collider()
	if collider != null:
		if collider is Enemy:
			collider.hit(projectile_data)
		has_hit = true
		queue_free()
		
	position += movement 
	if projectile_visual.position.length() < 0.1:
		projectile_visual.position = Vector3.ZERO
	else:
		projectile_visual.position = projectile_visual.position * 0.9
	current_lifetime += delta
	if current_lifetime > projectile_data.lifetime:
		queue_free()
