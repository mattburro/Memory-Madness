extends TextureRect

const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_NORMAL: Vector2 = Vector2.ONE
const SPIN_TIME_RANGE: Array[float] = [1.0, 2.0]
const SCALE_TIME: float = 0.5

func _ready():
	run_me()

func set_random_image():
	texture = ImageManager.get_random_item_image()

func get_random_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE[0], SPIN_TIME_RANGE[1])

func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))

func run_me():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(set_random_image)
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_TIME)
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME)
	tween.tween_callback(run_me)
