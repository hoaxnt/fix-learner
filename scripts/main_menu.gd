extends Control

func _ready() -> void:
	initialize_resources()

func _on_continue_button_pressed() -> void:
	load_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_learn_button_pressed() -> void:
	var user_data : UserData = ResourceLoader.load("user://user_data.tres")
	user_data.opened_once = true
	ResourceSaver.save(user_data, "res://user_data.tres")
	
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
	
func initialize_resources():
	var files = ["user://user_data.tres", "user://new_game_data.tres", "user://settings_data.tres"]
	if not files.all(FileAccess.file_exists):
		var user_data = UserData.new()
		var settings_data = SettingsData.new()
		var new_game_data = NewGameData.new()
		ResourceSaver.save(user_data, "user://user_data.tres")
		ResourceSaver.save(settings_data, "user://settings_data.tres")
		ResourceSaver.save(new_game_data, "user://new_game_data.tres")
		print("Default data initialized")
	else:
		print("Data already exist.")
		
