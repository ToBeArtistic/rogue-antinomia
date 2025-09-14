extends TextureProgressBar



func _ready():
	Signals.player_data_updated.connect(handle_updated_player_data)

func handle_updated_player_data(player : Player):
	value = player.data.health
	max_value = player.data.max_health
