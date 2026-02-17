extends Area2D

@export var item_name_string : String = "none"
@export var item_label : Label
@export var shadow : Sprite2D

@export var tutorial_scene : PackedScene = preload("res://scenes/learning_materials/coc_1/assemble_disassemble/tutorials/wiring_psu_tutorial_popup.tscn")

@onready var user_data = ResourceLoader.load("user://user_data.tres")

var initial_position : Vector2
var dragging : bool = false
var offset : Vector2 = Vector2.ZERO

# NEW: Boolean flag to track if the scene was already shown
var tutorial_shown : bool = false

func _ready() -> void:
	user_data.dragging = false
	ResourceSaver.save(user_data, "user://user_data.tres")
	initial_position = global_position
	
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
		elif dragging:
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
	
	# --- NEW TUTORIAL LOGIC ---
	if not tutorial_shown and tutorial_scene:
		var tutorial_instance = tutorial_scene.instantiate()
		# Add to the CanvasLayer of the current main scene
		get_tree().current_scene.get_node("CanvasLayer").add_child(tutorial_instance)
		tutorial_shown = true # Set to true so it never runs again
	# --------------------------
	
	if shadow: shadow.hide()
	if item_label: item_label.show()
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.7, 0.15)

func stop_dragging() -> void:
	dragging = false
	z_index = 0
	
	if shadow: shadow.show()
	if item_label: item_label.hide()
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	
	check_for_slot()
	
func check_for_slot() -> void:
	var targets = get_overlapping_areas()
	for area in targets:
		if area.is_in_group("slots"):
			snap_to_slot(area)
			return 
			
	return_to_start()

func snap_to_slot(slot_area: Area2D) -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", slot_area.global_position, 0.1).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	
	var main_game = get_tree().current_scene 
	if main_game.has_method("request_installation"):
		var success = main_game.request_installation(item_name_string)
		if success:
			queue_free()
		else:
			return_to_start()
	else:
		queue_free()
				
func return_to_start() -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", initial_position, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
