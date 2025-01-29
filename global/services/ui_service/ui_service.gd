extends Node

var ui_handler : UIHandler

func show_interact(command:ShowInteractCommand):
	ui_handler.show_interact(command)

func register_waypoint(waypoint:Waypoint):
	ui_handler.register_waypoint(waypoint)

func remove_waypoint(waypoint:Waypoint):
	ui_handler.remove_waypoint(waypoint)

func get_waypoints() -> Array[Waypoint]:
	return ui_handler.get_waypoints()
