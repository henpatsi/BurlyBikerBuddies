extends Node2D

var table = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("select_table1")):
		table = get_node("/root/LevelTest/tables/table1")
	if (Input.is_action_just_pressed("select_table2")):
		table = get_node("/root/LevelTest/tables/table2")
	if (Input.is_action_just_pressed("select_table3")):
		table = get_node("/root/LevelTest/tables/table3")
	
	if (table == null):
		return
	if (table.is_full()):
		table = null
		return

	print("Putting patron to " + table.name)
	var scn = load("res://scenes/sitting_patron.tscn")
	var sitting_patron = scn.instantiate()
	table.add_child(sitting_patron)
	table.add_patron(sitting_patron)
	queue_free()
