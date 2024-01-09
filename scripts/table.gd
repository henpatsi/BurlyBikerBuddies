extends Node2D

var patron1
var patron2

var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_patron(patron):
	if (patron1 == null):
		patron1 = patron
		return
	else:
		patron2 = patron
	check_patron_match()

func check_patron_match():
	get_points(patron1.get_stats()["age"] \
				in range(patron2.get_stats()["target_age_min"], \
						patron2.get_stats()["target_age_max"]), 1)
	get_points(patron2.get_stats()["age"] \
				in range(patron1.get_stats()["target_age_min"], \
						patron1.get_stats()["target_age_max"]), 1)
	print("Match points: " + str(points))

func get_points(match, amount):
	var change = amount if match else -amount
	points += change

func is_full():
	if (patron1 != null and patron2 != null):
		print(self.name + " is full")
		return true
	print("Table has room")
	return false
