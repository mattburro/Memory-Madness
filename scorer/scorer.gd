extends Node

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

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

func check_pair_made(tile: MemoryTile):
	tile.reveal(true)
	selections.append(tile)
	
	if selections.size() != 2:
		return
	
	SignalManager.on_selection_disabled.emit()
	moves_made += 1
	update_selections()

func selections_are_pair() -> bool:
	return (selections[0].get_item_name() == selections[1].get_item_name()
		and selections[0].get_instance_id() != selections[1].get_instance_id())

func kill_tiles():
	for tile in selections:
		tile.kill_on_success()
	
	pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func update_selections():
	reveal_timer.start()
	
	if selections_are_pair():
		kill_tiles()

func hide_selections():
	for tile in selections:
		tile.reveal(false)

func on_tile_selected(tile: MemoryTile):
	if not selections.has(tile):
		SoundManager.play_tile_click(sound)
		check_pair_made(tile)

func on_reveal_timer_timeout():
	if not selections_are_pair():
		hide_selections()
	
	selections.clear()
	SignalManager.on_selection_enabled.emit()

func on_game_exit_pressed():
	reveal_timer.stop()
