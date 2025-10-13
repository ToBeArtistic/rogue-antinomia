extends Node3D

class_name Projectile

@export var projectile_visual : Node3D
@export var hit_raycast : RayCast3D
@export var hitbox : RigidBody3D
@export var hitbox_collision_object : Node3D
@export var hit_sound : AudioStreamPlayer3D
@export var fire_sound : AudioStreamPlayer3D
@export var target_mode : PROJECTILE_TARGETABLE = PROJECTILE_TARGETABLE.TARGET_ENEMY

enum PROJECTILE_TARGETABLE {TARGET_PLAYER, TARGET_ENEMY, TARGET_OBJECT}

var current_lifetime : float = 0.0
var projectile_data : ProjectileData
var has_hit : bool = false

func _ready() -> void:
	projectile_visual.global_position = projectile_data.origin_visual
	
	#Hitbox initialization
	hitbox.contact_monitor = true
	hitbox.max_contacts_reported = 100 #High number of contacts reported allow for reporting despite imminent collision with a lot of geometry
	hitbox.body_entered.connect(handle_hit)
	
	#Handle lifetime
	var lifetime_timer : Timer = Timer.new()
	lifetime_timer.wait_time = projectile_data.lifetime
	lifetime_timer.timeout.connect(post_hit)
	add_child(lifetime_timer)
	lifetime_timer.start()

	if fire_sound:
		fire_sound.pitch_scale += randf_range(-0.1, 0.1)
		fire_sound.play()

func apply_data(data:ProjectileData) -> void:
	projectile_data = data
	transform.origin = projectile_data.origin
	basis = projectile_data.basis

	if not hitbox or not hitbox_collision_object:
		pass
	#hitbox_collision_object.scale.y = projectile_data.speed


func _process(delta : float) -> void:
	if not projectile_data:
		return

	if has_hit:
		pass
	
	if hit_raycast:
		check_raycast()

	var movement : Vector3 = (transform.basis * Vector3(0,0,-1)).normalized() * delta * projectile_data.speed
	position += movement 
	if projectile_visual.position.length() < 0.1:
		projectile_visual.position = Vector3.ZERO
	else:
		projectile_visual.position = projectile_visual.position * 0.9
	current_lifetime += delta

func check_raycast() -> void:
	hit_raycast.target_position = Vector3(0,0,-projectile_data.speed)
	var collider : CollisionObject3D = hit_raycast.get_collider()
	if collider != null:
		handle_hit(collider)

func handle_hit(node : Node) -> void:
	var hit_enemy : bool = node is Enemy and target_mode == PROJECTILE_TARGETABLE.TARGET_ENEMY
	var hit_player : bool = node is Player and target_mode == PROJECTILE_TARGETABLE.TARGET_PLAYER
	var hit_object : bool = target_mode == PROJECTILE_TARGETABLE.TARGET_OBJECT

	#We ignore enemy nodes if we're not trying to target them, and the same for player nodes
	var avoid_enemy : bool = node is Enemy and target_mode != PROJECTILE_TARGETABLE.TARGET_ENEMY
	var avoid_player : bool = node is Player and target_mode != PROJECTILE_TARGETABLE.TARGET_PLAYER

	if avoid_enemy or avoid_player:
		return
	if hit_enemy or hit_player or hit_object:
		if projectile_data:
			node.hit(projectile_data)
	play_hit_sound()
	post_hit()
	
func play_hit_sound() -> void:
	if hit_sound:
		hit_sound.pitch_scale = 0.3 + randf_range(-0.1, 0.1)
		hit_sound.play()

#function handles tasks that should be done when projectile is about to be removed
func post_hit() -> void:
	has_hit = true
	var timer : Timer = Timer.new()
	timer.wait_time = 0.8
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start()
