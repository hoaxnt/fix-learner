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
			
			var wiring_psu = wiring_psu_scene.instantiate()
			wiring_psu.wiring_complete.connect(_on_wiring_finished)
			get_parent().add_child(wiring_psu)
			
	if item_name == "Motherboard":
		if not mobo_installed:
			mobo.queue_free()   
			install_mobo()
	
func _on_wiring_finished():
	print("install psu")
	install_psu()
	
func install_mobo():
	unit_sprite.texture = no_psu
	mobo_installed = true
	
	var tutorial_instance = mobo_to_unit.instantiate()
	canvas_layer.add_child(tutorial_instance)
	
#	PSU pickable after mobo installed
	if psu:
		psu.input_pickable = true
	
func install_psu():
	unit_sprite.texture = with_psu
	psu_installed = true
	trigger_end_dialog()
	
func trigger_end_dialog():
	teacher_sprite.show()
	var data : Array[String] = ["Great job!", "Now, let's create a bootable flash drive to install the OS."]
	dialog_box.update_dialog("Teacher", data)
	await dialog_box.dialog_finished
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")
