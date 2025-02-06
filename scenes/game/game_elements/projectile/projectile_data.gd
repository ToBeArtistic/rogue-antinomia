extends Node

class_name ProjectileData

var origin : Vector3
var origin_visual : Vector3
var basis : Basis

var speed : float = 10.0
var lifetime : float = 3.0
var scene : PackedScene

var damage : float = 100.0

static func create(origin : Vector3, origin_visual : Vector3, basis : Basis, scene : PackedScene) -> ProjectileData:
	var data = ProjectileData.new()
	data.origin = origin
	data.origin_visual = origin_visual
	data.basis = basis
	data.scene = scene
	return data
