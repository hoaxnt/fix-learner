extends Control

@onready var background = $"../../Background"
@onready var ui = $"../UI"
@onready var prof = $"../../Prof"
@onready var dialogue_box = $CanvasLayer/UI/DialogueBox
@onready var dialogue = $"../UI/DialogueBox/MarginContainer/VBoxContainer/Dialogue"
@onready var answer_1 = $"../UI/ChoicesBox/VBoxContainer/Answer1"

var index = 0
var score = 0

var data = [
	{
		"question": "1. A manual that is provided by the manufacturer that explains how to repair, troubleshoot, and maintain a specific product or device.",
		"choices": [
			{"text": "Certifications", "image": "res://assets/images/lesson1/lo2/tool3.png"},
			{"text": "Service manual", "image": "res://assets/images/lesson1/lo2/tool1.png"},
			{"text": "Operations manual", "image": "res://assets/images/lesson1/lo2/tool2.png"},
		],
		"answer": 1
	},
	{
		"question": "2. Provides instructions on how to use and operate a device or system properly. It focuses on routine use, not repair.",
		"choices": [
			{"text": "Service manual", "image": "res://assets/images/lesson1/lo2/tool1.png"},
			{"text": "Certifications", "image": "res://assets/images/lesson1/lo2/tool3.png"},
			{"text": "Operations manual", "image": "res://assets/images/lesson1/lo2/tool2.png"},
		],
		"answer": 2
	},
	{
		"question": "3. Official documents issued by authorities or manufacturers that confirm a product or person meets specific standards.",
		"choices": [
			{"text": "Certifications", "image": "res://assets/images/lesson1/lo2/tool3.png"},
			{"text": "Operations manual", "image": "res://assets/images/lesson1/lo2/tool2.png"},
			{"text": "Service manual", "image": "res://assets/images/lesson1/lo2/tool1.png"},
		],
		"answer": 0
	}
]

func _ready():
	load_question()

func load_question():
	var question = data[index]
	$MarginContainer/VBoxContainer/Question.text = question["question"]

	for i in range(3):
		var choices = $MarginContainer/VBoxContainer/Choices.get_child(i)
		var item_image = choices.get_child(0)
		var item_name = choices.get_child(1)

		item_name.text = question["choices"][i]["text"]
		item_image.texture = load(question["choices"][i]["image"])

		# Disconnect previous signal if any
		if item_image.has_signal("gui_input"):
			item_image.disconnect("gui_input", Callable(self, "on_choice_selected"))
		
		# Add input listener to each image (or use Button instead of TextureRect)
		item_image.connect("gui_input", Callable(self, "_on_choice_selected").bind(i))

func _on_choice_selected(event: InputEvent, choice_index: int) -> void:
	if event is InputEventMouseButton and event.pressed and index != 4:
		var correct = data[index]["answer"]
		if choice_index == correct:
			print("✅ Correct!")
			score += 1
		else:
			print("❌ Incorrect!")

		index += 1
		if index < data.size():
			load_question()
		else:
			print("DONE!!")
			quiz_done()

func quiz_done():
	background.texture = load("res://assets/images/backgrounds/classroom.jpg")
	ui.visible = true
	prof.visible = true
	self.visible = false
	var parent = get_parent().get_parent()
	parent.is_quiz_done = true
	parent.score = score
	
	if score < 2:
		get_parent().get_node("UI/DialogueBox/Next").visible = false
		answer_1.visible = true
		answer_1.text = "Let's try again"
		dialogue.text = "Nice try! You earned %d points don't worry, give it another shot and you'll get there!" % (score)
	else:
		dialogue.text = "Great job! You earned %d points looks like you're ready to move on to the next topic!" % (score)
	prof.position = Vector2(0,0)
