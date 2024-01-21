extends Node

var rng = RandomNumberGenerator.new()

var patron_front_dir = "res://images/characters/front/"
var patron_side_dir = "res://images/characters/side/"
var patron_front_textures = []
var patron_side_textures = []

var accessory_odds = 0.5
var beard_odds = 0.5

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
		front_texture["beard"] = []
		front_texture["hair"] = []
		load_dir_textures(front_texture["body"], child_dir_name + "body/")
		load_dir_textures(front_texture["head"], child_dir_name + "head/")
		load_dir_textures(front_texture["accessories"], child_dir_name + "accessories/")
		load_dir_textures(front_texture["beard"], child_dir_name + "beard/")
		load_hair_textures(front_texture["hair"], child_dir_name + "hair/")
		front_texture["body_outline"] = load(child_dir_name + "body_outline.png")
		front_texture["head_outline"] = load(child_dir_name + "head_outline.png")
		patron_front_textures.append(front_texture)
		print(front_texture)

func load_hair_textures(tex_list, parent_dir_str):
	var parent_dir = DirAccess.open(parent_dir_str)
	for dir_name in parent_dir.get_directories():
		var hair_colors = []
		load_dir_textures(hair_colors, parent_dir_str + dir_name + "/")
		tex_list.append(hair_colors)
		

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
	# Get hair and color, none if out of range of hairs
	var hair_style_index = rng.randi_range(0, front_texture["hair"].size())
	var hair_color_index = rng.randi_range(0, front_texture["hair"][0].size() - 1)
	if (hair_style_index != front_texture["hair"].size()):
		patron_textures["hair"] = front_texture["hair"][hair_style_index][hair_color_index]
	else:
		patron_textures["hair"] = null
	# Get beard, match hair color
	if (rng.randf_range(0, 1) <= beard_odds):
		patron_textures["beard"] = front_texture["beard"][hair_color_index]
	else:
		patron_textures["beard"] = null
	# Get any amount of accessories
	patron_textures["accessories"] = []
	for accessory in front_texture["accessories"]:
		if (rng.randf_range(0, 1) <= accessory_odds):
			patron_textures["accessories"].append(accessory)
	return patron_textures

func generate_side_texture(index):
	return patron_side_textures[0]
