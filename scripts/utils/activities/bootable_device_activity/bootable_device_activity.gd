extends Control

@onready var background = $CanvasLayer/Background

# We use an Array to hold the buttons for easier access in a loop
var buttons: Array = []

# Preloading all 25 images
@onready var image_1 = preload("res://assets/items/bootable_device/activity/1.jpg")
@onready var image_2 = preload("res://assets/items/bootable_device/activity/2.jpg")
@onready var image_3 = preload("res://assets/items/bootable_device/activity/3.jpg")
@onready var image_4 = preload("res://assets/items/bootable_device/activity/4.jpg")
@onready var image_5 = preload("res://assets/items/bootable_device/activity/5.jpg")
@onready var image_6 = preload("res://assets/items/bootable_device/activity/6.jpg")
@onready var image_7 = preload("res://assets/items/bootable_device/activity/7.jpg")
@onready var image_8 = preload("res://assets/items/bootable_device/activity/8.jpg")
@onready var image_9 = preload("res://assets/items/bootable_device/activity/9.jpg")
@onready var image_10 = preload("res://assets/items/bootable_device/activity/10.jpg")
@onready var image_11 = preload("res://assets/items/bootable_device/activity/11.jpg")
@onready var image_12 = preload("res://assets/items/bootable_device/activity/12.jpg")
@onready var image_13 = preload("res://assets/items/bootable_device/activity/13.jpg")
@onready var image_14 = preload("res://assets/items/bootable_device/activity/14.jpg")
@onready var image_15 = preload("res://assets/items/bootable_device/activity/15.jpg")
@onready var image_16 = preload("res://assets/items/bootable_device/activity/16.jpg")
@onready var image_17 = preload("res://assets/items/bootable_device/activity/17.jpg")
@onready var image_18 = preload("res://assets/items/bootable_device/activity/18.jpg")
@onready var image_19 = preload("res://assets/items/bootable_device/activity/19.jpg")
@onready var image_20 = preload("res://assets/items/bootable_device/activity/20.jpg")
@onready var image_21 = preload("res://assets/items/bootable_device/activity/21.jpg")
@onready var image_22 = preload("res://assets/items/bootable_device/activity/22.jpg")
@onready var image_23 = preload("res://assets/items/bootable_device/activity/23.jpg")
@onready var image_24 = preload("res://assets/items/bootable_device/activity/24.jpg")
@onready var image_25 = preload("res://assets/items/bootable_device/activity/25.jpg")

# Store images in an array for indexed access
@onready var all_images = [
	image_1, image_2, image_3, image_4, image_5, 
	image_6, image_7, image_8, image_9, image_10,
	image_11, image_12, image_13, image_14, image_15,
	image_16, image_17, image_18, image_19, image_20,
	image_21, image_22, image_23, image_24, image_25
]

func _ready() -> void:
	# Automatically find and connect all 25 buttons
	for i in range(1, 26):
		var btn_path = "CanvasLayer/Control/Button" + str(i)
		var btn = get_node_or_null(btn_path)
		
		if btn:
			buttons.append(btn)
			# Connect the signal with the button's index (0-24)
			btn.pressed.connect(_on_any_button_pressed.bind(i - 1))
			
			# Optional: Hide all buttons except the first one at start
			if i > 1:
				btn.hide()
		else:
			print("Warning: Button ", i, " not found at path: ", btn_path)

	# Set initial background
	background.texture = image_1

func _on_any_button_pressed(index: int) -> void:
	# 1. Hide the current button
	buttons[index].hide()
	
	# 2. Check if there is a next image to show
	if index + 1 < all_images.size():
		background.texture = all_images[index + 1]
		
		# 3. Show the next button in the sequence (if it exists)
		if index + 1 < buttons.size():
			buttons[index + 1].show()
	else:
		print("Sequence complete!")

# Individual functions (Manual connections)
# If you prefer connecting manually in the editor, use these:

func _on_button_1_pressed(): _on_any_button_pressed(0)
func _on_button_2_pressed(): _on_any_button_pressed(1)
func _on_button_3_pressed(): _on_any_button_pressed(2)
func _on_button_4_pressed(): _on_any_button_pressed(3)
func _on_button_5_pressed(): _on_any_button_pressed(4)
func _on_button_6_pressed(): _on_any_button_pressed(5)
func _on_button_7_pressed(): _on_any_button_pressed(6)
func _on_button_8_pressed(): _on_any_button_pressed(7)
func _on_button_9_pressed(): _on_any_button_pressed(8)
func _on_button_10_pressed(): _on_any_button_pressed(9)
func _on_button_11_pressed(): _on_any_button_pressed(10)
func _on_button_12_pressed(): _on_any_button_pressed(11)
func _on_button_13_pressed(): _on_any_button_pressed(12)
func _on_button_14_pressed(): _on_any_button_pressed(13)
func _on_button_15_pressed(): _on_any_button_pressed(14)
func _on_button_16_pressed(): _on_any_button_pressed(15)
func _on_button_17_pressed(): _on_any_button_pressed(16)
func _on_button_18_pressed(): _on_any_button_pressed(17)
func _on_button_19_pressed(): _on_any_button_pressed(18)
func _on_button_20_pressed(): _on_any_button_pressed(19)
func _on_button_21_pressed(): _on_any_button_pressed(20)
func _on_button_22_pressed(): _on_any_button_pressed(21)
func _on_button_23_pressed(): _on_any_button_pressed(22)
func _on_button_24_pressed(): _on_any_button_pressed(23)
func _on_button_25_pressed(): _on_any_button_pressed(24)
