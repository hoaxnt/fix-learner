extends Area2D

@export var item_sprite : Texture2D

@onready var sprite : Sprite2D = $Sprite2D
#NOTE : GENERATE IMAGES OF HAZARDS ONE BY ONE ATLEAST 4
func _ready() -> void:
	sprite.texture = item_sprite
