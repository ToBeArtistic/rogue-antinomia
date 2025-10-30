@tool
extends Resource

class_name Originator

signal try_send_delivery

var name : String
@export var identifier : IDENTIFIER = IDENTIFIER.UNASSIGNED
@export_subgroup("Stats")
@export var frequency : float = 1.0
@export var charges : int = 10
@export var cooldown : float = 2.0
@export_subgroup("Tags")
@export var tags : Array[TAGS] = []

var parent_originator : Originator :
	set(value):
		EffectSystemUtils.print_reference(self, value)
		parent_originator = value
var parent_actor : Actor :
	set(value):
		EffectSystemUtils.print_reference(self, value)
		parent_actor = value
var parent_loadout : Loadout :
	set(value):
		EffectSystemUtils.print_reference(self, value)
		parent_loadout = value

var child_originators : Array[Originator] = []

enum TAGS {
	CORE,
	SKILL,
	PASSIVE,
	WEAPON,
	SPELL,
	RIFLE,
	GRENADE
}

enum IDENTIFIER {
	UNASSIGNED

}

static func attach_to_wrapper(wrapper:Node, originator:Originator) -> void:
	EffectSystemUtils.check_resource_name_add_if_none(wrapper,originator,"%s(originator)")
	EffectSystemUtils.print_attachment(wrapper, originator)
	var children : Array[Node] = EffectSystemUtils.find_all_children(wrapper)
	for child in children:
		if child.get("originator"):
			var child_originator : Originator = child.get("originator")
			child_originator.parent_originator = originator
		if child.get("delivery"):
			var delivery : Delivery = child.get("delivery")
			delivery.parent_originator = originator
	