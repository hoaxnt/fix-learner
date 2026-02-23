extends CanvasLayer

@onready var background : TextureRect = $Background

@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
@onready var button_3 : Button = $Button3
@onready var button_4 : Button = $Button4

@onready var screw_button : Button = $ItemList/ScrewButton
@onready var screw_driver_button : Button = $ItemList/ScrewdriverButton

@onready var image_1 : Texture2D = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/p2.jpg")
@onready var image_2 : Texture2D = preload("")
@onready var image_3 : Texture2D = preload("")
@onready var image_4 : Texture2D = preload("")

var all_screw_placed : bool = false


func _on_button_1_pressed() -> void:
	background.texture = image_1
	button_1.hide()
	button_2.show()

func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	pass # Replace with function body.
