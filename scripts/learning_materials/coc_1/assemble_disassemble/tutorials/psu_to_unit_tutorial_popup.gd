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

@onready var backpanel_scene : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/backpanel_tutorial_popup.tscn")


var all_screw_placed : bool = false
var screws_tightened : int = 0

func _ready() -> void:
	button_1.hide()
	button_2.hide()
	button_3.hide()
	button_4.hide()
	dialog_box.hide()

func _on_button_1_pressed() -> void:
	if screw_button.button_pressed:
		background.texture = image_1
	
	button_1.hide()
	button_2.show()
	_handle_tightening()
	
func _on_button_2_pressed() -> void:
	if screw_button.button_pressed:
		background.texture = image_2
	
	button_2.hide()
	button_3.show()
	_handle_tightening()
	
func _on_button_3_pressed() -> void:
	if screw_button.button_pressed:
		background.texture = image_3
	
	button_3.hide()
	button_4.show()
	_handle_tightening()
	
func _on_button_4_pressed() -> void:
	if screw_button.button_pressed:
		background.texture = image_4
		all_screw_placed = true
		screw_driver_button.disabled = false
	
	button_4.hide()
	_handle_tightening()
	
func _handle_tightening() -> void:
	if screw_driver_button.button_pressed and all_screw_placed:
		screws_tightened += 1
		if screws_tightened >= 4:
			_finish_tutorial()
			
func _on_screw_button_button_up() -> void:
	screw_button.toggle_mode = true
	screw_button.button_pressed = true
	screw_driver_button.button_pressed = false
	if not all_screw_placed:
		button_1.show()
	
func _on_screwdriver_button_button_up() -> void:
	if not all_screw_placed:
		screw_driver_button.button_pressed = false
		var warning_data : Array[String] = ["You need to put all the screws in place first before tightening them."]
		dialog_box.show()
		dialog_box.update_dialog("Teacher", warning_data)
		return
	
	screw_driver_button.toggle_mode = true
	screw_driver_button.button_pressed = true
	screw_button.button_pressed = false
	button_1.show()
	
func _finish_tutorial() -> void:
	dialog_box.show()
	var final_data : Array[String] = ["Great job! The Power Supply Unit is now securely mounted to the case."]
	dialog_box.update_dialog("Teacher", final_data)
	
	if dialog_box.has_signal("dialog_finished"):
		await dialog_box.dialog_finished
		
		var backpanel_instance = backpanel_scene.instantiate()
		get_parent()
		
	else:
		await get_tree().create_timer(3.0).timeout
		
	queue_free()
