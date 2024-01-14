extends Node

var level_scene = "res://scenes/levels/level.tscn"

var money_label

func _ready():
	money_label = get_node("MarginContainer/VBoxContainer/ScoreLabel")
	money_label.text = "You made " + str(global.money) + " $"

func _on_restart_button_pressed():
	get_tree().change_scene_to_file(level_scene)

func _on_exit_button_pressed():
	get_tree().quit()
