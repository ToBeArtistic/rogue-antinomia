extends CharacterBody3D

class_name Enemy

signal died()

func hit(data : ProjectileData):
	Signals.create_damage_number.emit(data.damage)

func die():
	Signals.enemy_died.emit(self)
	died.emit()
	queue_free()