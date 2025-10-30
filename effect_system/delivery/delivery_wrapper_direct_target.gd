extends Node

class_name DeliveryWrapperDirectTarget

@export var delivery : Delivery
@export var target : Node
var targetable : Targetable

func _ready() -> void:
	if not "targetable" in target or not target.get("targetable"):
		push_error("%s target node does not have targetable property" % name)
	targetable = target.get("targetable")

	Delivery.attach_to_wrapper(self, delivery)
	delivery.create_delivery.connect(apply_direct_to_target)

func apply_direct_to_target() -> void:
	print_debug("create direct delivery %s" % delivery.name)
	delivery.confirm_hit.emit(targetable)
	targetable.confirm_hit.emit(delivery)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("equipment_primary"):
		delivery.create_delivery.emit()
