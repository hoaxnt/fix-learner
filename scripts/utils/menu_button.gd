extends Button

@export var options_menu : Control

func _on_button_up() -> void:
	options_menu.show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
