extends CanvasLayer

signal wiring_complete

func _on_button_pressed() -> void:
	# Tell the parent script we are done
	wiring_complete.emit()
	
	# Self-destruct
	queue_free()
