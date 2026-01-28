extends Node

@onready var dialog_box = $CanvasLayer/DialogBox
@onready var teacher_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float) -> void:
	if dialog_box.current_line_index == 4:
		teacher_sprite.hide()
