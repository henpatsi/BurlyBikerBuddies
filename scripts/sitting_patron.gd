extends Node2D

#var patron_offset_x = 100
#var patron_offset_y = 20
var patron_scale = 2
var table_position

var stats
var stats_tracker

var patron_builder
var textures = {}

func _ready():
	stats_tracker = get_node("/root/Level/PatronInfo/")
	patron_builder = get_node("/root/Level/PatronSpawn/PatronBuilder")

func fit_to_table():
	table_position = stats["table"].get_free_position()
	self.transform = table_position.transform
	set_ordering()
	set_texture()

func set_ordering():
	self.z_index = table_position.z_index

func set_texture():
	textures = patron_builder.generate_side_texture()
	var head = get_node("Head")
	get_node("Body").set_texture(textures["body"])
	head.set_texture(textures["head"])
	get_node("Body/Outline").set_texture(textures["body_outline"])
	get_node("Head/Outline").set_texture(textures["head_outline"])
	for accessory_texture in textures["accessories"]:
		var sprite = Sprite2D.new()
		head.add_child(sprite)
		sprite.z_index = 5
		sprite.set_texture(accessory_texture)
	if (textures["hair"] != null):
		var sprite = Sprite2D.new()
		head.add_child(sprite)
		sprite.z_index = 2
		sprite.set_texture(textures["hair"])
	if (textures["beard"] != null):
		var sprite = Sprite2D.new()
		head.add_child(sprite)
		sprite.z_index = 2
		sprite.set_texture(textures["beard"])

func set_stats(start_stats, table):
	self.stats = start_stats
	stats["table"] = table
	
func get_stats():
	return stats

func _on_mouse_entered():
	stats_tracker.show_patron_stats(self)

func _on_mouse_exited():
	stats_tracker.hide_patron_stats()
