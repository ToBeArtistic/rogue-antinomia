extends Node

class_name GameSaveHandler

const OWNED_GEAR_PATH : String = "user://owned_gear.json" 

static func save_string(location:String, data:String) -> void:
	var save_file : FileAccess = FileAccess.open(location, FileAccess.WRITE)
	save_file.store_line(data)
	save_file.close()

static func load_string(location:String) -> String:
	return FileAccess.get_file_as_string(location)
