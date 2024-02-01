extends Control

@export var level_button_scene: PackedScene

@onready var levels = $VBoxContainer/Levels

func _ready():
	setup_levels_grid()

func setup_levels_grid():
	for level in GameManager.LEVELS:
		create_level_button(level)

func create_level_button(level_number: int):
	var level_button = level_button_scene.instantiate()
	levels.add_child(level_button)
	level_button.set_level_number(level_number)
