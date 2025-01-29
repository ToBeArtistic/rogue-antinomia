extends Node

var camera_handler : CameraHandler

func set_player_camera(camera:Camera3D):
	camera_handler.set_player_camera(camera)

func get_active_camera() -> Camera3D:
	return camera_handler.get_active_camera()
