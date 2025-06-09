extends Node2D

@onready var dialogue_box = $CanvasLayer/UI/DialogueBox
@onready var dialogue = $CanvasLayer/UI/DialogueBox/MarginContainer/VBoxContainer/Dialogue
@onready var prof = $Prof
@onready var tool_preview = $ToolPreview
@onready var choices_box = $CanvasLayer/UI/ChoicesBox

var dialogue_data = [
		"Hi there, students of computer system servicing!",
		"I’m [Teacher Name], your guide and mentor as you begin your journey into the world of computer hardware and electronics.",
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

var textures = {
	
}

var index := 0

func _ready() -> void:
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
			var image_path = "res://assets/images/lesson_1/lo_1/tool_%d.png" % (index - 4)
			var new_texture = load(image_path)
			
			if new_texture:
				tool_preview.texture = new_texture
			else:
				tool_preview.texture = null
				choices_box.visible = true
				print("❌ Could not load texture:", image_path)
	else:
		print("END")
