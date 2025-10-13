extends TextureProgressBar



func _ready() -> void:
	Signals.player_data_updated.connect(handle_updated_player_data)

func handle_updated_player_data(data : PlayerData):
	value = data.health
	max_value = data.max_health
