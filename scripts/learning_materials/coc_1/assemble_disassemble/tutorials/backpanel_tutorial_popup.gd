extends CanvasLayer

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var b1 = $Button1
@onready var b2 = $Button2
@onready var b3 = $Button3
@onready var b4 = $Button4

@onready var tex2 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b2.png")
@onready var tex3 = preload("")
@onready var tex4 = preload("")
@onready var tex5 = preload("")

func _ready() -> void:
	b2.hide()
	b3.hide()
	b4.hide()

func _on_button_1_pressed() -> void:
	background.texture = tex2
	b1.hide()
	b2.show()

func _on_button_2_pressed() -> void:
	background.texture = tex3
	b2.hide()
	b3.show()

func _on_button_3_pressed() -> void:
	background.texture = tex4
	b3.hide()
	b4.show()

func _on_button_4_pressed() -> void:
	background.texture = tex5
	b4.hide()
	
	var data : Array[String] = ["Great! now put the PSU to case"]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/assemble_disassemble/system_unit_minigame.tscn")
	queue_free()
