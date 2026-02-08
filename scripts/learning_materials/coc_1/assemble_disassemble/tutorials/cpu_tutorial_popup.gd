extends Node2D

@onready var button_1 : Button = $CanvasLayer/Button1
@onready var button_2 : Button = $CanvasLayer/Button2
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_2.hide()


func _on_button_1_button_up() -> void:
	button_2.show()
	button_1.hide()

func _on_button_2_button_up() -> void:
	var data : Array[String] = ["You can now put the fan", "That's nice!"]
	dialog_box.update_dialog("Teacher", data)
