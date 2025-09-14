extends Node3D

var is_active : bool = true

var bob : float = 0.0
var bobEnabled : bool = false
@export var bobbing_speed_y : float = 5.0
@export var bobbing_speed_x : float = 6.0
@export var bobbing_offset_y : float = 0.001
@export var bobbing_offset_x : float = 0.0002
@export var sprite : Sprite3D
@export var raycast_aim : RayCast3D
@export var projectile_creation_point : Node3D
@export var projectile_scene : PackedScene
var sprite_start_x : float
var sprite_start_y : float
var charge : int = 30
var max_charge : int = 30
var recharge_speed : float = 0.7
var recharge_progress : float = 0.0
var recharging : bool = false

@export var aux_image : Texture2D
@export var core_image : Texture2D

@export var fire_rate : float = 0.05
var _fire_rate_progress : float = 0.0

func _ready() -> void:
	Signals.on_player_move.connect(_on_player_move)
	Signals.on_player_stop.connect(_on_player_stop)
	
	sprite_start_x = sprite.position.x
	sprite_start_y = sprite.position.y

func _process(delta : float) -> void:
	if not is_active:
		return

	_handle_bobbing(delta)
	_handle_firing(delta)
	_handle_recharge(delta)
	_update_ui()

func _handle_bobbing(delta : float) -> void:
	if bobEnabled:
		bob += delta
		var boby : float = bob * bobbing_speed_y
		var bobx : float = bob * bobbing_speed_x
		sprite.position.y += cos(boby) * bobbing_offset_y
		sprite.position.x += cos(bobx) * bobbing_offset_x
	else:
		sprite.position.y += (sprite_start_y - sprite.position.y) * delta * bobbing_speed_y
		sprite.position.x += (sprite_start_x - sprite.position.x) * delta * bobbing_speed_y
	

func _on_player_move(_player : Player) -> void:
	bobEnabled = true
	
func _on_player_stop(_player : Player) -> void:
	bobEnabled = false
	

func _handle_firing(delta : float) -> void:
	#Fire rate should update regardless of whether an attempt is made to fire
	if _fire_rate_progress < fire_rate:
		_fire_rate_progress += delta

	if not Input.is_action_pressed("equipment_primary"):
		return
	_on_equipment_primary()

func _handle_recharge(delta : float) -> void:
	if not recharging and Input.is_action_pressed("recharge") or charge == 0:
		recharging = true

	if recharging:
		recharge_progress += delta
	
	if recharge_progress > recharge_speed:
		recharging = false
		charge = max_charge
		recharge_progress = 0.0

func _on_equipment_primary() -> void:
	if charge <= 0 or recharging:
		return
	
	if _fire_rate_progress < fire_rate:
		return

	_fire_rate_progress -= fire_rate
	charge -= 1

	var data : ProjectileData = ProjectileData.create(
		global_position, 
		projectile_creation_point.global_position, 
		global_transform.basis, 
		projectile_scene
	)
	data.damage = 30 + randi_range(5,17)
	Signals.create_projectile.emit(data)
	
func _update_ui() -> void:
	#Core
	var core_card_data : UICardData = UICardData.new()
	core_card_data.text_name = "PH_Rifle"
	core_card_data.text_control_hint = "[LMB]"
	core_card_data.text_charges = str(charge)
	core_card_data.progress_visible = false
	core_card_data.image = core_image

	if recharging or charge == 0:
		core_card_data.text_control_hint = " "
		core_card_data.progress_percentage = recharge_progress/recharge_speed*100.0
		core_card_data.progress_visible = true
		core_card_data.progress_text = " "#"%0.2f" % recharge_progress

	Signals.update_core_card.emit(core_card_data)

	#Aux
	var aux_card_data : UICardData = UICardData.new()
	aux_card_data.text_name = "PH_Rifle_Spellcasting"
	aux_card_data.text_control_hint = "[RMB]"
	aux_card_data.text_charges = " "
	aux_card_data.progress_visible = false
	aux_card_data.image = aux_image
	Signals.update_aux_card.emit(aux_card_data)
