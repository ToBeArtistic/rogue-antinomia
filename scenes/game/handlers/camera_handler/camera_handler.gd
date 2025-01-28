extends Node3D

#CameraHandler keeps track of the various cameras in the game, and acts as a message handler for camera switching etc.
#Individual cameras should still be set as children of their relevant nodes
#Cameras should register themselves with the camera handler in _ready()
class_name CameraHandler

var player_camera : Camera3D
var global_camera : Camera3D

func set_player_camera(camera:Camera3D):
	player_camera = camera
