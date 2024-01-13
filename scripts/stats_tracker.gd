extends Node

var name_index = 0
var names = ["Dirtbike", "Whisky", "Bullet", "Killer", "Rust", "Bicep", "Chainsaw", "Harry", "Shotgun"]

var current_patrons = []
var patron_history
var history_label
var history_visible = false

func _ready():
	patron_history = get_node("/root/LevelTest/PatronHistory")
	history_label = patron_history.get_child(0)
	patron_history.hide()

func _process(delta):
	get_input()

func get_input():
	if (Input.is_action_just_pressed("show_current_patrons")):
		if (!history_visible):
			show_current_patrons()
		else:
			patron_history.hide()
			history_visible = false

func add_patron(sitting_patron):
	if (current_patrons.size() == 4):
		current_patrons.pop_back()
	current_patrons.push_front(sitting_patron)
	
func show_current_patrons():
	history_label.text = ""
	for patron in current_patrons:
		history_label.text += patron.get_stats()["name"]
		history_label.text += "\n" + str(patron.get_stats()["age"])
		history_label.text += "\n" + patron.get_stats()["table"].name
		history_label.text += "\n\n"
	patron_history.show()
	history_visible = true

func generate_name():
	var name = names[name_index]
	name_index += 1
	return name
