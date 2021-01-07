extends MarginContainer



var SONG_DIR = "res://assets//songs"
var GAME_SCENE = "res://Scenes//Game Scene.tscn"
var MAIN_MENU = "res://Scenes//Title Screen.tscn"


var SSButtons
var songs

# function overrides
func _ready():
	songs = list_songs_in_directory(SONG_DIR)
	var song_container = $VBoxContainer/HBoxContainer/Songs
	var fst = true
	var dir = {}
	SSButtons = ButtonGroup.new()
	for song in songs:
		var button = CheckBox.new()
		song_container.add_child(button)
		button.group=SSButtons
		button.text = trunc_ext(song)
		dir[button] = SONG_DIR + "//" + song
		if fst:
			button.pressed = true
	songs = dir



# signal handlers
func _on_Play_Button_pressed():
	get_tree().call_group("Loader","Load_Game",get_selected_song())

func _on_Back_Button_pressed():
	get_tree().call_group("Loader","Load_Main_Menu")


# helper functions
func get_selected_song():
	var items = $VBoxContainer/HBoxContainer/Songs.get_children()
	var count = 0
	for i in items:
		if i.pressed:
			return songs[i]
	return null

func list_songs_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file =="":
			break
		elif not file.begins_with("."):
			if file.ends_with(".wav"):
				files.append(file)
	dir.list_dir_end()
	return files
	
func trunc_ext(filename):
	var ret = ""
	for ch in filename:
		if ch == '.':
			break
		else:
			ret += ch
	return ret
