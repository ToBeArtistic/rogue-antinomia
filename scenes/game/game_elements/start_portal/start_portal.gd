extends Node3D

class_name StartPortal


func interact(params:InteractionParams):
	Signals.player_interact_with.emit(params.player, self)
