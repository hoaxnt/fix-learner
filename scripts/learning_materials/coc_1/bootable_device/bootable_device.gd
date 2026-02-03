extends Node2D

@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher

func _ready() -> void:
	dialog_box.dialog_finished.connect(_hide_teacher)

func _hide_teacher():
	teacher_sprite.hide()
	
	var data : Array[String] = ["A"]
