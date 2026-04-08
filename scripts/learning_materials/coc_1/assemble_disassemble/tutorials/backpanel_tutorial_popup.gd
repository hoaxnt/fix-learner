extends CanvasLayer

@onready var background : TextureRect = $Background
@onready var dialog_box : MarginContainer = $DialogBox

@onready var b1 = $Button1
@onready var b2 = $Button2
@onready var b3 = $Button3
@onready var b4 = $Button4

# Preloaded textures
@onready var tex2 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b2.png")
@onready var tex3 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b3.png")
@onready var tex4 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b4.jpg")
@onready var tex5 = preload("res://assets/tutorials/assemble_disassemble/psu_to_unit_tutorial/b5.png")

signal install_complete

func _ready() -> void:
	# Disable the dialog's built-in "Next" mechanics until the tutorial is over
	if dialog_box.next_button:
		dialog_box.next_button.disabled = true
		if dialog_box.next_label:
			dialog_box.next_label.visible = false
	
	# Initialize tutorial buttons
	b2.hide()
	b3.hide()
	b4.hide()

func _on_button_1_pressed() -> void:
	# Force the dialog to advance if necessary
	if dialog_box.next_button:
		dialog_box.next_button.pressed.emit()
	
	background.texture = tex2
	b1.hide()
	b2.show()

func _on_button_2_pressed() -> void:
	if dialog_box.next_button:
		dialog_box.next_button.pressed.emit()
		
	background.texture = tex3
	b2.hide()
	b3.show()

func _on_button_3_pressed() -> void:
	# Note: In your original code, button 4/5 didn't always emit. 
	# If you want the text to change here, keep the emit.
	if dialog_box.next_button:
		dialog_box.next_button.pressed.emit()
		
	background.texture = tex4
	b3.hide()
	b4.show()

func _on_button_4_pressed() -> void:
	# Final step
	background.texture = tex5
	b4.hide()
	
	# Update the dialog text for the conclusion
	var data : Array[String] = ["Great! We're all set!"]
	dialog_box.update_dialog("Teacher", data)
	
	# Re-enable the dialog's "Next" button so the user can finish the talk
	if dialog_box.next_button:
		dialog_box.next_button.disabled = false
		if dialog_box.next_label:
			dialog_box.next_label.visible = true
	
	# Wait for the user to click the dialog's next button and finish the text
	await dialog_box.dialog_finished
	
	install_complete.emit()
	
	# Handle scene cleanup and external UI
	if get_tree().root.has_node("SystemUnitMinigame/CanvasLayer/FinishButton"):
		var finish_button : Button = get_tree().root.get_node("SystemUnitMinigame/CanvasLayer/FinishButton")
		finish_button.show()
	else:
		print("finish button not found")
	
	queue_free()
