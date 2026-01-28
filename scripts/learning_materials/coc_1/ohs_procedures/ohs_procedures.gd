extends Node

@onready var dialog_box = $CanvasLayer/DialogBox
@onready var teacher_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float) -> void:
	print(dialog_box.current_line_index)
	if dialog_box.current_line_index == 3:
		teacher_sprite.hide()
		
		var extra_lines: Array[String] = [
				"Wait! I forgot to tell you something.",
        "The treasure is hidden behind the [wave]waterfall[/wave]."
		]
		dialog_box.update_dialog(extra_lines)
		print(dialog_box.current_line_index)
