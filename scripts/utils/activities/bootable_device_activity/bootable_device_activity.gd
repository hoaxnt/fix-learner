extends Control

@onready var background = $CanvasLayer/Background

@onready var image_1 = preload("res://assets/items/bootable_device/1.jpg")
@onready var image_2 = preload("res://assets/items/bootable_device/2.jpg")

func _on_button_1_pressed() -> void:
	background.texture = image_2
