extends Node3D

#CameraHandler keeps track of the various cameras in the game, and acts as a message handler for camera switching etc.
#Individual cameras should still be set as children of their relevant nodes
#Cameras should register themselves with the camera handler in _ready()
class_name CameraHandler

var player_camera : Camera3D = null
var global_camera : Camera3D = null

func set_player_camera(camera:Camera3D):
	player_camera = camera

func get_active_camera() -> Camera3D:
	if player_camera != null:
		if player_camera.current:
			return player_camera
	if global_camera != null:
		if global_camera.current:
			return global_camera
	return null
	pass
