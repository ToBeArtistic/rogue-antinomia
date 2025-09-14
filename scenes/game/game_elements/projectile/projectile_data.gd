extends Node

class_name ProjectileData

var origin : Vector3
var origin_visual : Vector3
var basis : Basis

var speed : float = 400.0
var lifetime : float = 3.0
var scene : PackedScene

var damage : float = 1000.0

static func create(_origin : Vector3, _origin_visual : Vector3, _basis : Basis, _scene : PackedScene) -> ProjectileData:
	var data : ProjectileData = ProjectileData.new()
	data.origin = _origin
	data.origin_visual = _origin_visual
	data.basis = _basis
	data.scene = _scene
	return data
