extends Node

var rng = RandomNumberGenerator.new()

var patron_front_dir = "res://images/characters/front/"
var patron_side_dir = "res://images/characters/side/"
var patron_front_textures = []
var patron_side_textures = []

var accessory_odds = 0.5
var beard_odds = 0.5

var type_index
var variation_index
var hair_style_index
var hair_color_index 
var has_beard
var accessory_indexes = []

func _ready():
	load_patron_textures(patron_front_dir, patron_front_textures)
	load_patron_textures(patron_side_dir, patron_side_textures)

func load_patron_textures(dir_str, textures_list):
	var dir = DirAccess.open(dir_str)
	if (!dir):
		print("Error accesssing", dir_str)
	var child_dir_name
	for dir_name in dir.get_directories():
		var texture_dict = {}
		child_dir_name = dir_str + dir_name + "/"
		texture_dict["body"] = []
		texture_dict["head"] = []
		texture_dict["accessories"] = []
		texture_dict["beard"] = []
		texture_dict["hair"] = []
		load_dir_textures(texture_dict["body"], child_dir_name + "body/")
		load_dir_textures(texture_dict["head"], child_dir_name + "head/")
		load_dir_textures(texture_dict["accessories"], child_dir_name + "accessories/")
		load_dir_textures(texture_dict["beard"], child_dir_name + "beard/")
		load_hair_textures(texture_dict["hair"], child_dir_name + "hair/")
		texture_dict["body_outline"] = load(child_dir_name + "body_outline.png")
		texture_dict["head_outline"] = load(child_dir_name + "head_outline.png")
		textures_list.append(texture_dict)

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
	type_index = rng.randi_range(0, patron_front_textures.size() - 1)
	var front_texture = patron_front_textures[type_index]
	variation_index = rng.randi_range(0, front_texture["body"].size() - 1)
	patron_textures["body"] = front_texture["body"][variation_index]
	patron_textures["head"] = front_texture["head"][variation_index]
	patron_textures["body_outline"] = front_texture["body_outline"]
	patron_textures["head_outline"] = front_texture["head_outline"]
	# Get hair and color, none if out of range of hairs
	hair_style_index = rng.randi_range(0, front_texture["hair"].size())
	hair_color_index = rng.randi_range(0, front_texture["hair"][0].size() - 1)
	if (hair_style_index != front_texture["hair"].size()):
		patron_textures["hair"] = front_texture["hair"][hair_style_index][hair_color_index]
	else:
		patron_textures["hair"] = null
	# Get beard, match hair color
	has_beard = rng.randf_range(0, 1) <= beard_odds
	if has_beard:
		patron_textures["beard"] = front_texture["beard"][hair_color_index]
	else:
		patron_textures["beard"] = null
	# Get any amount of accessories
	accessory_indexes.clear()
	patron_textures["accessories"] = []
	for i in range(front_texture["accessories"].size()):
		if (rng.randf_range(0, 1) <= accessory_odds):
			patron_textures["accessories"].append(front_texture["accessories"][i])
			accessory_indexes.append(i)
	return patron_textures

func generate_side_texture():
	var patron_textures = {}
	var side_texture = patron_side_textures[type_index]
	patron_textures["body"] = side_texture["body"][variation_index]
	patron_textures["head"] = side_texture["head"][variation_index]
	patron_textures["body_outline"] = side_texture["body_outline"]
	patron_textures["head_outline"] = side_texture["head_outline"]
	if (hair_style_index != side_texture["hair"].size()):
		patron_textures["hair"] = side_texture["hair"][hair_style_index][hair_color_index]
	else:
		patron_textures["hair"] = null
	if has_beard:
		patron_textures["beard"] = side_texture["beard"][hair_color_index]
	else:
		patron_textures["beard"] = null
	patron_textures["accessories"] = []
	for i in accessory_indexes:
		patron_textures["accessories"].append(side_texture["accessories"][i])
	return patron_textures
