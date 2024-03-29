extends Node2D

#var table_sprite
var table_highlight_sprite

var patron1 = null
var patron2 = null

var relationship_icon
var icon_show_time = 2
var discussion_time = 5
var points = 0

var level

func _ready():
	level = get_node("/root/Level")
	#table_sprite = get_node("Table")
	table_highlight_sprite = get_node("TableHighlight")
	table_highlight_sprite.hide()

func add_patron(patron):
	if (patron1 == null):
		patron1 = patron
		return
	else:
		patron2 = patron
	check_patron_match()
	resolve_relationship()
	
func remove_patrons():
	patron1.remove_patron()
	patron2.remove_patron()
	
func check_patron_match():
	points = 1
	var p1_likes = patron1.get_stats()["likes"]
	var p2_likes = patron2.get_stats()["likes"]
	var p1_dislikes = patron1.get_stats()["dislikes"]
	var p2_dislikes = patron2.get_stats()["dislikes"]
	for like in p1_likes:
		if like in p2_likes:
			points += 3
		elif like in p2_dislikes:
			points -= 3
	for like in p2_likes:
		if like in p1_dislikes:
			points -= 3
	for dislike in p1_dislikes:
		if dislike in p2_dislikes:
			points += 3

func calculate_points(match, amount):
	var change = amount if match else -amount
	points += change

func resolve_relationship():
	await get_tree().create_timer(discussion_time).timeout
	if points <= 0:
		relationship_icon = get_node("RelationshipIcons/bad")
	if points > 0 and points < 6:
		relationship_icon = get_node("RelationshipIcons/ok")
	if points > 6:
		relationship_icon = get_node("RelationshipIcons/great")
	wait_hide_icon()
	await get_tree().create_timer(icon_show_time).timeout
	remove_patrons()
	level.add_money(points * 100)
	level.add_friend(points);
	
func wait_hide_icon():
	relationship_icon.show()
	relationship_icon.play("default")
	await get_tree().create_timer(icon_show_time).timeout
	relationship_icon.hide()
	relationship_icon.stop()

func is_full():
	if (patron1 == null or patron2 == null):
		return false
	return true
	
func get_free_position():
	if (patron2 == null):
		return get_node("PatronPosition1")
	return get_node("PatronPosition2")

func _on_mouse_entered():
	if (!is_full()):
		#table_sprite.hide()
		table_highlight_sprite.show()
	level.set_target_table(self)

func _on_mouse_exited():
	table_highlight_sprite.hide()
	#table_sprite.show()
	level.set_target_table(null)
