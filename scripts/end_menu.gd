extends Node

var level_scene = "res://scenes/levels/level.tscn"

var sfx_player

var money_label
var friendship_label
var enemies_label
var lovers_label

func _ready():
	sfx_player = get_node("AudioStreamPlayer")
	money_label = get_node("MarginContainer/VBoxContainer/ScoreLabel")
	friendship_label = get_node("MarginContainer/VBoxContainer/VBoxContainer/FriendshipsLabel")
	lovers_label = get_node("MarginContainer/VBoxContainer/VBoxContainer/LoversLabel")
	enemies_label = get_node("MarginContainer/VBoxContainer/VBoxContainer/EnemiesLabel")
	money_label.text = "You made " + str(global.money) + " $"
	friendship_label.text = "Buds: " + str(global.friends)
	lovers_label.text = "Best Buds: " + str(global.best_friends)
	enemies_label.text = "Enemies: " + str(global.enemies)

func _on_restart_button_pressed():
	sfx_player.stream = load("res://audio/sfx/SFX_START.wav")
	sfx_player.play()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_file(level_scene)

func _on_exit_button_pressed():
	sfx_player.stream = load("res://audio/sfx/SFX_MenuSounds.wav")
	sfx_player.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
