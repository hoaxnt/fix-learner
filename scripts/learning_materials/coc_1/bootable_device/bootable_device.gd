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
		"In the first steps, search for Control Panel in the search bar.",
		"In the second step, go to Category and click on Small icons.",
		"In the third step, find the Network and Sharing Center and click on it.",
		"In the fourth step, after we click on Network and Sharing Center, go to Set up a new connection or network.",
		"In the fifth step, click on Manually connect to a wireless network.",
		"In the sixth step, set up the Wi-Fi name, security type, and Wi-Fi password for your Wi-Fi.",
		"In the seventh step, the wifi name, wifi security, and wifi password of your wifi are shown, and once finished, click the next button.",
		"In the eighth step, you will find Change Connection Settings. Click on it.",
		"In the ninth step, you will see your registered Wi-Fi address here; nothing needs to be changed.",
		"In the tenth step, click the wifi logo at the bottom right side of your PC's taskbar. After clicking, you will see your wifi signal.",
		"In the eleventh step, after clicking on the Wi-Fi, you will see the connect button. Just click it to connect our PC to the Wi-Fi we registered."
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
