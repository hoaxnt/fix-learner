extends CanvasLayer

@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var image_2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/gpu_tutorial/2.png")

func _ready() -> void:
	await dialog_box.dialog_finished
	button_1.show()

func _on_button_1_button_up() -> void:
	button_1.hide()
	button_2.show()
	
func _on_button_2_button_up() -> void:
	background.texture = image_2
	button_2.hide()
	var data : Array[String] = ["After hearing the click sound, you are ready to proceed to the next step."]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	queue_free()
