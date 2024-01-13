extends Node2D

var table = null

var stats_label = null
var rng = RandomNumberGenerator.new()
var stats = {}
var stats_tacker

func _ready():
	stats_tacker = get_node("/root/LevelTest/StatsTracker")
	set_random_stats()
	stats_label = get_node("/root/LevelTest/PatronSpawn/StatsLabel")
	stats_label.show_stats(stats)

func set_random_stats():
	stats["name"] = stats_tacker.generate_name()
	stats["age"] = rng.randi_range(30, 70)

func _process(delta):
	get_input()
	put_patron_to_table()
	
func get_input():
	if (Input.is_action_just_pressed("select_table1")):
		table = get_node("/root/LevelTest/tables/table1")
	if (Input.is_action_just_pressed("select_table2")):
		table = get_node("/root/LevelTest/tables/table2")
	if (Input.is_action_just_pressed("select_table3")):
		table = get_node("/root/LevelTest/tables/table3")
	
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
	stats_tacker.add_patron(sitting_patron)
	queue_free()
