@tool
extends Resource

class_name Delivery

signal create_delivery # Each delivery subtype should implement a method that instantiates the delivery method whenever this signal fires
signal confirm_hit(target:Targetable)

@export var name : String

var parent_originator : Originator :
	set(value):
		EffectSystemUtils.print_reference(self, value)
		parent_originator = value

var targets_to_ignore : Array[Targetable] = []

enum TAGS {
	DIRECT_ACTOR_DELIVERY,
	PROJECTILE,
	AREA_OF_EFFECT
} 

static func attach_to_wrapper(wrapper:Node, delivery:Delivery) -> void:
	EffectSystemUtils.check_resource_name_add_if_none(wrapper,delivery,"%s(delivery)")
	EffectSystemUtils.print_attachment(wrapper, delivery)
	var children : Array[Node] = EffectSystemUtils.find_all_children(wrapper)
	for child in children:
		if child.get("effect") and child.get("effect") is Effect:
			var effect : Effect = child.get("effect")
			effect.parent_delivery = delivery
			delivery.confirm_hit.connect(func (target:Targetable) -> void: effect.apply_to_targetable.emit(target))
			
	
