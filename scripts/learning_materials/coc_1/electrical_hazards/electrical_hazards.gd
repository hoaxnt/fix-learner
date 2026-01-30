extends Node2D

@onready var teacher_sprite : Sprite2D = $Teacher
@onready var camera : Camera2D = $Camera2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var objective_label : Label = $CanvasLayer/ObjectiveLabel
@onready var user_data = ResourceLoader.load("user://user_data.tres")

var triggered_cleanup_event : bool = false

func _ready() -> void:
	user_data.is_final_message = false
	ResourceSaver.save(user_data, "user://user_data.tres")
	objective_label.hide()

func _process(_delta: float) -> void:
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

	var data : Array[String] = ["Oh no!", "Clean up the mess!"]
	
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	teacher_sprite.hide()
	objective_label.show()
