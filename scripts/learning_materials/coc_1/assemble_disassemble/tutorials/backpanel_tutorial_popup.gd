extends CanvasLayer

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var b1 = $Button1
@onready var b2 = $Button2
@onready var b3 = $Button3
@onready var b4 = $Button4

# Completing the sequence of preloaded textures
@onready var tex2 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b2.png")
@onready var tex3 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b3.png")
@onready var tex4 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b4.jpg")
@onready var tex5 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b5.png")

signal install_complete

func _ready() -> void:
	# Initialize the UI state
	b2.hide()
	b3.hide()
	b4.hide()

func _on_button_1_pressed() -> void:
	background.texture = tex2
	b1.hide()
	b2.show()

func _on_button_2_pressed() -> void:
	background.texture = tex3
	b2.hide()
	b3.show()

func _on_button_3_pressed() -> void:
	background.texture = tex4
	b3.hide()
	b4.show()

func _on_button_4_pressed() -> void:
	# Final step: update texture and cleanup
	background.texture = tex5
	b4.hide()
	install_complete.emit()
	
	var data : Array[String] = ["Great! We're all set!"]
	dialog_box.update_dialog("Teacher", data)
	
	# Wait for the player to finish reading before switching scenes
	await dialog_box.dialog_finished
	
	if get_tree().root.get_node("SystemUnitMinigame/CanvasLayer/FinishButton"):
		var finish_button : Button = get_tree().root.get_node("SystemUnitMinigame/CanvasLayer/FinishButton")
		finish_button.show()
	else:
		print("finish button not found")
	
	queue_free()
