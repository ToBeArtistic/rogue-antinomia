extends RichTextLabel

func _ready():
	Signals.player_data_updated.connect(update_hp_value)
	
func update_hp_value(data : PlayerData):
	var format_text = "%s"
	text = format_text % data.health
