extends ProgressBar

func _ready() -> void:
	Signals.player_data_updated.connect(update_hp_progressbar)
	
func update_hp_progressbar(data : PlayerData) -> void:
	value = data.health / data.max_health * 100
