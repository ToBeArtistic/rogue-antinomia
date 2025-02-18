extends CharacterBody3D

class_name Player

var data : PlayerData = PlayerData.new()

var direction = Vector3()
var speed : float = SPEED
const SPEED = 5.0
const MAX_SPEED = 20.0
const ACCELERATION = 6.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Camera variables
var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float
var _mouse_rotation : Vector3

var _player_rotation : Vector3
var _camera_rotation : Vector3

@export var TILT_LOWER_LIMIT := deg_to_rad(-89)
@export var TILT_UPPER_LIMIT := deg_to_rad(89)
@export var CAMERA_CONTROLLER : Camera3D

@export var MOUSE_SENS_Y := 0.5
@export var MOUSE_SENS_X := 0.5

@onready var camera : Camera3D = $camera_player


func _ready():
	Signals.player_select_equipment.emit(self, Enum.EQUIPMENT.PH_RIFLE)
	Signals.player_data_updated.emit(self)

func _input(event):
	if event.is_action("exit_game"):
		get_tree().quit()
	if event.is_action_pressed("equipment_primary"):
		pass
	if event.is_action_pressed("interact"):
		PlayerService.interact()

#Mouse movement handled in this method so that UI inputs will be captured first
func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y

func _update_camera(delta):
	_mouse_rotation.x += _tilt_input * delta * MOUSE_SENS_X
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta * MOUSE_SENS_Y
	
	_player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)
	
	transform.basis = Basis.from_euler(_player_rotation)
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	_rotation_input = 0.0
	_tilt_input = 0.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle camera rotation
	_update_camera(delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		speed = clampf(speed + ACCELERATION * delta, SPEED, MAX_SPEED)
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		Signals.on_player_move.emit(self)
	else:
		speed = clampf(speed - ACCELERATION * delta, SPEED, MAX_SPEED)
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		velocity.z = move_toward(velocity.z, 0, ACCELERATION)
		Signals.on_player_stop.emit(self)

	move_and_slide()
	Signals.player_position_updated.emit(self,global_position)
	
func handle_damage(damage : DamageData):
	damage.damage_player(self)
	
