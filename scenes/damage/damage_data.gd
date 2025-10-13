extends Node

class_name DamageData

var damage : float = 10

func damage_player(player : Player) -> void:
	if not player:
		return
	player.data.health -= damage
	Signals.player_data_updated.emit(player.data)
