extends Node2D

@onready var dialogue_box = $CanvasLayer/UI/DialogueBox
@onready var dialogue = $CanvasLayer/UI/DialogueBox/MarginContainer/VBoxContainer/Dialogue
@onready var prof = $Prof
@onready var tool_preview = $ToolPreview
@onready var background = $Background
@onready var ui = $CanvasLayer/UI
@onready var quiz_ui = $CanvasLayer/QuizUI
@onready var answer_1 = $CanvasLayer/UI/ChoicesBox/VBoxContainer/Answer1
@onready var answer_2 = $CanvasLayer/UI/ChoicesBox/VBoxContainer/Answer2
@onready var answer_3 = $CanvasLayer/UI/ChoicesBox/VBoxContainer/Answer3

var is_quiz_done = false
var score = 0

var dialogue_data = [
		"Hello again, technician-in-training!",
		"I'm here to guide you through Lesson 2: Assess Own Work. Ready to power up your quality-checking skills?",
		"In this lessons, we will define each manuals and their purposes",
#		Item description
		"[b]Service Manual[/b] is a detailed guide provided by the manufacturer that explains how to repair, troubleshoot, and maintain a specific product or device.",
		"[b]Operations Manual[/b] provides instructions on how to use and operate a device or system properly. It focuses on routine use, not repair.",
		"[b]Certifications[/b] are official documents issued by authorities or manufacturers that confirm a product or person meets specific standards.",
		"Time for a quick quiz! Just 3 questions, are you ready to test your brain?"
]

var index := 0

func _ready() -> void:
	quiz_ui.visible = false
	tool_preview.visible = false
	dialogue.text = dialogue_data[index]
	
func _on_pressed() -> void:
	index += 1

	if index < dialogue_data.size():
		dialogue.text = dialogue_data[index]

		if index >= 3:
			prof.position = Vector2(-680.0, 0.0)
			tool_preview.visible = true

			# Dynamically change texture based on index
			var image_path = "res://assets/images/lesson1/lo2/tool%d.png" % (index - 2)
			var new_texture = load(image_path)
			
			if new_texture:
				tool_preview.texture = new_texture
			else:
				tool_preview.texture = null
				answer_1.visible = true
				answer_2.visible = true
	else:
		if is_quiz_done == true:
			get_tree().change_scene_to_file("res://scenes/lessons/lessons_list.tscn")

func _on_answer_1_pressed() -> void:
	background.texture = load("res://assets/images/backgrounds/background.jpg")
	ui.visible = false
	prof.visible = false
	tool_preview.visible = false
	quiz_ui.visible = true
	answer_1.visible = false
	answer_2.visible = false
	answer_3.visible = false
	
	if score < 3 and is_quiz_done:
		get_tree().reload_current_scene()


func _on_answer_2_pressed() -> void:
	get_tree().reload_current_scene()


func _on_answer_3_pressed() -> void:
	pass
