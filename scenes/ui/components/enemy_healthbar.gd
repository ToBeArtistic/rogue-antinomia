extends UIChargeBar

class_name UIEnemyHealthbar

var data : UIEnemyHealthBarData

@onready var defense_bar_left : ProgressBar = $"defense_bar_left"
@onready var defense_bar_right : ProgressBar = $"defense_bar_right"

func _ready() -> void: 
	data.enemy.tree_exited.connect(queue_free)
	data.enemy.healthbar_values_changed.connect(update_enemy_health_bar)
	scale = scale * 0.9
	update_enemy_health_bar()
	

func update_enemy_health_bar() -> void:
	if not data:
		return
	
	var health_pct : float = data.enemy.health / data.enemy.max_health * 100.0
	update(true, health_pct, str(data.enemy.health))
	var defense_pct : float = data.enemy.defense / 400 * 100.0
	defense_bar_left.value = defense_pct
	defense_bar_right.value = defense_pct
	
func _process(_delta: float) -> void:
	if not data:
		return

	var screenspace_vector : Vector2 = CameraService.unproject_position(data.enemy.global_position)
	screenspace_vector = UIService.get_hud().get_clamped_vector2(screenspace_vector)
	position = screenspace_vector + Vector2(0, -100)
	var distance_from_center : float = (UIService.get_hud().get_center().position - position).length()
	if distance_from_center > 170.0: 
		visible = false
	else:
		visible = true
		scale = Vector2(1.0,1.0)*(180-distance_from_center)/110.0
		z_index = 100-int(distance_from_center)