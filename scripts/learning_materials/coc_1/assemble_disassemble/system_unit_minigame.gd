extends Node2D

# UI and Visuals
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@onready var unit_sprite : Sprite2D = $Parts/EmptyUnit/Sprite2D
@onready var canvas_layer : CanvasLayer = $CanvasLayer

# Textures
@onready var no_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/no-psu.png")
@onready var with_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-psu.png")

# Tutorial Scene to Instantiate
@onready var mobo_to_unit = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/mobo_to_unit_tutorial_popup.tscn")
@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var wiring_psu_scene : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/wiring_psu_tutorial_popup.tscn")
@onready var backpanel_scene : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/backpanel_tutorial_popup.tscn")

# State Flags
@onready var mobo_installed : bool = false
@onready var psu_installed : bool = false

@export var psu : Area2D
@export var mobo : Area2D
	
func _ready() -> void:
	if dialog_box:
		dialog_box.dialog_finished.connect(_hide_teacher)

func _hide_teacher():
	teacher_sprite.hide()
	
func request_installation(item_name: String) -> void:
	if item_name == "Power Supply":
		if mobo_installed:
			psu.queue_free()
			unit_sprite.texture = with_psu
			psu_installed = true
			
			var backpanel_instance = backpanel_scene.instantiate()
			var wiring_psu_instance = wiring_psu_scene.instantiate()
			get_parent().add_child(wiring_psu_instance)
			var error = backpanel_instance.install_complete.connect(_on_install_finished)
			if error == OK:
				print("backpanel connected")
			else:
				print("failed to connect backpanel")
			
			
	if item_name == "Motherboard":
		if not mobo_installed:
			mobo.queue_free()   
			install_mobo()
	
func _on_install_finished():
	trigger_end_dialog()
	
func install_mobo():
	unit_sprite.texture = no_psu
	mobo_installed = true
	
	var tutorial_instance = mobo_to_unit.instantiate()
	canvas_layer.add_child(tutorial_instance)
	
#	PSU pickable after mobo installed
	if psu:
		psu.input_pickable = true
	
func trigger_end_dialog():
	teacher_sprite.show()
	var data : Array[String] = ["Great job!", "Now, let's create a bootable flash drive to install the OS."]
	dialog_box.update_dialog("Teacher", data)
	await dialog_box.dialog_finished
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")
