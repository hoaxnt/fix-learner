extends Panel

@onready var display = $VBoxContainer/Display
@onready var close_button = $VBoxContainer/CloseButton

func _on_close_button_pressed() -> void:
	get_parent().hide()
