extends Node2D

@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@onready var unit_sprite : Sprite2D = $Parts/EmptyUnit/Sprite2D
@onready var no_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/no-psu.png")
@onready var with_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-psu.png")
@onready var user_data = ResourceLoader.load("user://user_data.tres")

var mobo_installed : bool = false
var psu_installed : bool = false

func _process(_delta: float) -> void:
	await dialog_box.dialog_finished
	teacher_sprite.hide()

func _on_mobo_area_exited(area: Area2D) -> void:
	if area.is_in_group("slots"):
		if user_data.dragging == false:
			unit_sprite.texture = no_psu
			mobo_installed = true

func _on_psu_area_exited(area: Area2D) -> void:
	if area.is_in_group("slots"):
		if mobo_installed:
			if user_data.dragging == false:
				unit_sprite.texture = with_psu
				psu_installed = true
			
func _physics_process(_delta: float) -> void:
	if psu_installed:
		psu_installed = false
		
		teacher_sprite.show()
		var data : Array[String] = ["great","job","lets move on to installing softwares"]
		dialog_box.update_dialog("Teacher", data)
		
		await dialog_box.dialog_finished
		
		SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")
