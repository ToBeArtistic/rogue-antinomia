extends Node3D

class_name Waypoint

@export var color : Color = Color.AQUA

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIService.register_waypoint(self)

func _exit_tree() -> void:
	UIService.remove_waypoint(self)
