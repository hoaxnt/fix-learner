extends Control

@onready var background = $"../../Background"
@onready var ui = $"../UI"
@onready var prof = $"../../Prof"
@onready var dialogue_box = $CanvasLayer/UI/DialogueBox
@onready var dialogue = $"../UI/DialogueBox/MarginContainer/VBoxContainer/Dialogue"

var index = 0
var score = 0

var data = [
	{
		"question": "1. Materials with insulated plastics, it can also transmit electrical current from one component to another in a circuit.",
		"choices": [
			{"text": "Cables", "image": "res://assets/images/lesson_1/lo_1/tool_2.png"},
			{"text": "Electrical Tape", "image": "res://assets/images/lesson_1/lo_1/tool_3.png"},
			{"text": "Wires", "image": "res://assets/images/lesson_1/lo_1/tool_1.png"},
		],
		"answer": 2
	},
	{
		"question": "2. A group of two or more insulated wires bundled together to transmit electrical power or data signals.",
		"choices": [
			{"text": "Electrical Tape", "image": "res://assets/images/lesson_1/lo_1/tool_3.png"},
			{"text": "Wires", "image": "res://assets/images/lesson_1/lo_1/tool_1.png"},
			{"text": "Cables", "image": "res://assets/images/lesson_1/lo_1/tool_2.png"},
		],
		"answer": 2
	},
	{
		"question": "3. An insulating tape made of plastic or vinyl used to wrap and protect electrical wires and connections from moisture, abrasion.",
		"choices": [
			{"text": "Electrical Tape", "image": "res://assets/images/lesson_1/lo_1/tool_3.png"},
			{"text": "Capacitor", "image": "res://assets/images/lesson_1/lo_1/tool_5.png"},
			{"text": "Wires", "image": "res://assets/images/lesson_1/lo_1/tool_1.png"},
		],
		"answer": 0
	},
	{
		"question": "4. Passive electrical components that limit or regulate the flow of electrical current in a circuit.",
		"choices": [
			{"text": "Capacitor", "image": "res://assets/images/lesson_1/lo_1/tool_5.png"},
			{"text": "Wires", "image": "res://assets/images/lesson_1/lo_1/tool_1.png"},
			{"text": "Resistors", "image": "res://assets/images/lesson_1/lo_1/tool_4.png"},
		],
		"answer": 2
	},
	{
		"question": "5. Electronic components that store and release electrical energy.",
		"choices": [
			{"text": "Capacitor", "image": "res://assets/images/lesson_1/lo_1/tool_5.png"},
			{"text": "Diodes", "image": "res://assets/images/lesson_1/lo_1/tool_7.png"},
			{"text": "Transistors", "image": "res://assets/images/lesson_1/lo_1/tool_8.png"},
		],
		"answer": 0
	},
	{
		"question": "6. Micro electronic circuits consisting of semiconductor devices and passive components built onto a single chip.",
		"choices": [
			{"text": "Diodes", "image": "res://assets/images/lesson_1/lo_1/tool_7.png"},
			{"text": "Integrated Circuit", "image": "res://assets/images/lesson_1/lo_1/tool_6.png"},
			{"text": "Capacitor", "image": "res://assets/images/lesson_1/lo_1/tool_5.png"},
		],
		"answer": 1
	},
	{
		"question": "7. Semiconductor devices that allow current to flow in one direction only.",
		"choices": [
			{"text": "Transistors", "image": "res://assets/images/lesson_1/lo_1/tool_8.png"},
			{"text": "Diodes", "image": "res://assets/images/lesson_1/lo_1/tool_7.png"},
			{"text": "Capacitor", "image": "res://assets/images/lesson_1/lo_1/tool_5.png"},
		],
		"answer": 1
	},
	{
		"question": "8. Semiconductor devices used to amplify or switch electronic signals.",
		"choices": [
			{"text": "Transistors", "image": "res://assets/images/lesson_1/lo_1/tool_8.png"},
			{"text": "Integrated Circuit", "image": "res://assets/images/lesson_1/lo_1/tool_6.png"},
			{"text": "Diodes", "image": "res://assets/images/lesson_1/lo_1/tool_7.png"},
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
	if event is InputEventMouseButton and event.pressed and index != 8:
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
	background.texture = load("res://assets/images/classroom.jpg")
	ui.visible = true
	prof.visible = true
	self.visible = false
	var parent = get_parent().get_parent()
	parent.is_quiz_done = true
	
	if score < 5:
		dialogue.text = "Nice try! You earned %d points don't worry, give it another shot and you'll get there!" % (score)
	else:
		dialogue.text = "Great job! You earned %d points looks like you're ready to move on to the next topic!" % (score)
	prof.position = Vector2(0,0)
