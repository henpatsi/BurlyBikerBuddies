extends Node2D

var timer = 0
var time_between_patrons = 2

var patron_spawn

func _ready():
	patron_spawn = get_node("PatronSpawn")

func _process(delta):
	handle_patrons(delta)

func	handle_patrons(delta):
	var patron = get_node_or_null(patron_spawn.name + "/patron")
	if (patron != null):
		return
	timer += delta
	if (timer < time_between_patrons):
		return
	instantiate_new_patron()

func	instantiate_new_patron():
	print("Instantiating new patron")
	var scn = load("res://scenes/patron.tscn")
	var new_patron = scn.instantiate()
	patron_spawn.add_child(new_patron)
	timer = 0
