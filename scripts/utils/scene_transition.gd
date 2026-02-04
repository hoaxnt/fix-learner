extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

var is_changing: bool = false

func _ready() -> void:
	color_rect.visible = false
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(target_scene_path: String) -> void:
	if is_changing:
		return
	
	is_changing = true
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	color_rect.visible = true
	
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	var path = target_scene_path.strip_edges()
	var error = get_tree().change_scene_to_file(path)
	
	if error != OK:
		push_error("SCENE CHANGER ERROR: Could not load path: " + path)
		is_changing = false
		color_rect.visible = false
		return

	await get_tree().process_frame
	
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	color_rect.visible = false
	is_changing = false
