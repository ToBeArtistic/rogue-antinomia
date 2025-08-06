extends Node3D

class_name RogueAntinomia

# Called when the node enters the scene tree for the first time.
func _ready():
	#Start game
	GameService.game_start(GameStartCommand.new())
	pass

var paused : bool = false

func _input(event):
	if event.is_action_pressed("exit_game"):
		get_tree().quit()
	if event.is_action_pressed("pause"):
		paused = !paused
		if paused:
			Signals.pause_game.emit()
		else:
			Signals.unpause_game.emit()
	if event.is_action("show_mouse"):
		Signals.toggle_mouse_visibility.emit()
