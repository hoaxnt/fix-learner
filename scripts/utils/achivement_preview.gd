extends Panel

@onready var display = $VBoxContainer/Display
@onready var close_button = $VBoxContainer/CloseButton

# Preloads updated to match your file extensions exactly
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
	# Default display
	display.texture = os_installed
