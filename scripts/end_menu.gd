extends Node

var level_scene = "res://scenes/levels/level.tscn"

var sfx_player
var instructions

var money_label
var friendship_label
var enemies_label
var lovers_label

func _ready():
	sfx_player = get_node("AudioStreamPlayer")
	instructions = get_node("Instructions")
	money_label = get_node("Stats/ScoreLabel")
	friendship_label = get_node("Stats/VBoxContainer/FriendshipsLabel")
	lovers_label = get_node("Stats/VBoxContainer/LoversLabel")
	enemies_label = get_node("Stats/VBoxContainer/EnemiesLabel")
	money_label.text = "You made " + str(global.money) + " $"
	friendship_label.text = "Buds: " + str(global.friends)
	lovers_label.text = "Best Buds: " + str(global.best_friends)
	enemies_label.text = "Enemies: " + str(global.enemies)
	instructions.hide()

func _on_start_button_pressed():
	sfx_player.stream = load("res://audio/sfx/SFX_START.wav")
	sfx_player.play()
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_file(level_scene)

func _on_exit_button_pressed():
	sfx_player.stream = load("res://audio/sfx/SFX_MenuSounds.wav")
	sfx_player.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func _on_instruction_button_mouse_entered():
	instructions.show()

func _on_instruction_button_mouse_exited():
	instructions.hide()
