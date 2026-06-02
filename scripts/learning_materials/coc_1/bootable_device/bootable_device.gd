extends Node2D

@onready var background : Sprite2D = $Background
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@export var scenes_texture : Array[Texture2D]

var current_tex_index : int = 0

var texture_map : Dictionary = {
	0: 0,
	1: 1,
	2: 2,
	3: 3,
	4: 4,
	5: 5,
	6: 6,
	7: 7,
	8: 8,
	9: 9,
	10: 10
}

func _ready() -> void:
	# Connect the signal from your DialogBox script
	dialog_box.line_changed.connect(_on_line_changed)
	
	# Start the tutorial right away
	_start_tutorial()

func _start_tutorial():
	teacher_sprite.show()

	var data : Array[String] = [
		"The first step is to search for the control panel in the search bar at the bottom.",
		"The second step is after we click on the control panel, we look for Network and Internet.",
		"The third step is to find and click on Connect to a network.",
		"In the fourth step, after we click on Connect to a network, we will go to Ethernet and as you can see, we are still not connected to the internet.",
		"In the fifth step, we will right-click using the mouse to enable our Ethernet LAN.",
		"In our sixth step, after we enable the Ethernet LAN, we still need to configure it to get the internet working.",
		"In the seventh step, right-click on the Ethernet again using the mouse and go to Properties.",
		"In our eighth step, when the Ethernet Properties show up, just look for Internet Protocol Version 4 (TCP/IPv4).",
		"In our ninth step, after seeing Internet Protocol Version 4 (TCP/IPv4), we need to enable it. Just click the box on the side to check it and make it similar to the other enabled ones.",
		"In our tenth step, we can see that our LAN internet is now on and has connected to our Wi-Fi router.",
		"In our eleventh step, after checking that there is internet, open any browser to be more certain and check more thoroughly if there is internet."
		]

	if scenes_texture.size() > 0:
		background.texture = scenes_texture[0]
		
	dialog_box.update_dialog("Teacher", data)
	
func _end():
	SceneTransition.change_scene("res://scenes/learning_materials/coc_2/lessons_list_2.tscn")
	
func _on_line_changed(index: int):
	# The teacher starts visible at index 0.
	# After the first index (index >= 1), the teacher is hidden.
	# At the eleventh index (index >= 10, since arrays start at 0), the teacher shows again.
	if index == 10:
		teacher_sprite.visible = true
	elif index >= 1:
		teacher_sprite.visible = false
	else:
		teacher_sprite.visible = true # Keeps teacher visible at index 0
		
	print(index)
	
	if index >= 10:
		dialog_box.dialog_finished.connect(_end)
	if texture_map.has(index):
		current_tex_index = texture_map[index]
	
	if current_tex_index < scenes_texture.size():
		background.texture = scenes_texture[current_tex_index]
