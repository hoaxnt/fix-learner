extends Node2D

@onready var motherboard_sprite : Sprite2D = $Motherboard
@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var cpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-cpu.png")
@onready var thermal_paste_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/thermal-cpu.png")
@onready var cpu_fan_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/fan-cpu.png")
@onready var ram_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-ram.png")
@onready var gpu_slot_texture : Texture2D = preload("gpu")
func _on_cpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "CPU" and user_data.dragging == false:
		motherboard_sprite.texture = cpu_slot_texture
		area.queue_free()


func _on_thermal_paste_slot_area_exited(area: Area2D) -> void:
	if area.name == "ThermalPaste" and user_data.dragging == false:
		area.queue_free()


func _on_cpu_fan_slot_area_exited(area: Area2D) -> void:
	if area.name == "Fan" and user_data.dragging == false:
		area.queue_free()


func _on_ram_slot_area_exited(area: Area2D) -> void:
	if area.name == "RAM" and user_data.dragging == false:
		area.queue_free()


func _on_gpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "GPU" and user_data.dragging == false:
		area.queue_free()
