extends MarginContainer

var TITLE_SONG = "res://assets/songs/Test Song 2- Overworld.wav"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Game Scene").set_song(load(TITLE_SONG))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_Button_pressed():
	get_tree().call_group("Loader","Load_Song_Select")
	queue_free()
	pass # Replace with function body.


func _on_Quit_Button_pressed():
	get_tree().call_group("Loader","Quit")
	pass # Replace with function body.


func _on_Options_Button_pressed():
	get_tree().call_group("Loader","Load_Options")
	queue_free()
	pass # Replace with function body.
