extends Control

func _on_back_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
func _on_wired_connection_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_2/wired_connection/wired_connection.tscn")
func _on_wireless_connection_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_2/wireless_connection/wireless_connection.tscn")
func _on_lan_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_2/lan/lan.tscn")
