extends Control

func _ready():
	# calls the other parent from the main parent
	var lessons_list = $VBoxContainer/Lessons
	#	it gets the list of children of another parent
	for child in lessons_list.get_children():
#		make sure the child is a button
		if child is Button:
			child.pressed.connect(func() : _on_pressed(child.name))
			
func _on_pressed(button_name):
	match button_name:
		"1": get_tree().change_scene_to_file("res://scenes/lessons/lesson_1/lesson_1.tscn")
		"2": get_tree().change_scene_to_file("res://scenes/lessons/lesson_2/lesson_2.tscn")
		"3": get_tree().change_scene_to_file("res://scenes/lessons/lesson_3/lesson_3.tscn")
		"4": get_tree().change_scene_to_file("res://scenes/lessons/lesson_4/lesson_4.tscn")
		"5": get_tree().change_scene_to_file("res://scenes/lessons/lesson_5/lesson_5.tscn")
		"6": get_tree().change_scene_to_file("res://scenes/lessons/lesson_6/lesson_6.tscn")
		"7": get_tree().change_scene_to_file("res://scenes/lessons/lesson_7/lesson_7.tscn")
		"8": get_tree().change_scene_to_file("res://scenes/lessons/lesson_8/lesson_8.tscn")
		"9": get_tree().change_scene_to_file("res://scenes/lessons/lesson_9/lesson_9.tscn")
		"10": get_tree().change_scene_to_file("res://scenes/lessons/lesson_10/lesson_10.tscn")
		"11": get_tree().change_scene_to_file("res://scenes/lessons/lesson_11/lesson_11.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	print("back")
