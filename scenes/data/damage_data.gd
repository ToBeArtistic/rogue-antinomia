extends Node

class_name DamageData

var damage : float = 10

func damage_player(player : Player):
	player.data.health -= damage
	Signals.player_data_updated.emit()
