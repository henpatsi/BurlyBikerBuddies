extends Node

var rng = RandomNumberGenerator.new()
var names = ["Dirtbike", "Whisky", "Bullet", "Killer", "Rust", "Bicep", "Chainsaw", "Harry", "Shotgun"]

var patron_info
var patron_info_label

func _ready():
	patron_info = get_node("/root/Level/PatronInfo")
	patron_info_label = patron_info.get_child(0)
	patron_info.hide()

func show_patron_stats(patron):
	patron_info_label.write_patron_stats(patron.get_stats())
	patron_info.show()

func hide_patron_stats():
	patron_info.hide()

func generate_name():
	return names[rng.randi_range(0, names.size() - 1)]
	
func generate_age():
	return (rng.randi_range(30, 70))
