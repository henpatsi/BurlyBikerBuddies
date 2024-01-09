extends Node

var name_index = 0
var names = ["Dirtbike", "Whisky", "Bullet", "Killer", "Rust", "Bicep", "Chainsaw", "Harry", "Shotgun"]

var current_patrons = []
var history_label
var history_label_visible = false

func _ready():
	history_label = get_node("/root/LevelTest/PatronHistory")

func _process(delta):
	get_input()

func get_input():
	if (Input.is_action_just_pressed("show_current_patrons")):
		if (!history_label_visible):
			show_current_patrons()
		else:
			history_label.hide()
			history_label_visible = false

func add_patron(sitting_patron):
	current_patrons.append(sitting_patron)
	
func show_current_patrons():
	history_label.text = ""
	for patron in current_patrons:
		history_label.text += patron.get_stats()["name"]
		history_label.text += "\n" + str(patron.get_stats()["age"])
		history_label.text += "\n" + patron.get_stats()["table"].name
		history_label.text += "\n\n"
	history_label.show()
	history_label_visible = true

func generate_name():
	var name = names[name_index]
	name_index += 1
	return name
