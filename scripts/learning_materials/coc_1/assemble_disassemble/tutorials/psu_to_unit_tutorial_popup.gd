extends CanvasLayer

signal wiring_complete

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var button_3 : Button = $Button3
@onready var button_4 : Button = $Button4

@onready var screw_button : Button = $ItemList/ScrewButton
@onready var screw_driver_button : Button = $ItemList/ScrewdriverButton

@onready var image_1 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/p2.jpg")
@onready var image_2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/p3.jpg")
@onready var image_3 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/p4.jpg")
@onready var image_4 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/p5.jpg")

var all_screw_placed : bool = false

func _ready() -> void:
	button_2.hide()
	button_3.hide()
	button_4.hide()
	screw_driver_button.disabled = true

func _on_button_1_pressed() -> void:
	background.texture = image_1
	button_1.hide()
	button_2.show()

func _on_button_2_pressed() -> void:
	background.texture = image_2
	button_2.hide()
	button_3.show()

func _on_button_3_pressed() -> void:
	background.texture = image_3
	button_3.hide()
	button_4.show()

func _on_button_4_pressed() -> void:
	background.texture = image_4
	all_screw_placed = true
	button_4.hide()
	screw_driver_button.disabled = false


func _on_screw_button_button_up() -> void:
	screw_button.toggle_mode = true
	screw_button.button_pressed = true
	screw_driver_button.button_pressed = false
	if not all_screw_placed:
		button_1.show()

func _on_screwdriver_button_button_up() -> void:
	screw_driver_button.toggle_mode = true
	screw_driver_button.button_pressed = true
	screw_button.button_pressed = false
	if all_screw_placed:
		button_1.show()
	else:
		screw_driver_button.button_pressed = false
		var warning_data : Array[String] = ["You need to put all the screws in place first before tightening them."]
		dialog_box.update_dialog("Teacher", warning_data)
