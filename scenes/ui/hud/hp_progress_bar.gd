extends ProgressBar

func _ready():
	Signals.player_data_updated.connect(update_hp_progressbar)
	
func update_hp_progressbar(data : PlayerData):
	value = data.health / data.max_health * 100
