extends Button

@onready var anim = $AnimationPlayer
@export var id : String
var pending_id = ""

func _ready() -> void:
	self.pivot_offset = Vector2(self.size.x / 2, self.size.y / 2)
	
func _on_pressed():
	pending_id = id
	anim.play("Popup")
	await anim.animation_finished
	match pending_id:
				"new_game":    
						load_scene("res://Scenes/NewGame.tscn")
				"options":
						load_scene("res://Scenes/Options.tscn")
				"back":
						load_scene("res://Scenes/MainMenu.tscn")
				"3d":
						load_scene("res://Scenes/Test3D.tscn")
						
func load_scene(path: String):
		var scene = load(path)
		get_tree().change_scene_to_packed(scene)
	
	
