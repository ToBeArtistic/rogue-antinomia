extends RichTextLabel

func _ready() -> void:
	Signals.player_data_updated.connect(update_hp_value)
	
func update_hp_value(data : PlayerData) -> void:
	var format_text : String = "%s"
	text = format_text % data.health