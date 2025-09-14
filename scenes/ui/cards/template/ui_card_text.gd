extends Control

class_name UICardTextElement

@export var text_name : RichTextLabel
@export var text_duration : RichTextLabel
@export var text_charges : RichTextLabel
@export var text_control_hint : RichTextLabel

func update(data : UICardData) -> void:
    if data.text_name:
        text_name.text = data.text_name
    if data.text_duration:
        text_duration.text = data.text_duration
    if data.text_charges:
        text_charges.text = data.text_charges
    if data.text_control_hint:
        text_control_hint.text = data.text_control_hint

