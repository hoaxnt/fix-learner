extends Control

@onready var background_panel : Panel = $Background

func _on_resume_button_button_up() -> void:
	hide()
	get_tree().paused = false
# NOTE: FIX THE OPTIONS GOING TO MAIN MENU FROM MENU OPTIONS
func _on_mainmenu_button_button_up() -> void:
	SceneTransition.change_scene("res://scenes/main_menu.tscn")
