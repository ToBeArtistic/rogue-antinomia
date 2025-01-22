extends Node3D


var bob : float = 0.0
var bobEnabled : bool = false
@export var bobbing_speed_y : float = 5.0
@export var bobbing_speed_x : float = 6.0
@export var bobbing_offset_y : float = 0.001
@export var bobbing_offset_x : float = 0.0002
@export var sprite : Sprite3D
var sprite_start_x : float
var sprite_start_y : float

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerGlobal.connect("PLAYER_MOVING", _on_player_move)
	PlayerGlobal.connect("PLAYER_STOPPED", _on_player_stop)
	sprite_start_x = sprite.position.x
	sprite_start_y = sprite.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_bobbing(delta)

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
	

func _on_player_move():
	bobEnabled = true
	
func _on_player_stop():
	bobEnabled = false
