extends Node2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var objective_label : Label = $CanvasLayer/ObjectiveLabel

func _ready() -> void:
	anim_player.play("camera_slide_down")
	await anim_player.animation_finished
	objective_label.show()
