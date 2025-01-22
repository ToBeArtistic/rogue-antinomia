extends CharacterBody3D


@export var sprite : Sprite3D
@export var speed : float = 2.0

@onready var nav_agent = $NavigationAgent3D

var targetPosition : Vector3

func _ready():
	PlayerGlobal.connect("PLAYER_POSITION_UPDATED", _update_lookat)

func _update_lookat(target):
	targetPosition = target

func _process(delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(targetPosition)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	look_at(targetPosition, Vector3.UP)
	move_and_slide()

