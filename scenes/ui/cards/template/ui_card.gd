extends Control

class_name UICard

@export var text_element : UICardTextElement
@export var image_element : UICardImageElement
@export var charge_bar : UIChargeBar

var card_data : UICardData

func ready() -> void:
    card_data = UICardData.new()

func update_text(new_data : UICardData) -> void:
    if new_data.progress_visible:
        text_element.text_charges.visible = false
    else:
        text_element.text_charges.visible = true
    text_element.update(new_data)

    charge_bar.update(
        new_data.progress_visible, 
        new_data.progress_percentage, 
        new_data.progress_text
    )
    