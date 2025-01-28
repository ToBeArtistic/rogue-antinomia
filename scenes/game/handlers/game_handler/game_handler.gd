extends Node3D

class_name GameHandler


func game_start(command:GameStartCommand):
	LevelService.select_hub_area()
