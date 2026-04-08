extends Control

# The node that will be deleted (queue_free)
@export var dragged_parent: Node

func _on_close_button_pressed():
	if dragged_parent:
		SceneTransition.change_scene("res://scenes/utils/activity_log.tscn")
		dragged_parent.queue_free()
	else:
		print("No dragged_parent assigned to queue_free!")
