extends Node2D

@onready var teacher_sprite : Sprite2D = $Teacher
@onready var camera : Camera2D = $Camera2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox

# Use this to make sure the event only happens once
var triggered_cleanup_event : bool = false

func _process(_delta: float) -> void:
	# Check if we hit the specific line and haven't run this logic yet
	if dialog_box.current_line_index == 2 and not triggered_cleanup_event:
		trigger_teacher_move()

func trigger_teacher_move() -> void:
	triggered_cleanup_event = true # Lock this function immediately
	
	teacher_sprite.hide()
	anim_player.play("camera_slide_down")
	
	await anim_player.animation_finished
	
	# Move the teacher to the new "mess" location
	teacher_sprite.position = Vector2(7.0, 230.0)
	teacher_sprite.show()

	# Prepare the new dialogue
	var data : Array[String] = ["Oh no!", "Clean up the mess!"]
	
	# IMPORTANT: Update the dialog and ensure it resets to its internal index 0
	dialog_box.update_dialog("Teacher", data)
	
	# If your DialogBox script doesn't automatically reset current_line_index 
	# to 0 inside update_dialog, you should do it manually here:
	# dialog_box.current_line_index = 0
