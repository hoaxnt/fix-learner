extends Node2D

@onready var background : Sprite2D = $Background
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher

@export var scenes_texture : Array[Texture2D]

# The next scene to load after completion
@export var next_scene_path : String = "res://scenes/learning_materials/coc_1/lessons_list_1.tscn"

var current_tex_index : int = 0

# 0-3 are intro/setup lines (Texture 0)
# 4 starts the first technical screenshot
var texture_map : Dictionary = {
	0: 0, 1: 0, 2: 0, 3: 0,  # Intro lines use the first texture
	4: 1,  # Boot Media
	5: 2,  # Regional
	6: 3,  # Install Now
	7: 4,  # Product Key
	8: 5,  # OS Selection
	9: 6,  # License
	10: 7, # Custom Install
	11: 8, # Drive Management
	12: 9, # Delete Partitions
	13: 10,# Writing Files
	14: 11,# Region Confirm
	15: 12,# Keyboard
	16: 13,# Network
	17: 14,# Username
	18: 15,# Location
	19: 16,# Find My Device
	20: 17,# Telemetry
	21: 18,# Diagnostic
	22: 19,# Finalizing
	23: 20 # Deployment Successful
}

func _ready() -> void:
	if !dialog_box.is_connected("line_changed", _on_line_changed):
		dialog_box.line_changed.connect(_on_line_changed)
	
	_start_tutorial()

func _start_tutorial():
	var data : Array[String] = [
		"Congratulations, student! You've reached the final laboratory.",
		"Your task is to install the Operating System (OS) and all essential drivers.",
		"This will complete the computer setup and make the system fully functional!",
	
		"Ensure your installation drive is connected. We must boot from the correct external media to begin.",
		"Select your language and time zone. Accuracy here ensures the system clock and updates sync correctly.",
		"Click 'Install Now' to launch the Windows Setup wizard.",
		"If you are performing a standard lab install without a key, you may select 'I don't have a product key' to proceed.",
		"Choose the specific edition of the Operating System required for this workstation's hardware specifications.",
		"Review the terms of service. You must check the acceptance box to comply with software deployment protocols.",
		"Select 'Custom: Install Windows only.' This ensures a clean, professional environment free of previous file conflicts.",
		"Identify your target drive. New drives appear as 'Unallocated Space.' Select the drive and click Next.",
		"If partitions exist, delete them to return the drive to 'Unallocated' status. Warning: This wipes all data.",
		"The system is now writing files to the disk. Depending on hardware, this may take between 2 to 30 minutes.",
		"The installer will ask for your region again to finalize local system services. Provide the standard localized input.",
		"Select your physical layout (e.g., US or UK). Improper selection will result in incorrect character mapping during use.",
		"For training purposes, we recommend skipping network setup now to expedite the local account creation.",
		"Define your Username. If a local-only access policy is in place, you may leave the password field blank for now.",
		"To maximize system privacy, we recommend setting Location Services to 'No' unless specifically required.",
		"This feature is primarily for mobile hardware. For desktop lab units, set this to 'No' and proceed.",
		"Select 'Required Only' for data transmission to Microsoft. This minimizes unnecessary background network traffic.",
		"Toggle diagnostic data to 'No.' This keeps the system lean and focused on performance.",
		"Windows is now applying final configurations. Maintain power to the unit for the next 10 minutes.",
		"Windows 11 is now fully installed and ready for initial software configuration. Excellent work, technician."
	]

	teacher_sprite.show()

	if scenes_texture.size() > 0:
		background.texture = scenes_texture[0]
		
	dialog_box.update_dialog("Technical", data)

func _on_line_changed(index: int):
	# Teacher is visible for the intro (0-3) and the final success message (23)
	teacher_sprite.visible = (index <= 2 or index >= 23)
	
	print("Current Line Index: ", index)
	
	if texture_map.has(index):
		current_tex_index = texture_map[index]
		if current_tex_index < scenes_texture.size():
			background.texture = scenes_texture[current_tex_index]
			
	# Connect finish signal on the very last line (Index 23)
	if index >= 23:
		if !dialog_box.is_connected("dialog_finished", _end):
			dialog_box.dialog_finished.connect(_end)

func _end():
	if SceneTransition:
		SceneTransition.change_scene(next_scene_path)
	else:
		get_tree().change_scene_to_file(next_scene_path)
