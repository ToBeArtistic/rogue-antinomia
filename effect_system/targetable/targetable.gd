extends Resource

class_name Targetable
#Targetable confirms or denies hits from deliveries, then passes the effect on to the parent actor
#Targetables may apply modifiers to effects

signal confirm_hit(delivery:Delivery)
signal ignore_hit(delivery:Delivery)
signal try_hit(deliveries:Delivery)

var name : String

var parent_actor : Actor :
	set(value):
		EffectSystemUtils.print_reference(self, value)
		if value.targetables.has(self):
			return
		value.targetables.append(self)
		parent_actor = value

static func attach_to_wrapper(wrapper:Node, targetable:Targetable) -> void:
	EffectSystemUtils.check_resource_name_add_if_none(wrapper,targetable,"%s(targetable)")
	EffectSystemUtils.print_attachment(wrapper, targetable)
