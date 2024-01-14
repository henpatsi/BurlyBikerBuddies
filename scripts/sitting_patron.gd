extends Node2D

#var patron_offset_x = 100
#var patron_offset_y = 20
var patron_scale = 2
var table_position

var stats
var stats_tracker

func _ready():
	stats_tracker = get_node("/root/Level/PatronInfo/")

func fit_to_table():
	table_position = stats["table"].get_free_position()
	self.transform = table_position.transform
	set_ordering()

func set_ordering():
	self.z_index = 0
	
func set_stats(stats, table):
	self.stats = stats
	stats["table"] = table
	
func get_stats():
	return stats

func _on_mouse_entered():
	stats_tracker.show_patron_stats(self)

func _on_mouse_exited():
	stats_tracker.hide_patron_stats()
