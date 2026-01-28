extends Control

@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var continue_button = $HBoxContainer/Panel/VBoxContainer/ContinueButton

func _ready() -> void:
	if user_data.opened_once:
		continue_button.disabled = false

func _on_continue_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_learn_button_pressed() -> void:
	user_data.opened_once = true
	ResourceSaver.save(user_data, "user://user_data.tres")
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_options_button_pressed() -> void:
	pass # Replace with function body.
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_accept_button_pressed() -> void:
	get_child(2).visible = false
	
func _on_decline_button_pressed() -> void:
	get_tree().quit()
