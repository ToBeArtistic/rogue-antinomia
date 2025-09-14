extends Node3D

class_name HudCard3D

@export var card_data : UICardData
@export var card_ui : UICard
@export var mode : card_mode = card_mode.NONE

enum card_mode {NONE, CORE_CARD, AUX_CARD, CANTRIP, SPELL1, SPELL2, SPELL3, SPELL4}

func _ready() -> void:
    if card_data and card_ui:
        card_ui.update(card_data)
    
    match mode:
        card_mode.CORE_CARD:
            Signals.update_core_card.connect(update_card)
        card_mode.AUX_CARD:
            Signals.update_aux_card.connect(update_card)
        
    

func update_card(data : UICardData) -> void:
    card_data = data
    card_ui.update(data)
    
