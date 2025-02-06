extends Control

class_name UIHandler

@onready var hud : Hud = $hud

func _ready():
	UIService.ui_handler = self

func show_interact(command:ShowInteractCommand):
	command.run(self)

var waypoints : Array[Waypoint] = []
func register_waypoint(waypoint:Waypoint):
	waypoints.push_back(waypoint)
	print_debug("waypoint registered")

func remove_waypoint(waypoint:Waypoint):
	waypoints.erase(waypoint)

func get_waypoints() -> Array[Waypoint]:
	return waypoints

func get_hud() -> Hud:
	return hud
