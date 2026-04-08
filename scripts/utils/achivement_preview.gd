extends Panel

@onready var display = $VBoxContainer/Display
@onready var close_button = $VBoxContainer/CloseButton
@onready var protocol_master = preload("res://assets/ui/achievement/protocol-master.jpg")
@onready var hazard_handler = preload("res://assets/ui/achievement/hazard.PNG")

func _ready() -> void:
	display.texture = hazard_handler
		
