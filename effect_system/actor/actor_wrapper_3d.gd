extends Node3D

class_name ActorWrapper3D

@export var identifier : String
@export var actor : Actor

func _ready() -> void:
	Actor.attach_to_wrapper(self, actor)
