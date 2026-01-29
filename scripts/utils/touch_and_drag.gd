extends Area2D

@export var dialog_box : MarginContainer
@export var item_display_name: String
@export_multiline var item_info: Array[String]

@export var texture : Texture2D
@export var item_name : String = "None"

@onready var user_data = ResourceLoader.load("user://user_data.tres")
@onready var shadow_sprite : Sprite2D = $Shadow
@onready var name_label : Label = $NameLabel
@onready var item_sprite : Sprite2D = $Sprite2D
@onready var initial_position = global_position
var dragging = false
var offset = Vector2.ZERO

func _ready() -> void:
	user_data.toolbox_item_count = 0
	name_label.hide()
	name_label.text = item_name
	
	if texture:
		item_sprite.texture = texture

func _input_event(_viewport, event, _shape_idx):
	# Detect the initial touch
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			name_label.show()
			shadow_sprite.hide()
			
			# "Pick up" animation: make it slightly bigger and transparent
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
			offset = global_position - event.position
		else:
			dragging = false
			name_label.hide()
			shadow_sprite.show()
			
			# "Drop" animation: snap back to normal size
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
			check_for_slot()

func _input(event):
	# Follow the finger move
	if event is InputEventScreenDrag and dragging:
		global_position = event.position + offset
				
func check_for_slot():
	var areas = get_overlapping_bodies()
	var found_slot = false
	
	for body in areas:
		if body.is_in_group("slots"):
			# 1. Snap Animation
			var tween = create_tween()
			tween.tween_property(self, "global_position", body.global_position, 0.1)
			
			if dialog_box:
				var data : Array[String] = item_info.duplicate()
				user_data.toolbox_item_count += 1
				ResourceSaver.save(user_data, "user://user_data.tres")
				# NOTE: make the append dynamic data
				if user_data.toolbox_item_count == 5:
					data.append("Nice! Let's go!") 
					user_data.toolbox_item_count = 0 # Reset for next round
				# Send the updated array (which now has 1 extra line at the end)
				dialog_box.update_dialog(item_display_name, data)
		
			body.is_occupied = true
			found_slot = true
				# 3. Delay queue_free so the player sees the snap
			await tween.finished
			queue_free()
			break
					
	if not found_slot:
			var tween = create_tween()
			tween.tween_property(self, "global_position", initial_position, 0.2)
