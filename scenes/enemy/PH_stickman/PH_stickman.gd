extends Enemy

@export var sprite : Sprite3D
@export var speed : float = 2.0

@onready var nav_agent = $NavigationAgent3D

@export var health : float = 10.0

var targetPosition : Vector3

func _update_lookat(target):
	targetPosition = target

func _process(delta):
	velocity = Vector3.ZERO
	_update_lookat(PlayerService.get_player_position())
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
	queue_free()
