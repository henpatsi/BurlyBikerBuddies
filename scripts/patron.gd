extends Node2D

var table = null

var stats_label = null
var stats = {}
var patron_spawn
var stats_tacker
var audio_player

var patron_builder
var textures = {}

var level

func _ready():
	level = get_node("/root/Level")
	stats_tacker = get_node("/root/Level/PatronInfo")
	patron_spawn = get_node("/root/Level/PatronSpawn")
	stats_label = get_node("/root/Level/PatronSpawn/StatsLabel")
	audio_player = get_node("/root/Level/Audio")
	patron_builder = get_node("../PatronBuilder")
	textures = patron_builder.generate_front_textures()
	set_textures()
	set_random_stats()
	stats_label.write_stats(stats)
	patron_spawn.show()
	audio_player.play_sfx("door")
	audio_player.play_dialogue()

func set_textures():
	var head = get_node("Head")
	get_node("Body").set_texture(textures["body"])
	head.set_texture(textures["head"])
	get_node("Body/Outline").set_texture(textures["body_outline"])
	get_node("Head/Outline").set_texture(textures["head_outline"])
	for accessory_texture in textures["accessories"]:
		var sprite = Sprite2D.new()
		head.add_child(sprite)
		sprite.z_index = 5
		sprite.set_texture(accessory_texture)
	if (textures["hair"] != null):
		var sprite = Sprite2D.new()
		head.add_child(sprite)
		sprite.z_index = 2
		sprite.set_texture(textures["hair"])
	if (textures["beard"] != null):
		var sprite = Sprite2D.new()
		head.add_child(sprite)
		sprite.z_index = 2
		sprite.set_texture(textures["beard"])

func set_random_stats():
	stats["name"] = stats_tacker.generate_name()
	stats["age"] = stats_tacker.generate_age()
	stats["likes"] = stats_tacker.generate_likes()
	stats["dislikes"] = stats_tacker.generate_dislikes(stats["likes"])

func _process(_delta):
	get_input()
	put_patron_to_table()
	
func get_input():
	if (Input.is_action_just_pressed("select_table")):
		table = level.get_target_table()
	
func put_patron_to_table():
	if (table == null):
		return
	if (table.is_full()):
		table = null
		return
	
	var scn = load("res://scenes/sitting_patron.tscn")
	var sitting_patron = scn.instantiate()
	sitting_patron.set_stats(stats, table)
	table.add_child(sitting_patron)
	table.add_patron(sitting_patron)
	sitting_patron.fit_to_table()
	patron_spawn.hide()
	audio_player.play_sfx("sit")
	queue_free()
