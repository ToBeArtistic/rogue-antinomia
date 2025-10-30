extends Node3D

class_name TargetableWrapper3D

@export var targetable : Targetable

func _ready() -> void:
	Targetable.attach_to_wrapper(self, targetable)
	targetable.confirm_hit.connect(log_hit_from_delivery)

func log_hit_from_delivery(delivery:Delivery) -> void:
	print_debug("%s hit by %s" % [name, delivery.name])