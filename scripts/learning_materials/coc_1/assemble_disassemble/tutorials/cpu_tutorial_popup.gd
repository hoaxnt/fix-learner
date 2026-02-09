extends CanvasLayer

@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var dialog_box : MarginContainer = $DialogBox
@onready var background : TextureRect = $Background

@onready var background_1 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_tutorial/1.png")
@onready var background_2 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/cpu_tutorial/2.png")

func _ready() -> void:
	button_1.hide()
	button_2.hide()
	var data : Array[String] = ["Press the number and follow the sequence"]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	button_1.show()

func _on_button_1_button_up() -> void:
	button_2.show()
	button_1.hide()
	background.texture = background_1

func _on_button_2_button_up() -> void:
	button_2.hide()
	background.texture = background_2
	
	var data : Array[String] = ["Great job!", "CPU is placed, now put some thermal paste in it"]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	queue_free()
