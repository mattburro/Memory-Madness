extends Control

@onready var moves_label = %MovesLabel

func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func on_game_over(moves: int):
	moves_label.text = str(moves)
	show()

func on_exit_button_pressed():
	hide()
	SignalManager.on_game_exit_pressed.emit()
