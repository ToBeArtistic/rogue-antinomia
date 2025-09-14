extends TextEdit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	var moretext : String
	if GameService.game_handler.current >= GameService.game_handler.goal:
		moretext = "complete"
	else:
		moretext = "ongoing"
	
	text = str(GameService.game_handler.current) + " " + moretext
