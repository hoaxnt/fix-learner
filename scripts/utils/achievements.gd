extends Control

@onready var display = $CanvasLayer/AchivementPreview/VBoxContainer/Display
@onready var canvas_layer = $CanvasLayer

# Preloads
@onready var protocol_master = preload("res://assets/ui/achievement/protocol-master.jpg")
@onready var hazard_handler = preload("res://assets/ui/achievement/hazard.PNG")
@onready var core_master = preload("res://assets/ui/achievement/core-master.jpg")
@onready var cool_operator = preload("res://assets/ui/achievement/cool-operator.jpg")
@onready var airflow_expert = preload("res://assets/ui/achievement/airflow-expert.PNG")
@onready var memory_ready = preload("res://assets/ui/achievement/memory-ready.jpg")
@onready var visual_boost = preload("res://assets/ui/achievement/visual-boost.jpg")
@onready var speed_driver = preload("res://assets/ui/achievement/speed-driver.jpg")
@onready var board_secured = preload("res://assets/ui/achievement/board-secured.PNG")
@onready var power_connected = preload("res://assets/ui/achievement/power-connected.jpg")
@onready var power_routed = preload("res://assets/ui/achievement/power-routed.jpg")
@onready var usb_ready = preload("res://assets/ui/achievement/usb-ready.jpg")
@onready var os_installed = preload("res://assets/ui/achievement/os-installed.jpg")

func _ready() -> void:
	# Hide the preview layer by default
	canvas_layer.hide()

func _on_close_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main_menu.tscn")
	
func _on_protocol_master_pressed() -> void:
	display.texture = protocol_master
	canvas_layer.show()

func _on_hazard_handler_pressed() -> void:
	display.texture = hazard_handler
	canvas_layer.show()

func _on_core_master_pressed() -> void:
	display.texture = core_master
	canvas_layer.show()

func _on_cool_operator_pressed() -> void:
	display.texture = cool_operator
	canvas_layer.show()

func _on_airflow_expert_pressed() -> void:
	display.texture = airflow_expert
	canvas_layer.show()

func _on_memory_ready_pressed() -> void:
	display.texture = memory_ready
	canvas_layer.show()

func _on_visual_boost_pressed() -> void:
	display.texture = visual_boost
	canvas_layer.show()

func _on_speed_driver_pressed() -> void:
	display.texture = speed_driver
	canvas_layer.show()

func _on_board_secured_pressed() -> void:
	display.texture = board_secured
	canvas_layer.show()

func _on_power_connected_pressed() -> void:
	display.texture = power_connected
	canvas_layer.show()

func _on_power_routed_pressed() -> void:
	display.texture = power_routed
	canvas_layer.show()

func _on_usb_ready_pressed() -> void:
	display.texture = usb_ready
	canvas_layer.show()

func _on_os_installed_pressed() -> void:
	display.texture = os_installed
	canvas_layer.show()
