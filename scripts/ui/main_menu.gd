extends Button

func _on_play_pressed() -> void:
	load_scene("res://scenes/lessons/list.tscn")
	print("play")

func _on_sound_pressed() -> void:
	print("sound")

func load_scene(path: String):
	var scene = load(path)
	get_tree().change_scene_to_packed(scene)
	
	
