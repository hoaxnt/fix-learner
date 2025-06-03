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
	print("Name: ", button_name)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	print("back")
