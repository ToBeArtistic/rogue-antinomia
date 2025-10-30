extends EffectWrapper

class_name TestEffect

func _ready() -> void:
	super._ready()
	effect.apply_to_targetable.connect(apply_effect)

func apply_effect(target:Targetable) -> void:
	print_debug("apply effect on target %s" % target.name)
	target.parent_actor.health -= 10
	print_debug("%s health %d" % [target.parent_actor.name, target.parent_actor.health])
