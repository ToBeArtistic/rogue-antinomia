extends RichTextLabel

class_name UIDamageNumber

var duration : float = 1.3
var tween := create_tween()
var value : float = 0.0

signal remove(number:float)

func _ready() -> void:
    tween.set_parallel(true)
    tween.tween_property(self, "modulate", Color.TRANSPARENT, duration)
    tween.tween_property(self, "position", position + Vector2(randf_range(-450.0, -150.0), randf_range(-150.0, 150.0)), duration)
    tween.tween_property(self, "rotation_degrees", rotation_degrees + randf_range(-10, 10.0), duration)
    tween.set_parallel(false)
    tween.tween_callback(self.queue_free)

func _exit_tree() -> void:
    remove.emit(value)