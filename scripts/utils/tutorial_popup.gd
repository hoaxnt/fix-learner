extends Control

@export var images : Array[Texture2D]
@export_multiline var descriptions : Array[String]
@export var dialog_box : MarginContainer

@onready var slides : TextureRect = $Slides

var current_index : int = 0

func _ready() -> void:
	if !dialog_box.is_connected("dialog_finished", _on_dialog_finished):
		dialog_box.dialog_finished.connect(_on_dialog_finished)
	update_content()

func _on_dialog_finished() -> void:
	current_index += 1
	
	if current_index < images.size():
		update_content()
	else:
		hide()

func update_content() -> void:
	if current_index < images.size():
		slides.texture = images[current_index]
	
	if current_index < descriptions.size():
		var lines : Array[String] = [descriptions[current_index]] 
		dialog_box.update_dialog("Tutorial Step", lines)
