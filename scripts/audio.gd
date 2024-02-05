extends Node

var rng = RandomNumberGenerator.new()

var music_player
var sfx_player
var dialogue_player

var door_sfx_dir = "res://audio/sfx/door/"
var sit_sfx_dir = "res://audio/sfx/sit/"
var door_sfxs = []
var sit_sfxs = []

var dialogue_dir = "res://audio/dialogue/"
var dialogues = []
var last_dialogues_index = null

func _ready():
	music_player = get_node("MusicPlayer")
	sfx_player = get_node("SFXPlayer")
	dialogue_player = get_node("DialoguePlayer")
	load_sound_files(sit_sfxs, sit_sfx_dir)
	load_sound_files(door_sfxs, door_sfx_dir)
	load_sound_files(dialogues, dialogue_dir)

func play_sfx(type):
	sfx_player.stream = get_random_sfx(type)
	sfx_player.play()
	
func play_dialogue():
	dialogue_player.stream = get_random_dialogue()
	dialogue_player.play()

func get_random_sfx(type):
	if type == "door":
		return door_sfxs[rng.randi_range(0, door_sfxs.size() - 1)]
	if type == "sit":
		return sit_sfxs[rng.randi_range(0, sit_sfxs.size() - 1)]

func get_random_dialogue():
	var index = rng.randi_range(0, dialogues.size() - 1)
	while (index == last_dialogues_index):
		index = rng.randi_range(0, dialogues.size() - 1)
	last_dialogues_index = index
	return dialogues[index]

func load_sound_files(into_list, dir_str):
	var dir = DirAccess.open(dir_str)
	if (!dir):
		print("Error accesssing", dir_str)
	dir.list_dir_begin()
	var audio_file
	var file_name = dir.get_next()
	while file_name != "":
		# Needed for game export
		if file_name.ends_with(".import"):
			file_name = file_name.replace(".import", "")
		if file_name.ends_with(".wav"):
			audio_file = load(dir_str + file_name)
			into_list.append(audio_file)
		file_name = dir.get_next()
