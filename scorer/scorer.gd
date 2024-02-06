extends Node

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var tiles: Array = []
var selections: Array = []
var target_pairs: int = 0
var moves_made: int = 0
var pairs_made: int = 0

func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)

func clear_new_game(new_target_pairs: int):
	selections.clear()
	pairs_made = 0
	moves_made = 0
	target_pairs = new_target_pairs
	tiles = get_tree().get_nodes_in_group(GameManager.GROUP_TILE)

func check_pair_made(tile: MemoryTile):
	tile.reveal(true)
	selections.append(tile)
	
	if not selections.size() == 2:
		return
	
	SignalManager.on_selection_disabled.emit()
	moves_made += 1
	
	update_selections()

func update_selections():
	reveal_timer.start()

func hide_selections():
	for tile in selections:
		tile.reveal(false)

func on_tile_selected(tile: MemoryTile):
	SoundManager.play_tile_click(sound)
	check_pair_made(tile)

func on_reveal_timer_timeout():
	hide_selections()
	selections.clear()
	SignalManager.on_selection_enabled.emit()

func on_game_exit_pressed():
	reveal_timer.stop()
