extends CanvasLayer

@onready var dialog_box : MarginContainer = $DialogBox
@onready var button_1 : Button = $Button1
@onready var button_2 : Button = $Button2
	
func _on_button_1_button_up() -> void:
	var data : Array[String] = ["Applying correct thermal paste can improve heat transfer between the CPU and the cooler",
	"Helping the processor stay cool, maintain stable performance, and prevent overheating.", "We can now install the CPU fan!"]
	dialog_box.update_dialog("Teacher", data)
	await dialog_box.dialog_finished
	queue_free()

func _on_button_2_button_up() -> void:
	var data : Array[String] = ["Applying too much thermal paste can cause poor heat transfer, higher CPU temperatures, and excess paste to spill onto the motherboard",
	"Which may lead to mess, reduced cooling efficiency, or even potential damage if the paste is conductive."]
	dialog_box.update_dialog("Teacher", data)
