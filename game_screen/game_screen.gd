extends Control

@export var memory_tile_scene: PackedScene

@onready var sound = $Sound
@onready var tile_container = %TileContainer
@onready var scorer = $Scorer

func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)

func add_memory_tile(image_dict: Dictionary, frame_image: CompressedTexture2D):
	var memory_tile = memory_tile_scene.instantiate()
	tile_container.add_child(memory_tile)
	memory_tile.setup(image_dict, frame_image)

func on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_game_exit_pressed.emit()

func on_level_selected(level_num: int):
	var level_selection = GameManager.get_level_selection(level_num)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_selection.num_cols
	
	for image_dict in level_selection.image_list:
		add_memory_tile(image_dict, frame_image)
	
	scorer.clear_new_game(level_selection.target_pairs)
