extends Node2D

var end_menu_path = "res://scenes/levels/end_menu.tscn"

var level_duration = 120
var level_timer = level_duration
var level_time_bar

var patron_spawn_timer = 0
var time_between_patrons = 2

var patron_spawn
var target_table = null

var money_label

func _ready():
	global.reset_all()
	level_time_bar = get_node("LevelTimeBar")
	money_label = get_node("MoneyLabel")
	patron_spawn = get_node("PatronSpawn")

func _process(delta):
	handle_patrons(delta)
	time_level(delta)

func time_level(delta):
	level_timer -= delta
	level_time_bar.value = (level_timer / level_duration) * 100
	if (level_timer > 0):
		return
	end_level()

func handle_patrons(delta):
	var patron = get_node_or_null(patron_spawn.name + "/patron")
	if (patron != null):
		return
	patron_spawn_timer += delta
	if (patron_spawn_timer < time_between_patrons):
		return
	instantiate_new_patron()

func instantiate_new_patron():
	var scn = load("res://scenes/patron.tscn")
	var new_patron = scn.instantiate()
	patron_spawn.add_child(new_patron)
	patron_spawn_timer = 0

func add_money(amount):
	global.money += amount
	money_label.text = "Money: "
	money_label.text += str(global.money) + " $"
	
func add_friend(points):
	if points <= 0:
		global.enemies += 1
	if points > 0 and points < 6:
		global.friends += 1
	if points > 6:
		global.best_friends += 1

func end_level():
	get_tree().change_scene_to_file(end_menu_path)

func get_target_table():
	return target_table

func set_target_table(table):
	target_table = table
