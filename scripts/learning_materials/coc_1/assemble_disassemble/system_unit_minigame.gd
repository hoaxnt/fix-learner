extends Node2D

@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher
@onready var unit_sprite : Sprite2D = $Parts/EmptyUnit/Sprite2D
@onready var no_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/no-psu.png")
@onready var with_psu : Texture2D = preload("res://assets/items/assemble_disassemble/build/with-psu.png")
@onready var user_data = ResourceLoader.load("user://user_data.tres")

@onready var mobo_installed : bool = false
@onready var psu_installed : bool = false

#func _process(_delta: float) -> void:
	#await dialog_box.dialog_finished
	#teacher_sprite.hide()
#
#func _on_mobo_area_exited(area: Area2D) -> void:
	#if area.is_in_group("slots"):
		#if user_data.dragging == false:
			#unit_sprite.texture = no_psu
			#mobo_installed = true
#
#func _on_psu_area_exited(area: Area2D) -> void:
	#if area.is_in_group("slots"):
		#print("Mbobo1: ", mobo_installed)
		#if user_data.dragging == false and mobo_installed == true:
			#print("Mbobo2: ", mobo_installed)
			#unit_sprite.texture = with_psu
			##psu_installed = true
			#
			#teacher_sprite.show()
			#var data : Array[String] = ["great","job","lets move on to installing softwares"]
			#dialog_box.update_dialog("Teacher", data)
			#
			#await dialog_box.dialog_finished
			#
			#SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")

func request_installation(item_name: String) -> bool:
		if item_name == "Power Supply":
				if mobo_installed:
						install_psu()
						return true # Item will queue_free
				else:
						# Optional: Show a hint to the user
						var data : Array[String] = ["Wait! You need to install the Motherboard first."]
						dialog_box.update_dialog("Teacher", data)
						return false # Item will return_to_start
						
		if item_name == "Motherboard":
				install_mobo()
				return true
				
		return false

func install_mobo():
		unit_sprite.texture = no_psu
		mobo_installed = true

func install_psu():
		unit_sprite.texture = with_psu
		psu_installed = true
		trigger_end_dialog()

func trigger_end_dialog():
		teacher_sprite.show()
		var data : Array[String] = ["Great job!", "Let's move on to installing software."]
		dialog_box.update_dialog("Teacher", data)
		await dialog_box.dialog_finished
		SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")
