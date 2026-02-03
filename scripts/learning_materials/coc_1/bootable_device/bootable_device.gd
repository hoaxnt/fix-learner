extends Node2D

@onready var background : Sprite2D = $Background
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@export var scenes_texture : Array[Texture2D]

func _ready() -> void:
	if dialog_box.has_signal("line_changed"):
			dialog_box.line_changed.connect(_on_line_changed)
	dialog_box.dialog_finished.connect(_tutorial_scene)
	
func _tutorial_scene():
	teacher_sprite.hide()
	
	var data : Array[String] = [
	"First, search for 'Rufus' and click the link that says Rufus... you know the one.",
	"Now, click on 'rufus-4.12.exe' make sure it's the standard type.",
	"You’ll see the setup file pop up in the top right corner, but don't click it just yet!",
	"Next, go to Google Chrome and search for 'Windows 11 ISO'.",
	"Click the 'Download Windows 11' link below.",
	"Now you select the OS type. For this one, we're definitely going with Windows 11.",
	"Click the 'Select Download' drop-down section.",
	"Choose the 'Windows 11 Multi-edition ISO for x64 devices'.",
	"Wait for a few seconds... loading dito boy.",
	"In this section, we need to pick the language we're going to use.",
	"Choose 'English (United States)'.",
	"And wait a few more seconds... loading ule boy.",
	"Now, click the '64-bit Download' button.",
	"You’ll see the download progress in the top right corner.",
	"While Windows 11 is downloading, click the Rufus icon in your downloads to find the folder—just click the button next to it, boi.",
	"Click on the Rufus file...",
	"And finally, click 'Open'!"
]
# Show the first texture immediately
	if scenes_texture.size() > 0:
			background.texture = scenes_texture[0]
	dialog_box.update_dialog("Teacher", data)

func _on_line_changed(index: int):
	if index < scenes_texture.size():
			background.texture = scenes_texture[index]
