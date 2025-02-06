extends Node3D

class_name RogueAntinomia

# Called when the node enters the scene tree for the first time.
func _ready():
	#Start game
	GameService.game_start(GameStartCommand.new())
	pass


func _input(event):
	if event.is_action("exit_game"):
		get_tree().quit()
