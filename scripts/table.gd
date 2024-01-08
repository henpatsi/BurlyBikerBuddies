extends Node2D

var patrons = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_patron(patron):
	patrons.append(patron)

func is_full():
	if (patrons.size() == 2):
		print(self.name + " is full")
		return true
	print("Table has room")
	return false
