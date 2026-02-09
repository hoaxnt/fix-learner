extends Node2D

# Local Nodes
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@onready var motherboard_sprite : Sprite2D = $Motherboard
@onready var options_menu : Control = $CanvasLayer/OptionsMenu
@onready var canvas_layer : CanvasLayer = $CanvasLayer

# Data
@onready var user_data = ResourceLoader.load("user://user_data.tres")

# Textures
@onready var cpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-cpu.png")
@onready var thermal_paste_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/thermal-cpu.png")
@onready var cpu_fan_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/fan-cpu.png")
@onready var ram_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-ram.png")
@onready var gpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-gpu.png")
@onready var m2_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/m2_installed.png")

# Preloaded Scene
@onready var cpu_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/cpu_tutorial_popup.tscn")
@onready var thermal_paste_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/thermal_paste_tutorial_popup.tscn")
@onready var cpu_fan_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/cpu_fan_tutorial_popup.tscn")
@onready var ram_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/ram_tutorial_popup.tscn")
@onready var gpu_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/gpu_tutorial_popup.tscn")
@onready var m2_tutorial_popup : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/m2_tutorial_popup.tscn")

var item_placement_sequence : int = 0
var cpu_slot : bool = false
var thermal_paste_slot : bool = false
var cpu_fan_slot : bool = false
var ram_slot : bool = false
var gpu_slot : bool = false
var m2_slot : bool = false

signal motherboard_assembled

func _on_cpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "CPU" and user_data.dragging == false:
		if thermal_paste_slot == false and cpu_fan_slot == false and ram_slot == false and gpu_slot == false:
			cpu_slot = true
			motherboard_sprite.texture = cpu_slot_texture
			area.queue_free()
			canvas_layer.add_child(cpu_tutorial_popup.instantiate())

func _on_thermal_paste_slot_area_exited(area: Area2D) -> void:
	if area.name == "ThermalPaste" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == false and cpu_fan_slot == false and ram_slot == false and gpu_slot == false:
			thermal_paste_slot = true
			motherboard_sprite.texture = thermal_paste_slot_texture
			area.queue_free()
			canvas_layer.add_child(thermal_paste_tutorial_popup.instantiate())

func _on_cpu_fan_slot_area_exited(area: Area2D) -> void:
	if area.name == "Fan" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == false and ram_slot == false and gpu_slot == false:
			cpu_fan_slot = true
			motherboard_sprite.texture = cpu_fan_slot_texture
			area.queue_free()
			canvas_layer.add_child(cpu_fan_tutorial_popup.instantiate())

func _on_ram_slot_area_exited(area: Area2D) -> void:
	if area.name == "RAM" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == true and ram_slot == false and gpu_slot == false:
			ram_slot = true
			motherboard_sprite.texture = ram_slot_texture
			area.queue_free()
			canvas_layer.add_child(ram_tutorial_popup.instantiate())

func _on_gpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "GPU" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == true and ram_slot == true and gpu_slot == false:
			gpu_slot = true
			motherboard_sprite.texture = gpu_slot_texture
			area.queue_free()
			canvas_layer.add_child(gpu_tutorial_popup.instantiate())
			
func _on_m_2_slot_area_exited(area: Area2D) -> void:
	if area.name == "M2" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == true and ram_slot == true and gpu_slot == true and m2_slot == false:
			m2_slot = true
			motherboard_sprite.texture = m2_slot_texture
			area.queue_free()
			canvas_layer.add_child(m2_tutorial_popup.instantiate())
			motherboard_assembled.emit()

func _process(_delta: float) -> void:
	await dialog_box.dialog_finished
	teacher_sprite.hide()
	
	await motherboard_assembled
	
	teacher_sprite.show()
	
	var data : Array[String] = ["Excellent job!","All components are in the correct slots and the motherboard assembly is successful."]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/assemble_disassemble/system_unit_minigame.tscn")
