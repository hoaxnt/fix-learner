extends Node2D

@onready var teacher_sprite : Sprite2D = $Teacher
@onready var camera : Camera2D = $Camera2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox

var is_index_max : bool = true

func _process(_delta: float) -> void:
	if dialog_box.current_line_index == 2 and is_index_max:
		teacher_sprite.hide()
		anim_player.play("camera_slide_down")
		
		await anim_player.animation_finished
		
		is_index_max = false
		teacher_sprite.position = Vector2(7.0, 230.0)
		teacher_sprite.show()
#		NOTE: FIX THE TEACHER HIDE LOGIC AFTER THE ANIMATION DOWN AND ALSO HIDE THE TEACHER, THE BUG IS STILL ZERO EVEN IF THE DIALOG IS CLICKING
		var data : Array[String] = ["Oh no!", "Tangina kumalat shet!"]
		dialog_box.update_dialog("Teacher", data)

		if dialog_box.current_line_index == 0:
			teacher_sprite.hide()
		
		
		
		
