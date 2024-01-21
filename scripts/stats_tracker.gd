extends Node

var rng = RandomNumberGenerator.new()
var names
var likes = {}
var dislikes = {}
var topics

var patron_info
var patron_info_label
var showing_patron = null

var patron_front_dir = "res://images/characters/front/"
var patron_side_dir = "res://images/characters/side/"
var patron_front_textures = []
var patron_side_textures = []

func _ready():
	patron_info = get_node("/root/Level/PatronInfo")
	patron_info_label = get_node("/root/Level/PatronInfo/PatronInfoLabel")
	patron_info.hide()
	load_files()
	topics = likes.keys()

func load_files():
	var name_file = FileAccess.open("res://stat_files/names.txt", FileAccess.READ)
	var name_content = name_file.get_as_text().trim_suffix("\n")
	names = name_content.split("\n")
	load_preference_file("res://stat_files/likes.txt", likes)
	load_preference_file("res://stat_files/dislikes.txt", dislikes)
	load_patron_textures(patron_front_textures, patron_front_dir)
	load_patron_textures(patron_side_textures, patron_side_dir)
		
func load_preference_file(file_path, target_dict):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	var groups = content.split("\n\n", false)
	for group in groups:
		var split = group.split(":", false)
		var long = split[1].split("\n", false)
		target_dict[split[0]] = long

func load_patron_textures(tex_list, dir_str):
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

func _process(_delta):
	if (showing_patron == null):
		patron_info.hide()

func show_patron_stats(patron):
	patron_info_label.write_patron_stats(patron.get_stats())
	patron_info.show()
	showing_patron = patron

func hide_patron_stats():
	patron_info.hide()
	showing_patron = null

func generate_front_texture():
	var index = rng.randi_range(0, patron_front_textures.size() - 1)
	return [index, patron_front_textures[index]]
	
func generate_side_texture(index):
	return patron_side_textures[index]

func generate_name():
	return names[rng.randi_range(0, names.size() - 1)]
	
func generate_age():
	return (rng.randi_range(30, 70))

func generate_likes():
	var topic = topics[rng.randi_range(0, topics.size() - 1)]
	var description = likes[topic][rng.randi_range(0, likes[topic].size() - 1)]
	var like1 = {topic: description}
	return like1
	
func generate_dislikes(patron_likes):
	var topic = topics[rng.randi_range(0, topics.size() - 1)]
	while (topic in patron_likes.keys()):
		topic = topics[rng.randi_range(0, topics.size() - 1)]
	var description = dislikes[topic][rng.randi_range(0, dislikes[topic].size() - 1)]
	var dislike1 = {topic: description}
	return dislike1
