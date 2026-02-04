extends Control

@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var canvas_layer : CanvasLayer = $CanvasLayer

func _ready() -> void:
	#user_data.opened_once = false
	#ResourceSaver.save(user_data, "user://user_data.tres")
	if user_data.opened_once:
		canvas_layer.hide()
		

func _on_continue_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_learn_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_options_button_pressed() -> void:
	pass # Replace with function body.
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_accept_button_pressed() -> void:
	user_data.opened_once = true
	ResourceSaver.save(user_data, "user://user_data.tres")
	
	get_child(2).visible = false
	
func _on_decline_button_pressed() -> void:
	get_tree().quit()
