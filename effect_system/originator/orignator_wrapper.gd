extends Node

class_name OriginatorWrapper

@export var originator : Originator

func _ready() -> void:
	Originator.attach_to_wrapper(self, originator)