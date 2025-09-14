extends Control

class_name UIHandler

@onready var hud : Hud = $hud
@onready var menus : CanvasLayer = $menus

func _ready() -> void:
	UIService.ui_handler = self
	Signals.pause_game.connect(handle_pause)
	Signals.unpause_game.connect(handle_unpause)
	Signals.start_game.connect(handle_unpause)
	Signals.toggle_mouse_visibility.connect(toggle_mouse)

func show_interact(command:ShowInteractCommand) -> void:
	command.run(self)

var waypoints : Array[Waypoint] = []
func register_waypoint(waypoint:Waypoint) -> void:
	waypoints.push_back(waypoint)
	print_debug("waypoint registered")

func remove_waypoint(waypoint:Waypoint) -> void:
	waypoints.erase(waypoint)

func get_waypoints() -> Array[Waypoint]:
	return waypoints

func get_hud() -> Hud:
	return hud

func handle_pause() -> void:
	hud.visible = false
	menus.visible = true
	toggle_mouse()

func handle_unpause() -> void:
	hud.visible = true
	menus.visible = false
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		toggle_mouse()

func toggle_mouse() -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
