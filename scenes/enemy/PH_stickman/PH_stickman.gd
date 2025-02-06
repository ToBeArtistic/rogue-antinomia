extends Enemy

@export var sprite : Sprite3D
@export var speed : float = 2.0

@onready var nav_agent = $NavigationAgent3D

@export var health : float = 500.0

var targetPosition : Vector3

func _ready():
	Signals.player_position_updated.connect(_update_lookat)

func _update_lookat(player, target):
	targetPosition = target

func _process(delta):
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

func die():
	Signals.enemy_died.emit(self)
	queue_free()

func hit(data:ProjectileData):
	take_damage(data.damage)
