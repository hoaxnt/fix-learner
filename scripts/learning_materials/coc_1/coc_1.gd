extends Control

func _on_back_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")

func _on_ohs_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/ohs_procedures/ohs_procedures.tscn")

func _on_hazards_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_1/electrical_hazards/electrical_hazards.tscn")

func _on_assemble_button_pressed() -> void:
	SceneTransition.change_scene("")
