extends Node2D

var patron1 = null
var patron2 = null

var relationship_icon
var icon_show_time = 2
var discussion_time = 5
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
	resolve_relationship()
	
func remove_patrons():
	patron1.queue_free()
	patron2.queue_free()
	
func check_patron_match():
	#get_points(patron1.get_stats()["age"] \
				#in range(patron2.get_stats()["target_age_min"], \
						#patron2.get_stats()["target_age_max"]), 1)
	#get_points(patron2.get_stats()["age"] \
				#in range(patron1.get_stats()["target_age_min"], \
						#patron1.get_stats()["target_age_max"]), 1)
	print("Match points: " + str(points))
	
func resolve_relationship():
	await get_tree().create_timer(discussion_time).timeout
	if points < 10 and points > -10:
		relationship_icon = get_node("RelationshipIcons/ok")
	if points > 10:
		relationship_icon = get_node("RelationshipIcons/great")
	if points < -10:
		relationship_icon = get_node("RelationshipIcons/bad")
	wait_hide_icon()
	await get_tree().create_timer(icon_show_time).timeout
	remove_patrons()
	
func wait_hide_icon():
	relationship_icon.show()
	relationship_icon.play("default")
	await get_tree().create_timer(icon_show_time).timeout
	relationship_icon.hide()

func get_points(match, amount):
	var change = amount if match else -amount
	points += change

func is_full():
	if (patron1 == null or patron2 == null):
		return false
	return true
