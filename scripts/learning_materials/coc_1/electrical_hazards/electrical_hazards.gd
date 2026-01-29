extends Node2D

@onready var teacher_sprite : Sprite2D = $Teacher
@onready var camera : Camera2D = $Camera2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox

func _process(_delta: float) -> void:
	if dialog_box.current_line_index == 2:
		dialog_box.current_line_index = 0
		teacher_sprite.hide()
		anim_player.play("camera_slide_down")
		await anim_player.animation_finished
		print("Stopped!")
