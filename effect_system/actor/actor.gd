extends Resource

class_name Actor

signal activate_core
signal apply_effect(effect:Effect)

var name : String

@export var health : float = 1000
@export var defense : float = 100
@export var resistance : float = 1
@export var speed : float = 10

var loadouts : Array[Loadout] = []
var child_originators : Array[Originator] = []
var targetables : Array[Targetable] = []


static func attach_to_wrapper(wrapper:Node, actor:Actor) -> void:
	EffectSystemUtils.check_resource_name_add_if_none(wrapper,actor,"%s(actor)")
	EffectSystemUtils.print_attachment(wrapper,actor)
	var children : Array[Node] = EffectSystemUtils.find_all_children(wrapper)
	for child in children:
		if child.get("targetable") and child.get("targetable") is Targetable:
			var targetable : Targetable = child.get("targetable")
			targetable.parent_actor = actor
		if child.get("originator") and child.get("originator") is Originator:
			var originator : Originator = child.get("originator")
			originator.parent_actor = actor
		if child.get("loadout") and child.get("loadout") is Loadout:
			var loadout : Loadout = child.get("loadout")
			loadout.parent_actor = actor