extends Control

@export var images : Array[Texture2D]
@export_multiline var descriptions : Array[String]
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var slides : TextureRect = $Slides

var current_index : int = 0

func _ready() -> void:
	if !dialog_box.is_connected("dialog_finished", _on_dialog_finished):
		dialog_box.dialog_finished.connect(_on_dialog_finished)
	update_content.call_deferred()

func _on_dialog_finished() -> void:
	current_index += 1
	if current_index < images.size():
		update_content()
	else:
		queue_free()

func update_content() -> void:
	# Update the visual slide
	if current_index < images.size():
		slides.texture = images[current_index]
	# Update the dialog text
	if current_index < descriptions.size():
		# Wrap the single string in an Array[String] as your function expects
		var lines : Array[String] = [descriptions[current_index]]
		# Pass both the title and the array
		dialog_box.update_dialog("Teacher", lines)
