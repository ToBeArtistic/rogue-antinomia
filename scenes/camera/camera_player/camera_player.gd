extends Camera3D

class_name CameraPlayer

@export var player : Player
@export var interact_raycast : RayCast3D

var interact_object
# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("player camera instantiated")
	current = true
	print_debug("player camera is current camera")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	CameraService.set_player_camera(self)
	pass # Replace with function body.

func _process(_delta):
	fire_interact_cast()
		

func fire_interact_cast():
	interact_object = interact_raycast.get_collider()
	if interact_object != null:
		var can_interact_command = CanInteractCommand.new()
		can_interact_command.interact_object = interact_object
		can_interact_command.player = player
		PlayerService.can_interact(can_interact_command)
