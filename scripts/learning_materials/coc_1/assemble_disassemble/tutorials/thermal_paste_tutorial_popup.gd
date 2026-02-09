extends CanvasLayer

@onready var dialog_box : MarginContainer = $DialogBox
@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2

func _ready() -> void:
	pass
	
func _on_button_1_button_up() -> void:
	var data : Array[String] = ["",""]
	dialog_box.update_dialog("Teacher", data)
	await dialog_box.dialog_finished
	queue_free()


func _on_button_2_button_up() -> void:
	var data : Array[String] = ["",""]
	dialog_box.update_dialog("Teacher", data)
