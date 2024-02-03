extends Node

const FRAME_IMAGES = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
	preload("res://assets/frames/green_frame.png")
]

var item_images: Array = []

func _ready():
	load_item_images()

func add_file_to_list(file_name: String, path: String):
	var full_path = path + "/" + file_name
	var dict = {
		"item_name": file_name.rstrip(".png"),
		"item_texture": load(full_path)
	}
	item_images.append(dict)

func load_item_images():
	var path = "res://assets/glitch/"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("ERROR: ", path)
	
	var file_names = dir.get_files()
	for file_name in file_names:
		if ".import" not in file_name:
			add_file_to_list(file_name, path)

func get_item_image(index: int):
	return item_images[index]

func get_random_item_image():
	return item_images.pick_random()

func get_random_frame_image() -> CompressedTexture2D:
	return FRAME_IMAGES.pick_random()

func shuffle_images():
	item_images.shuffle()
