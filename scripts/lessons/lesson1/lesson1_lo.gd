extends Control

func _ready():
	var lo_list = get_node("VBoxContainer/L0")
	for child in lo_list.get_children():
		if child is Button:
			child.pressed.connect(func() : _on_pressed(child.name))
	pass
	
func _on_pressed(button_name):
	match button_name:
		"1": get_tree().change_scene_to_file("res://scenes/lessons/lesson1/lo1/lo1.tscn")
		"2": get_tree().change_scene_to_file("res://scenes/lessons/lesson1/lo2/lo2.tscn")
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	print("back")
