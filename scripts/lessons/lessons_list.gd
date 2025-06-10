extends Control

func _ready():
	var lessons_list = get_node("VBoxContainer/Lessons")
	for child in lessons_list.get_children():
		if child is Button:
			child.pressed.connect(func() : _on_pressed(child.name))
			
func _on_pressed(button_name):
	print(button_name)
	match button_name:
		"1": get_tree().change_scene_to_file("res://scenes/lessons/lesson1/lesson1_lo.tscn")
		"2": get_tree().change_scene_to_file("res://scenes/lessons/lesson2/lesson2_lo.tscn")
		"3": get_tree().change_scene_to_file("res://scenes/lessons/lesson3/lesson3_lo.tscn")
		"4": get_tree().change_scene_to_file("res://scenes/lessons/lesson4/lesson4_lo.tscn")
		"5": get_tree().change_scene_to_file("res://scenes/lessons/lesson5/lesson5_lo.tscn")
		"6": get_tree().change_scene_to_file("res://scenes/lessons/lesson6/lesson6_lo.tscn")
		"7": get_tree().change_scene_to_file("res://scenes/lessons/lesson7/lesson7_lo.tscn")
		"8": get_tree().change_scene_to_file("res://scenes/lessons/lesson8/lesson8_lo.tscn")
		"9": get_tree().change_scene_to_file("res://scenes/lessons/lesson9/lesson9_lo.tscn")
		"10": get_tree().change_scene_to_file("res://scenes/lessons/lesson10/lesson10_lo.tscn")
		"11": get_tree().change_scene_to_file("res://scenes/lessons/lesson11/lesson11_lo.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	print("back")


func _on__pressed() -> void:
	pass # Replace with function body.
