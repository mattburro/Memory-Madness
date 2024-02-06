class_name MemoryTile extends TextureButton

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
	on_selection_enabled()

func kill_on_success():
	z_index = 1
	disabled = true
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "rotation", deg_to_rad(720), 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)

func get_item_name() -> String:
	return item_name

func on_selection_disabled():
	selectable = false

func on_selection_enabled():
	selectable = true

func _on_pressed():
	if selectable:
		SignalManager.on_tile_selected.emit(self)
