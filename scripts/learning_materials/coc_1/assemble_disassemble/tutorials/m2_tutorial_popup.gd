extends CanvasLayer

# Data
@onready var user_data = ResourceLoader.load("user://user_data.tres")

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
@onready var image_3 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/m2_tutorial/3.png")
@onready var image_4 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/m2_tutorial/4.jpg")
@onready var image_5 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/m2_tutorial/5.jpg")
var is_bolt_placed : bool = false


func _ready() -> void:
	await dialog_box.dialog_finished
	button_1.show()

func _on_button_1_button_up() -> void:
	button_1.hide()
	background.texture = image_2
	
	var data : Array[String] = ["Next, click the lock button to secure the M.2 drive in place and ensure it is properly locked."]
	dialog_box.update_dialog("Teacher", data)
	await dialog_box.dialog_finished
	button_2.show()
	
func _on_button_2_button_up() -> void:
	button_2.hide()
	background.texture = image_3
	item_list.show()
	
	var data : Array[String] = ["Place the screw into the socket and tighten it carefully with a screwdriver to secure the component firmly in place."]
	dialog_box.update_dialog("Teacher", data)
	
func _on_button_3_button_up() -> void:
	is_bolt_placed = true
	button_3.hide()
	background.texture = image_4

func _on_button_4_button_up() -> void:
	button_4.hide()
	background.texture = image_5
	
	var data : Array[String] = ["Great job! let's move on to the next one"]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	# Set the flag and save
	user_data.motherboard_assembled = true
	ResourceSaver.save(user_data, "user://user_data.tres")
	
	# This removal will trigger 'child_order_changed' in the parent
	queue_free()
	
func _on_screw_button_button_up() -> void:
	screw_button.toggle_mode = true
	screw_button.button_pressed = true
	screw_driver_button.button_pressed = false
	
	if not is_bolt_placed:
		button_3.show()

func _on_screwdriver_button_button_up() -> void:
	screw_driver_button.toggle_mode = true
	screw_driver_button.button_pressed = true 
	screw_button.button_pressed = false

	if is_bolt_placed:
		button_4.show()
	else:
		screw_driver_button.button_pressed = false
		var warning_data : Array[String] = ["You must put the bolt first"]
		dialog_box.update_dialog("Teacher", warning_data)
