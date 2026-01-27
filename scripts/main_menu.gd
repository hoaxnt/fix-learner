extends Control

var data = UserData.new()

func _on_continue_button_pressed() -> void:
	print("Continue Opened Once: ", data.opened_once)
	load_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_learn_button_pressed() -> void:
	data.opened_once = not data.opened_once
	print("Learn Opened Once: ", data.opened_once)
	load_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_options_button_pressed() -> void:
	pass # Replace with function body.
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_accept_button_pressed() -> void:
	get_child(2).visible = false
	
func _on_decline_button_pressed() -> void:
	get_tree().quit()
	
func load_scene(path: String):
	var scene = load(path)
	get_tree().change_scene_to_packed(scene)
