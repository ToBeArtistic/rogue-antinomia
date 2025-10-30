@tool
extends Resource

class_name Effect

signal apply_to_targetable(target:Targetable) 	# Effects must implement a method that handles this

var name : String

var parent_delivery : Delivery :
	set(value):
		EffectSystemUtils.print_reference(self, value)
		parent_delivery = value


@export var identifier : IDENTIFIER = IDENTIFIER.UNASSIGNED

@export_category("Stats")
@export_subgroup("Power")
@export var power : float = 100
@export_subgroup("Boon")
@export var boon : float = 10
@export_range (0, 1) var min_boon : float = 0 
@export_range (0, 1) var max_boon : float = 1 

@export_subgroup("Amplification")
@export var amplification : float = 1.0
@export_subgroup("Critical")
@export var critical : float = 1.0

@export_category("Tags")
@export var tags : Array[TAGS] = []

# Total effect on actor determined by:
var flat_total : float = 0		# = (power+boon-defense)
var mult_total : float = 0 		# = (amplification*critical/resistance)
var total_effect : float = 0 	# = (flat_total * mult_total)

func _get_rng_boon() -> float:
	var rng_boon : float = boon * randf_range(min_boon, max_boon)
	return rng_boon

func calculate_total_effect(actor:Actor) -> float:
	flat_total = (power + _get_rng_boon() - actor.defense)
	mult_total = (amplification * critical / actor.resistance)
	total_effect = (flat_total * mult_total)
	return total_effect

enum IDENTIFIER {
	UNASSIGNED,
	DEAL_IMPACT_DAMAGE

}

enum TAGS {
	HARMLESS,
	WEAK,
	HEAVY
}

enum CALC_FLAG {
	EXCLUDE_DEF = 1<<0
}

static func attach_to_wrapper(wrapper:Node, effect:Effect) -> void:
	EffectSystemUtils.check_resource_name_add_if_none(wrapper,effect,"%s(effect)")
	EffectSystemUtils.print_attachment(wrapper, effect)
