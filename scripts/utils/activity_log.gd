extends Control

@onready var canvas_layer : CanvasLayer = $CanvasLayer
@onready var ohs_procedure = preload("res://scenes/utils/activities/ohs_procedure_activity/ohs_procedure_activity.tscn")
func _on_back_button_pressed() -> void:
	self.queue_free()

func _on_safety_tools_pressed() -> void:
	var ohs_procedure_instance = ohs_procedure.instantiate()
	canvas_layer.add_child(ohs_procedure_instance)
	pass # Replace with function body.

#NOTE: Make atleast one activity working when pressed in activity log
