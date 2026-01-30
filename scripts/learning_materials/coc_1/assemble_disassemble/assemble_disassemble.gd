extends Node2D

@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher

func _process(_delta: float) -> void:
	await dialog_box.dialog_finished
	teacher_sprite.hide()
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/assemble_disassemble/cpu_minigame.tscn")
