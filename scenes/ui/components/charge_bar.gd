extends Control

class_name UIChargeBar

@onready var progress_bar_left : ProgressBar = $"progress_bar_left"
@onready var progress_bar_right : ProgressBar = $"progress_bar_right"
@onready var number : RichTextLabel = $"number"

func update(_visible : bool, percentage_progress : float, number_text : String) -> void:
    progress_bar_left.value = percentage_progress
    progress_bar_right.value = percentage_progress
    number.text = number_text
    visible = _visible 