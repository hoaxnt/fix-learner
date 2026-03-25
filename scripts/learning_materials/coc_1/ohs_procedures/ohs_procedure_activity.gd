extends Node

@onready var minigame : Node2D = $Minigame
@onready var minigame_label : Label = $CanvasLayer/MinigameLabel

func _ready() -> void:
	minigame.show()
	minigame_label.show()
