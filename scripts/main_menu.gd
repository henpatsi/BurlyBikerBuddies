extends Node

var level_scene = "res://scenes/levels/level.tscn"

func _on_start_button_pressed():
	get_tree().change_scene_to_file(level_scene)

func _on_exit_button_pressed():
	get_tree().quit()
