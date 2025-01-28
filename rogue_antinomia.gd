extends Node3D

class_name RogueAntinomia

@export var game_handler : GameHandler
@export var level_handler : LevelHandler
@export var player_handler : PlayerHandler
@export var environment_handler : EnvironmentHandler
@export var camera_handler : CameraHandler
@export var ui_handler : UIHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	#Initialize services
	GameService.game_handler = game_handler
	LevelService.level_handler = level_handler
	PlayerService.player_handler = player_handler
	UIService.ui_handler = ui_handler
	#Start game
	GameService.game_start(GameStartCommand.new())
	pass


func _input(event):
	if event.is_action("exit_game"):
		get_tree().quit()
