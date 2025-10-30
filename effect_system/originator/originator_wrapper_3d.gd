extends Node3D

class_name OriginatorWrapper3D

@export var originator : Originator

func _ready() -> void:
	Originator.attach_to_wrapper(self, originator)