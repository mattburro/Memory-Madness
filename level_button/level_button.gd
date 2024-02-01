extends TextureButton

@onready var label = $Label
@onready var sound = $Sound

var level_number: int = 0

func _ready():
	pass

func set_level_number(level_number: int):
	self.level_number = level_number
	var level_data = GameManager.LEVELS[level_number]
	label.text = "%sx%s" % [level_data.rows, level_data.cols]

func on_pressed():
	SoundManager.play_button_click(sound)
