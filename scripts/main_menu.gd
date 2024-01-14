extends Node

var level_scene = "res://scenes/levels/level.tscn"

var sfx_player

var instruction_text

func _ready():
	sfx_player = get_node("AudioStreamPlayer")
	instruction_text = get_node("InstructionText")
	instruction_text.hide()

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
	instruction_text.show()

func _on_instruction_button_mouse_exited():
	instruction_text.hide()
