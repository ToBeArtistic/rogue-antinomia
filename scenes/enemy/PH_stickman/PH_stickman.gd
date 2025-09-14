extends Enemy

@export var sprite : Sprite3D
@export var speed : float = 12.0
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D


var target_player : Player
var targetPosition : Vector3
var can_attack : bool = true
var attack_interval : float = 2

func _ready() -> void:
	#Connect target for staring at player behavior
	Signals.player_position_updated.connect(_update_lookat)
	super._ready()

func _update_lookat(player : Player, target : Vector3) -> void:
	targetPosition = target
	target_player = player

func _process(_delta : float) -> void:
	velocity = Vector3.ZERO
	nav_agent.set_target_position(targetPosition)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	look_at(targetPosition, Vector3.UP)
	move_and_slide()

func take_damage(amount:float) -> void:
	health -= amount
	if(health<=0):
		die()

func hit(data:ProjectileData) -> void:
	super(data)
	take_damage(data.damage)

func attack_player(player : Player) -> void:
	var damage : DamageData = DamageData.new()
	damage.damage = 20
	player.handle_damage(damage)
	
	
