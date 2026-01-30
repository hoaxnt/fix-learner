extends Area2D

@export var anim_player : AnimationPlayer
@export var objective_label : Label
@export var dialog_box : MarginContainer
@export var teacher_sprite : Sprite2D
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var user_data = ResourceLoader.load("user://user_data.tres")

func _ready() -> void:
	user_data.trash_count = 0
	ResourceSaver.save(user_data, "user://user_data.tres")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hazards"):
		anim_sprite.frame = 0

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("hazards"):
		anim_sprite.frame = 1
		print(user_data.trash_count)
		
		if user_data.trash_count == 6:
			user_data.trash_count = 0
			ResourceSaver.save(user_data, "user://user_data.tres")
			
			objective_label.hide()
			anim_player.play("trash_slide_down")
			
			await anim_player.animation_finished
			
			var data : Array[String] = ["Great!","that's what im talking","nice!"]
			dialog_box.update_dialog("Teacher", data)
			teacher_sprite.show()

			if dialog_box.dialog_finished:
				SceneTransition.change_scene("res://scenes/learning_materials/coc_1/lessons_list_1.tscn")
			
