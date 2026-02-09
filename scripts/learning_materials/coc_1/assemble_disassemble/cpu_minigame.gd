extends Node2D

## --- Nodes ---
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@onready var motherboard_sprite : Sprite2D = $Motherboard
@onready var options_menu : Control = $CanvasLayer/OptionsMenu
@onready var canvas_layer : CanvasLayer = $CanvasLayer

## --- Data & Resources ---
@onready var user_data = ResourceLoader.load("user://user_data.tres")

@export_group("Slot Textures")
@onready var cpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-cpu.png")
@onready var thermal_paste_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/thermal-cpu.png")
@onready var cpu_fan_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/fan-cpu.png")
@onready var ram_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-ram.png")
@onready var gpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-gpu.png")
@onready var m2_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/m2_installed.png")

@export_group("Tutorial Scenes")
@onready var cpu_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/cpu_tutorial_popup.tscn")
@onready var thermal_paste_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/thermal_paste_tutorial_popup.tscn")
@onready var cpu_fan_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/cpu_fan_tutorial_popup.tscn")
@onready var ram_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/ram_tutorial_popup.tscn")
@onready var gpu_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/gpu_tutorial_popup.tscn")
@onready var m2_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/m2_tutorial_popup.tscn")

## --- State Variables ---
var cpu_slot : bool = false
var thermal_paste_slot : bool = false
var cpu_fan_slot : bool = false
var ram_slot : bool = false
var gpu_slot : bool = false
var m2_slot : bool = false

func _ready() -> void:
	await dialog_box.dialog_finished
	teacher_sprite.hide()
	# Connect to the signal that fires when a popup is closed (removed from the layer)
	canvas_layer.child_order_changed.connect(_on_canvas_layer_changed)

## --- Logic ---

func _on_canvas_layer_changed() -> void:
	# This triggers whenever a popup (like M2) is queue_free()
	if user_data.motherboard_assembled:
		_trigger_victory_sequence()

func _trigger_victory_sequence() -> void:
	# Prevent multiple triggers
	user_data.motherboard_assembled = false
	ResourceSaver.save(user_data, "user://user_data.tres")
	
	teacher_sprite.show()
	
	var data : Array[String] = [
		"Excellent job!",
		"All components are in the correct slots and the motherboard assembly is successful."
	]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/assemble_disassemble/system_unit_minigame.tscn")

## --- Slot Detection ---

func _on_cpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "CPU" and not user_data.dragging:
		if not any_installed():
			cpu_slot = true
			_handle_placement(area, cpu_slot_texture, cpu_tutorial_popup)

func _on_thermal_paste_slot_area_exited(area: Area2D) -> void:
	if area.name == "ThermalPaste" and not user_data.dragging:
		if cpu_slot and not thermal_paste_slot:
			thermal_paste_slot = true
			_handle_placement(area, thermal_paste_slot_texture, thermal_paste_tutorial_popup)

func _on_cpu_fan_slot_area_exited(area: Area2D) -> void:
	if area.name == "Fan" and not user_data.dragging:
		if thermal_paste_slot and not cpu_fan_slot:
			cpu_fan_slot = true
			_handle_placement(area, cpu_fan_slot_texture, cpu_fan_tutorial_popup)

func _on_ram_slot_area_exited(area: Area2D) -> void:
	if area.name == "RAM" and not user_data.dragging:
		if cpu_fan_slot and not ram_slot:
			ram_slot = true
			_handle_placement(area, ram_slot_texture, ram_tutorial_popup)

func _on_gpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "GPU" and not user_data.dragging:
		if ram_slot and not gpu_slot:
			gpu_slot = true
			_handle_placement(area, gpu_slot_texture, gpu_tutorial_popup)
			
func _on_m_2_slot_area_exited(area: Area2D) -> void:
	if area.name == "M2" and not user_data.dragging:
		if gpu_slot and not m2_slot:
			m2_slot = true
			_handle_placement(area, m2_slot_texture, m2_tutorial_popup)

## --- Helpers ---

func _handle_placement(area: Area2D, tex: Texture2D, popup_scene: PackedScene) -> void:
	motherboard_sprite.texture = tex
	area.queue_free()
	canvas_layer.add_child(popup_scene.instantiate())

func any_installed() -> bool:
	return cpu_slot or thermal_paste_slot or cpu_fan_slot or ram_slot or gpu_slot or m2_slot
