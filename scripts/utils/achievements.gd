extends Control

func _on_close_button_pressed() -> void:
	self.queue_free()
