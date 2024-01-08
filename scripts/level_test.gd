extends Node2D

var timer = 0
var time_between_patrons = 2

var patron_spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	patron_spawn = get_node("PatronSpawn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var patron = get_node_or_null(patron_spawn.name + "/patron")

	if (patron != null):
		return

	timer += delta
	if (timer < time_between_patrons):
		return

	print("Instantiating new patron")
	var scn = load("res://scenes/patron.tscn")
	var new_patron = scn.instantiate()
	patron_spawn.add_child(new_patron)
	timer = 0
