extends Control

func _ready():
	# calls the other parent from the main parent
	var first_lessons = $Lessons1
	var second_lessons = $Lessons2
	second_lessons.visible = false
	#	it gets the list of children of another parent
	for child in first_lessons.get_children():
#		make sure the child is a button
		if child is Button:
			child.pressed.connect(func() : _on_pressed(child.name))

func _on_pressed(button_name):
	print("Name: ", button_name)

func _on_back_pressed() -> void:
	print("back")

	#match button_name:
		#"Button":
			#print("Do action for Button 1")
		#"Button2":
			#print("Do action for Button 2")
