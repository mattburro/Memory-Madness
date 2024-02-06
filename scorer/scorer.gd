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

func on_tile_selected(tile: MemoryTile):
	tile.reveal(true)
	selections.append(tile)
	pass
