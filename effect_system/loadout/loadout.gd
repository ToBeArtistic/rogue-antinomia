@tool
extends Resource

class_name Loadout

@export var name : String

var parent_actor : Actor :
	set(value):
		for core in cores:
			core.parent_actor = parent_actor

@export var max_number_of_cores : int = 3
@export var cores : Array[OriginatorCore] = []
@export var starting_modifiers : Array[Modifier] = []

static func attach_to_wrapper(wrapper:Node, loadout:Loadout) -> void:
	EffectSystemUtils.check_resource_name_add_if_none(wrapper,loadout,"%s(loadout)")
	var children : Array[Node] = EffectSystemUtils.find_all_children(wrapper)
	for child in children:
		if child.get("originator"):
			var originator : Originator = child.get("originator")
			originator.parent_loadout = loadout
