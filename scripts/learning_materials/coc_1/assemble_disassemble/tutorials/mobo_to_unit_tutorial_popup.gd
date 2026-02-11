extends CanvasLayer

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var button_3 : Button = $Button3
@onready var button_4 : Button = $Button4
@onready var screw_button : Button = $ItemList/ScrewButton
@onready var screw_driver_button : Button = $ItemList/ScrewdriverButton

@onready var image_1 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/mobo_to_unit_tutorial/b2.jpg")
@onready var image_2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/mobo_to_unit_tutorial/b3.jpg")
@onready var image_3 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/mobo_to_unit_tutorial/b4.jpg")
@onready var image_4 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/mobo_to_unit_tutorial/b5.jpg")

var all_screw_placed : bool = false

func _on_button_1_button_up() -> void:
	if all_screw_placed:
		button_1.hide()
		button_2.show()
		return
	background.texture = image_1
	button_1.hide()
	button_2.show()

func _on_button_2_button_up() -> void:
	if all_screw_placed:
		button_2.hide()
		button_3.show()
		return
		
	background.texture = image_2
	button_2.hide()
	button_3.show()

func _on_button_3_button_up() -> void:
	if all_screw_placed:
		button_3.hide()
		button_4.show()
		return
		
	background.texture = image_3
	button_3.hide()
	button_4.show()

func _on_button_4_button_up() -> void:
	if all_screw_placed:
		button_4.hide()
		var data_done : Array[String] = ["Great job!"]
		dialog_box.update_dialog("Teacher", data_done) 
		await dialog_box.dialog_finished
		queue_free()
		return
	
	background.texture = image_4
	button_4.hide()
	var data : Array[String] = ["All screws are positioned correctly. Use the screwdriver to tighten them securely."]
	dialog_box.update_dialog("Teacher", data) 
	all_screw_placed = true

func _on_screw_button_button_up() -> void:
	# 1. Logic for the Screw Button itself
	screw_button.toggle_mode = true
	screw_button.button_pressed = true # Keep this one down
	# 2. Untoggle the Screwdriver (the "vice versa" part)
	screw_driver_button.button_pressed = false
	
	# 3. Functional logic
	if not all_screw_placed:
		button_1.show()

func _on_screwdriver_button_button_up() -> void:
	# 1. Logic for the Screwdriver Button itself
	screw_driver_button.toggle_mode = true
	screw_driver_button.button_pressed = true # Keep this one down
	# 2. Untoggle the Screw button
	screw_button.button_pressed = false
	
	# 3. Functional logic
	if all_screw_placed:
		# Restart the button sequence for tightening
		button_1.show()
	else:
		# If they haven't finished placing screws, 
		# pop the screwdriver back up and warn them
		screw_driver_button.button_pressed = false
		var warning_data : Array[String] = ["You need to put all the screws in place first before tightening them."]
		dialog_box.update_dialog("Teacher", warning_data)
