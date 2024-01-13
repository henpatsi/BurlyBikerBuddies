extends Node2D

var table = null

var stats_label = null
var stats = {}
var stats_tacker

var level

func _ready():
	level = get_node("/root/Level")
	stats_tacker = get_node("/root/Level/PatronInfo")
	set_random_stats()
	stats_label = get_node("/root/Level/PatronSpawn/StatsLabel")
	stats_label.show_stats(stats)

func set_random_stats():
	stats["name"] = stats_tacker.generate_name()
	stats["age"] = stats_tacker.generate_age()

func _process(delta):
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
	
	print("Putting patron to " + table.name)
	var scn = load("res://scenes/sitting_patron.tscn")
	var sitting_patron = scn.instantiate()
	sitting_patron.set_stats(stats, table)
	table.add_child(sitting_patron)
	table.add_patron(sitting_patron)
	sitting_patron.fit_to_table()
	stats_label.hide()
	queue_free()
