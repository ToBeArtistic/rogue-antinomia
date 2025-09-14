extends Control

class_name HudControls

@export var damage_number_scene : PackedScene
@export var dps_number_element : RichTextLabel

var dps : float = 0.0

func _ready() -> void:
	Signals.create_damage_number.connect(create_damage_number_popup)

func create_damage_number_popup(number : float) -> void:
	var damage_number : UIDamageNumber = damage_number_scene.instantiate()
	damage_number.text = "%0.0f" % number
	damage_number.value = number
	add_child(damage_number)
	dps += number
	damage_number.remove.connect(subtract_damage_number)

func _process(_delta: float) -> void:
	if dps > 1:
		dps_number_element.text = "%0.0f" % dps
	else: 
		dps_number_element.text = " "

func subtract_damage_number(number : float) -> void:
	dps -= number
	
