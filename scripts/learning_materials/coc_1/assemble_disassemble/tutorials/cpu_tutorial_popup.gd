extends Node2D

@onready var button_1 : Button = $CanvasLayer/Button1
@onready var button_2 : Button = $CanvasLayer/Button2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_2.hide()


func _on_button_1_button_up() -> void:
	pass # Replace with function body.


func _on_button_2_button_up() -> void:
	pass # Replace with function body.
