extends Node

class_name ProjectileData

var origin : Vector3
var origin_visual : Vector3
var basis : Basis

@export var speed : float = 400.0
@export var lifetime : float = 3.0
@export var scene : PackedScene

@export var damage : float = 1000.0
@export var random_bonus_low : float = 0.0
@export var random_bonus_high : float = 0.0

static func create(_origin : Vector3, _origin_visual : Vector3, _basis : Basis, _scene : PackedScene) -> ProjectileData:
	var data : ProjectileData = ProjectileData.new()
	data.origin = _origin
	data.origin_visual = _origin_visual
	data.basis = _basis
	data.scene = _scene
	return data

func get_damage_data() -> DamageData:
	var damage_data : DamageData = DamageData.new()
	damage_data.damage = damage + randf_range(random_bonus_low, random_bonus_high)
	return damage_data