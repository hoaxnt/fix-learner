extends Node2D

@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@onready var unit_sprite : Sprite2D = $Parts/EmptyUnit/Sprite2D
@onready var with_mobo : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-gpu.png")
@onready var with_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-psu.png")

var mobo_installed : bool = false

func _process(_delta: float) -> void:
	await dialog_box.dialog_finished
	teacher_sprite.hide()

func _on_mobo_area_exited(area: Area2D) -> void:
	if area.is_in_group("slots"):
		area.hide()
		mobo_installed = true


func _on_psu_area_exited(area: Area2D) -> void:
	if area.is_in_group("slots"):
		if mobo_installed:
			area.hide()
			
