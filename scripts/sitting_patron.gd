extends Node2D

var table
var patron_offset_x = 100
var patron_offset_y = 20

var stats

func apply_table_offset():
	if (stats["table"].is_full()):
		self.position.x -= patron_offset_x
	else:
		self.position.x += patron_offset_x
	self.position.y -= patron_offset_y
	# Uncomment if sprite ordering needs to be set
	#var table_sprite = get_node("/root/LevelTest/tables/" + table.name + "/Table")
	#self.z_index = table_sprite.z_index - 1
	
func set_stats(stats, table):
	self.stats = stats
	stats["table"] = table
	
func get_stats():
	return stats
