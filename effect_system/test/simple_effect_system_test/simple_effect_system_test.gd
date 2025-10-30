extends Node

@onready var actor_a : ActorWrapper3D = %ActorA

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("equipment_core"):
		actor_a.actor.activate_core.emit()