extends Node3D

class_name Projectile

@export var projectile_visual : Node3D
@export var hit_raycast : RayCast3D
@export var hitbox : RigidBody3D
@export var hitbox_collision_object : Node3D

var current_lifetime : float = 0.0
var projectile_data : ProjectileData
var has_hit : bool = false

func _ready():
	projectile_visual.global_position = projectile_data.origin_visual
	hitbox.contact_monitor = true
	hitbox.max_contacts_reported = 100
	hitbox.body_entered.connect(handle_hit)

func apply_data(data:ProjectileData):
	projectile_data = data
	transform.origin = projectile_data.origin
	basis = projectile_data.basis

	if not hitbox or not hitbox_collision_object:
		pass
	#hitbox_collision_object.scale.y = projectile_data.speed


func _process(delta):
	if has_hit:
		pass
	
	if hit_raycast:
		check_raycast()

	var movement = (transform.basis * Vector3(0,0,-1)).normalized() * delta * projectile_data.speed
	position += movement 
	if projectile_visual.position.length() < 0.1:
		projectile_visual.position = Vector3.ZERO
	else:
		projectile_visual.position = projectile_visual.position * 0.9
	current_lifetime += delta
	if current_lifetime > projectile_data.lifetime:
		queue_free()

func check_raycast():
	hit_raycast.target_position = Vector3(0,0,-projectile_data.speed)
	var collider = hit_raycast.get_collider()
	if collider != null:
		handle_hit(collider)

func handle_hit(node : Node):
	if node is Enemy:
		node.hit(projectile_data)
		has_hit = true
		queue_free()
	