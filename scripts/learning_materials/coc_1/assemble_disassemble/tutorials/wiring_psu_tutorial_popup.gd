extends CanvasLayer

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox
@onready var b1 = $Button1
@onready var b2 = $Button2
@onready var b3 = $Button3
@onready var b4 = $Button4
@onready var b5 = $Button5
@onready var b6 = $Button6

@onready var tex2 = preload("res://assets/tutorials/assemble_disassemble/wiring_psu_tutorial/2.jpg")
@onready var tex3 = preload("res://assets/tutorials/assemble_disassemble/wiring_psu_tutorial/3.png")
@onready var tex4 = preload("res://assets/tutorials/assemble_disassemble/wiring_psu_tutorial/4.png")
@onready var tex5 = preload("res://assets/tutorials/assemble_disassemble/wiring_psu_tutorial/5.jpg")
@onready var tex6 = preload("res://assets/tutorials/assemble_disassemble/wiring_psu_tutorial/6.jpg")
@onready var tex7 = preload("res://assets/tutorials/assemble_disassemble/wiring_psu_tutorial/7.jpg")

@onready var psu_to_unit_scene : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/psu_to_unit_tutorial_popup.tscn")


func _ready() -> void:
	b2.hide()
	b3.hide()
	b4.hide()
	b5.hide()
	b6.hide()

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
	b5.show()

func _on_button_5_pressed() -> void:
	background.texture = tex6
	b5.hide()
	b6.show()
	
func _on_button_6_pressed() -> void:
	background.texture = tex7
	b6.hide()
	
	var data : Array[String] = ["Great! now put the PSU to case"]
	dialog_box.update_dialog("Teacher", data)
	
	await dialog_box.dialog_finished
	
	var psu_to_unit_instance = psu_to_unit_scene.instantiate()
	get_parent().add_child(psu_to_unit_instance)
	
	queue_free()
