extends Node

@onready var minigame : Node2D = $Minigame
@onready var minigame_label : Label = $CanvasLayer/MinigameLabel
@onready var user_data = ResourceLoader.load("user://user_data.tres")

func _ready() -> void:
	user_data.is_final_message = false
	ResourceSaver.save(user_data, "user://user_data.tres")
	minigame.show()
	minigame_label.show()
