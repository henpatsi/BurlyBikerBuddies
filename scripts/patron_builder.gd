extends Node

var rng = RandomNumberGenerator.new()

var patron_front_dir = "res://images/characters/front/"
var patron_side_dir = "res://images/characters/side/"
var patron_front_textures = []
var patron_side_textures = []

var accessory_odds = 0.5

func _ready():
	load_patron_front_textures()
	load_dir_textures(patron_side_textures, patron_side_dir)

func load_patron_front_textures():
	var front_dir = DirAccess.open(patron_front_dir)
	if (!front_dir):
		print("Error accesssing", patron_front_dir)
	var child_dir_name
	for dir_name in front_dir.get_directories():
		var front_texture = {}
		child_dir_name = patron_front_dir + dir_name + "/"
		front_texture["body"] = []
		front_texture["head"] = []
		front_texture["accessories"] = []
		load_dir_textures(front_texture["body"], child_dir_name + "body/")
		load_dir_textures(front_texture["head"], child_dir_name + "head/")
		load_dir_textures(front_texture["accessories"], child_dir_name + "accessories/")
		front_texture["body_outline"] = load(child_dir_name + "body_outline.png")
		front_texture["head_outline"] = load(child_dir_name + "head_outline.png")
		patron_front_textures.append(front_texture)

func load_dir_textures(tex_list, dir_str):
	var dir = DirAccess.open(dir_str)
	if (!dir):
		print("Error accesssing", dir_str)
	dir.list_dir_begin()
	var texture
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".png"):
			texture = load(dir_str + file_name)
			tex_list.append(texture)
		file_name = dir.get_next()
		
func generate_front_textures():
	var patron_textures = {}
	var type_index = rng.randi_range(0, patron_front_textures.size() - 1)
	var front_texture = patron_front_textures[type_index]
	var variation_index = rng.randi_range(0, front_texture["body"].size() - 1)
	patron_textures["body"] = front_texture["body"][variation_index]
	patron_textures["head"] = front_texture["head"][variation_index]
	patron_textures["body_outline"] = front_texture["body_outline"]
	patron_textures["head_outline"] = front_texture["head_outline"]
	patron_textures["accessories"] = []
	for accessory in front_texture["accessories"]:
		if (rng.randf_range(0, 1) <= accessory_odds):
			patron_textures["accessories"].append(accessory)
	return patron_textures

func generate_side_texture(index):
	return patron_side_textures[0]
