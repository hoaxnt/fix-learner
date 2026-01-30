extends Node2D

@onready var motherboard_sprite : Sprite2D = $Motherboard
@onready var cpu_slot_texture : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-cpu.png")
@onready var user_data = ResourceLoader.load("user://user_data.tres")

func _on_cpu_slot_area_exited(area: Area2D) -> void:
	if area.name == "CPU" and user_data.dragging == false:
		motherboard_sprite.texture = cpu_slot_texture
		area.queue_free()
