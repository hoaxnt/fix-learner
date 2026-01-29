extends Node

@onready var dialog_box = $CanvasLayer/DialogBox
@onready var teacher_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var minigame : Node2D = $Minigame
@onready var minigame_label : Label = $CanvasLayer/MinigameLabel

func _ready() -> void:
	dialog_box.show()
	teacher_sprite.show()
	minigame.hide()
	minigame_label.hide()

func _process(_delta: float) -> void:
	if dialog_box.current_line_index == 4:
		teacher_sprite.hide()
		minigame.show()
		minigame_label.show()
