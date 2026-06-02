extends Control

func _ready():
	var lessons_list = get_node("VBoxContainer/HBoxContainer")
	for child in lessons_list.get_children():
		if child is Button:
			child.pressed.connect(func() : _on_pressed(child.name))
			
func _on_pressed(button_name):
	print(button_name)
	match button_name:
		"Coc1Button": SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")
		"Coc2Button": SceneTransition.change_scene("res://scenes/learning_materials/coc_2/lessons_list_2.tscn")

func _on_back_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main_menu.tscn")
	print("back")
