extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Reparent this CanvasLayer to the current scene root
	var parent_scene := get_tree().current_scene
	if get_parent() != parent_scene:
		get_parent().remove_child(self)
		parent_scene.add_child(self)

	# After 3 seconds, fade out then free
	await get_tree().create_timer(3.0).timeout
	var panel := get_node_or_null("Panel")
	if panel:
		var tween := create_tween()
		tween.tween_property(panel, "modulate:a", 0.0, 0.5)
		await tween.finished
	queue_free()
