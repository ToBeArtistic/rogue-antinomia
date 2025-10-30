@tool
extends Resource

class_name PlayerGearCollectionEntry

@export var identifier : PlayerGear.GEAR_IDENTIFIER = PlayerGear.GEAR_IDENTIFIER.UNASSIGNED
@export var variant_value : int = 0
@export var copies : int = 1

func _init() -> void:
	resource_local_to_scene = true

