extends CharacterBody3D

class_name Enemy

signal died()

func hit(data : ProjectileData):
	print_debug(data.damage)
