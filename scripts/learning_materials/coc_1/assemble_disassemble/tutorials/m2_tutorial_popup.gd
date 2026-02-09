extends CanvasLayer

@onready var dialog_box : MarginContainer = $DialogBox
@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var button_3 : Button = $Button3
@onready var button_4 : Button = $Button4
@onready var screw_button : Button = $ItemList/ScrewButton
@onready var screw_driver_button : Button = $ItemList/ScrewdriverButton

@onready var background : TextureRect = $Background
@onready var item_list : VBoxContainer = $ItemList

@onready var image_2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/m2_tutorial/2.jpg")
@onready var image_3 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/m2_tutorial/3.jpg")
@onready var image_4 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/m2_tutorial/4.jpg")

var is_bolt_placed : bool = false

func _ready() -> void:
	await dialog_box.dialog_finished
	button_1.show()

func _on_button_1_button_up() -> void:
	button_1.hide()
	item_list.show()
	background.texture = image_2

func _on_button_2_button_up() -> void:
	pass # Replace with function body.

func _on_button_3_button_up() -> void:
	pass # Replace with function body.

func _on_button_4_button_up() -> void:
	pass # Replace with function body.

func _on_screw_button_button_up() -> void:
	screw_button.toggle_mode = true
	screw_button.button_pressed = true
	screw_driver_button.button_pressed = false
	
	if not is_bolt_placed:
		button_2.show()


func _on_screwdriver_button_button_up() -> void:
	screw_driver_button.toggle_mode = true
	screw_driver_button.button_pressed = true 
	screw_button.button_pressed = false

	if is_bolt_placed:
		button_1.show()
	else:
		screw_driver_button.button_pressed = false
		var warning_data : Array[String] = ["You need to put all the screws in place first before tightening them to ensure the CPU cooler is properly balanced and evenly mounted, which helps apply consistent pressure and improves cooling performance."]
		dialog_box.update_dialog("Teacher", warning_data)
