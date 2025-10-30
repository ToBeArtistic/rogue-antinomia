extends Node3D

class_name StartPortal


func interact(params:InteractionParams) -> void:
	Signals.player_interact_with.emit(params.player, self)
