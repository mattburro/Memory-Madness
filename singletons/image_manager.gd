extends Node

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
