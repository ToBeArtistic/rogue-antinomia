extends CenterContainer

@export var DOT_RADIUS : float = 1.3
@export var DOT_COLOR : Color = Color.WHITE_SMOKE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

	
func _draw():
	draw_circle(Vector2(0,0), DOT_RADIUS, DOT_COLOR)
