extends Node2D

var patron_offset_x = 100
var patron_offset_y = 20
var patron_scale = 2

var stats
var stats_tracker

func _ready():
	stats_tracker = get_node("/root/Level/PatronInfo/")

func fit_to_table():
	apply_offset()
	apply_scaling()
	flip_sprite()
	set_ordering()

func apply_offset():
	if (stats["table"].is_full()):
		self.position.x -= patron_offset_x
	else:
		self.position.x += patron_offset_x
	self.position.y -= patron_offset_y
	
func apply_scaling():
	self.scale = Vector2(patron_scale, patron_scale)
	
func flip_sprite():
	if (!stats["table"].is_full()):
		self.scale.x = -self.scale.x

func set_ordering():
	var table_sprite = get_node("/root/Level/tables/" + stats["table"].name + "/Table")
	self.z_index = table_sprite.z_index + 1
	
func set_stats(stats, table):
	self.stats = stats
	stats["table"] = table
	
func get_stats():
	return stats

func _on_mouse_entered():
	stats_tracker.show_patron_stats(self)

func _on_mouse_exited():
	stats_tracker.hide_patron_stats()
