extends Control

@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var canvas_layer : CanvasLayer = $CanvasLayer
@onready var user_agreement : Panel = $CanvasLayer/Panel
@onready var achievements = preload("res://scenes/utils/achievements.tscn")
@onready var activity_log = preload("res://scenes/utils/activity_log.tscn")

func _ready() -> void:
	#user_data.opened_once = false
	#ResourceSaver.save(user_data, "user://user_data.tres")
	if user_data.opened_once:
		user_agreement.hide()
		
func _on_continue_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_learn_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/learning_materials/coc_list.tscn")
	
func _on_options_button_pressed() -> void:
	print("Options")
	pass # Replace with function body.
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_accept_button_pressed() -> void:
	user_data.opened_once = true
	ResourceSaver.save(user_data, "user://user_data.tres")
	
	get_child(2).visible = false
	
func _on_decline_button_pressed() -> void:
	get_tree().quit()

func _on_achievements_button_pressed() -> void:
	var achievements_instance = achievements.instantiate()
	canvas_layer.add_child(achievements_instance)

func _on_activity_log_button_pressed() -> void:
	var activity_log_instance = activity_log.instantiate()
	canvas_layer.add_child(activity_log_instance)
