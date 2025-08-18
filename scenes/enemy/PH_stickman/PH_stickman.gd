extends Enemy

@export var sprite : Sprite3D
@export var speed : float = 2.0

@onready var nav_agent = $NavigationAgent3D

@export var health : float = 500.0

var target_player : Player
var targetPosition : Vector3
var can_attack : bool = true
var attack_interval : float = 2

func _ready():
	Signals.player_position_updated.connect(_update_lookat)

func _update_lookat(player, target):
	targetPosition = target
	target_player = player

func _process(_delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(targetPosition)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	look_at(targetPosition, Vector3.UP)
	move_and_slide()

func take_damage(amount:float):
	health -= amount
	if(health<=0):
		die()

func hit(data:ProjectileData):
	super(data)
	take_damage(data.damage)

func attack_player(player : Player):
	var damage = DamageData.new()
	damage.damage = 20
	player.handle_damage(damage)
	
	
