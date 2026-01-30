extends Node2D

@onready var motherboard_sprite : Sprite2D = $Motherboard
@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var cpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-cpu.png")
@onready var thermal_paste_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/thermal-cpu.png")
@onready var cpu_fan_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/fan-cpu.png")
@onready var ram_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-ram.png")
@onready var gpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-gpu.png")

var item_placement_sequence : int = 0
var cpu_slot : bool = false
var thermal_paste_slot : bool = false
var cpu_fan_slot : bool = false
var ram_slot : bool = false
var gpu_slot : bool = false

func _on_cpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "CPU" and user_data.dragging == false:
		if thermal_paste_slot == false and cpu_fan_slot == false and ram_slot == false and gpu_slot == false:
			cpu_slot = true
			motherboard_sprite.texture = cpu_slot_texture
			area.queue_free()


func _on_thermal_paste_slot_area_exited(area: Area2D) -> void:
	if area.name == "ThermalPaste" and user_data.dragging == false:
		print(cpu_fan_slot,thermal_paste_slot,cpu_fan_slot,ram_slot,gpu_slot)
		if cpu_slot == true and thermal_paste_slot == false and cpu_fan_slot == false and ram_slot == false and gpu_slot == false:
			thermal_paste_slot = true
			motherboard_sprite.texture = thermal_paste_slot_texture
			area.queue_free()


func _on_cpu_fan_slot_area_exited(area: Area2D) -> void:
	if area.name == "Fan" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == false and ram_slot == false and gpu_slot == false:
			cpu_fan_slot = true
			motherboard_sprite.texture = cpu_fan_slot_texture
			area.queue_free()


func _on_ram_slot_area_exited(area: Area2D) -> void:
	if area.name == "RAM" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == true and ram_slot == false and gpu_slot == false:
			ram_slot = true
			motherboard_sprite.texture = ram_slot_texture
			area.queue_free()


func _on_gpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "GPU" and user_data.dragging == false:
		if cpu_slot == true and thermal_paste_slot == true and cpu_fan_slot == true and ram_slot == true and gpu_slot == false:
			gpu_slot = true
			motherboard_sprite.texture = gpu_slot_texture
			area.queue_free()
