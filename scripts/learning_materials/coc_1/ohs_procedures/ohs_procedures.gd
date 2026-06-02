extends Node

@onready var dialog_box = $CanvasLayer/DialogBox
@onready var minigame : Node2D = $Minigame
@onready var minigame_label : Label = $CanvasLayer/MinigameLabel
@onready var user_data = ResourceLoader.load("user://user_data.tres")

func _ready() -> void:
	user_data.is_final_message = false
	ResourceSaver.save(user_data, "user://user_data.tres")
	dialog_box.show()
	minigame.hide()
	minigame_label.hide()

func _process(_delta: float) -> void:
	if dialog_box.current_line_index == 4:
		minigame.show()
		minigame_label.show()
