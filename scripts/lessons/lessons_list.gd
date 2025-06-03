extends Control

func _on_back_pressed() -> void:
	print("back")

func _ready():
	for child in get_children():
		if child is Button:
			child.pressed.connect(func() : _on_pressed(child.name))

func _on_pressed(button_name):
	match button_name:
		"Button":
			print("Do action for Button 1")
		"Button2":
			print("Do action for Button 2")
