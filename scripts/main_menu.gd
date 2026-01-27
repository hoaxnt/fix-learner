extends Control

func _on_continue_button_pressed() -> void:
	load_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_learn_button_pressed() -> void:
	var d : UserData = ResourceLoader.load("user://user_data.tres")
	d.opened_once = false
	print(d.opened_once)
	ResourceSaver.save(d, "user://user_data.tres")
	
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
	
