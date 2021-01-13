extends Node

const GAME_SCENE = preload("res://Scenes//Game Scene.tscn")
const MAIN_MENU = preload("res://Scenes//Title Screen.tscn")
const SONG_SELECT = preload("res://Scenes//Song Select.tscn")
const OPTIONS = preload("res://Scenes//Options.tscn")
const DEFAULT_SONG = "res://assets/songs/Test Song 2- Overworld.wav"

const SETTINGS = "res://resources//settings.tres"




func _ready():
	var res = load(SETTINGS)
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus,res.master_volume)
	bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus,res.music_volume)
	pass



# Loader functions
func Load_Game(song = DEFAULT_SONG):
	for i in get_children():
		i.queue_free()
	var game = GAME_SCENE.instance()
	if typeof(song) == TYPE_STRING:
		game.set_song(load(song))
	else:
		game.set_song(song)
	add_child(game)
	

func Load_Main_Menu():
	for i in get_children():
		i.queue_free()
	add_child(MAIN_MENU.instance())

func Load_Song_Select():
	for i in get_children():
		i.queue_free()
	add_child(SONG_SELECT.instance())

func Load_Options():
	for i in get_children():
		i.queue_free()
	add_child(OPTIONS.instance())
	
func Quit():
	for i in get_children():
		i.queue_free()
	get_tree().quit()
