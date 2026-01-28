extends StaticBody2D

@export var slot_type: String = "none"
@export var is_occupied: bool = false
@export var slot_color: ColorRect

func accept_item(item_name: String) -> bool:
	if item_name: # == slot_type:
		print("Safety Procedure Followed!")
		slot_color.color = Color.GREEN # Visual feedback
		return true
	else:
		print("OHS Violation: Wrong tool for this step!")
		return false
