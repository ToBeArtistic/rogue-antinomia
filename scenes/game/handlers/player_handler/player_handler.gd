extends Node3D

class_name PlayerHandler

@export var player_scene : PackedScene

var player : Player
var interact_object

func _ready():
	PlayerService.player_handler = self

func get_player_position() -> Vector3:
	return player.global_position
	
func spawn_player(command:SpawnPlayerCommand):
	command.run(self)

func can_interact(command:CanInteractCommand):
	command.run(self)

func clear_player():
	if player != null:
		player.queue_free()

func interact():
	var params = InteractionParams.new()
	params.player = player
	interact_object.interact(params)

func _process(_delta: float) -> void:
	if player.global_position.y < -200.0:
		clear_player()
		var spawn_cmd = SpawnPlayerCommand.new()
		spawn_cmd.spawn_point = LevelService.get_player_spawn()
		spawn_player(spawn_cmd)
