extends Node2D

var sprite

var table = null

var stats_label = null
var stats = {}
var patron_spawn
var stats_tacker
var audio_player

var level

func _ready():
	sprite = get_node("Sprite")
	level = get_node("/root/Level")
	stats_tacker = get_node("/root/Level/PatronInfo")
	patron_spawn = get_node("/root/Level/PatronSpawn")
	stats_label = get_node("/root/Level/PatronSpawn/StatsLabel")
	audio_player = get_node("/root/Level/Audio")
	get_random_texture()
	set_random_stats()
	stats_label.write_stats(stats)
	patron_spawn.show()
	audio_player.play_sfx("door")

func get_random_texture():
	var index_texture
	index_texture = stats_tacker.generate_front_texture()
	stats["texture_index"] = index_texture[0]
	sprite.set_texture(index_texture[1])

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
	sitting_patron.set_texture(stats["texture_index"])
	audio_player.play_sfx("sit")
	queue_free()
