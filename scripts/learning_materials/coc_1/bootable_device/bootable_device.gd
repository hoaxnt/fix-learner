extends Node2D

@onready var background : Sprite2D = $Background
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher

@export var scenes_texture : Array[Texture2D]

func _ready() -> void:
	# Connect the signal from your DialogBox script
	dialog_box.line_changed.connect(_on_line_changed)
	
	# Start the tutorial right away
	_start_tutorial()

func _start_tutorial():
	teacher_sprite.show()
	
	var data : Array[String] = [
		"Well done, student. Now, let’s take it a step further.",
		"In our next lab, you’ll be preparing a bootable flash drive...",
		"Pay close attention to the formatting steps.",
		"First, search for 'Rufus' and click the link...",
		"Now, click on 'rufus-4.12.exe'...",
		"You’ll see the setup file pop up...",
		"Next, go to Google Chrome and search for 'Windows 11 ISO'...",
		"Click download Windows 11 below...",
		"Now select the type of OS...",
		"Click the select download drop down section...",
		"Now select the windows 11 multi edition...",
		"Wait for a few seconds... loading dito boy",
		"Now in this section, we will select the language...",
		"Choose english(united states)...",
		"And wait a few seconds... loading ule boy",
		"Click 64 bit download...",
		"And you will see on the right top that the download is in progress...",
		"While the win11 is downloading, click the rufus button boi...",
		"Click the rufus...",
		"And click open!"
	]
	# Set initial texture before starting
	if scenes_texture.size() > 0:
		background.texture = scenes_texture[0]
		
	dialog_box.update_dialog("Teacher", data)

func _on_line_changed(index: int):
	if index >= 3:
		teacher_sprite.hide()
	else:
		teacher_sprite.show()
		
	if index < 3:
		background.texture = scenes_texture[0]
	else:
		if index < scenes_texture.size():
			background.texture = scenes_texture[index - 3]
