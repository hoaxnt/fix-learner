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
		"Welcome again, students of computer system servicing!",
		"I’m Prof, your guide and mentor as you begin your journey into the world of computer hardware and electronics.",
		"Before we dive in, let me share some essential information to power up your knowledge!",
		"In this lesson, you'll explore specifications of materials and components like wires, resistors, and integrated circuits",
		"So lets get started!",
#		Item description
		"[b]Wires[/b] are conductive materials insulated with plastic, used to transmit electrical current from one component to another in a circuit.",
		"[b]Cables[/b] are groups of two or more insulated wires bundled together to transmit electrical power or data signals.",
		"[b]Electrical[/b] tape is an insulating tape made of plastic or vinyl, used to wrap and protect electrical wires and connections from moisture and abrasion.",
		"[b]Resistors[/b] are passive electrical components that limit or regulate the flow of electrical current in a circuit.",
		"[b]Capacitors[/b] are electronic components that store and release electrical energy.",
		"[b]Integrated[/b] circuits are microelectronic circuits consisting of semiconductor devices and passive components built onto a single chip.",
		"[b]Diodes[/b] are semiconductor devices that allow current to flow in one direction only.",
		"[b]Transistors[/b] are semiconductor devices used to amplify or switch electronic signals.",
		"Okay, it's quiz time! Are you ready?"
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

		if index >= 5:
			prof.position = Vector2(-680.0, 0.0)
			tool_preview.visible = true

			# Dynamically change texture based on index
			var image_path = "res://assets/images/lesson1/lo1/tool%d.png" % (index - 4)
			var new_texture = load(image_path)
			
			if new_texture:
				tool_preview.texture = new_texture
			else:
				tool_preview.texture = null
				answer_1.visible = true
				answer_2.visible = true
	else:
		if is_quiz_done == true:
			get_tree().change_scene_to_file("res://scenes/lessons/lesson1/lesson1_lo.tscn")

func _on_answer_1_pressed() -> void:
	background.texture = load("res://assets/images/backgrounds/background.jpg")
	ui.visible = false
	prof.visible = false
	tool_preview.visible = false
	quiz_ui.visible = true
	answer_1.visible = false
	answer_2.visible = false
	answer_3.visible = false
	
	if score < 5 and is_quiz_done:
		get_tree().reload_current_scene()


func _on_answer_2_pressed() -> void:
	get_tree().reload_current_scene()


func _on_answer_3_pressed() -> void:
	pass
