@tool
extends Area2D

@export var item_sprite : Texture2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D

var initial_position : Vector2
var dragging = false
var offset = Vector2.ZERO

func _ready() -> void:
	if Engine.is_editor_hint():
		# This allows you to see the texture change in the editor
		if item_sprite:
			$Sprite2D.texture = item_sprite
		return
		
	sprite.texture = item_sprite
	initial_position = global_position

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			dragging = true
			# Calculate offset using GLOBAL mouse position
			offset = global_position - get_global_mouse_position()
			
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
			get_viewport().set_input_as_handled()
		else:
			dragging = false
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
			check_for_slot()

func _input(event):
	# Use the global mouse position instead of event.position
	if dragging and (event is InputEventScreenDrag or event is InputEventMouseMotion):
		global_position = get_global_mouse_position() + offset

func start_dragging():
	dragging = true
	z_index = 100 
	
	# Calculate offset BEFORE the scale change to prevent jumping
	offset = global_position - get_global_mouse_position()
	
	# Visual Pop: Scale up slightly (1.2x)
	var tween = create_tween()
	# .set_trans(Tween.TRANS_BACK) gives it a nice organic 'bounce'
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# Optional: Make it slightly transparent so you can see the slots underneath
	tween.parallel().tween_property(self, "modulate:a", 0.7, 0.15)

func stop_dragging():
	dragging = false
	z_index = 0
	
	var tween = create_tween()
	# Return to original size and full opacity
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	tween.parallel().tween_property(self, "modulate:a", 1.0, 0.1)
	
	check_for_slot()

func check_for_slot():
	var areas = get_overlapping_areas()
	var found_slot = false
	
	for area in areas:
		if area.is_in_group("slots"):
			found_slot = true
			snap_to_slot(area)
			queue_free()
			break
					
	if not found_slot:
		return_to_start()

func snap_to_slot(slot_area):
	var tween = create_tween()
	# Snap to the center of the slot
	tween.tween_property(self, "global_position", slot_area.global_position, 0.1).set_trans(Tween.TRANS_CUBIC)
	
	# Handle slot logic here (e.g., slot_area.is_occupied = true)
	if slot_area.has_method("occupy_slot"):
		slot_area.occupy_slot()
		
	await tween.finished
	queue_free()

func return_to_start():
	var tween = create_tween()
	tween.tween_property(self, "global_position", initial_position, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
