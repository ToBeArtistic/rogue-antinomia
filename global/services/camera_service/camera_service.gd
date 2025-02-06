extends Node

var camera_handler : CameraHandler

func set_player_camera(camera:Camera3D):
	camera_handler.set_player_camera(camera)

func get_active_camera() -> Camera3D:
	return camera_handler.get_active_camera()

func unproject_position(position : Vector3) -> Vector2:
	return get_active_camera().unproject_position(position)

func is_position_behind(position : Vector3) -> bool:
	return get_active_camera().is_position_behind(position)
