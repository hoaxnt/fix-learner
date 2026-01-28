extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect

func _ready():
	color_rect.modulate.a = 0
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(target_scene_path: String):
		animation_player.play("fade_to_black")
		await animation_player.animation_finished
		get_tree().change_scene_to_file(target_scene_path)
		animation_player.play("fade_to_normal")
