extends Node3D

func _ready():
	Signals.objective_completed.emit()
