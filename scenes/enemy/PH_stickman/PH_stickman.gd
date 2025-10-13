extends Enemy

@export var sprite : Sprite3D
@export var speed : float = 12.0
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
@export var projectile_data : ProjectileData


var target_player : Player
var targetPosition : Vector3
var can_attack : bool = true
var attack_interval : float = 1.0
var attack_interval_counter : float = 0.0
var attack_timer : Timer = Timer.new()

func _ready() -> void:
	#Connect target for staring at player behavior
	Signals.player_position_updated.connect(_update_lookat)
	#attack_timer.wait_time = attack_interval
	#attack_timer.one_shot = false
	#attack_timer.timeout.connect(fire_projectile)
	#add_child(attack_timer)
	super._ready()

func _update_lookat(player : Player, target : Vector3) -> void:
	targetPosition = target
	target_player = player

func _process(delta : float) -> void:
	velocity = Vector3.ZERO
	nav_agent.set_target_position(targetPosition)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	look_at(targetPosition, Vector3.UP)
	move_and_slide()
	if attack_interval_counter > attack_interval:
		attack_interval_counter = 0.0
		fire_projectile()
	attack_interval_counter += delta

func take_damage(amount:float) -> void:
	health -= amount
	if(health<=0):
		die()

func hit(data:ProjectileData) -> void:
	super(data)
	take_damage(data.get_damage_data().damage)

func attack_player(player : Player) -> void:
	var damage : DamageData = DamageData.new()
	damage.damage = 20
	player.handle_damage(damage)
	
	
func fire_projectile() -> void:
	print_debug("PH_Stickman fire projectile")
	if not projectile_data:
		return
	projectile_data.origin = global_position+Vector3.UP*0.5
	projectile_data.basis = sprite.global_basis
	projectile_data.origin_visual = global_position+Vector3.UP*0.5
	Signals.create_projectile.emit(projectile_data)

	
