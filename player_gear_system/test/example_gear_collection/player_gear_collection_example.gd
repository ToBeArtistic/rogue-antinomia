extends Node

@export var gear_collection : PlayerGearCollection

var string : String = ""

#ALT+K Quick save
#ALT+L Quick load

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quick_save"):
		print_debug("attempting_save")
		GameSaveHandler.save_string(GameSaveHandler.OWNED_GEAR_PATH, "happy tiem")
		print_debug("completed_save")
	if Input.is_action_just_pressed("quick_load"):
		print_debug("attempt_load")
		string = GameSaveHandler.load_string(GameSaveHandler.OWNED_GEAR_PATH)
		print(string)
	
