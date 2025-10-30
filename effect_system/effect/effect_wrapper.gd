extends Node

class_name EffectWrapper

@export var effect : Effect

func _ready() -> void:
	Effect.attach_to_wrapper(self, effect)
