extends Area2D

var dragging = false
var offset = Vector2.ZERO
@onready var initial_position = global_position

func _input_event(_viewport, event, _shape_idx):
	# Detect the initial touch
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			# "Pick up" animation: make it slightly bigger and transparent
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
			offset = global_position - event.position
		else:
			dragging = false
			# "Drop" animation: snap back to normal size
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
			check_for_slot()

func _input(event):
	# Follow the finger move
	if event is InputEventScreenDrag and dragging:
		global_position = event.position + offset

func check_for_slot():
		var areas = get_overlapping_bodies() # Finds StaticBody2D slots
		var found_slot = false
		
		for body in areas:
				if body.is_in_group("slots"):# and not body.is_occupied:
						# Snap to the center of the slot
						var tween = create_tween()
						tween.tween_property(self, "global_position", body.global_position, 0.1)
						body.is_occupied = true
						found_slot = true
						print("Item placed in slot: ", body.slot_type)
						break
		if not found_slot:
				var tween = create_tween()
				tween.tween_property(self, "global_position", initial_position, 0.2)
