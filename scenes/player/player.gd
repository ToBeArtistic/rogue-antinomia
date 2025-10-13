extends CharacterBody3D

class_name Player

var data : PlayerData = PlayerData.new()

var direction : Vector3 = Vector3()
var speed : float = STARTING_SPEED
var acceleration : float = ACCELERATION
var slowdown_acceleration : float = SLOWDOWN_ACCELERATION
var max_speed : float = MAX_SPEED
var dash_timer : float = 0.0
var dash_cooldown : float = 0.0
var dash_active : bool = false
var double_jump : bool = true

var coyote_timer : float = 0.0

const STARTING_SPEED = 8.0
const MAX_SPEED = 30.0
const MAX_OVERSPEED = 80.0
const ACCELERATION = 10.0
const SLOWDOWN_ACCELERATION = 5.0
const AIR_ACCELERATION = 0.7
const SLOWDOWN_AIR_ACCELERATION = 0.5
const JUMP_VELOCITY = 30.0
const DOUBLE_JUMP_FACTOR = 1.3
const DASH_VELOCITY = 1000.0
const DASH_ACTIVATION_TIME = 0.2
const DASH_COOLDOWN = 0.3
const COYOTE_TIME = 0.3

var gravity : float = 60.0

#Camera variables
var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float
var _mouse_rotation : Vector3

var _player_rotation : Vector3
var _camera_rotation : Vector3

@export var debug_mode : bool

@export var TILT_LOWER_LIMIT := deg_to_rad(-89)
@export var TILT_UPPER_LIMIT := deg_to_rad(89)
@export var CAMERA_CONTROLLER : Camera3D

@export var MOUSE_SENS_Y := 0.5
@export var MOUSE_SENS_X := 0.5

@onready var camera : Camera3D = $camera_player


func _ready() -> void:
	Signals.player_select_equipment.emit(self, Enum.EQUIPMENT.PH_RIFLE)
	Signals.player_data_updated.emit(self.data)

func _input(event : InputEvent) -> void:
	if event.is_action("exit_game"):
		get_tree().quit()
	if event.is_action_pressed("equipment_primary"):
		pass
	if event.is_action_pressed("interact"):
		PlayerService.interact()
	if debug_mode:
		debug(event)

#Mouse movement handled in this method so that UI inputs will be captured first
func _unhandled_input(event : InputEvent) -> void:
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y

func _update_camera(delta: float) -> void:
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

func _physics_process(delta : float) -> void:
	var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	acceleration = ACCELERATION
	slowdown_acceleration = SLOWDOWN_ACCELERATION
	max_speed = MAX_SPEED
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		coyote_timer -= delta
		acceleration = AIR_ACCELERATION
		slowdown_acceleration = SLOWDOWN_AIR_ACCELERATION
	else:
		coyote_timer = COYOTE_TIME
		double_jump = true

	if Input.is_action_pressed("dash") and dash_cooldown < 0.01:
		dash_active = true
		dash_timer = DASH_ACTIVATION_TIME
		dash_cooldown = DASH_COOLDOWN
	
	if dash_cooldown > 0.01:
		dash_cooldown -= delta
	
	if dash_timer < 0.01:
		dash_active = false
	
	if dash_active:
		acceleration = DASH_VELOCITY
		max_speed = MAX_OVERSPEED
		dash_timer -= delta
		
	if input_dir.length() < 0.01 and dash_active:
		input_dir.y -= 1.0
		
	if input_dir.length() < 0.01:
		acceleration = SLOWDOWN_ACCELERATION	
	
	handle_jump()

	# Handle camera rotation
	_update_camera(delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var velocity_direction = Vector3(velocity.x, 0.0, velocity.z).normalized()
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		speed = clampf(speed + acceleration * delta, STARTING_SPEED, max_speed)
		velocity.x = (direction.x * speed + 7 * velocity.x) / 8
		velocity.z = (direction.z * speed + 7 * velocity.z) / 8
		Signals.on_player_move.emit(self)
	else:
		speed = clampf(speed - slowdown_acceleration * 10 * delta, STARTING_SPEED, max_speed)
		Signals.on_player_stop.emit(self)
		velocity.x = move_toward(velocity.x, 0, slowdown_acceleration)
		velocity.z = move_toward(velocity.z, 0, slowdown_acceleration)

	move_and_slide()
	Signals.player_position_updated.emit(self,global_position)
	data.velocity = velocity.length()
	Signals.player_data_updated.emit(self.data)
	
func handle_damage(damage : DamageData) -> void:
	damage.damage_player(self)
	
func debug(event : InputEvent) -> void:
	if event.is_action_pressed("debug_take_damage"):
			data.health = data.health - 10
			Signals.player_data_updated.emit(data)

func handle_jump() -> void:
	if not Input.is_action_just_pressed("jump"): 
		return
	var jump_velocity : float = JUMP_VELOCITY
	if not (coyote_timer >= 0.0 or double_jump):
		return
	if not coyote_timer >= 0.0 and double_jump:
		double_jump = false
		jump_velocity = JUMP_VELOCITY / DOUBLE_JUMP_FACTOR
	velocity.y = jump_velocity

func hit(projectile_data : ProjectileData) -> void:
	if not projectile_data:
		return
	handle_damage(projectile_data.get_damage_data())