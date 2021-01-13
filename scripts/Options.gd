extends MarginContainer

const SETTINGS = "res://resources//settings.tres"

var MasterBI = AudioServer.get_bus_index("Master")
var MusicBI = AudioServer.get_bus_index("Music")



func _ready():
	var res = load(SETTINGS)
	$VSplitContainer/MasterVolume/HBoxContainer/MasterVolumeSlider.value = db_to_slider(res.master_volume)
	$VSplitContainer/MusicVolume/HBoxContainer/MusicVolumeSlider.value = db_to_slider(res.music_volume)
	pass # Replace with function body.



func _on_MasterVolumeSlider_value_changed(value):
	var res = load(SETTINGS)
	res.master_volume = slider_to_db(value)
	AudioServer.set_bus_volume_db(MasterBI,res.master_volume)
	ResourceSaver.save(SETTINGS,res)
	pass # Replace with function body.


func _on_MusicVolumeSlider_value_changed(value):
	var res = load(SETTINGS)
	res.music_volume = slider_to_db(value)
	AudioServer.set_bus_volume_db(MusicBI,res.music_volume)
	ResourceSaver.save(SETTINGS,res)
	pass # Replace with function body.


# helper functions
func db_to_slider(db):
	return pow(10,((db+40)/20))
	pass
	
func slider_to_db(value):
	return 20*log(value)/log(10) - 40
	pass


func _on_Button_pressed():
	get_tree().call_group("Loader","Load_Main_Menu")
	pass # Replace with function body.
