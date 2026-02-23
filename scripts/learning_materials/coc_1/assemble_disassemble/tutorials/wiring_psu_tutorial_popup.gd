extends CanvasLayer

signal wiring_complete

func _on_button_pressed() -> void:
	wiring_complete.emit()
	queue_free()
