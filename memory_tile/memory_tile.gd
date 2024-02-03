extends TextureButton

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var item_name: String
var selectable: bool

func _ready():
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	SignalManager.on_selection_enabled.connect(on_selection_enabled)

func reveal(show: bool):
	frame_image.visible = show
	item_image.visible = show

func setup(item_image_dict: Dictionary, frame_image: CompressedTexture2D):
	self.frame_image.texture = frame_image
	item_image.texture = item_image_dict.item_texture
	item_name = item_image_dict.item_name
	reveal(false)

func get_item_name() -> String:
	return item_name

func on_selection_disabled():
	selectable = false

func on_selection_enabled():
	selectable = true

func _on_pressed():
	if selectable:
		reveal(true)
