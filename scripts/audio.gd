extends Node

var rng = RandomNumberGenerator.new()

var music_player
var sfx_player
var dialogue_player

var sfx_dir = "res://audio/sfx/"
var door_sfxs = ["SFX_DoorOpen1.wav", "SFX_DoorOpen2.wav"]
var sit_sfxs = ["SFX_Sit3.wav", "SFX_Sit4.wav"]

var dialogue_dir = "res://audio/dialogue/"
var dialogue_sfxs = [""]

func _ready():
	music_player = get_node("MusicPlayer")
	sfx_player = get_node("SFXPlayer")
	dialogue_player = get_node("DialoguePlayer")

func play_sfx(type):
	sfx_player.stream = load(get_random_sfx(type))
	sfx_player.play()
	
func play_dialogue(type):
	sfx_player.stream = load(get_random_dialogue())
	sfx_player.play()

func get_random_sfx(type):
	var clip_name
	if type == "door":
		clip_name = door_sfxs[rng.randi_range(0, door_sfxs.size() - 1)]
	if type == "sit":
		clip_name = sit_sfxs[rng.randi_range(0, sit_sfxs.size() - 1)]
	return sfx_dir + clip_name

func get_random_dialogue():
	var clip_name = dialogue_sfxs[rng.randi_range(0, dialogue_sfxs.size() - 1)]
	return dialogue_dir + clip_name
