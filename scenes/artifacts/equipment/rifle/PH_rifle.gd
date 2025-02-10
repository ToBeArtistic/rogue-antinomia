extends Node3D

var bob : float = 0.0
var bobEnabled : bool = false
@export var bobbing_speed_y : float = 5.0
@export var bobbing_speed_x : float = 6.0
@export var bobbing_offset_y : float = 0.001
@export var bobbing_offset_x : float = 0.0002
@export var sprite : Sprite3D
@export var raycast_aim : RayCast3D
@export var projectile_creation_point : Node3D
@export var projectile_scene : PackedScene
var sprite_start_x : float
var sprite_start_y : float

@export var fire_rate : float = 0.1
var _fire_rate : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.on_player_move.connect(_on_player_move)
	Signals.on_player_stop.connect(_on_player_stop)
	
	sprite_start_x = sprite.position.x
	sprite_start_y = sprite.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_bobbing(delta)
	_handle_firing(delta)

func _handle_bobbing(delta):
	if bobEnabled:
		bob += delta
		var boby = bob * bobbing_speed_y
		var bobx = bob * bobbing_speed_x
		sprite.position.y += cos(boby) * bobbing_offset_y
		sprite.position.x += cos(bobx) * bobbing_offset_x
	else:
		sprite.position.y += (sprite_start_y - sprite.position.y) * delta * bobbing_speed_y
		sprite.position.x += (sprite_start_x - sprite.position.x) * delta * bobbing_speed_y
	

func _on_player_move(player : Player):
	bobEnabled = true
	
func _on_player_stop(player : Player):
	bobEnabled = false
	

func _handle_firing(delta):
	if Input.is_action_pressed("equipment_primary"):
		_on_equipment_primary(delta)

func _on_equipment_primary(delta):
	if _fire_rate > 0.0:
		_fire_rate -= delta
		return
	_fire_rate += fire_rate
	var data = ProjectileData.create(
		global_position, 
		projectile_creation_point.global_position, 
		global_transform.basis, 
		projectile_scene
	)
	Signals.create_projectile.emit(data)
	
