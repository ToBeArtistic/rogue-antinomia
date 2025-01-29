extends CanvasLayer

class_name Hud

@export var top : Control
@export var bottom : Control
@export var left : Control
@export var right : Control
@export var center : Control

@export var margin : float = 40.0


func get_clamped_vector2(coordinates:Vector2) -> Vector2:
	var x = clamp(coordinates.x, left.position.x+margin, right.position.x-margin)
	var y = clamp(coordinates.y, top.position.y+margin, bottom.position.y-margin)
	var clamped : Vector2 = Vector2(x,y)
	return clamped

func get_edge_vector2(coordinates:Vector2) -> Vector2:
	var clamped = get_clamped_vector2(coordinates)
	var closest_to_top = clamped.y > (bottom.position.y / 2.0)
	var closest_to_left = left.position.x + clamped.x > (right.position.x / 2.0)
	
	var y : float
	var x : float
	if closest_to_top:
		y = top.position.y + margin
	else:
		y = bottom.position.y - margin
	if closest_to_left:
		x = left.position.x + margin
	else:
		x = right.position.x - margin
	return Vector2(x, y)
