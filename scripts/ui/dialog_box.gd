extends MarginContainer

# This allows you to add lines of text in the Inspector
@export_multiline var dialog_lines: Array[String] = []
@export var text_speed: float = 0.05

@onready var label = $MarginContainer/VBoxContainer/RichTextLabel
@onready var timer = $Timer

var current_line_index: int = 0

func _ready():
	scale = Vector2(0.5, 0.5)
	modulate.a = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	if dialog_lines.size() > 0:
		show_line()
	else:
		hide()

func _on_next_button_pressed() -> void:
	if label.visible_ratio < 1.0:
		label.visible_ratio = 1.0
		timer.stop()
	else:
		current_line_index += 1
		if current_line_index < dialog_lines.size():
			show_line()
		else:
			finish_dialog()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if label.visible_ratio < 1.0:
			label.visible_ratio = 1.0
			timer.stop()
		else:
			current_line_index += 1
			if current_line_index < dialog_lines.size():
				show_line()
			else:
				finish_dialog()
				
func update_dialog(new_lines: Array[String]):
	dialog_lines = new_lines
	current_line_index = 0
	show()
	set_process_input(true) 
	show_line()

func show_line():
		label.text = dialog_lines[current_line_index]
		label.visible_characters = 0
		timer.start(text_speed)

func _on_timer_timeout():
		if label.visible_characters < label.text.length():
				label.visible_characters += 1
		else:
				timer.stop()

func finish_dialog():
	hide()
	set_process_input(false)
	#emit a signal so other scripts know it's done
	emit_signal("dialog_finished")
