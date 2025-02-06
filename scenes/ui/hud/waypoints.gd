extends CenterContainer

class_name WaypointDrawer

@export var waypoint_size : float = 5.0
@export var waypoint_color : Color = Color.AQUA

func _process(_delta):
	self.queue_redraw()

func _draw():
	var waypoints : Array[Waypoint] = UIService.get_waypoints()	
	if waypoints == null:
		return
	for waypoint in waypoints:
		var screenspace_vector : Vector2 = CameraService.unproject_position(waypoint.global_position)
		var is_behind : bool = CameraService.is_position_behind(waypoint.global_position)
		if !is_behind:
			draw_circle(UIService.get_hud().get_clamped_vector2(screenspace_vector), waypoint_size, waypoint_color)
		else:
			draw_circle(UIService.get_hud().get_edge_vector2(screenspace_vector, true), waypoint_size, waypoint_color)
		
