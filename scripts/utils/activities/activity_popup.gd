extends Control

# The node that will be deleted (queue_free)
@export var dragged_parent: Node

func _on_close_button_pressed():
	# 3. Remove the dragged parent from the game
	if dragged_parent:
		dragged_parent.queue_free()
		
	else:
		push_error("No dragged_parent assigned to queue_free!")
