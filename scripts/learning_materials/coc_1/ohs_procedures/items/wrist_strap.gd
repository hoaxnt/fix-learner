extends Area2D

var dragging = false
var offset = Vector2.ZERO

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
			#check_ohs_compliance()

func _input(event):
	# Follow the finger move
	if event is InputEventScreenDrag and dragging:
		global_position = event.position + offset

#func check_ohs_compliance():
	## Your OHS Logic here
	## Example: If dropped on 'PowerSupply' without 'AntiStaticStrap'
	#if is_on_target("PowerSupply") and not Global.has_strap:
		#print("OHS Violation: Electrostatic Discharge!")
		## Snap back to original position
