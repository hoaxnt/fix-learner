extends Control

@onready var dialog = CanvasLayer

func _ready() -> void:
	$CanvasLayer/AcceptDialog.popup_centered()

func _process(delta: float) -> void:
	pass
