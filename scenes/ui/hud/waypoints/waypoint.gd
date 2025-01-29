extends Node3D

class_name Waypoint
# Called when the node enters the scene tree for the first time.
func _ready():
	UIService.register_waypoint(self)

func _exit_tree():
	UIService.remove_waypoint(self)
