extends CanvasLayer

class_name Hud

@export var top : Control
@export var bottom : Control
@export var left : Control
@export var right : Control
@export var center : Control

@export var margin : float = 40.0

@export var damage_number_textbox : RichTextLabel
var damage_number : float = 0.0
var damage_number_timer : Timer

@export var aux_card_container : Control

func _ready() -> void:
	#Signals.create_damage_number.connect(create_damage_number)
	#damage_number_timer = Timer.new()
	#add_child(damage_number_timer)
	#damage_number_timer.timeout.connect(reset_damage_number_text)
	aux_card_container.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("equipment_secondary"):
		aux_card_container.visible = true
	if Input.is_action_just_released("equipment_secondary"):
		aux_card_container.visible = false


func get_clamped_vector2(coordinates:Vector2) -> Vector2:
	var x : float = clamp(coordinates.x, left.position.x+margin, right.position.x-margin)
	var y : float = clamp(coordinates.y, top.position.y+margin, bottom.position.y-margin)
	var clamped : Vector2 = Vector2(x,y)
	return clamped

func get_edge_vector2(coordinates:Vector2, only_sides:bool) -> Vector2:
	var clamped : Vector2 = get_clamped_vector2(coordinates)
	var closest_to_top : float = clamped.y > (bottom.position.y / 2.0)
	var closest_to_left : float = left.position.x + clamped.x > (right.position.x / 2.0)
	
	var y : float
	var x : float
	if closest_to_top:
		y = top.position.y + margin
	else:
		y = bottom.position.y - margin
	if only_sides:
		y = clamped.y
	
	if closest_to_left:
		x = left.position.x + margin
	else:
		x = right.position.x - margin
	return Vector2(x, y)


func create_damage_number(number : float) -> void:
	damage_number = number
	damage_number_textbox.text = str(damage_number).pad_decimals(-1)
	damage_number_timer.start(0.5)

func reset_damage_number_text() -> void:
	damage_number_textbox.text = ""

func get_center() -> Control:
	return center