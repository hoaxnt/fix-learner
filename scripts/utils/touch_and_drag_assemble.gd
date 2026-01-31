extends Area2D

@export var item_name_string : String = "none"
@export var item_label : Label
@export var shadow : Sprite2D
@onready var user_data = ResourceLoader.load("user://user_data.tres")

var initial_position : Vector2
var dragging : bool = false
var offset : Vector2 = Vector2.ZERO

func _ready() -> void:
	user_data.dragging = false
	ResourceSaver.save(user_data, "user://user_data.tres")
	initial_position = global_position
	
	# Setup initial UI state
	if item_label:
		item_label.text = item_name_string
		item_label.hide()
	if shadow:
		shadow.show()

func _input_event(_viewport, event, _shape_idx) -> void:
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			user_data.dragging = true
			ResourceSaver.save(user_data, "user://user_data.tres")
			start_dragging()
			get_viewport().set_input_as_handled()
		elif dragging: # Only stop if we were actually dragging
			user_data.dragging = false
			ResourceSaver.save(user_data, "user://user_data.tres")
			stop_dragging()

func _input(event) -> void:
	if dragging and (event is InputEventScreenDrag or event is InputEventMouseMotion):
		global_position = get_global_mouse_position() + offset

func start_dragging() -> void:
	dragging = true
	z_index = 100
	offset = global_position - get_global_mouse_position()
	
	# Toggle Visuals
	if shadow: shadow.hide()
	if item_label: item_label.show()
	
	# "Pick up" Animation
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.7, 0.15)

func stop_dragging() -> void:
	dragging = false
	z_index = 0
	
	# Toggle Visuals
	if shadow: shadow.show()
	if item_label: item_label.hide()
	
	# "Drop" Animation
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	
	check_for_slot()
	
func check_for_slot() -> void:
	var targets = get_overlapping_areas()
	# Optional: if your slots are StaticBodies, use get_overlapping_bodies()
	
	for area in targets:
		if area.is_in_group("slots"):
			snap_to_slot(area)
			return # Exit function early if found
			
	return_to_start()

func snap_to_slot(slot_area: Area2D) -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", slot_area.global_position, 0.1).set_trans(Tween.TRANS_CUBIC)
	
	if slot_area.has_method("occupy_slot"):
		slot_area.occupy_slot()
		
	await tween.finished
	queue_free() # Uncomment if item should disappear after snapping

func return_to_start() -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", initial_position, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
