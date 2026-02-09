extends CanvasLayer

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var button_3 : Button = $Button3
@onready var button_4 : Button = $Button4
@onready var screw_button : Button = $ItemList/ScrewButton
@onready var screw_driver_button : Button = $ItemList/ScrewdriverButton

@onready var image_1 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/1.png")
@onready var image_2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/2.png")
@onready var image_3 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/3.png")
@onready var image_4 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/4.png")
@onready var image_c1 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/c1.png")
@onready var image_c2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/c2.png")
@onready var image_c3 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/c3.png")
@onready var image_c4 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_fan_tutorial/c4.png")

var all_screw_placed : bool = false

func _on_button_1_button_up() -> void:
	if all_screw_placed:
		background.texture = image_c1
		button_1.hide()
		button_4.text = "2"
		button_4.show()
		return
	background.texture = image_1
	button_1.hide()
	button_2.show()

func _on_button_2_button_up() -> void:
	if all_screw_placed:
		background.texture = image_c3
		button_2.hide()
		button_3.text = "4"
		button_3.show()
		return
	background.texture = image_2
	button_2.hide()
	button_3.show()

func _on_button_3_button_up() -> void:
	if all_screw_placed:
		background.texture = image_c4
		button_3.hide()

		var final_data : Array[String] = ["The CPU fan is now securely fastened. Great job!"]
		dialog_box.update_dialog("Teacher", final_data)
		await dialog_box.dialog_finished
		queue_free()
		return
	background.texture = image_3
	button_3.hide()
	button_4.show()

func _on_button_4_button_up() -> void:
	if all_screw_placed:
		background.texture = image_c2
		button_4.hide()
		button_2.text = "3"
		button_2.show()
		return
		
	background.texture = image_4
	button_4.hide()
	var data : Array[String] = ["All screws are positioned correctly. Use the screwdriver to tighten them securely."]
	dialog_box.update_dialog("Teacher", data) 
	all_screw_placed = true

func _on_screwdriver_button_button_up() -> void:
	if all_screw_placed:
		# Restart the button sequence but for tightening (c-images)
		button_1.show()
	else:
		var warning_data : Array[String] = ["You need to place all the screws before you can tighten them!"]
		dialog_box.update_dialog("Teacher", warning_data)

func _on_screw_button_button_up() -> void:
	if not all_screw_placed:
		button_1.show()
