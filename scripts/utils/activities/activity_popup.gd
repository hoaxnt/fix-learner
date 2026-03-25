extends Control

# The scene you want to create
@export var scene_to_instantiate: PackedScene

# The node where the new instance will be placed
@export var target_parent: Node

# The node that will be deleted (queue_free)
@export var dragged_parent: Node

func _ready():
	# Connect the button's pressed signal to our function
	self.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed():
	if scene_to_instantiate == null:
		push_warning("No scene assigned to instantiate!")
		return

	# 1. Instantiate the new scene
	var new_instance = scene_to_instantiate.instantiate()
	
	# 2. Add it to the assigned target parent
	if target_parent:
		target_parent.add_child(new_instance)
	else:
		# Fallback: add to the button's parent if target isn't set
		get_parent().add_child(new_instance)
	
	# 3. Remove the dragged parent from the game
	if dragged_parent:
		dragged_parent.queue_free()
		print("Dragged parent removed and scene instantiated!")
	else:
		push_error("No dragged_parent assigned to queue_free!")
