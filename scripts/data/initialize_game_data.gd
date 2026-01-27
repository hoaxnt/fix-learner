extends Node

func _ready() -> void:
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
