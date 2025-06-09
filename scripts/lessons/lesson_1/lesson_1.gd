extends Node2D

@onready var dialogue_box = $CanvasLayer/UI/DialogueBox
@onready var dialogue = $CanvasLayer/UI/DialogueBox/MarginContainer/VBoxContainer/Dialogue

var dialogue_data = [
		"Hi there, students of computer system servicing!",
		"I’m [Teacher Name], your guide and mentor as you begin your journey into the world of computer hardware and electronics.",
		"Before we dive in, let me share some essential information to power up your knowledge!",
		"In this lesson, you'll explore specifications of materials and components like wires, resistors, and integrated circuits",
		"So lets get started!"
]

var index := 0

func _ready() -> void:
	dialogue.text = dialogue_data[index]

func _on_pressed() -> void:
	index += 1
	if index < dialogue_data.size():
			dialogue.text = dialogue_data[index]
	else:
			dialogue_box.visible = false
