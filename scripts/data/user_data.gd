extends Resource
class_name UserData

# Config
@export var opened_once: bool = false

# Settings
@export var sounds: bool = false

# COC
@export var coc_1_unlocked : bool = true
@export var coc_2_unlocked : bool = false

# COC 1 Lessons
@export var ohs_procedures : bool = true
@export var electrical_hazards : bool = false
@export var assemble_disassemble : bool = false
@export var creating_bootable_device : bool = false
@export var installing_softwares : bool = false

# OHS Procedures
@export var toolbox_item_count : int = 0
@export var is_final_message : bool = false

# Electrical Hazards
@export var trash_count : int = 0

# Assemble Disassemble
@export var dragging : bool = false
@export var motherboard_assembled : bool = false

#COC 2 Lessons
