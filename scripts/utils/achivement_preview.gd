extends Panel

@onready var close_button = $VBoxContainer/CloseButton

func _ready() -> void:
	pass
	#get_parent().hide()

func _on_close_button_pressed() -> void:
	get_parent().hide()
