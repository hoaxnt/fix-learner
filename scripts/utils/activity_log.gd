extends Control

@onready var canvas_layer : CanvasLayer = $CanvasLayer

func _on_back_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main_menu.tscn")
	
func _on_safety_tools_pressed() -> void:
	SceneTransition.change_scene("res://scenes/utils/activities/ohs_procedure_activity/ohs_procedure_activity.tscn")
	
func _on_electrical_hazards_pressed() -> void:
	SceneTransition.change_scene("res://scenes/utils/activities/electrical_hazards_activity/electrical_hazards_activity.tscn")
	
func _on_bootable_device_pressed() -> void:
	SceneTransition.change_scene("res://scenes/utils/activities/electrical_hazards_activity/electrical_hazards_activity.tscn")
