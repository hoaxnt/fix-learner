extends Node2D

@onready var background : Sprite2D = $Background
@onready var dialog_box : MarginContainer = $CanvasLayer/DialogBox
@onready var teacher_sprite : Sprite2D = $Teacher

@export var scenes_texture : Array[Texture2D]

func _ready() -> void:
	# Connect the signal from your DialogBox script
	dialog_box.line_changed.connect(_on_line_changed)
	
	# Start the tutorial right away
	_start_tutorial()

func _start_tutorial():
	teacher_sprite.show()

	var data : Array[String] = [
	"Well done, student. Now, let’s take it a step further.",
	"In our next lab, you’ll be preparing a bootable flash drive...",
	"Pay close attention to the formatting steps.",
	"Search Rufus and click the link below that says Rufus...",
	"Now click the rufus-4.12.exe with the standard type.",
	"You can now see the downloaded setup on the top right corner, but don't click it yet.",
	"Search Windows 11 ISO on Google Chrome.",
	"Click Download Windows 11 below.",
	"After that, you may select the type of OS you want to download; this time we are using Windows 11.",
	"Click the select download drop down section.",
	"Now select the Windows 11 Multi-edition ISO for x64 devices.",
	"Wait for a few seconds... loading dito boy.",
	"Now in this section, we will select the language we will use.",
	"Choose English (United States).",
	"And wait a few seconds... loading ule boy.",
	"Click 64-bit Download.",
	"And you will see on the right top that the download is in progress.",
	"While the Win11 is downloading, click the Rufus button to be directed to the folder.",
	"Click the Rufus file...",
	"And click Open!",
	"The device name needs to be correct; the USB input listed here must be correct for the files to be extracted there.",
	"After securing the USB device, now click 'Select' to find the location of the Windows ISO file.",
	"Once the Windows ISO file is found, click on the entire ISO file and then click the Open button at the bottom.",
	"The next step is to click the Start button below to proceed to the next procedure.",
	"If the Windows User Experience window appears, just click OK.",
	"Click the OK button again to start extracting our ISO file.",
	"Just wait until our ISO file is extracted and don't touch it.",
	"Once our extracted ISO file is finished, just click the Close button at the bottom.",
	"Now let's go to our PC's file manager and check if the inserted USB files have been extracted correctly.",
	"Once all the files are okay, it can be used to reformat the computer."
]
	# Set initial texture before starting
	if scenes_texture.size() > 0:
		background.texture = scenes_texture[0]
		
	dialog_box.update_dialog("Teacher", data)

func _on_line_changed(index: int):
	if index >= 3:
		teacher_sprite.hide()
	else:
		teacher_sprite.show()
		
	if index < 3:
		background.texture = scenes_texture[0]
	else:
		if index < scenes_texture.size():
			background.texture = scenes_texture[index - 3]
