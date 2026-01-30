extends Area2D

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hazards"):
		anim_sprite.frame = 0

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("hazards"):
		anim_sprite.frame = 1
